#include "RadioCountToLeds154.h"

configuration RadioCountToLeds154C {}

implementation {
    components MainC, RadioCountToLeds154P as App, LedsC;
    components CC2420XIeee154MessageC;
    components new TimerMilliC();

    App.Boot -> MainC.Boot;

    App.Ieee154Receive -> CC2420XIeee154MessageC.Ieee154Receive;
    App.Ieee154Send -> CC2420XIeee154MessageC.Ieee154Send;
    App.RadioControl -> CC2420XIeee154MessageC.SplitControl;
    App.Leds -> LedsC;
    App.MilliTimer -> TimerMilliC;
}


