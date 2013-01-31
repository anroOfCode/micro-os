#ifndef PLATFORM_MESSAGE_H
#define PLATFORM_MESSAGE_H

#include <CC2420XRadio.h>

typedef union message_header {
  cc2420xpacket_header_t cc2420;
  //serial_header_t serial;
} message_header_t;

typedef union message_footer {
  cc2420xpacket_footer_t cc2420;
} message_footer_t;

typedef union message_metadata {
  cc2420xpacket_metadata_t cc2420;
} message_metadata_t;

#endif
