interface McuSleep {
    /** Called by the scheduler to put the MCU to sleep. */
    async command void    sleep();
}
