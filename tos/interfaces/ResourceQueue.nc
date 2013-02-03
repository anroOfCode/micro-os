#include "Resource.h"
   
interface ResourceQueue {
	
  /**
   * Check to see if the queue is empty.
   *
   * @return TRUE  if the queue is empty. <br>
   *         FALSE if there is at least one entry in the queue
   */
  async command bool isEmpty();
  
  /**
   * Check to see if a given client id has already been enqueued
   * and is waiting to be processed.
   *
   * @return TRUE  if the client id is in the queue. <br>
   *         FALSE if it does not
   */
  async command bool isEnqueued(resource_client_id_t id);
  
  /**
   * Retreive the client id of the next resource in the queue. 
   * If the queue is empty, the return value is undefined.
   *
   * @return The client id at the head of the queue.
   */
  async command resource_client_id_t dequeue();

  /**
   * Enqueue a client id
   *
   * @param clientId - the client id to enqueue
   * @return SUCCESS if the client id was enqueued successfully <br>
   *         EBUSY   if it has already been enqueued.
   */
  async command error_t enqueue(resource_client_id_t id);
}
