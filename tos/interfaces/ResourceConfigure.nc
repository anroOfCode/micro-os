interface ResourceConfigure {
  /**
   * Used to configure a resource just before being granted access to it.
   * Must always be used in conjuntion with the Resource interface.
   */
  async command void configure();

  /**
   * Used to unconfigure a resource just before releasing it.
   * Must always be used in conjuntion with the Resource interface.
   */
  async command void unconfigure();
} 
