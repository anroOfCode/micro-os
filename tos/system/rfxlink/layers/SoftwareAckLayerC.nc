#include <Tasklet.h>
#include <RadioAssert.h>

generic module SoftwareAckLayerC()
{
	provides
	{
		interface RadioSend;
		interface RadioReceive;
		interface PacketAcknowledgements;
	}

	uses
	{
		interface RadioSend as SubSend;
		interface RadioReceive as SubReceive;
		interface RadioAlarm;

		interface SoftwareAckConfig as Config;
		interface PacketFlag as AckReceivedFlag;
	}
}

implementation
{
	tasklet_norace uint8_t state;
	enum
	{
		STATE_READY = 0,
		STATE_DATA_SEND = 1,
		STATE_ACK_WAIT = 2,
		STATE_ACK_SEND = 3,
	};

	tasklet_norace message_t *txMsg;
	tasklet_norace message_t ackMsg;

	tasklet_async event void SubSend.ready()
	{
		if( state == STATE_READY )
			signal RadioSend.ready();
	}

	tasklet_async command error_t RadioSend.send(message_t* msg)
	{
		error_t error;

		if( state == STATE_READY )
		{
			if( (error = call SubSend.send(msg)) == SUCCESS )
			{
				call AckReceivedFlag.clear(msg);
				state = STATE_DATA_SEND;
				txMsg = msg;
			}
		}
		else
			error = EBUSY;

		return error;
	}

	tasklet_async event void SubSend.sendDone(error_t error)
	{
		if( state == STATE_ACK_SEND )
		{
			// TODO: what if error != SUCCESS
			RADIO_ASSERT( error == SUCCESS );

			state = STATE_READY;
		}
		else
		{
			RADIO_ASSERT( state == STATE_DATA_SEND );
			RADIO_ASSERT( call RadioAlarm.isFree() );

			if( error == SUCCESS && call Config.requiresAckWait(txMsg) && call RadioAlarm.isFree() )
			{
				call RadioAlarm.wait(call Config.getAckTimeout());
				state = STATE_ACK_WAIT;
			}
			else
			{
				state = STATE_READY;
				signal RadioSend.sendDone(error);
			}
		}
	}

	tasklet_async event void RadioAlarm.fired()
	{
		RADIO_ASSERT( state == STATE_ACK_WAIT );

		call Config.reportChannelError();

		state = STATE_READY;
		signal RadioSend.sendDone(SUCCESS);	// we have sent it, but not acked
	}

	tasklet_async event bool SubReceive.header(message_t* msg)
	{
		// drop unexpected ACKs
		if( call Config.isAckPacket(msg) )
			return state == STATE_ACK_WAIT;

		// drop packets that need ACKs while waiting for our ACK
//		if( state == STATE_ACK_WAIT && call Config.requiresAckWait(msg) )
//			return FALSE;

		return signal RadioReceive.header(msg);
	}

	tasklet_async event message_t* SubReceive.receive(message_t* msg)
	{
		RADIO_ASSERT( state == STATE_ACK_WAIT || state == STATE_READY );

		if( call Config.isAckPacket(msg) )
		{
			if( state == STATE_ACK_WAIT && call Config.verifyAckPacket(txMsg, msg) )
			{
				call RadioAlarm.cancel();
				call AckReceivedFlag.set(txMsg);

				state = STATE_READY;
				signal RadioSend.sendDone(SUCCESS);
			}

			return msg;
		}

		if( state == STATE_READY && call Config.requiresAckReply(msg) )
		{
			call Config.createAckPacket(msg, &ackMsg);

			// TODO: what to do if we are busy and cannot send an ack
			if( call SubSend.send(&ackMsg) == SUCCESS )
				state = STATE_ACK_SEND;
			else
				RADIO_ASSERT(FALSE);
		}

		return signal RadioReceive.receive(msg);
	}

/*----------------- PacketAcknowledgements -----------------*/

	async command error_t PacketAcknowledgements.requestAck(message_t* msg)
	{
		call Config.setAckRequired(msg, TRUE);

		return SUCCESS;
	}

	async command error_t PacketAcknowledgements.noAck(message_t* msg)
	{
		call Config.setAckRequired(msg, FALSE);

		return SUCCESS;
	}

	async command bool PacketAcknowledgements.wasAcked(message_t* msg)
	{
		return call AckReceivedFlag.get(msg);
	}
}
