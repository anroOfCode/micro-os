#include "hardware.h"

interface McuPowerOverride {

    /**
     * Called when computing the low power state, in order to allow
     * a high-level component to institute a lower bound. Because
     * this command originates deep within the basic TinyOS scheduling
     * mechanisms, it should be used very sparingly. Refer to TEP 112 for
     * details.
     *
     * @return    the lowest power state the system can enter to meet the 
     *            requirements of this component
     */
    async command mcu_power_t lowestState();
}
