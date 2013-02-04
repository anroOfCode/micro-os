#include <PacketLinkLayer.h>

generic configuration PacketLinkLayerC()
{
	provides
	{
		interface BareSend as Send;
		interface BareReceive as Receive;
		interface PacketLink;
		interface RadioPacket;
	}

	uses
	{
		interface BareSend as SubSend;
		interface BareReceive as SubReceive;
		interface RadioPacket as SubPacket;
		interface PacketAcknowledgements;
	}

#ifndef PACKET_LINK
	uses interface PacketLink as UnconnectedPacketLink;
	provides interface PacketAcknowledgements as UnconnectedPacketAcks;
#endif
}

implementation
{
#ifdef PACKET_LINK
	components new PacketLinkLayerP(), new TimerMilliC() as DelayTimerC;
  
	PacketLink = PacketLinkLayerP;
	Send = PacketLinkLayerP;
	SubSend = PacketLinkLayerP;
	PacketAcknowledgements = PacketLinkLayerP;
	RadioPacket = PacketLinkLayerP;
	SubPacket = PacketLinkLayerP;

	PacketLinkLayerP.DelayTimer -> DelayTimerC;

	Receive = SubReceive;
#else
	Send = SubSend;
	Receive = SubReceive;
	RadioPacket = SubPacket;
  
	PacketLink = UnconnectedPacketLink;
	PacketAcknowledgements = UnconnectedPacketAcks;
#endif
}
