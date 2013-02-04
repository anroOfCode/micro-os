generic configuration DummyLayerC()
{
	provides
	{
		interface SplitControl;
		interface BareSend;
		interface BareReceive;

		interface RadioState;
		interface RadioSend;
		interface RadioReceive;
		interface RadioCCA;
		interface RadioPacket;

		interface DummyConfig as UnconnectedConfig;
	}

	uses 
	{
		interface SplitControl as SubControl;
		interface BareSend as SubBareSend;
		interface BareReceive as SubBareReceive;

		interface RadioState as SubState;
		interface RadioSend as SubSend;
		interface RadioReceive as SubReceive;
		interface RadioCCA as SubRadioCCA;
		interface RadioPacket as SubPacket;

		interface DummyConfig as Config;
	}
}

implementation
{
	RadioState = SubState;
	RadioSend = SubSend;
	RadioReceive = SubReceive;
	RadioCCA = SubRadioCCA;
	RadioPacket = SubPacket;

	SplitControl = SubControl;
	BareSend = SubBareSend;
	BareReceive = SubBareReceive;

	Config = UnconnectedConfig;
}
