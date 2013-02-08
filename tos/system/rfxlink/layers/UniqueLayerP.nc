#include <Tasklet.h>
#include <Neighborhood.h>

generic module UniqueLayerP()
{
	provides
	{
		interface BareSend as Send;
		interface RadioReceive;

		interface Init;
	}

	uses
	{
		interface BareSend as SubSend;
		interface RadioReceive as SubReceive;

		interface Ieee154PacketHelper;
		interface Neighborhood;
		interface NeighborhoodFlag;
	}
}

implementation
{
	uint8_t sequenceNumber;

	command error_t Init.init()
	{
		sequenceNumber = TOS_NODE_ID << 4;
		return SUCCESS;
	}

	command error_t Send.send(message_t* msg)
	{
		call Ieee154PacketHelper.setDSN(msg, ++sequenceNumber);
		return call SubSend.send(msg);
	}

	command error_t Send.cancel(message_t* msg)
	{
		return call SubSend.cancel(msg);
	}

	event void SubSend.sendDone(message_t* msg, error_t error)
	{
		signal Send.sendDone(msg, error);
	}

	tasklet_async event bool SubReceive.header(message_t* msg)
	{
		// we could scan here, but better be lazy
		return signal RadioReceive.header(msg);
	}

	tasklet_norace uint8_t receivedNumbers[NEIGHBORHOOD_SIZE];

	tasklet_async event message_t* SubReceive.receive(message_t* msg)
	{
		uint8_t idx = call Neighborhood.insertNode(call Ieee154PacketHelper.getSrcAddr(msg));
		uint8_t dsn = call Ieee154PacketHelper.getDSN(msg);

		if( call NeighborhoodFlag.get(idx) )
		{
			uint8_t diff = dsn - receivedNumbers[idx];

			if( diff == 0 )
			{
				//call UniqueConfig.reportChannelError();
				return msg;
			}
		}
		else
			call NeighborhoodFlag.set(idx);

		receivedNumbers[idx] = dsn;

		return signal RadioReceive.receive(msg);
	}

	tasklet_async event void Neighborhood.evicted(uint8_t idx) { }
}
