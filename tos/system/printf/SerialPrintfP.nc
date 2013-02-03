module SerialPrintfP {
  uses {
    interface StdControl as UartControl;
    interface UartByte;
  }
  provides {
    interface StdControl;
    interface Init;
    interface Putchar;
  }
}

implementation {
  
  command error_t Init.init () {
    return call StdControl.start();
  }

  command error_t StdControl.start ()
  {
    return call UartControl.start();
  }

  command error_t StdControl.stop ()
  {
    return call UartControl.stop();
  }

  int printfflush() @C() @spontaneous() {
    return SUCCESS;
  }

#undef putchar
  command int Putchar.putchar (int c)
  {
    return (SUCCESS == call UartByte.send(c)) ? c : -1;
  }
}
