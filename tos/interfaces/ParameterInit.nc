#include "TinyError.h"

interface ParameterInit <parameter> {

  /**
   * Initialize this component. Initialization should not assume that
   * any component is running: init() cannot call any commands besides
   * those that initialize other components. This command behaves
   * identically to Init.init, except that it takes a parameter.
   *
   * @param   param   the initialization parameter
   * @return          SUCCESS if initialized properly, FAIL otherwise.
   */
  command error_t init(parameter param);
}
