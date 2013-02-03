#include "TinyError.h"

interface GpioCapture {

    /** 
     * Enable an edge based timer capture event.
     *
     * @return Whether the timer capture has been enabled.
     */
    async command error_t captureRisingEdge();
    async command error_t captureFallingEdge();

    /**
     * Fired when an edge interrupt occurs.
     *
     * @param val The value of the 32kHz timer.
     */
    async event void captured(uint16_t time);

    /**
     * Disable further captures.
     */ 
    async command void disable();

}
