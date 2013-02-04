#include <MetadataFlagsLayer.h>
#include <RadioAssert.h>

generic module MetadataFlagsLayerC()
{
	provides 
	{
		interface PacketFlag[uint8_t bit];
		interface RadioPacket;
	}

	uses
	{
		interface RadioPacket as SubPacket;
	}
}

implementation
{
	flags_metadata_t* getMeta(message_t* msg)
	{
		return ((void*)msg) + sizeof(message_t) - call RadioPacket.metadataLength(msg);
	}

/*----------------- RadioPacket -----------------*/

	async command bool PacketFlag.get[uint8_t bit](message_t* msg)
	{
		return getMeta(msg)->flags & (1<<bit);
	}

	async command void PacketFlag.set[uint8_t bit](message_t* msg)
	{
		RADIO_ASSERT( bit  < 8 );

		getMeta(msg)->flags |= (1<<bit);
	}

	async command void PacketFlag.clear[uint8_t bit](message_t* msg)
	{
		RADIO_ASSERT( bit  < 8 );

		getMeta(msg)->flags &= ~(1<<bit);
	}

	async command void PacketFlag.setValue[uint8_t bit](message_t* msg, bool value)
	{
		if( value )
			call PacketFlag.set[bit](msg);
		else
			call PacketFlag.clear[bit](msg);
	}

/*----------------- RadioPacket -----------------*/
	
	async command uint8_t RadioPacket.headerLength(message_t* msg)
	{
		return call SubPacket.headerLength(msg);
	}

	async command uint8_t RadioPacket.payloadLength(message_t* msg)
	{
		return call SubPacket.payloadLength(msg);
	}

	async command void RadioPacket.setPayloadLength(message_t* msg, uint8_t length)
	{
		call SubPacket.setPayloadLength(msg, length);
	}

	async command uint8_t RadioPacket.maxPayloadLength()
	{
		return call SubPacket.maxPayloadLength();
	}

	async command uint8_t RadioPacket.metadataLength(message_t* msg)
	{
		return call SubPacket.metadataLength(msg) + sizeof(flags_metadata_t);
	}

	async command void RadioPacket.clear(message_t* msg)
	{
		getMeta(msg)->flags = 0;
		call SubPacket.clear(msg);
	}
}
