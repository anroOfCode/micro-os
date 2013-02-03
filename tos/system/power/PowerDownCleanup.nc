interface PowerDownCleanup {
  /**
   * This command will be called by the power management component of
   * a shared Resource.  The implementation of this command defines
   * what must be done just before that shared Resource is shut off.
   *
   */
  async command void cleanup();
} 
