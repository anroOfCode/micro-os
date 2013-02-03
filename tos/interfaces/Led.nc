interface Led {
    /** Turn the LED on. */
    async command void on ();

    /** Turn the LED off. */
    async command void off ();

    /** Turn the LED on or off, depending on parameter.
    * @param turn_on if TRUE, turn LED on; otherwise turn LED off */
    async command void set (bool turn_on);

    /** Toggle the LED. */
    async command void toggle ();
}
