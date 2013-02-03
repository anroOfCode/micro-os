configuration SerialPrintfC {
  provides {
    interface StdControl;
  }
} implementation {
  components SerialPrintfP;
  StdControl = SerialPrintfP.StdControl;

  components MainC;
  MainC.SoftwareInit -> SerialPrintfP;

  components PlatformSerialC;
  SerialPrintfP.UartControl -> PlatformSerialC;
  SerialPrintfP.UartByte -> PlatformSerialC;

  components PutcharC;
  PutcharC.Putchar -> SerialPrintfP;
}

