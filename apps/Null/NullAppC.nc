configuration NullAppC{}
implementation {
  components MainC, NullC;

  MainC.Boot <- NullC;
}

