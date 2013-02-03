#include "Timer.h"

/**
 * A LocalTime interface counts time in some units. If you need to detect
 * time overflow, you should use a component offering the Counter
 * interface.
 *
 * <p>The LocalTime interface is parameterised by its "precision"
 * (milliseconds, microseconds, etc), identified by a type. This prevents,
 * e.g., unintentionally mixing components expecting milliseconds with
 * those expecting microseconds as those interfaces have a different type.
 *
 * <p>See TEP102 for more details.
 *
 * @param precision_tag A type indicating the precision of this Counter.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 */

interface LocalTime<precision_tag>
{
  /** 
   * Return current time. Time starts counting at boot - some time sources
   * may stop counting while the processor is in low-power mode.
   *
   * @return Current time.
   */
  async command uint32_t get();
}

