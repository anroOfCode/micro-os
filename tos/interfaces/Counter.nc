#include "Timer.h"

/**
 * A Counter counts time in some units and in some width, signaling
 * overflow.
 *
 * <p>A Counter is parameterised by its "precision" (milliseconds,
 * microseconds, etc), identified by a type. This prevents, e.g.,
 * unintentionally mixing components expecting milliseconds with those
 * expecting microseconds as those interfaces have a different type.
 *
 * <p>A Counter's second parameter is its "width", i.e., the number of
 * bits used to represent time values. Width is indicated by including
 * the appropriate size integer type as a Counter parameter.
 *
 * <p>See TEP102 for more details.
 *
 * @param precision_tag A type indicating the precision of this Counter.
 * @param size_type An integer type representing time values for this Counter.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 */

interface Counter<precision_tag, size_type>
{
  /** 
   * Return counter value. Counters start at boot - some time sources may
   * stop counting while the processor is in low-power mode.
   * @return Current counter value.
   */
  async command size_type get();

  /** 
   * Return TRUE if an overflow event will occur after the outermost atomic
   * block is exits.  FALSE otherwise.
   * @return Counter pending overflow status.
   */
  async command bool isOverflowPending();

  /**
   * Cancel a pending overflow interrupt.
   */
  async command void clearOverflow();

  /**
   * Signals that the current time has overflowed.  That is, the current
   * time has wrapped around from its maximum value to zero.
   */ 
  async event void overflow();
}

