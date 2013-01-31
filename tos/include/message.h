#ifndef __MESSAGE_H__
#define __MESSAGE_H__

#include "platform_message.h"

#define TOS_AM_GROUP 0x22

#define TOS_AM_ADDRESS 1
#define AM_BROADCAST_ADDR 0xFFFF

typedef uint16_t am_addr_t;
typedef uint8_t am_group_t;

#ifndef TOSH_DATA_LENGTH
#define TOSH_DATA_LENGTH 28
#endif

// used by the Driver layer to determine if
// LPL should auto request ACK.
#ifndef TOS_BCAST_ADDR
#define TOS_BCAST_ADDR 0xFFFF
#endif

typedef nx_struct message_t {
  nx_uint8_t header[sizeof(message_header_t)];
  nx_uint8_t data[TOSH_DATA_LENGTH];
  nx_uint8_t footer[sizeof(message_footer_t)];
  nx_uint8_t metadata[sizeof(message_metadata_t)];
} message_t;

#define RADIO_SEND_RESOURCE "RADIO_SEND_RESOURCE"

#endif
