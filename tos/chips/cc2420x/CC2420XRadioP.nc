#include <CC2420XRadio.h>
#include <RadioConfig.h>
#include <Tasklet.h>

module CC2420XRadioP
{
	provides
	{
		interface CC2420XDriverConfig;
		interface SoftwareAckConfig;
		interface UniqueConfig;
		interface CsmaConfig;
		interface RandomCollisionConfig;
		interface DummyConfig;

#ifdef LOW_POWER_LISTENING
		interface LowPowerListeningConfig;
#endif
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

	async command uint16_t SoftwareAckConfig.getAckTimeout()
	{
		return (uint16_t)(SOFTWAREACK_TIMEOUT * RADIO_ALARM_MICROSEC);
	}

	tasklet_async command void SoftwareAckConfig.reportChannelError()
	{
#ifdef TRAFFIC_MONITOR
//		signal TrafficMonitorConfig.channelError();
#endif
	}

/*----------------- UniqueConfig -----------------*/

	async command uint8_t UniqueConfig.getSequenceNumber(message_t* msg)
	{
		return call Ieee154PacketHelper.getDSN(msg);
	}

	async command void UniqueConfig.setSequenceNumber(message_t* msg, uint8_t dsn)
	{
		call Ieee154PacketHelper.setDSN(msg, dsn);
	}

	async command ieee154_addr_t UniqueConfig.getSender(message_t* msg)
	{
		return call Ieee154PacketHelper.getSrcAddr(msg);
	}

	tasklet_async command void UniqueConfig.reportChannelError()
	{
	}

/*----------------- CsmaConfig -----------------*/

	async command bool CsmaConfig.requiresSoftwareCCA(message_t* msg)
	{
		return call Ieee154PacketHelper.isDataFrame(msg);
	}

/*----------------- RandomCollisionConfig -----------------*/

	/*
	 * We try to use the same values as in CC2420
	 *
	 * CC2420_MIN_BACKOFF = 10 jiffies = 320 microsec
	 * CC2420_BACKOFF_PERIOD = 10 jiffies
	 * initial backoff = 0x1F * CC2420_BACKOFF_PERIOD = 310 jiffies = 9920 microsec
	 * congestion backoff = 0x7 * CC2420_BACKOFF_PERIOD = 70 jiffies = 2240 microsec
	 */

#ifndef LOW_POWER_LISTENING

	async command uint16_t RandomCollisionConfig.getMinimumBackoff()
	{
		return (uint16_t)(320 * RADIO_ALARM_MICROSEC);
	}

	async command uint16_t RandomCollisionConfig.getInitialBackoff(message_t* msg)
	{
		return (uint16_t)(9920 * RADIO_ALARM_MICROSEC);
	}

	async command uint16_t RandomCollisionConfig.getCongestionBackoff(message_t* msg)
	{
		return (uint16_t)(2240 * RADIO_ALARM_MICROSEC);
	}

#endif

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

/*----------------- LowPowerListening -----------------*/

#ifdef LOW_POWER_LISTENING

	command bool LowPowerListeningConfig.needsAutoAckRequest(message_t* msg)
	{
		return call Ieee154PacketHelper.getDestAddr(msg) != TOS_BCAST_ADDR;
	}

	command bool LowPowerListeningConfig.ackRequested(message_t* msg)
	{
		return call Ieee154PacketHelper.getAckRequired(msg);
	}

	command uint16_t LowPowerListeningConfig.getListenLength()
	{
		return 5;
	}

	async command uint16_t RandomCollisionConfig.getMinimumBackoff()
	{
		return (uint16_t)(320 * RADIO_ALARM_MICROSEC);
	}

	async command uint16_t RandomCollisionConfig.getInitialBackoff(message_t* msg)
	{
		return (uint16_t)(1600 * RADIO_ALARM_MICROSEC);
	}

	async command uint16_t RandomCollisionConfig.getCongestionBackoff(message_t* msg)
	{
		return (uint16_t)(3200 * RADIO_ALARM_MICROSEC);
	}

#endif

}
