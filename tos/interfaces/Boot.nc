/**
  * Interface that notifies components when TinyOS has booted
  * (initialized all of its components), as discussed in TEP 107.
  *
  * @author Philip Levis
  * @date   January 5 2005
  */ 

interface Boot {
    /**
     * Signaled when the system has booted successfully. Components can
     * assume the system has been initialized properly. Services may
     * need to be started to work, however.
     *
     * @see StdControl
     * @see SplitConrol
     * @see TEP 107: Boot Sequence
     */
    event void booted();
}

