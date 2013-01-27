#include "hardware.h"

module PlatformP {
  provides {
    interface Init;
  }
  uses {
    interface Init as MoteClockInit;
    interface Init as MoteInit;
    interface Init as LedsInit;
  }
}
implementation {
  command error_t Init.init() {
    WDTCTL = WDTPW + WDTHOLD;
    call MoteClockInit.init();
    call MoteInit.init();
    call LedsInit.init();
    return SUCCESS;
  }

  default command error_t LedsInit.init() {
    return SUCCESS;
  }
}
