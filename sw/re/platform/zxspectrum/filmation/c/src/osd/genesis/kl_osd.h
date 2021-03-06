#ifndef _LR_OSD_H_
#define _LR_OSD_H_


// we can't #include genesis.h here
// - because TILE_SPACE is #defined
#include <genesis.h>

//#include "config.h"
//#include "asm.h"
//#include "types.h"
//#include "sys.h"
//#include "memory.h"

#include "kl_dat.h"

// 0=27, 1=28...
#define OSD_KEY_0     (27+'0'-'0')
#define OSD_KEY_1     (27+'1'-'0')
#define OSD_KEY_2     (27+'2'-'0')
#define OSD_KEY_3     (27+'3'-'0')
#define OSD_KEY_4     (27+'4'-'0')
#define OSD_KEY_5     (27+'5'-'0')
#define OSD_KEY_6     (27+'6'-'0')
#define OSD_KEY_7     (27+'7'-'0')
#define OSD_KEY_8     (27+'8'-'0')
#define OSD_KEY_9     (27+'9'-'0')

// A=1, B=2...
#define OSD_KEY_D     ('D' & 0x3f)
#define OSD_KEY_E     ('E' & 0x3f)
#define OSD_KEY_G     ('G' & 0x3f)
#define OSD_KEY_I     ('I' & 0x3f)
#define OSD_KEY_J     ('J' & 0x3f)
#define OSD_KEY_K     ('K' & 0x3f)
#define OSD_KEY_L     ('L' & 0x3f)
#define OSD_KEY_N     ('N' & 0x3f)
#define OSD_KEY_O     ('O' & 0x3f)
#define OSD_KEY_P     ('P' & 0x3f)
#define OSD_KEY_S     ('S' & 0x3f)
#define OSD_KEY_U     ('U' & 0x3f)
#define OSD_KEY_W     ('W' & 0x3f)
#define OSD_KEY_X     ('X' & 0x3f)
#define OSD_KEY_Z     ('Z' & 0x3f)
#define OSD_KEY_ESC   0x3b

#define DBGPRINTF(format...)
//#define DBGPRINTF(format...) VDP_drawText(format, 1, 20);

// ctype.h
#define isdigit(c)    ((c)<'0'||(c)>'9'?0:1)
  
void osd_cls (void);
void osd_delay (unsigned ms);
int osd_key (int _key);
int osd_keypressed (void);
int osd_readkey (void);
void osd_print_text_raw (uint8_t *gfxbase_8x8, uint8_t x, uint8_t y, uint8_t *str);
void osd_print_text (uint8_t *gfxbase_8x8, uint8_t x, uint8_t y, char *str);
uint8_t osd_print_8x8 (uint8_t *gfxbase_8x8, uint8_t x, uint8_t y, uint8_t code);
void osd_print_sprite (POBJ32 p_obj);

#endif
