generic configuration LowPowerListeningDummyC()
{
	provides
	{
		interface SplitControl;
		interface BareSend as Send;
		interface BareReceive as Receive;
		interface RadioPacket;

		interface LowPowerListening;
	}
	uses
	{
		interface SplitControl as SubControl;
		interface BareSend as SubSend;
		interface BareReceive as SubReceive;
		interface RadioPacket as SubPacket;
	}
}

implementation
{
	SplitControl = SubControl;
	Send = SubSend;
	Receive = SubReceive;
	RadioPacket = SubPacket;

	components new LowPowerListeningDummyP();
	LowPowerListening = LowPowerListeningDummyP;
}
