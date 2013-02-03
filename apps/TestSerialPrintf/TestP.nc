#include <stdio.h>
#include <stdint.h>

module TestP @safe() {
  uses interface Boot;
  uses interface Leds;
} implementation {
  event void Boot.booted()  {
    int ctr = 0;
    while (++ctr) {
      volatile uint16_t idlectr = 0;
      printf("Hello iteration %d\n", ctr);
      call Leds.led0Toggle();
      /* "Portable" arbitrary delay, just to reduce the stream going
       * to the serial port. */
      while (++idlectr) {
        ;
      }
    }
  }
}
