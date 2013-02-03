#include "TinyError.h"

interface Init {

    /**
     * Initialize this component. Initialization should not assume that
     * any component is running: init() cannot call any commands besides
     * those that initialize other components.  
     * 
     * @return SUCCESS if initialized properly, FAIL otherwise.
     * @see TEP 107: Boot Sequence
     *
     */
    command error_t init();
}
