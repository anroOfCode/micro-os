interface ResourceRequested {
  /**
   * This event is signalled whenever the user of this interface
   * currently has control of the resource, and another user requests
   * it through the Resource.request() command. You may want to
   * consider releasing a resource based on this event
  */
  async event void requested();

  /**
  * This event is signalled whenever the user of this interface
  * currently has control of the resource, and another user requests
  * it through the Resource.immediateRequest() command. You may
  * want to consider releasing a resource based on this event
  */
  async event void immediateRequested();
}
