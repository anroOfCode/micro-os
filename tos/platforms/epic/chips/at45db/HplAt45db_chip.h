#ifndef HPLAT45DB_CHIP_H
#define HPLAT45DB_CHIP_H

// flash characteristics
enum {
    AT45_MAX_PAGES = 4096,
    AT45_PAGE_SIZE = 528,
    AT45_PAGE_SIZE_LOG2 = 9 // For those who want to ignore the last 8 bytes
};

typedef uint16_t at45page_t;
typedef uint16_t at45pageoffset_t; /* must fit 0 to AT45_PAGE_SIZE - 1 */

#endif
