interface McuPowerState {
    /** 
     * Called by any component to tell TinyOS that the MCU low
     * power state may have changed. Generally, this should be
     * called whenever a peripheral/timer is started/stopped. 
     */
    async command void update();
}
