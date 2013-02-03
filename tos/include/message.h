#ifndef __MESSAGE_H__
#define __MESSAGE_H__

#include "platform_message.h"

#ifndef TOSH_DATA_LENGTH
#define TOSH_DATA_LENGTH 28
#endif

// used by the Driver layer to determine if
// LPL should auto request ACK.
#define TOS_BCAST_ADDR 0xFFFF
#define TOS_GROUP 0x22
#define TOS_ADDR 1

typedef nx_struct message_t {
  nx_uint8_t header[sizeof(message_header_t)];
  nx_uint8_t data[TOSH_DATA_LENGTH];
  nx_uint8_t footer[sizeof(message_footer_t)];
  nx_uint8_t metadata[sizeof(message_metadata_t)];
} message_t;

#define RADIO_SEND_RESOURCE "RADIO_SEND_RESOURCE"

#endif
