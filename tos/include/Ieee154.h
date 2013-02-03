#ifndef __IEEE154_H__
#define __IEEE154_H__

#include "IeeeEui64.h"

#define IEEE154_SEND_CLIENT "IEEE154_SEND_CLIENT"

typedef uint16_t       ieee154_panid_t;
typedef uint16_t       ieee154_saddr_t;
typedef uint64_t       ieee154_laddr_t;

typedef struct {
  uint8_t ieee_mode:2;
  union {
    ieee154_saddr_t saddr;
    ieee154_laddr_t laddr;
  } ieee_addr;
} ieee154_addr_t;

#define i_saddr ieee_addr.saddr
#define i_laddr ieee_addr.laddr

typedef nx_struct ieee154_fcf_t {
  nxle_uint16_t frame_type: 3;
  nxle_uint16_t security_enabled: 1;
  nxle_uint16_t frame_pending: 1;
  nxle_uint16_t ack_request: 1;
  nxle_uint16_t pan_id_compression: 1;
  nxle_uint16_t _reserved: 3;
  nxle_uint16_t dest_addr_mode: 2;
  nxle_uint16_t frame_version: 2;
  nxle_uint16_t src_addr_mode: 2;
} ieee154_fcf_t;

enum {
  IEEE154_LINK_MTU       = 127,
};

struct ieee154_frame_addr {
  ieee154_addr_t  ieee_src;
  ieee154_addr_t  ieee_dst;
  ieee154_panid_t ieee_dstpan;
};

enum {
  IEEE154_MIN_HDR_SZ = 6,
};


typedef nx_struct ieee154_simple_header_t
{
  nxle_uint16_t fcf;
  nxle_uint8_t dsn;
} ieee154_simple_header_t;

enum ieee154_fcf_enums {
  IEEE154_FCF_FRAME_TYPE = 0,
  IEEE154_FCF_SECURITY_ENABLED = 3,
  IEEE154_FCF_FRAME_PENDING = 4,
  IEEE154_FCF_ACK_REQ = 5,
  IEEE154_FCF_INTRAPAN = 6,
  IEEE154_FCF_DEST_ADDR_MODE = 10,
  IEEE154_FCF_SRC_ADDR_MODE = 14,
};

enum ieee154_fcf_type_enums {
  IEEE154_TYPE_BEACON = 0,
  IEEE154_TYPE_DATA = 1,
  IEEE154_TYPE_ACK = 2,
  IEEE154_TYPE_MAC_CMD = 3,
  IEEE154_TYPE_MASK = 7,
};

enum ieee154_fcf_addr_mode_enums {
  IEEE154_ADDR_NONE = 0,
  IEEE154_ADDR_SHORT = 2,
  IEEE154_ADDR_EXT = 3,
  IEEE154_ADDR_MASK = 3,
};

#endif	/* __IEEE154_H__ */
