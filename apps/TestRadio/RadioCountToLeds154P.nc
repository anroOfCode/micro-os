#include "Timer.h"
#include "RadioCountToLeds154.h"

 #include <stdio.h>

/**
 * Implementation of the RadioCountToLeds application. RadioCountToLeds
 * maintains a 4Hz counter, broadcasting its value in an AM packet
 * every time it gets updated. A RadioCountToLeds node that hears a counter
 * displays the bottom three bits on its LEDs. This application is a useful
 * test to show that basic AM communication and timers work.
 *
 * @author Philip Levis
 * @date   June 6 2005
 */

module RadioCountToLeds154P @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface BareReceive as Ieee154Receive;
    interface BareSend as Ieee154Send;
    interface Timer<TMilli> as MilliTimer;
    interface SplitControl as RadioControl;
  }
}
implementation {
    void sendMessage();
    message_t packet;
    uint16_t counter = 0;

    event void Boot.booted() {
        call MilliTimer.startPeriodic(500);
        call RadioControl.start();
    }

    event void RadioControl.startDone(error_t err) {
        if (err == SUCCESS) {
            sendMessage();
        }
        else {
            call RadioControl.start();
        }
    }

    void sendMessage()
    {
        error_t e;
        radio_count_msg_t* rcm;
        //call Leds.led0Toggle();
        counter++;

        //printf("RadioCountToLedsC: timer fired, counter is %hu.\n", counter);

        rcm = (radio_count_msg_t*)(((char*) &packet) + 2);
        if (rcm == NULL) {
            return;
        }

        rcm->counter = counter;

        e = call Ieee154Send.send(&packet);
        if (e == SUCCESS) {
            //printf("RadioCountToLedsC: packet sent.\n", counter);
        }
        else {
        }
    }

    event void RadioControl.stopDone(error_t err) {
        // do nothing
    }

    event void MilliTimer.fired() {
        sendMessage();
    }

    event message_t* Ieee154Receive.receive(message_t* bufPtr) {
        //  printf("RadioCountToLedsC", "Received packet of length %hhu.\n", len);

        radio_count_msg_t* rcm = (radio_count_msg_t*)bufPtr;
        if (rcm->counter & 0x1) {
        call Leds.led0On();
        }
        else {
        call Leds.led0Off();
        }
        if (rcm->counter & 0x2) {
        call Leds.led1On();
        }
        else {
        call Leds.led1Off();
        }
        if (rcm->counter & 0x4) {
        call Leds.led2On();
        }
        else {
        call Leds.led2Off();
        }
        return bufPtr;
    }

    event void Ieee154Send.sendDone(message_t* bufPtr, error_t error) {
        call Leds.led1Toggle();
    }

}




