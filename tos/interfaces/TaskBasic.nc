#include "TinyError.h"

interface TaskBasic {

    /**
     * Post this task to the TinyOS scheduler. At some later time,
     * depending on the scheduling policy, the scheduler will signal the
     * <tt>run()</tt> event. 
     *
     * @return SUCCESS if task was successfuly
     * posted; the semantics of a non-SUCCESS return value depend on the
     * implementation of this interface (the class of task).
     */
    
    async command error_t postTask();

    /**
     * Event from the scheduler to run this task. Following the TinyOS
     * concurrency model, the codes invoked from <tt>run()</tt> signals
     * execute atomically with respect to one another, but can be
     * preempted by async commands/events.
     */
    event void runTask();
}

