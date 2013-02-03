#include "IeeeEui64.h"

/**
 * Interface to read the 64-bit IEEE EUI.
 *
 */
interface LocalIeeeEui64 {
  /**
   * Get the 64-bit IEEE EUI.
   * @returns the 64-bit IEEE EUI type, defined in tos/types/IeeeEui64.h
   */
  command ieee_eui64_t getId();
}
