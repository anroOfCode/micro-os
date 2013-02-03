interface Platform {
    /*
     * platforms provide a low level usec timing element.
     * usecsRaw returns a raw value for this timing element.
     * This is used in low level time outs that are time based.
     */
    async command uint16_t usecsRaw();

    /*
     * platforms provide a longer term timing element.
     *
     * typically 32768 Hz (32 KiHz).  For lack of a better name
     * call it jiffies.  Note.   Existing code calls these ticks
     * jiffies already.
     */
    async command uint16_t jiffiesRaw();
}
