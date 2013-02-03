#include "printf.h"

/**
 * This application reads the 64-bit EUI of the device at initialization time
 * and then periodically prints it out using printf.
 *
 */
configuration TestEuiAppC{}
implementation {
  components MainC, TestEuiC, LedsC, LocalIeeeEui64C, new TimerMilliC();

  MainC.Boot <- TestEuiC;
  TestEuiC.Timer -> TimerMilliC;

  TestEuiC -> LedsC.Leds;

  TestEuiC.LocalIeeeEui64 -> LocalIeeeEui64C;
}

