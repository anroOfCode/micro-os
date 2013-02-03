generic configuration Ieee154PacketLayerC()
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
	components new Ieee154PacketLayerP();

	Ieee154PacketHelper = Ieee154PacketLayerP;
	RadioPacket = Ieee154PacketLayerP;
	SubPacket = Ieee154PacketLayerP;
}
