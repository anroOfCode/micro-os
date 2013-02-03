interface Scheduler {

    /** 
     * Initialize the scheduler.
     */
    command void init();

    /** 
      * Run the next task if one is waiting, otherwise return immediately. 
      *
      * @return        whether a task was run -- TRUE indicates a task
      *                ran, FALSE indicates there was no task to run.
      */
    command bool runNextTask();

    /**
     * Enter an infinite task-running loop. Put the MCU into a low power
     * state when the processor is idle (task queue empty, waiting for
     * interrupts). This call never returns.
     */
    command void taskLoop();
}

