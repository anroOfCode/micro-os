#ifndef TINY_ERROR_H_INCLUDED
#define TINY_ERROR_H_INCLUDED

#ifdef NESC
#define NESC_COMBINE(x) @combine(x)
#else
#define NESC_COMBINE(x)
#endif

typedef enum {
  SUCCESS        =  0,
  FAIL           =  1,           // Generic condition: backwards compatible
  ESIZE          =  2,           // Parameter passed in was too big.
  ECANCEL        =  3,           // Operation cancelled by a call.
  EOFF           =  4,           // Subsystem is not active
  EBUSY          =  5,           // The underlying system is busy; retry later
  EINVAL         =  6,           // An invalid parameter was passed
  ERETRY         =  7,           // A rare and transient failure: can retry
  ERESERVE       =  8,           // Reservation required before usage
  EALREADY       =  9,           // The device state you are requesting is already set
  ENOMEM         = 10,           // Memory required not available
  ENOACK         = 11,           // A packet was not acknowledged
  ETIMEOUT	 = 12,		 // operation timed out
  ELAST          = 12            // Last enum value
} error_t NESC_COMBINE("ecombine");

/*
 * Returns: r1 if r1 == r2, FAIL otherwise.
 *
 * This is the standard error combination function: two successes, or
 * two identical errors are preserved, while conflicting errors are
 * represented by FAIL.
 */
error_t ecombine(error_t r1, error_t r2) @safe() {
  return r1 == r2 ? r1 : FAIL;
}

#endif
