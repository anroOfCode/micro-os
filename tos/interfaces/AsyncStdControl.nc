/**
 * Please refer to TEP 115 for more information about this interface and its
 * intended use.<br><br>
 *
 * This is the asynchronous counterpart to the StdContol interface.  It
 * should be used for switching between the on and off power states of
 * the component providing it.  This interface differs from the
 * StdControl interface only in the fact that any of its commands can
 * be called from asynchronous context.
 *
 * @author Joe Polastre
 * @author Kevin Klues (klueska@cs.wustl.edu)
 */

interface AsyncStdControl
{
  /**
   * Start this component and all of its subcomponents.
   *
   * @return SUCCESS if the component was either already on or was 
   *         successfully turned on<br>
   *         FAIL otherwise
   */
  async command error_t start();

  /**
   * Stop the component and any pertinent subcomponents (not all
   * subcomponents may be turned off due to wakeup timers, etc.).
   *
   * @return SUCCESS if the component was either already off or was 
   *         successfully turned off<br>
   *         FAIL otherwise
   */
  async command error_t stop();
}
