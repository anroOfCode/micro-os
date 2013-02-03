configuration TestAppC {
} implementation {
  components TestP;
  components LedsC;

  components MainC;
  TestP.Boot -> MainC;
  TestP.Leds -> LedsC;
  components SerialPrintfC;
}

