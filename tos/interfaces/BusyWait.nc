#include "Timer.h"

/**
 * BusyWait is a low-level interface intended for busy waiting for short
 * durations.
 *
 * <p>BusyWait is parameterised by its "precision" (milliseconds,
 * microseconds, etc), identified by a type. This prevents, e.g.,
 * unintentionally mixing components expecting milliseconds with those
 * expecting microseconds as those interfaces have a different type.
 *
 * <p>BusyWait's second parameter is its "width", i.e., the number of bits
 * used to represent time values. Width is indicated by including the
 * appropriate size integer type as a BusyWait parameter.
 *
 * <p>See TEP102 for more details.
 *
 * @param precision_tag A type indicating the precision of this BusyWait
 *   interface.
 * @param size_type An integer type representing time values for this 
 *   BusyWait interface.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 */

interface BusyWait<precision_tag, size_type>
{
  /**
   * Busy wait for (at least) dt time units. Use sparingly, when the
   * cost of using an Alarm or Timer would be too high.
   * @param dt Time to busy wait for.
   */
  async command void wait(size_type dt);
}

