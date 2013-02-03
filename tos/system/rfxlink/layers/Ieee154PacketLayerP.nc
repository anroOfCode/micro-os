#include <Ieee154PacketLayer.h>

generic module Ieee154PacketHelperP()
{
	provides 
	{
		interface Ieee154PacketHelper;
		interface RadioPacket;
	}

	uses
	{
		interface RadioPacket as SubPacket;
	}
}

implementation
{
/*----------------- Ieee154Packet -----------------*/

	enum
	{
		IEEE154_DATA_FRAME_MASK = (IEEE154_TYPE_MASK << IEEE154_FCF_FRAME_TYPE) 
			| (1 << IEEE154_FCF_INTRAPAN) 
			| (IEEE154_ADDR_MASK << IEEE154_FCF_DEST_ADDR_MODE) 
			| (IEEE154_ADDR_MASK << IEEE154_FCF_SRC_ADDR_MODE),

		IEEE154_DATA_FRAME_VALUE = (IEEE154_TYPE_DATA << IEEE154_FCF_FRAME_TYPE) 
			| (1 << IEEE154_FCF_INTRAPAN) 
			| (IEEE154_ADDR_SHORT << IEEE154_FCF_DEST_ADDR_MODE) 
			| (IEEE154_ADDR_SHORT << IEEE154_FCF_SRC_ADDR_MODE),

		IEEE154_DATA_FRAME_PRESERVE = (1 << IEEE154_FCF_ACK_REQ) 
			| (1 << IEEE154_FCF_FRAME_PENDING),

		IEEE154_ACK_FRAME_LENGTH = 3,	// includes the FCF, DSN
		IEEE154_ACK_FRAME_MASK = (IEEE154_TYPE_MASK << IEEE154_FCF_FRAME_TYPE), 
		IEEE154_ACK_FRAME_VALUE = (IEEE154_TYPE_ACK << IEEE154_FCF_FRAME_TYPE),
	};

	ieee154_simple_header_t* getHeader(message_t* msg)
	{
		return ((void*)msg) + call SubPacket.headerLength(msg);
	}

	async command uint16_t Ieee154PacketHelper.getFCF(message_t* msg)
	{
		return getHeader(msg)->fcf;
	}

	async command void Ieee154PacketHelper.setFCF(message_t* msg, uint16_t fcf)
	{
		getHeader(msg)->fcf = fcf;
	}

	async command bool Ieee154PacketHelper.isDataFrame(message_t* msg)
	{
		return (getHeader(msg)->fcf & IEEE154_DATA_FRAME_MASK) == IEEE154_DATA_FRAME_VALUE;
	}

	async command void Ieee154PacketHelper.createDataFrame(message_t* msg)
	{
		// keep the ack requested and frame pending bits
		getHeader(msg)->fcf = (getHeader(msg)->fcf & IEEE154_DATA_FRAME_PRESERVE)
			| IEEE154_DATA_FRAME_VALUE;
	}

	async command bool Ieee154PacketHelper.isAckFrame(message_t* msg)
	{
		return (getHeader(msg)->fcf & IEEE154_ACK_FRAME_MASK) == IEEE154_ACK_FRAME_VALUE;
	}

	async command void Ieee154PacketHelper.createAckFrame(message_t* msg)
	{
		call SubPacket.setPayloadLength(msg, IEEE154_ACK_FRAME_LENGTH);
		getHeader(msg)->fcf = IEEE154_ACK_FRAME_VALUE;
	}

	async command void Ieee154PacketHelper.createAckReply(message_t* data, message_t* ack)
	{
		ieee154_simple_header_t* header = getHeader(ack);
		call SubPacket.setPayloadLength(ack, IEEE154_ACK_FRAME_LENGTH);

		header->fcf = IEEE154_ACK_FRAME_VALUE;
		header->dsn = getHeader(data)->dsn;
	}

	async command bool Ieee154PacketHelper.verifyAckReply(message_t* data, message_t* ack)
	{
		ieee154_simple_header_t* header = getHeader(ack);

		return header->dsn == getHeader(data)->dsn
			&& (header->fcf & IEEE154_ACK_FRAME_MASK) == IEEE154_ACK_FRAME_VALUE;
	}

	async command bool Ieee154PacketHelper.getAckRequired(message_t* msg)
	{
		return getHeader(msg)->fcf & (1 << IEEE154_FCF_ACK_REQ) ? TRUE : FALSE;
	}

	async command void Ieee154PacketHelper.setAckRequired(message_t* msg, bool ack)
	{
		if( ack )
			getHeader(msg)->fcf |= (1 << IEEE154_FCF_ACK_REQ);
		else
			getHeader(msg)->fcf &= ~(uint16_t)(1 << IEEE154_FCF_ACK_REQ);
	}

	async command bool Ieee154PacketHelper.getFramePending(message_t* msg)
	{
		return getHeader(msg)->fcf & (1 << IEEE154_FCF_FRAME_PENDING) ? TRUE : FALSE;
	}

	async command void Ieee154PacketHelper.setFramePending(message_t* msg, bool pending)
	{
		if( pending )
			getHeader(msg)->fcf |= (1 << IEEE154_FCF_FRAME_PENDING);
		else
			getHeader(msg)->fcf &= ~(uint16_t)(1 << IEEE154_FCF_FRAME_PENDING);
	}

	async command uint8_t Ieee154PacketHelper.getDSN(message_t* msg)
	{
		return getHeader(msg)->dsn;
	}

	async command void Ieee154PacketHelper.setDSN(message_t* msg, uint8_t dsn)
	{
		getHeader(msg)->dsn = dsn;
	}

	async command bool Ieee154PacketHelper.requiresAckWait(message_t* msg)
	{
		return call Ieee154PacketHelper.getAckRequired(msg)
			&& call Ieee154PacketHelper.isDataFrame(msg);
	}

	async command bool Ieee154PacketHelper.requiresAckReply(message_t* msg)
	{
		return call Ieee154PacketHelper.getAckRequired(msg)
			&& call Ieee154PacketHelper.isDataFrame(msg);
	}

	async command ieee154_addr_t Ieee154PacketHelper.getSrcAddr(message_t* msg)
	{
		ieee154_addr_t ret;
		ieee154_fcf_t* fcf_ptr;

		fcf_ptr = (ieee154_fcf_t*) &(getHeader(msg)->fcf);

		ret.ieee_mode = fcf_ptr->src_addr_mode;

		if (ret.ieee_mode == IEEE154_ADDR_SHORT)
			memcpy(&ret.ieee_addr.saddr, getHeader(msg) + 7, 2);
		else
			memcpy(&ret.ieee_addr.laddr, getHeader(msg) + 7, 8);

		return ret;
	}

/*----------------- RadioPacket -----------------*/

	async command uint8_t RadioPacket.headerLength(message_t* msg)
	{
		return call SubPacket.headerLength(msg) + sizeof(ieee154_simple_header_t);
	}

	async command uint8_t RadioPacket.payloadLength(message_t* msg)
	{
		return call SubPacket.payloadLength(msg) - sizeof(ieee154_simple_header_t);
	}

	async command void RadioPacket.setPayloadLength(message_t* msg, uint8_t length)
	{
		call SubPacket.setPayloadLength(msg, length + sizeof(ieee154_simple_header_t));
	}

	async command uint8_t RadioPacket.maxPayloadLength()
	{
		return call SubPacket.maxPayloadLength() - sizeof(ieee154_simple_header_t);
	}

	async command uint8_t RadioPacket.metadataLength(message_t* msg)
	{
		return call SubPacket.metadataLength(msg);
	}

	async command void RadioPacket.clear(message_t* msg)
	{
		call Ieee154PacketHelper.createDataFrame(msg);
		call SubPacket.clear(msg);
	}
}
