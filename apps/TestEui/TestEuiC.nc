/**
 * This application reads the 64-bit EUI of the device at initialization time
 * and then periodically, and prints it out using printf.
 *
 */
module TestEuiC
{
  uses interface Boot;
  uses interface Timer<TMilli>;
  uses interface Leds;
  uses interface LocalIeeeEui64;
}
implementation
{
  void print() {
  }

  event void Boot.booted()  {
    call Timer.startPeriodic(1000);
  }

  event void Timer.fired() {
    int i;
    ieee_eui64_t id;

    call Leds.led0Toggle();

    id = call LocalIeeeEui64.getId();

    printf("IEEE 64-bit UID: ");
    for(i=0;i<8;i++) {
      printf("%d ", id.data[i]);
    }
    printf("\n");
  	printfflush();

  }
}

