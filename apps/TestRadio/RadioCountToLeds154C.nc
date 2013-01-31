#include "RadioCountToLeds154.h"

/**
 * Configuration for the RadioCountToLeds application. RadioCountToLeds
 * maintains a 4Hz counter, broadcasting its value in an AM packet
 * every time it gets updated. A RadioCountToLeds node that hears a counter
 * displays the bottom three bits on its LEDs. This application is a useful
 * test to show that basic AM communication and timers work.
 *
 * @author Philip Levis
 * @author Brad Campbell (change to use Ieee154 interfaces)
 * @date   June 6 2005
 */

configuration RadioCountToLeds154C {}
implementation {
  components MainC, RadioCountToLeds154P as App, LedsC;
  components CC2420XIeee154MessageC;
  components new TimerMilliC();

  App.Boot -> MainC.Boot;

  App.Receive -> CC2420XIeee154MessageC.Ieee154Receive;
  App.Ieee154Send -> CC2420XIeee154MessageC.Ieee154Send;
  App.RadioControl -> CC2420XIeee154MessageC.SplitControl;
  App.Leds -> LedsC;
  App.MilliTimer -> TimerMilliC;
  App.Ieee154Packet -> CC2420XIeee154MessageC.Packet;
}


