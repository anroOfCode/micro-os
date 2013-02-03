interface SplitControl
{
  /**
   * Start this component and all of its subcomponents.  Return
   * values of SUCCESS will always result in a <code>startDone()</code>
   * event being signalled.
   *
   * @return SUCCESS if the device is already in the process of 
   *         starting or the device was off and the device is now ready to turn 
   *         on.  After receiving this return value, you should expect a 
   *         <code>startDone</code> event in the near future.<br>
   *         EBUSY if the component is in the middle of powering down
   *               i.e. a <code>stop()</code> command has been called,
   *               and a <code>stopDone()</code> event is pending<br>
   *         EALREADY if the device is already on <br>
   *         FAIL Otherwise
   */
  command error_t start();

  /** 
   * Notify caller that the component has been started and is ready to
   * receive other commands.
   *
   * @param <b>error</b> -- SUCCESS if the component was successfully
   *                        turned on, FAIL otherwise
   */
  event void startDone(error_t error);

  /**
   * Start this component and all of its subcomponents.  Return
   * values of SUCCESS will always result in a <code>startDone()</code>
   * event being signalled.
   *
   * @return SUCCESS if the device is already in the process of 
   *         stopping or the device was on and the device is now ready to turn 
   *         off.  After receiving this return value, you should expect a 
   *         <code>stopDone</code> event in the near future.<br>
   *         EBUSY if the component is in the middle of powering up
   *               i.e. a <code>start()</code> command has been called,
   *               and a <code>startDone()</code> event is pending<br>
   *         EALREADY if the device is already off <br>
   *         FAIL Otherwise
   */
  command error_t stop();

  /**
   * Notify caller that the component has been stopped.
   *
  * @param <b>error</b> -- SUCCESS if the component was successfully
  *                        turned off, FAIL otherwise
   */
  event void stopDone(error_t error);
}
