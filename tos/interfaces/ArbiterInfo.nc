/**
 * Please refer to TEP 108 for more information about this interface and its
 * intended use.<br><br>
 *
 * The ArbiterInfo interface allows a component to query the current 
 * status of an arbiter.  It must be provided by ALL arbiter implementations,
 * and can be used for a variety of different purposes.  Normally it will be
 * used in conjunction with the Resource interface for performing run time
 * checks on access rights to a particular shared resource.
 *
 * @author Kevin Klues (klueska@cs.wustl.edu)
 */

interface ArbiterInfo {
  /**
   * Check whether a resource is currently allocated.
   *
   * @return TRUE If the resource being arbitrated is currently allocated
   *              to any of its users<br>
   *         FALSE Otherwise.
   */
  async command bool inUse();

  /**
   * Get the id of the client currently using a resource.
   * 
   * @return Id of the current owner of the resource<br>
   *         0xFF if no one currently owns the resource
   */
  async command uint8_t userId();
}
