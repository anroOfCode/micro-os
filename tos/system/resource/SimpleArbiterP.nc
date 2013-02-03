/**
 * Please refer to TEP 108 for more information about this component and its
 * intended use.<br><br>
 *
 * This component provides the Resource, ArbiterInfo, and ResourceRequested
 * interfaces and uses the ResourceConfigure interface as
 * described in TEP 108.  It provides arbitration to a shared resource.
 * An queue is used to keep track of which users have put
 * in requests for the resource.  Upon the release of the resource by one
 * of these users, the queue is checked and the next user
 * that has a pending request will ge granted control of the resource.  If
 * there are no pending requests, then the resource becomes idle and any
 * user can put in a request and immediately receive access to the
 * Resource.
 * 
 * @author Kevin Klues (klues@tkn.tu-berlin.de)
 * @author Philip Levis
 */
 
generic module SimpleArbiterP() @safe() {
  provides {
    interface Resource[uint8_t id];
    interface ResourceRequested[uint8_t id];
    interface ArbiterInfo;
  }
  uses {
    interface ResourceConfigure[uint8_t id];
    interface ResourceQueue as Queue;
  }
}
implementation {

  enum {RES_IDLE = 0, RES_GRANTING = 1, RES_BUSY = 2};
  enum {NO_RES = 0xFF};

  uint8_t state = RES_IDLE;
  norace uint8_t resId = NO_RES;
  norace uint8_t reqResId;
  
  task void grantedTask();
  
  async command error_t Resource.request[uint8_t id]() {
    signal ResourceRequested.requested[resId]();
    atomic {
      if(state == RES_IDLE) {
        state = RES_GRANTING;
        reqResId = id;
        post grantedTask();
        return SUCCESS;
      }
      return call Queue.enqueue(id);
    }
  }

  async command error_t Resource.immediateRequest[uint8_t id]() {
    signal ResourceRequested.immediateRequested[resId]();
    atomic {
      if(state == RES_IDLE) {
        state = RES_BUSY;
        resId = id;
        call ResourceConfigure.configure[resId]();
        return SUCCESS;
      }
      return FAIL;
    }
  }
   
  async command error_t Resource.release[uint8_t id]() {
    bool released = FALSE;
    atomic {
      if(state == RES_BUSY && resId == id) {
        if(call Queue.isEmpty() == FALSE) {
          resId = NO_RES;
          reqResId = call Queue.dequeue();
          state = RES_GRANTING;
          post grantedTask();
        }
        else {
          resId = NO_RES;
          state = RES_IDLE;
        }
        released = TRUE;
      }
    }
    if(released == TRUE) {
	    call ResourceConfigure.unconfigure[id]();
      return SUCCESS;
    }
    return FAIL;
  }
    
  /**
    Check if the Resource is currently in use
  */    
  async command bool ArbiterInfo.inUse() {
    atomic {
      if (state == RES_IDLE)
        return FALSE;
    }
    return TRUE;
  }

  /**
    Returns the current user of the Resource.
    May return the default owner id.
  */      
  async command uint8_t ArbiterInfo.userId() {
    return resId;
  }

  /**
   * Returns whether you are the current owner of the resource or not
   */      
  async command bool Resource.isOwner[uint8_t id]() {
    atomic {
      if(resId == id && state == RES_BUSY) return TRUE;
      else return FALSE;
    }
  }
  
  task void grantedTask() {
    atomic {
      resId = reqResId;
      state = RES_BUSY;
    }
    call ResourceConfigure.configure[resId]();
    signal Resource.granted[resId]();
  }
  
  //Default event/command handlers
  default event void Resource.granted[uint8_t id]() {
  }
  default async event void ResourceRequested.requested[uint8_t id]() {
  }
  default async event void ResourceRequested.immediateRequested[uint8_t id]() {
  }
  default async command void ResourceConfigure.configure[uint8_t id]() {
  }
  default async command void ResourceConfigure.unconfigure[uint8_t id]() {
  }
}
