#include <Tasklet.h>

/**
 * This interface provides one bit storage for each neighbor in a very
 * fast and conveint way (without using shifts for example). 
 */
interface NeighborhoodFlag
{
	/**
	 * Returns the value of the flag for the given index
	 */
	tasklet_async command bool get(uint8_t idx);
	
	/**
	 * Sets the flag for the given index
	 */
	tasklet_async command void set(uint8_t idx);

	/**
	 * Clears the flag for the given index. The flag is automatically
	 * cleared after the Neighborhood.evicted event is fired.
	 */
	tasklet_async command void clear(uint8_t idx);

	/**
	 * Clears the flag for all indices
	 */
	tasklet_async command void clearAll();
}
