interface GpioInterrupt {

    /** 
     * Enable an edge based interrupt. Calls to these functions are
     * not cumulative: only the transition type of the last called function
     * will be monitored for.
     *
     *
     * @return SUCCESS if the interrupt has been enabled
     */
    async command error_t enableRisingEdge();
    async command error_t enableFallingEdge();

    /**  
     * Diables an edge interrupt or capture interrupt
     * 
     * @return SUCCESS if the interrupt has been disabled
     */ 
    async command error_t disable();

    /**
     * Fired when an edge interrupt occurs.
     *
     * NOTE: Interrupts keep running until "disable()" is called
     */
    async event void fired();

}
