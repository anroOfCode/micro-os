#include <RadioConfig.h>

configuration CC2420XRadioC
{
    provides 
    {
        interface SplitControl;

        interface BareSend as Ieee154Send;
        interface BareReceive as Ieee154Receive;


        interface PacketAcknowledgements;
        interface LowPowerListening;
        interface PacketLink;

#ifdef TRAFFIC_MONITOR
        interface TrafficMonitor;
#endif

        interface RadioChannel;

        interface PacketField<uint8_t> as PacketLinkQuality;
        interface PacketField<uint8_t> as PacketTransmitPower;
        interface PacketField<uint8_t> as PacketRSSI;

        interface LocalTime<TRadio> as LocalTimeRadio;
    }
}

implementation
{
    #define UQ_METADATA_FLAGS   "UQ_CC2420X_METADATA_FLAGS"
    #define UQ_RADIO_ALARM      "UQ_CC2420X_RADIO_ALARM"

// -------- RadioP

    components CC2420XRadioP as RadioP;

#ifdef RADIO_DEBUG
    components AssertC;
#endif

    RadioP.Ieee154PacketHelper -> Ieee154PacketLayerC;
    RadioP.RadioAlarm -> RadioAlarmC.RadioAlarm[unique(UQ_RADIO_ALARM)];
    RadioP.CC2420XPacket -> RadioDriverLayerC;

// -------- RadioAlarm

    components new RadioAlarmC();
    RadioAlarmC.Alarm -> RadioDriverLayerC;

// -------- Ieee154 Message

    Ieee154Send = UniqueLayerC;
    Ieee154Receive = PacketLinkLayerC;

// -------- IEEE 802.15.4 Packet

    components new Ieee154PacketLayerC();
    Ieee154PacketLayerC.SubPacket -> PacketLinkLayerC;

// -------- UniqueLayer Send part (wired twice)

    components new UniqueLayerC();
    UniqueLayerC.Config -> RadioP;
    UniqueLayerC.SubSend -> PacketLinkLayerC;

// -------- Packet Link

    components new PacketLinkLayerC();
    PacketLink = PacketLinkLayerC;
    PacketLinkLayerC.PacketAcknowledgements -> SoftwareAckLayerC;
    PacketLinkLayerC -> LowPowerListeningLayerC.Send;
    PacketLinkLayerC -> LowPowerListeningLayerC.Receive;
    PacketLinkLayerC -> LowPowerListeningLayerC.RadioPacket;

// -------- Low Power Listening

#ifdef LOW_POWER_LISTENING
    #warning "*** USING LOW POWER LISTENING LAYER"
    components new LowPowerListeningLayerC();
    LowPowerListeningLayerC.Config -> RadioP;
    LowPowerListeningLayerC.PacketAcknowledgements -> SoftwareAckLayerC;
#else   
    components new LowPowerListeningDummyC() as LowPowerListeningLayerC;
#endif
    LowPowerListeningLayerC.SubControl -> MessageBufferLayerC;
    LowPowerListeningLayerC.SubSend -> MessageBufferLayerC;
    LowPowerListeningLayerC.SubReceive -> MessageBufferLayerC;
    LowPowerListeningLayerC.SubPacket -> MetadataFlagsLayerC;
    SplitControl = LowPowerListeningLayerC;
    LowPowerListening = LowPowerListeningLayerC;

// -------- MessageBuffer

    components new MessageBufferLayerC();
    MessageBufferLayerC.RadioSend -> CollisionAvoidanceLayerC;
    MessageBufferLayerC.RadioReceive -> UniqueLayerC;
    MessageBufferLayerC.RadioState -> TrafficMonitorLayerC;
    RadioChannel = MessageBufferLayerC;

// -------- UniqueLayer receive part (wired twice)

    UniqueLayerC.SubReceive -> CollisionAvoidanceLayerC;

// -------- CollisionAvoidance

    components new RandomCollisionLayerC() as CollisionAvoidanceLayerC;
    CollisionAvoidanceLayerC.Config -> RadioP;
    CollisionAvoidanceLayerC.SubSend -> SoftwareAckLayerC;
    CollisionAvoidanceLayerC.SubReceive -> SoftwareAckLayerC;
    CollisionAvoidanceLayerC.RadioAlarm -> RadioAlarmC.RadioAlarm[unique(UQ_RADIO_ALARM)];

// -------- SoftwareAcknowledgement

    components new SoftwareAckLayerC();
    SoftwareAckLayerC.AckReceivedFlag -> MetadataFlagsLayerC.PacketFlag[unique(UQ_METADATA_FLAGS)];
    SoftwareAckLayerC.RadioAlarm -> RadioAlarmC.RadioAlarm[unique(UQ_RADIO_ALARM)];
    PacketAcknowledgements = SoftwareAckLayerC;
    SoftwareAckLayerC.Config -> RadioP;
    SoftwareAckLayerC.SubSend -> CsmaLayerC;
    SoftwareAckLayerC.SubReceive -> CsmaLayerC;

// -------- Carrier Sense

    components new DummyLayerC() as CsmaLayerC;
    CsmaLayerC.Config -> RadioP;
    CsmaLayerC -> TrafficMonitorLayerC.RadioSend;
    CsmaLayerC -> TrafficMonitorLayerC.RadioReceive;
    CsmaLayerC -> RadioDriverLayerC.RadioCCA;

// -------- MetadataFlags

    components new MetadataFlagsLayerC();
    MetadataFlagsLayerC.SubPacket -> RadioDriverLayerC;

// -------- Traffic Monitor

#ifdef TRAFFIC_MONITOR
    components new TrafficMonitorLayerC();
    TrafficMonitor = TrafficMonitorLayerC;
#else
    components new DummyLayerC() as TrafficMonitorLayerC;
#endif
    TrafficMonitorLayerC.Config -> RadioP;
    TrafficMonitorLayerC -> RadioDriverLayerC.RadioSend;
    TrafficMonitorLayerC -> RadioDriverLayerC.RadioReceive;
    TrafficMonitorLayerC -> RadioDriverLayerC.RadioState;

// -------- Driver

    components CC2420XDriverLayerC as RadioDriverLayerC;
    RadioDriverLayerC.Config -> RadioP;
    PacketTransmitPower = RadioDriverLayerC.PacketTransmitPower;
    PacketLinkQuality = RadioDriverLayerC.PacketLinkQuality;
    PacketRSSI = RadioDriverLayerC.PacketRSSI;
    LocalTimeRadio = RadioDriverLayerC;

    RadioDriverLayerC.TransmitPowerFlag -> MetadataFlagsLayerC.PacketFlag[unique(UQ_METADATA_FLAGS)];
    RadioDriverLayerC.RSSIFlag -> MetadataFlagsLayerC.PacketFlag[unique(UQ_METADATA_FLAGS)];
    RadioDriverLayerC.RadioAlarm -> RadioAlarmC.RadioAlarm[unique(UQ_RADIO_ALARM)];
}
