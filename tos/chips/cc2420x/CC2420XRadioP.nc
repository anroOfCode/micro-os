#include <CC2420XRadio.h>
#include <RadioConfig.h>
#include <Tasklet.h>

module CC2420XRadioP
{
	provides
	{
		interface CC2420XDriverConfig;
		interface SoftwareAckConfig;
		interface DummyConfig;
		interface RandomCollisionConfig;
	}

	uses
	{
		interface Ieee154PacketHelper;
		interface RadioAlarm;
		interface RadioPacket as CC2420XPacket;
	}
}

implementation
{

/*----------------- CC2420XDriverConfig -----------------*/

	async command uint8_t CC2420XDriverConfig.headerLength(message_t* msg)
	{
		return offsetof(message_t, data) - sizeof(cc2420xpacket_header_t);
	}

	async command uint8_t CC2420XDriverConfig.maxPayloadLength()
	{
		return sizeof(cc2420xpacket_header_t) + TOSH_DATA_LENGTH;
	}

	async command uint8_t CC2420XDriverConfig.metadataLength(message_t* msg)
	{
		return 0;
	}

	async command uint8_t CC2420XDriverConfig.headerPreloadLength()
	{
		// we need the fcf, dsn, len
		return 4;
	}

	async command bool CC2420XDriverConfig.requiresRssiCca(message_t* msg)
	{
		return call Ieee154PacketHelper.isDataFrame(msg);
	}

/*----------------- SoftwareAckConfig -----------------*/

	async command bool SoftwareAckConfig.requiresAckWait(message_t* msg)
	{
		return call Ieee154PacketHelper.requiresAckWait(msg);
	}

	async command bool SoftwareAckConfig.isAckPacket(message_t* msg)
	{
		return call Ieee154PacketHelper.isAckFrame(msg);
	}

	async command bool SoftwareAckConfig.verifyAckPacket(message_t* data, message_t* ack)
	{
		return call Ieee154PacketHelper.verifyAckReply(data, ack);
	}

	async command void SoftwareAckConfig.setAckRequired(message_t* msg, bool ack)
	{
		call Ieee154PacketHelper.setAckRequired(msg, ack);
	}

	async command bool SoftwareAckConfig.requiresAckReply(message_t* msg)
	{
		return call Ieee154PacketHelper.requiresAckReply(msg);
	}

	async command void SoftwareAckConfig.createAckPacket(message_t* data, message_t* ack)
	{
		call Ieee154PacketHelper.createAckReply(data, ack);
	}

	tasklet_async command void SoftwareAckConfig.reportChannelError()
	{
#ifdef TRAFFIC_MONITOR
//		signal TrafficMonitorConfig.channelError();
#endif
	}

/*----------------- CsmaConfig -----------------*/

	async command uint16_t RandomCollisionConfig.getTransmitBarrier(message_t* msg)
	{
		uint16_t time;

		// TODO: maybe we should use the embedded timestamp of the message
		time = call RadioAlarm.getNow();

		// estimated response time (download the message, etc) is 5-8 bytes
		if( call Ieee154PacketHelper.requiresAckReply(msg) )
			time += (uint16_t)(32 * (-5 + 16 + 11 + 5) * RADIO_ALARM_MICROSEC);
		else
			time += (uint16_t)(32 * (-5 + 5) * RADIO_ALARM_MICROSEC);

		return time;
	}

	tasklet_async event void RadioAlarm.fired()
	{
	}

/*----------------- Dummy -----------------*/
	async command void DummyConfig.nothing()
	{
	}
}
