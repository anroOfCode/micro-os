#include "hardware.h"

configuration PlatformC {
  provides {
    interface Init;
  }
}
implementation {
  components PlatformP;
  components MoteClockC;
  components MotePlatformC;

  Init = PlatformP;
  PlatformP.MoteClockInit -> MoteClockC;
  PlatformP.MoteInit -> MotePlatformC;
}
