interface ResourceDefaultOwner {
  /**
   * Event sent to the resource controller giving it control whenever a resource
   * goes idle. That is to say, whenever no one currently owns the resource,
   * and there are no more pending requests
  */
  async event void granted();

  /**
  * Release control of the resource
  *
  * @return SUCCESS The resource has been released and pending requests
  *                 can resume. <br>
  *             FAIL You tried to release but you are not the
  *                  owner of the resource
  */
  async command error_t release();

  /**
   *  Check if the user of this interface is the current
   *  owner of the Resource
   * 
   *  @return TRUE  It is the owner <br>
   *          FALSE It is not the owner
   */
  async command bool isOwner();

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
