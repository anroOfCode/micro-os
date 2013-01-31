configuration Ieee154MessageC  {
  provides {
    interface SplitControl;

    interface Ieee154Send;
    interface Receive as Ieee154Receive;

    interface Ieee154Packet;
    interface Packet;

    interface PacketAcknowledgements;
    interface LinkPacketMetadata;
    interface LowPowerListening;
    interface PacketLink;
  }

} implementation {
  components CC2420XIeee154MessageC as Msg;

  SplitControl = Msg;
  Ieee154Send  = Msg;
  Ieee154Receive = Msg;
  Ieee154Packet = Msg;
  Packet = Msg;
  
  PacketAcknowledgements = Msg;
  LinkPacketMetadata = Msg;
  LowPowerListening = Msg;
  PacketLink = Msg;
}
