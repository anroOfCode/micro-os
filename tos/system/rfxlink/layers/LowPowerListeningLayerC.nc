generic configuration LowPowerListeningLayerC()
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

		interface LowPowerListeningConfig as Config;
		interface PacketAcknowledgements;
	}
}

implementation
{
	components new LowPowerListeningLayerP(), new TimerMilliC();

	SplitControl = LowPowerListeningLayerP;
	Send = LowPowerListeningLayerP;
	Receive = LowPowerListeningLayerP;
	RadioPacket = LowPowerListeningLayerP;
	LowPowerListening = LowPowerListeningLayerP;

	SubControl = LowPowerListeningLayerP;
	SubSend = LowPowerListeningLayerP;
	SubReceive = LowPowerListeningLayerP;
	SubPacket = LowPowerListeningLayerP;
	Config = LowPowerListeningLayerP;
	PacketAcknowledgements = LowPowerListeningLayerP;
	
	LowPowerListeningLayerP.Timer -> TimerMilliC;

	components NoLedsC as LedsC;
	LowPowerListeningLayerP.Leds -> LedsC;
}
