#include <RadioConfig.h>
#include <CC2420XDriverLayer.h>

configuration CC2420XDriverLayerC
{
	provides
	{
		interface RadioState;
		interface RadioSend;
		interface RadioReceive;
		interface RadioCCA;
		interface RadioPacket;

		interface PacketField<uint8_t> as PacketTransmitPower;
		interface PacketField<uint8_t> as PacketRSSI;
		interface PacketField<uint8_t> as PacketLinkQuality;
		interface LinkPacketMetadata;

		interface LocalTime<TRadio> as LocalTimeRadio;
		interface Alarm<TRadio, tradio_size>;
	}

	uses
	{
		interface CC2420XDriverConfig as Config;

		interface PacketFlag as TransmitPowerFlag;
		interface PacketFlag as RSSIFlag;
		interface RadioAlarm;
	}
}

implementation
{
	components CC2420XDriverLayerP as DriverLayerP,
		BusyWaitMicroC,
		TaskletC,
		MainC,
		HplCC2420XC as HplC;

	MainC.SoftwareInit -> DriverLayerP.SoftwareInit;
	MainC.SoftwareInit -> HplC.Init;

	RadioState = DriverLayerP;
	RadioSend = DriverLayerP;
	RadioReceive = DriverLayerP;
	RadioCCA = DriverLayerP;
	RadioPacket = DriverLayerP;

	LocalTimeRadio = HplC;
	Config = DriverLayerP;

	DriverLayerP.VREN -> HplC.VREN;
	DriverLayerP.CSN -> HplC.CSN;
	DriverLayerP.CCA -> HplC.CCA;
	DriverLayerP.RSTN -> HplC.RSTN;
	DriverLayerP.FIFO -> HplC.FIFO;
	DriverLayerP.FIFOP -> HplC.FIFOP;
	DriverLayerP.SFD -> HplC.SFD;

	PacketTransmitPower = DriverLayerP.PacketTransmitPower;
	TransmitPowerFlag = DriverLayerP.TransmitPowerFlag;

	PacketRSSI = DriverLayerP.PacketRSSI;
	RSSIFlag = DriverLayerP.RSSIFlag;

	PacketLinkQuality = DriverLayerP.PacketLinkQuality;
	LinkPacketMetadata = DriverLayerP;

	Alarm = HplC.Alarm;
	RadioAlarm = DriverLayerP.RadioAlarm;

	DriverLayerP.SpiResource -> HplC.SpiResource;
	DriverLayerP.FastSpiByte -> HplC;

	DriverLayerP.SfdCapture -> HplC;
	DriverLayerP.FifopInterrupt -> HplC;

	DriverLayerP.Tasklet -> TaskletC;
	DriverLayerP.BusyWait -> BusyWaitMicroC;

	DriverLayerP.LocalTime-> HplC.LocalTimeRadio;

#ifdef RADIO_DEBUG
	components DiagMsgC;
	DriverLayerP.DiagMsg -> DiagMsgC;
#endif

	components LedsC;
	DriverLayerP.Leds -> LedsC;
}
