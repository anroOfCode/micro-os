#ifndef IEEEEUI64_H
#define IEEEEUI64_H

enum { IEEE_EUI64_LENGTH = 8 };

typedef struct ieee_eui64 {
  uint8_t data[IEEE_EUI64_LENGTH];
} ieee_eui64_t;

#endif // IEEEEUI64_H
