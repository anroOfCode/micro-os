/**
 * Please refer to TEP 108 for more information about this component and its
 * intended use.<br><br>
 *
 * This component provides the Resource, ArbiterInfo, and Resource
 * Controller interfaces and uses the ResourceConfigure interface as
 * described in TEP 108.  It provides arbitration to a shared resource in
 * an FCFS fashion.  An array is used to keep track of which users have put
 * in requests for the resource.  Upon the release of the resource by one
 * of these users, the array is checked and the next user (in FCFS order)
 * that has a pending request will ge granted control of the resource.  If
 * there are no pending requests, then the resource becomes idle and any
 * user can put in a request and immediately receive access to the
 * Resource.
 *
 * @param <b>resourceName</b> -- The name of the Resource being shared
 * 
 * @author Kevin Klues (klues@tkn.tu-berlin.de)
 * @author Philip Levis
 */
 
generic configuration SimpleFcfsArbiterC(char resourceName[]) {
  provides {
    interface Resource[uint8_t id];
    interface ResourceRequested[uint8_t id];
    interface ArbiterInfo;
  }
  uses interface ResourceConfigure[uint8_t id];
}
implementation {
  components MainC;
  components new FcfsResourceQueueC(uniqueCount(resourceName)) as Queue;
  components new SimpleArbiterP() as Arbiter;

  MainC.SoftwareInit -> Queue;

  Resource = Arbiter;
  ResourceRequested = Arbiter;
  ArbiterInfo = Arbiter;
  ResourceConfigure = Arbiter;

  Arbiter.Queue -> Queue;
}
