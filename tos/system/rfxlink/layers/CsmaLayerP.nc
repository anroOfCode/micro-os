#include <Tasklet.h>
#include <RadioAssert.h>

generic module CsmaLayerP()
{
	provides
	{
		interface RadioSend;
	}

	uses
	{
		interface CsmaConfig as Config;

		interface RadioSend as SubSend;
		interface RadioCCA as SubCCA;
	}
}

implementation
{
	tasklet_norace message_t *txMsg;

	tasklet_norace uint8_t state;
	enum
	{
		STATE_READY = 0,
		STATE_CCA_WAIT = 1,
		STATE_SEND = 2,
	};

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
			if( call Config.requiresSoftwareCCA(msg) )
			{
				txMsg = msg;

				if( (error = call SubCCA.request()) == SUCCESS )
					state = STATE_CCA_WAIT;
			}
			else if( (error = call SubSend.send(msg)) == SUCCESS )
				state = STATE_SEND;
		}
		else
			error = EBUSY;

		return error;
	}

	tasklet_async event void SubCCA.done(error_t error)
	{
		RADIO_ASSERT( state == STATE_CCA_WAIT );

		if( error == SUCCESS && (error = call SubSend.send(txMsg)) == SUCCESS )
			state = STATE_SEND;
		else
		{
			state = STATE_READY;
			signal RadioSend.sendDone(EBUSY);
		}
	}

	tasklet_async event void SubSend.sendDone(error_t error)
	{
		RADIO_ASSERT( state == STATE_SEND );

		state = STATE_READY;
		signal RadioSend.sendDone(error);
	}
}
