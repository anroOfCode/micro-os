/**
 *
 * @author Kevin Klues (klueska@cs.wustl.edu)
 * @version $Revision: 1.7 $
 * @date $Date: 2010-06-29 22:07:56 $
 */
 
#include "Resource.h"
 
generic module FcfsResourceQueueC(uint8_t size) @safe() {
  provides {
    interface Init;
    interface ResourceQueue as FcfsQueue;
  }
}
implementation {
  enum {NO_ENTRY = 0xFF};

  uint8_t resQ[size];
  uint8_t qHead = NO_ENTRY;
  uint8_t qTail = NO_ENTRY;

  command error_t Init.init() {
    memset(resQ, NO_ENTRY, sizeof(resQ));
    return SUCCESS;
  }  
  
  async command bool FcfsQueue.isEmpty() {
    atomic return (qHead == NO_ENTRY);
  }
  	
  async command bool FcfsQueue.isEnqueued(resource_client_id_t id) {
  	atomic return resQ[id] != NO_ENTRY || qTail == id; 
  }

  async command resource_client_id_t FcfsQueue.dequeue() {
    atomic {
      if(qHead != NO_ENTRY) {
        uint8_t id = qHead;
        qHead = resQ[qHead];
        if(qHead == NO_ENTRY)
          qTail = NO_ENTRY;
        resQ[id] = NO_ENTRY;
        return id;
      }
      return NO_ENTRY;
    }
  }
  
  async command error_t FcfsQueue.enqueue(resource_client_id_t id) {
    atomic {
      if(!(call FcfsQueue.isEnqueued(id))) {
        if(qHead == NO_ENTRY)
	  qHead = id;
	else
	  resQ[qTail] = id;
	qTail = id;
        return SUCCESS;
      }
      return EBUSY;
    }
  }
}
