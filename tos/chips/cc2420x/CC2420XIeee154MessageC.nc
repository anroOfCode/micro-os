#include <RadioConfig.h>

configuration CC2420XIeee154MessageC
{
	provides 
	{
		interface SplitControl;

		interface BareSend as Ieee154Send;
		interface BareReceive as Ieee154Receive;

		interface PacketAcknowledgements;
		interface LowPowerListening;
		interface PacketLink;

		interface RadioChannel;

		interface PacketField<uint8_t> as PacketLinkQuality;
		interface PacketField<uint8_t> as PacketTransmitPower;
		interface PacketField<uint8_t> as PacketRSSI;

		interface LocalTime<TRadio> as LocalTimeRadio;
	}
}

implementation
{
	components CC2420XRadioC;

	SplitControl = CC2420XRadioC.SplitControl;

	Ieee154Send = CC2420XRadioC.Ieee154Send;
	Ieee154Receive = CC2420XRadioC.Ieee154Receive;

	PacketAcknowledgements = CC2420XRadioC;
	LowPowerListening = CC2420XRadioC;
	PacketLink = CC2420XRadioC;

	RadioChannel = CC2420XRadioC;

	PacketLinkQuality = CC2420XRadioC.PacketLinkQuality;
	PacketTransmitPower = CC2420XRadioC.PacketTransmitPower;
	PacketRSSI = CC2420XRadioC.PacketRSSI;

	LocalTimeRadio = CC2420XRadioC;
}
