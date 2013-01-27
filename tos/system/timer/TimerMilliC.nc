#include "Timer.h"

generic configuration TimerMilliC() {
  provides interface Timer<TMilli>;
}
implementation {
  components TimerMilliP;

  // The key to unique is based off of TimerMilliC because TimerMilliImplP
  // is just a pass-through to the underlying HIL component (TimerMilli).
  Timer = TimerMilliP.TimerMilli[unique(UQ_TIMER_MILLI)];
}