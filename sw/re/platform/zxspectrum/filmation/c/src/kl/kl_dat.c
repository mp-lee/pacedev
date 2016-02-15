#include "kl_osd.h"
#include "kl_dat.h"

// Note on __FORCE_RODATA__
// - on the Neo Geo platform (gcc 2.9.5) there are some data structures
//   in this file that I simply cannot get into .rodata using 'const'
//   so I've been forced to specify the segment instead
// - this actually has the benefical side-effect that all the sprite
//   data is moved into ROM on the Neo Geo, but remains in RAM on
//   systems without hardware sprites

// font data has been re-arranged to allow straight printing
// from either font using ASCII strings

const uint8_t kl_font[][8] = 
{
  // "DAY" (0-3)
  { 0x06, 0x07, 0x06, 0x06, 0x06, 0x06, 0x06, 0x0F },   // $00
  { 0x00, 0x01, 0x82, 0xC6, 0x64, 0x6C, 0x6D, 0xC6 },   // $01
  { 0xC8, 0xC6, 0xE1, 0x60, 0x60, 0xE0, 0x64, 0x63 },   // $02
  { 0x60, 0x60, 0x60, 0xE0, 0x60, 0x40, 0xC0, 0x80 },   // $03

  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $04
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $05
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $06
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $07
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $08
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $09
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $0A
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $0B
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $0C
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $0D
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $0E
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $0F
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $10
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $11
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $12
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $13
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $14
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $15
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $16
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $17
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $18
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $19
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $1A
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $1B
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $1C
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $1D
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $1E
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $1F
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // ' '
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $21
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $22
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $23
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $24
  { 0x00, 0x62, 0x64, 0x08, 0x10, 0x26, 0x46, 0x00, },  // '%'
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $26
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $27
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $28
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $29
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $2A
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $2B
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $2C
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $2D
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00, },  // '.'
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $2F
  { 0x38, 0x6C, 0xD6, 0xD6, 0xD6, 0xD6, 0x6C, 0x38, },  // '0'
  { 0x18, 0x38, 0x58, 0x18, 0x18, 0x18, 0x18, 0x7C, },  // '1'
  { 0x38, 0x4C, 0x0C, 0x3C, 0x60, 0xC2, 0xC2, 0xFE, },  // '2'
  { 0x38, 0x4C, 0x0C, 0x3C, 0x0E, 0x86, 0x86, 0xFC, },  // '3'
  { 0x18, 0x38, 0x58, 0x9A, 0xFE, 0x1A, 0x18, 0x7C, },  // '4'
  { 0xFE, 0xC2, 0xC0, 0xFC, 0x06, 0x06, 0x86, 0x7C, },  // '5'
  { 0x1E, 0x32, 0x60, 0x7C, 0xC6, 0xC6, 0xC6, 0x7C, },  // '6'
  { 0x7E, 0x46, 0x4C, 0x0C, 0x18, 0x18, 0x30, 0xF8, },  // '7'
  { 0x38, 0x6C, 0x6C, 0x7C, 0xFE, 0xC6, 0xC6, 0x7C, },  // '8'
  { 0x7C, 0xC6, 0xC6, 0xC6, 0x7C, 0x0C, 0x98, 0xF0, },  // '9'
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $3A
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $3B
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $3C
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $3D
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $3E
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, },  // $3F
  { 0x3C, 0x42, 0x99, 0xA1, 0xA1, 0x99, 0x42, 0x3C, },  // '�'
  { 0x0C, 0x1C, 0x2E, 0x66, 0x46, 0xCE, 0xDB, 0x66, },  // 'A'
  { 0xF8, 0x6C, 0x6C, 0x78, 0x6C, 0x66, 0x66, 0xFC, },  // 'B'
  { 0x0E, 0x32, 0x60, 0x40, 0xC0, 0xC2, 0xE6, 0x7C, },  // 'C'
  { 0x60, 0x70, 0x68, 0x6C, 0x66, 0x66, 0x66, 0xFC, },  // 'D'
  { 0xFE, 0x60, 0x64, 0x7C, 0x64, 0x60, 0x7A, 0xC6, },  // 'E'
  { 0xC6, 0x7A, 0x60, 0x64, 0x7C, 0x64, 0x60, 0x60, },  // 'F'
  { 0x0E, 0x30, 0x60, 0xC6, 0xCE, 0xF6, 0x66, 0x0E, },  // 'G'
  { 0xEE, 0xC6, 0xC6, 0xFE, 0xC6, 0xC6, 0xC6, 0xEE, },  // 'H'
  { 0x7C, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x7C, },  // 'I'
  { 0x1E, 0x06, 0x06, 0x86, 0x86, 0xC6, 0x7E, 0x1C, },  // 'J'
  { 0xE4, 0x68, 0x70, 0x78, 0x6C, 0x64, 0x64, 0xF6, },  // 'K'
  { 0xE0, 0x60, 0x60, 0x60, 0x60, 0x60, 0x62, 0xFE, },  // 'L'
  { 0xC6, 0xEE, 0xEE, 0xD6, 0xD6, 0xD6, 0xC6, 0xEE, },  // 'M'
  { 0xCC, 0xD6, 0xD6, 0xE6, 0xE4, 0xC4, 0xC8, 0xDE, },  // 'N'
  { 0x38, 0x6C, 0xC6, 0xC6, 0xC6, 0xC6, 0x6C, 0x38, },  // 'O'
  { 0xF8, 0x6C, 0x66, 0x76, 0x6E, 0x60, 0x60, 0xF0, },  // 'P'
  { 0x38, 0x6C, 0xC6, 0xC6, 0xC6, 0xD6, 0x6C, 0x3A, },  // 'Q'
  { 0xF8, 0x6C, 0x66, 0x76, 0x7E, 0x78, 0x6C, 0xE6, },  // 'R'
  { 0x38, 0x64, 0x60, 0x3C, 0x06, 0x86, 0xC6, 0x7C, },  // 'S'
  { 0xFE, 0x9A, 0x98, 0x18, 0x18, 0x18, 0x18, 0x18, },  // 'T'
  { 0xF6, 0x26, 0x46, 0x4E, 0xCE, 0xD6, 0xD6, 0x66, },  // 'U'
  { 0xE2, 0x62, 0x64, 0x64, 0x68, 0x68, 0x70, 0x60, },  // 'V'
  { 0xEE, 0xC6, 0xD6, 0xD6, 0xD6, 0xEE, 0xEE, 0xC6, },  // 'W'
  { 0xC6, 0xC6, 0x6C, 0x38, 0x38, 0x6C, 0xC6, 0xC6, },  // 'X'
  { 0x86, 0x66, 0x16, 0x0E, 0x06, 0x04, 0x4C, 0x38, },  // 'Y'
  { 0x7E, 0x46, 0x0C, 0x18, 0x30, 0x62, 0xC2, 0xFE, },  // 'Z'
};

const ROOM_SIZE_T room_size_tbl[] = 
{
  { 64, 64, 128 },
  { 32, 64, 128 },
  { 64, 32, 128 }
};

const uint8_t location_tbl[] = 
{
  0, 25, 3,
  0x00, 0x01, 0x0C, 0xFF, 0x07, 0x10, 0x50, 0x90, 
  0x11, 0x51, 0x91, 0x0A, 0x4A, 0x06, 0x8A, 0x02, 
  0x42, 0x82, 0xC8, 0xC1, 0xC0, 0xA8, 0xC9, 
  1, 20, 20,
  0x01, 0x03, 0x0D, 0xFF, 0x03, 0x2B, 0x2C, 0x13, 
  0x14, 0x23, 0x6B, 0x6C, 0x53, 0x54, 0x40, 0x1C, 
  0x48, 0x28, 
  2, 6, 3,
  0x00, 0x01, 0x03, 0x0C, 
  3, 26, 22,
  0x01, 0x03, 0x0D, 0xFF, 0x03, 0x22, 0x1A, 0x25, 
  0x1D, 0x2B, 0x23, 0x1B, 0x24, 0x1C, 0x93, 0x2B, 
  0x2C, 0x13, 0x14, 0xB3, 0x63, 0x64, 0x5B, 0x5C, 
  4, 19, 5,
  0x00, 0x03, 0x0C, 0xFF, 0x2B, 0x23, 0x1A, 0x1C, 
  0x13, 0xB2, 0x5A, 0x5C, 0x53, 0x02, 0x63, 0x9B, 
  0xDB, 
  8, 26, 3,
  0x04, 0x05, 0x0F, 0x10, 0xFF, 0x1B, 0x1B, 0x5B, 
  0x9B, 0xDB, 0x2B, 0x23, 0x1A, 0x1C, 0x13, 0x93, 
  0x63, 0x5A, 0x5C, 0x53, 0xB8, 0x09, 0x80, 0x49, 
  9, 11, 6,
  0x05, 0x07, 0x0F, 0x11, 0x09, 0x0B, 0xFF, 0x48, 
  0x23, 
  10, 25, 3,
  0x05, 0x07, 0x0F, 0x11, 0xFF, 0x1D, 0x22, 0x62, 
  0xA2, 0x24, 0x64, 0xA4, 0x2F, 0x2A, 0x2B, 0x6B, 
  0x2C, 0x1A, 0x1B, 0x5B, 0x1C, 0x38, 0x0E, 
  11, 6, 6,
  0x05, 0x07, 0x0F, 0x11, 
  12, 23, 3,
  0x05, 0x07, 0x0F, 0x11, 0xFF, 0x2F, 0x3D, 0x32, 
  0x28, 0x2C, 0x2F, 0x22, 0x1C, 0x10, 0x2B, 0x12, 
  0x17, 0x0D, 0x04, 0xB8, 0x24, 
  13, 6, 4,
  0x00, 0x01, 0x03, 0x0C, 
  14, 11, 21,
  0x01, 0x03, 0x0D, 0xFF, 0x53, 0x12, 0x1D, 0x2C, 
  0x23, 
  15, 28, 4,
  0x00, 0x03, 0x0C, 0xFF, 0x07, 0x23, 0x25, 0x13, 
  0x15, 0x63, 0x64, 0x65, 0x5B, 0x04, 0x5D, 0x53, 
  0x54, 0x55, 0x1C, 0x9B, 0xA4, 0x9B, 0x9D, 0x94, 
  0xB0, 0x9C, 
  16, 24, 13,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x01, 0xC3, 0xC4, 
  0x5B, 0x05, 0x0C, 0x0B, 0x0A, 0x9B, 0x45, 0x4C, 
  0x4B, 0x4A, 0xA8, 0xC2, 0x50, 0x5A, 
  18, 24, 12,
  0x00, 0x02, 0x0E, 0xFF, 0x97, 0xFA, 0xFD, 0xF3, 
  0xF4, 0xEB, 0xEC, 0xE3, 0xE4, 0x97, 0xDB, 0xDC, 
  0xD3, 0xD4, 0xCB, 0xCC, 0xC2, 0xC5, 
  20, 26, 14,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x01, 0xC3, 0xC4, 
  0xAD, 0xC2, 0xCA, 0xD2, 0xDA, 0xDB, 0xDC, 0xAC, 
  0xDD, 0xE5, 0xAD, 0x75, 0x3D, 0x29, 0x0B, 0x0C, 
  24, 17, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x2F, 0x2A, 0x2B, 0x2C, 
  0x2D, 0x12, 0x13, 0x14, 0x15, 0xB8, 0x1B, 
  29, 27, 14,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x07, 0xC3, 0xC4, 
  0x0C, 0x4C, 0x8C, 0xCC, 0x24, 0x64, 0x02, 0x2C, 
  0x6C, 0x34, 0x29, 0x14, 0x1C, 0x58, 0x0C, 0x78, 
  0x54, 
  31, 23, 11,
  0x00, 0x02, 0x0E, 0xFF, 0x03, 0x12, 0x15, 0x2A, 
  0x2D, 0x2F, 0x52, 0x13, 0x14, 0x55, 0x6A, 0x2B, 
  0x2C, 0x6D, 0xE1, 0x93, 0x6B, 
  32, 18, 3,
  0x00, 0x01, 0x15, 0x17, 0x0C, 0xFF, 0x02, 0x18, 
  0xC3, 0xC4, 0xAA, 0x50, 0x88, 0xC0, 0x28, 0x02, 
  33, 28, 22,
  0x14, 0x16, 0x03, 0x0D, 0xFF, 0x07, 0x21, 0x61, 
  0xA2, 0xA3, 0x24, 0x64, 0x25, 0x65, 0x03, 0x26, 
  0x66, 0xE7, 0xDF, 0x29, 0xA4, 0xA6, 0x30, 0xE2, 
  0xC0, 0xA5, 
  34, 26, 3,
  0x02, 0x03, 0x0C, 0xFF, 0x03, 0x30, 0x78, 0xB9, 
  0xFA, 0x2F, 0x39, 0x3A, 0x3D, 0x3E, 0x3F, 0x33, 
  0x2B, 0x23, 0x2A, 0x34, 0x2C, 0x24, 0xA8, 0xFB, 
  36, 24, 3,
  0x00, 0x02, 0x0C, 0xFF, 0x2F, 0x02, 0x05, 0x0A, 
  0x0F, 0x10, 0x15, 0x19, 0x1B, 0x2F, 0x1C, 0x1F, 
  0x28, 0x2A, 0x2C, 0x2E, 0x3A, 0x3D, 
  39, 15, 6,
  0x00, 0x0C, 0xFF, 0x03, 0x1B, 0x1C, 0x23, 0x24, 
  0x4B, 0x12, 0x15, 0x2A, 0x2D, 
  40, 16, 14,
  0x00, 0x15, 0x0E, 0x17, 0xFF, 0x39, 0x23, 0x63, 
  0x29, 0x0B, 0x0C, 0x01, 0xC3, 0xC4, 
  45, 23, 4,
  0x14, 0x02, 0x16, 0x0C, 0xFF, 0x07, 0xDF, 0xE7, 
  0x13, 0x1B, 0x23, 0x5B, 0x63, 0xA3, 0x2B, 0x1E, 
  0x26, 0x22, 0x24, 0x70, 0xE3, 
  46, 17, 21,
  0x01, 0x03, 0x0D, 0xFF, 0x2F, 0x2B, 0x2C, 0x22, 
  0x25, 0x1A, 0x1D, 0x13, 0x14, 0x68, 0x23, 
  47, 6, 4,
  0x00, 0x02, 0x03, 0x0C, 
  48, 22, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x2F, 0x33, 0x34, 0x2A, 
  0x2D, 0x22, 0x25, 0x1A, 0x1D, 0x2B, 0x12, 0x15, 
  0x0B, 0x0C, 0xB8, 0x1B, 
  52, 24, 14,
  0x00, 0x02, 0x0E, 0xFF, 0x3F, 0x1A, 0x1B, 0x1C, 
  0x1D, 0x5A, 0x5B, 0x5C, 0x5D, 0x97, 0x9A, 0x9B, 
  0x9C, 0x9D, 0xDA, 0xDB, 0xDC, 0xDD, 
  55, 13, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x78, 0x14, 0x00, 0x2C, 
  0x49, 0x25, 0x1A, 
  56, 25, 11,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x05, 0x7A, 0xF2, 
  0xDA, 0xC2, 0xC3, 0xC4, 0xB3, 0xEA, 0xE2, 0xD2, 
  0xCA, 0x2C, 0x2A, 0x22, 0x1A, 0x12, 0x0A, 
  63, 25, 3,
  0x04, 0x06, 0x0F, 0x10, 0xFF, 0x1F, 0x18, 0x19, 
  0x1A, 0x5A, 0x1D, 0x5D, 0x1E, 0x1F, 0x2D, 0x58, 
  0x59, 0x9A, 0x9D, 0x5E, 0x5F, 0xD0, 0x1B, 
  64, 19, 6,
  0x14, 0x15, 0x16, 0x17, 0x0C, 0xFF, 0x05, 0x3F, 
  0x06, 0xC3, 0xC4, 0xDF, 0xE7, 0x68, 0x38, 0x80, 
  0xB8, 
  65, 23, 20,
  0x01, 0x03, 0x0D, 0xFF, 0x05, 0x12, 0x14, 0x16, 
  0x2A, 0x2C, 0x2E, 0x25, 0x52, 0x54, 0x56, 0x6A, 
  0x6C, 0x6E, 0x51, 0x15, 0x2B, 
  66, 21, 5,
  0x01, 0x03, 0x0C, 0xFF, 0x01, 0x1B, 0xDC, 0xA9, 
  0x63, 0xA4, 0x2F, 0x12, 0x1A, 0x22, 0x2B, 0x2C, 
  0x25, 0x1D, 0x14, 
  67, 27, 22,
  0x01, 0x03, 0x0D, 0xFF, 0x07, 0x1E, 0x26, 0x5D, 
  0x65, 0x19, 0x21, 0x5A, 0x62, 0x03, 0x2B, 0x2C, 
  0x13, 0x14, 0x2B, 0x6B, 0x6C, 0x53, 0x54, 0x60, 
  0x1B, 
  68, 7, 4,
  0x00, 0x01, 0x02, 0x03, 0x0C, 
  69, 29, 5,
  0x01, 0x03, 0x0C, 0xFF, 0x07, 0x23, 0x25, 0x13, 
  0x15, 0x63, 0x64, 0x65, 0x5B, 0x03, 0x5D, 0x53, 
  0x54, 0x55, 0x9B, 0xA4, 0x9B, 0x9D, 0x94, 0xB0, 
  0x9C, 0x28, 0x1C, 
  70, 28, 22,
  0x01, 0x03, 0x0D, 0xFF, 0x07, 0x23, 0x1B, 0x2C, 
  0x6C, 0x14, 0x54, 0x25, 0x1D, 0x23, 0x65, 0x5D, 
  0x63, 0x5B, 0x91, 0x24, 0x1C, 0xB3, 0xA4, 0xE4, 
  0x9C, 0xDC, 
  71, 6, 3,
  0x00, 0x02, 0x03, 0x0C, 
  72, 23, 14,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x07, 0xC3, 0xC4, 
  0xCC, 0x2C, 0x2D, 0x25, 0x6C, 0x6D, 0x00, 0xAC, 
  0x29, 0x0B, 0x14, 0x78, 0x8C, 
  79, 21, 6,
  0x04, 0x06, 0x0F, 0x10, 0xFF, 0x9F, 0xD8, 0xD9, 
  0xDA, 0xDB, 0xDC, 0xDD, 0xDE, 0xDF, 0x9B, 0xC3, 
  0xC4, 0xFB, 0xFC, 
  84, 22, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x01, 0x0C, 0x33, 0x2B, 
  0x1A, 0x5A, 0x25, 0x65, 0x93, 0x13, 0x0B, 0x2C, 
  0x24, 0x79, 0x14, 0x23, 
  87, 20, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x07, 0x2D, 0x6D, 0xAD, 
  0x24, 0x64, 0xA4, 0x1B, 0x5B, 0x03, 0x9B, 0x12, 
  0x52, 0x92, 
  88, 11, 13,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x48, 0x1D, 0x80, 
  0x5D, 
  94, 18, 6,
  0x04, 0x05, 0x0F, 0x10, 0xFF, 0x1F, 0x32, 0x35, 
  0x29, 0x2E, 0x11, 0x16, 0x0A, 0x0D, 0xC8, 0x2D, 
  95, 6, 3,
  0x04, 0x06, 0x07, 0x0F, 
  100, 18, 14,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x07, 0x03, 0x04, 
  0x0B, 0x0C, 0x23, 0x24, 0x2B, 0x2C, 0x30, 0x63, 
  103, 18, 12,
  0x00, 0x02, 0x0E, 0xFF, 0x01, 0x2A, 0x2D, 0x2B, 
  0x6A, 0x6D, 0x1A, 0x1D, 0xD0, 0x2B, 0x68, 0x25, 
  104, 25, 11,
  0x00, 0x02, 0x0E, 0xFF, 0x07, 0x3A, 0x7A, 0xBA, 
  0xFA, 0x3D, 0x7D, 0xBD, 0xFD, 0x03, 0x32, 0x33, 
  0x34, 0x35, 0x29, 0x72, 0x75, 0x60, 0xA3, 
  106, 5, 6,
  0x00, 0x01, 0x0C, 
  107, 17, 20,
  0x14, 0x03, 0x16, 0x0D, 0xFF, 0x05, 0x24, 0x1C, 
  0x64, 0x5C, 0xE7, 0xDF, 0x51, 0xD6, 0xED, 
  108, 24, 19,
  0x01, 0x03, 0x0D, 0xFF, 0x37, 0x2B, 0x23, 0x1B, 
  0x13, 0x6B, 0x63, 0x5B, 0x53, 0x9F, 0xAB, 0xA3, 
  0x9B, 0x93, 0xEB, 0xE3, 0xDB, 0xD3, 
  109, 23, 6,
  0x05, 0x07, 0x0F, 0x11, 0xFF, 0x1F, 0x14, 0x2C, 
  0x54, 0x6C, 0x94, 0x9C, 0xA4, 0xAC, 0x21, 0xD4, 
  0xEC, 0x38, 0x09, 0x40, 0x1E, 
  110, 7, 3,
  0x05, 0x06, 0x07, 0x0F, 0x11, 
  111, 20, 6,
  0x06, 0x07, 0x0F, 0x11, 0xFF, 0x1A, 0x2D, 0x2E, 
  0x2F, 0x22, 0x6D, 0x6E, 0x6F, 0x9B, 0x3D, 0x35, 
  0x7D, 0x75, 
  116, 24, 4,
  0x01, 0x02, 0x0C, 0xFF, 0x2A, 0x39, 0x30, 0x31, 
  0x07, 0x3A, 0x7A, 0x32, 0x72, 0x28, 0x68, 0x29, 
  0x69, 0xB3, 0xB8, 0xB9, 0xB0, 0xB1, 
  117, 14, 19,
  0x01, 0x03, 0x0D, 0xFF, 0x01, 0x23, 0x1C, 0x29, 
  0x24, 0x1B, 0xC8, 0x2B, 
  118, 22, 22,
  0x14, 0x03, 0x16, 0x0D, 0xFF, 0x06, 0xDF, 0xE7, 
  0xEF, 0xAE, 0x6D, 0x2C, 0xD7, 0x2D, 0x16, 0x1E, 
  0x26, 0x15, 0x1D, 0x25, 
  119, 7, 3,
  0x00, 0x01, 0x02, 0x03, 0x0C, 
  120, 25, 4,
  0x00, 0x01, 0x02, 0x03, 0x0C, 0xFF, 0x2F, 0x39, 
  0x3F, 0x35, 0x28, 0x2C, 0x2F, 0x23, 0x1D, 0x2C, 
  0x11, 0x13, 0x0A, 0x0D, 0x0E, 0x68, 0x17, 
  121, 22, 19,
  0x01, 0x03, 0x0D, 0xFF, 0xB3, 0x22, 0x1A, 0x25, 
  0x1D, 0x2F, 0x2B, 0x2C, 0x23, 0x24, 0x1B, 0x1C, 
  0x13, 0x14, 0x60, 0xDB, 
  122, 22, 5,
  0x02, 0x03, 0x0C, 0xFF, 0x04, 0x28, 0x70, 0xB8, 
  0xB9, 0xFF, 0x2D, 0xBA, 0xBC, 0xBE, 0x37, 0x2F, 
  0x27, 0xA9, 0xFB, 0xFD, 
  131, 5, 6,
  0x00, 0x01, 0x0C, 
  132, 23, 21,
  0x01, 0x03, 0x0D, 0xFF, 0x07, 0x2A, 0x6A, 0x2D, 
  0x6D, 0x12, 0x52, 0x15, 0x55, 0x23, 0xAA, 0xAD, 
  0x92, 0x95, 0x11, 0x1D, 0x9A, 
  133, 25, 20,
  0x14, 0x03, 0x16, 0x0D, 0xFF, 0x05, 0x28, 0x69, 
  0xAA, 0xEB, 0xE7, 0xDF, 0x2F, 0x1B, 0x23, 0x1C, 
  0x24, 0x1D, 0x25, 0x1E, 0x26, 0x78, 0xDB, 
  134, 11, 19,
  0x14, 0x03, 0x16, 0x0D, 0xFF, 0x80, 0x63, 0xB8, 
  0x23, 
  135, 24, 5,
  0x00, 0x01, 0x02, 0x03, 0x0C, 0xFF, 0x03, 0x2A, 
  0x2D, 0x12, 0x15, 0x2B, 0x6A, 0x6D, 0x52, 0x55, 
  0xD1, 0x2B, 0x13, 0xD9, 0x1A, 0x1D, 
  136, 19, 6,
  0x00, 0x01, 0x02, 0x03, 0x12, 0x13, 0x0C, 0xFF, 
  0x07, 0x32, 0x29, 0x35, 0x2E, 0x16, 0x0D, 0x11, 
  0x0A, 
  137, 20, 21,
  0x01, 0x03, 0x0D, 0xFF, 0x07, 0x2C, 0x6C, 0xAC, 
  0x24, 0x1C, 0x14, 0x54, 0x94, 0x21, 0xEC, 0xD4, 
  0x50, 0x64, 
  138, 24, 19,
  0x01, 0x03, 0x0D, 0xFF, 0x5F, 0x2A, 0x22, 0x1A, 
  0x12, 0x2D, 0x25, 0x1D, 0x15, 0x97, 0xEA, 0xE2, 
  0xDA, 0xD2, 0xED, 0xE5, 0xDD, 0xD5, 
  139, 6, 5,
  0x00, 0x01, 0x03, 0x0C, 
  140, 25, 20,
  0x01, 0x03, 0x0D, 0xFF, 0x07, 0x2A, 0x6A, 0x2D, 
  0x6D, 0x12, 0x52, 0x15, 0x55, 0x2B, 0xAA, 0xAD, 
  0x92, 0x95, 0xD9, 0x1A, 0x1D, 0x40, 0x1B, 
  141, 26, 5,
  0x01, 0x03, 0x0C, 0xFF, 0x07, 0x34, 0x74, 0x6C, 
  0xB4, 0xBC, 0xFB, 0xFD, 0xF3, 0x03, 0xFC, 0xF5, 
  0xEB, 0xED, 0x58, 0x3C, 0x28, 0x24, 0x10, 0xE4, 
  142, 12, 19,
  0x14, 0x03, 0x16, 0x0D, 0xFF, 0x39, 0x23, 0x63, 
  0x48, 0x2B, 
  143, 5, 6,
  0x00, 0x03, 0x0C, 
  147, 20, 12,
  0x00, 0x02, 0x0E, 0xFF, 0x07, 0x1A, 0x1B, 0x1C, 
  0x1D, 0x5A, 0x9A, 0x5D, 0x9D, 0x21, 0xDA, 0xDD, 
  0xA0, 0x5B, 
  151, 16, 12,
  0x00, 0x02, 0x0E, 0xFF, 0x03, 0x1A, 0x1B, 0x1C, 
  0x1D, 0x23, 0x5A, 0x5B, 0x5C, 0x5D, 
  152, 26, 11,
  0x00, 0x02, 0x0E, 0xFF, 0x01, 0x33, 0x0C, 0xA9, 
  0x6B, 0x54, 0x2F, 0x22, 0x23, 0x24, 0x25, 0x1A, 
  0x1B, 0x1C, 0x1D, 0xB3, 0xA3, 0xA4, 0x9B, 0x9C, 
  155, 23, 11,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x07, 0x3D, 0x7D, 
  0x35, 0x75, 0xB5, 0xF5, 0xC3, 0xC4, 0x78, 0xDD, 
  0x70, 0xDB, 0x29, 0x1C, 0x1D, 
  159, 24, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x07, 0x1A, 0x1B, 0x1C, 
  0x1D, 0x5A, 0x5B, 0x5C, 0x5D, 0x03, 0x9A, 0x9B, 
  0x9C, 0x9D, 0x2A, 0xDB, 0xDC, 0xDD, 
  163, 28, 11,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x05, 0x3D, 0x7D, 
  0x34, 0x74, 0xC3, 0xC4, 0x2B, 0x12, 0x14, 0x23, 
  0x25, 0x93, 0x52, 0x54, 0x63, 0x65, 0xB8, 0x35, 
  0x80, 0x75, 
  167, 5, 3,
  0x00, 0x02, 0x0C, 
  168, 24, 6,
  0x02, 0x0C, 0xFF, 0x07, 0x2A, 0x6A, 0x32, 0x72, 
  0xB2, 0xF2, 0x36, 0x76, 0x05, 0xB6, 0xF6, 0x16, 
  0x56, 0x96, 0xD6, 0x29, 0x35, 0x1E, 
  170, 24, 3,
  0x00, 0x01, 0x0C, 0xFF, 0x07, 0x00, 0x48, 0x90, 
  0x18, 0x58, 0x98, 0xD8, 0x21, 0x02, 0x61, 0x28, 
  0x68, 0x29, 0xA8, 0xA1, 0xA8, 0xE0, 
  171, 6, 4,
  0x00, 0x02, 0x03, 0x0C, 
  175, 14, 12,
  0x00, 0x15, 0x17, 0x0E, 0xFF, 0x03, 0x1B, 0x1C, 
  0x33, 0x34, 0x30, 0x74, 
  179, 6, 6,
  0x00, 0x01, 0x02, 0x0C, 
  180, 19, 4,
  0x03, 0x0C, 0xFF, 0x07, 0x13, 0x14, 0x15, 0x1B, 
  0x23, 0x63, 0xA3, 0xE3, 0x30, 0x55, 0x39, 0x2E, 
  0x6E, 
  183, 14, 12,
  0x00, 0x02, 0x0E, 0xFF, 0x03, 0x33, 0x34, 0x0B, 
  0x0C, 0x49, 0x23, 0x1C, 
  186, 25, 5,
  0x01, 0x02, 0x0C, 0xFF, 0x05, 0x2B, 0x6B, 0xAB, 
  0x1B, 0x5B, 0x9B, 0x2F, 0x2A, 0x22, 0x62, 0xA2, 
  0x1A, 0x2C, 0x24, 0x64, 0x29, 0xA4, 0x1C, 
  187, 11, 6,
  0x02, 0x03, 0x0C, 0xFF, 0x48, 0x24, 0x81, 0x64, 
  0xA4, 
  191, 29, 3,
  0x00, 0x15, 0x17, 0x0C, 0xFF, 0x04, 0x3D, 0x7E, 
  0xBE, 0xC3, 0xC4, 0x2F, 0x3F, 0x37, 0x2F, 0x2E, 
  0x2D, 0x25, 0x1D, 0x15, 0x29, 0x14, 0x0C, 0xB8, 
  0x7F, 0x80, 0xBF, 
  195, 20, 11,
  0x00, 0x02, 0x0E, 0xFF, 0x07, 0x1A, 0x1B, 0x1C, 
  0x1D, 0x5A, 0x5B, 0x5C, 0x5D, 0x03, 0x9A, 0x9B, 
  0x9C, 0x9D, 
  199, 11, 5,
  0x00, 0x15, 0x17, 0x0C, 0xFF, 0x80, 0x5B, 0x48, 
  0x1B, 
  207, 10, 12,
  0x00, 0x02, 0x08, 0x0A, 0x0E, 0xFF, 0x48, 0x1C, 
  208, 25, 5,
  0x00, 0x01, 0x0C, 0xFF, 0x07, 0x03, 0x42, 0x81, 
  0xC0, 0xC8, 0xD0, 0xD8, 0xE0, 0x03, 0x1C, 0x5C, 
  0x9C, 0xDC, 0x2B, 0x1B, 0x24, 0x1D, 0x14, 
  209, 17, 20,
  0x01, 0x03, 0x0D, 0xFF, 0x68, 0x16, 0x2F, 0x1E, 
  0x26, 0x1B, 0x1C, 0x23, 0x24, 0x19, 0x21, 
  210, 21, 5,
  0x00, 0x03, 0x0C, 0xFF, 0x07, 0x03, 0x27, 0x44, 
  0x5F, 0x85, 0x97, 0xC6, 0xCF, 0x01, 0xCE, 0xC7, 
  0x99, 0x0F, 0x06, 
  211, 18, 13,
  0x00, 0x02, 0x0E, 0xFF, 0x01, 0x2A, 0x2D, 0x2B, 
  0x6A, 0x6D, 0x1A, 0x1D, 0xD0, 0x2B, 0x68, 0x25, 
  214, 21, 6,
  0x04, 0x05, 0x0F, 0x10, 0xFF, 0x1F, 0x2C, 0x6C, 
  0xAC, 0xEC, 0x24, 0x1C, 0x14, 0x54, 0x18, 0x94, 
  0x11, 0x5D, 0x1B, 
  215, 14, 3,
  0x04, 0x05, 0x06, 0x07, 0x0F, 0xFF, 0x51, 0x1B, 
  0x24, 0xA1, 0x23, 0x1C, 
  216, 6, 3,
  0x04, 0x05, 0x07, 0x0F, 
  217, 5, 6,
  0x04, 0x07, 0x0F, 
  221, 20, 6,
  0x00, 0x14, 0x16, 0x0C, 0xFF, 0x01, 0xE7, 0xDF, 
  0x5B, 0x2F, 0x26, 0x1E, 0x17, 0x3B, 0x1A, 0x5A, 
  0x9A, 0xDA, 
  222, 5, 19,
  0x01, 0x03, 0x0D, 
  223, 22, 6,
  0x00, 0x02, 0x03, 0x0C, 0xFF, 0x04, 0x1B, 0x5B, 
  0x9B, 0xDB, 0xE2, 0x2B, 0x13, 0x1C, 0x23, 0x1A, 
  0xB2, 0x12, 0x54, 0xA4, 
  224, 17, 14,
  0x00, 0x02, 0x0E, 0xFF, 0x2F, 0x3A, 0x3D, 0x2B, 
  0x2C, 0x13, 0x14, 0x02, 0x05, 0xC8, 0x24, 
  226, 22, 14,
  0x00, 0x02, 0x0E, 0xFF, 0x97, 0x05, 0x0A, 0x0C, 
  0x13, 0x15, 0x1A, 0x1C, 0x23, 0x95, 0x25, 0x2A, 
  0x2C, 0x33, 0x35, 0x3A, 
  227, 27, 14,
  0x00, 0x02, 0x0E, 0xFF, 0xAF, 0x02, 0x05, 0x4A, 
  0x4D, 0x92, 0x95, 0xAA, 0xAD, 0xAB, 0x72, 0x75, 
  0x3A, 0x3D, 0xB3, 0xDA, 0xDD, 0xE2, 0xE5, 0x60, 
  0x1B, 
  230, 7, 3,
  0x04, 0x05, 0x06, 0x0F, 0x10, 
  231, 17, 6,
  0x04, 0x05, 0x06, 0x07, 0x0F, 0xFF, 0x2F, 0x33, 
  0x34, 0x21, 0x19, 0x26, 0x1E, 0x0B, 0x0C, 
  232, 22, 6,
  0x04, 0x05, 0x06, 0x07, 0x0F, 0xFF, 0x1F, 0x33, 
  0x21, 0x23, 0x63, 0xA3, 0xE3, 0x25, 0x13, 0x2B, 
  0x2B, 0x24, 0x1B, 0x22, 
  233, 6, 3,
  0x04, 0x06, 0x07, 0x0F, 
  237, 20, 12,
  0x00, 0x02, 0x0E, 0xFF, 0x07, 0x1A, 0x1B, 0x1C, 
  0x1D, 0x5A, 0x5B, 0x5C, 0x5D, 0x03, 0x9A, 0x9B, 
  0x9C, 0x9D, 
  239, 5, 13,
  0x00, 0x02, 0x0E, 
  240, 27, 5,
  0x14, 0x15, 0x16, 0x17, 0x0C, 0xFF, 0x07, 0xDF, 
  0xE7, 0xFF, 0xFE, 0x78, 0xA8, 0xD0, 0xC0, 0x03, 
  0xC1, 0xC2, 0xC3, 0xC4, 0x29, 0x39, 0x3B, 0x70, 
  0xFB, 
  241, 10, 19,
  0x01, 0x03, 0x09, 0x0B, 0x0D, 0xFF, 0xB8, 0x23, 
  242, 6, 5,
  0x01, 0x02, 0x03, 0x0C, 
  243, 23, 3,
  0x02, 0x03, 0x0C, 0xFF, 0x07, 0x32, 0x3A, 0x72, 
  0x7A, 0x34, 0x3C, 0x74, 0x7C, 0x01, 0xB3, 0xBB, 
  0x48, 0x33, 0x31, 0x2B, 0x6B, 
  246, 19, 6,
  0x05, 0x06, 0x0F, 0x10, 0x11, 0xFF, 0x1B, 0x1B, 
  0x5B, 0x9B, 0xDB, 0xB0, 0x1C, 0x30, 0x12, 0x38, 
  0x34, 
  247, 21, 3,
  0x05, 0x06, 0x07, 0x0F, 0x11, 0xFF, 0x1F, 0x22, 
  0x23, 0x24, 0x1A, 0x1C, 0x12, 0x13, 0x14, 0xB8, 
  0x1B, 0x30, 0x5B, 
  248, 7, 3,
  0x05, 0x06, 0x07, 0x0F, 0x11, 
  249, 19, 6,
  0x06, 0x07, 0x0F, 0x11, 0xFF, 0x9F, 0xFF, 0xFE, 
  0xF6, 0xF7, 0xFD, 0xEF, 0xC3, 0xC4, 0x99, 0xD8, 
  0xE0, 
  253, 17, 6,
  0x01, 0x02, 0x0C, 0xFF, 0x07, 0x28, 0x29, 0x2A, 
  0x32, 0x3A, 0x70, 0x71, 0x79, 0x00, 0xB8, 
  254, 18, 19,
  0x01, 0x03, 0x0D, 0xFF, 0x2B, 0x25, 0x1D, 0x22, 
  0x1A, 0x23, 0x2B, 0x2C, 0x13, 0x14, 0x60, 0x5B, 
  255, 11, 6,
  0x02, 0x03, 0x0C, 0xFF, 0x2B, 0x2E, 0x35, 0x37, 
  0x3E
};

const uint8_t block[] = 
{
  0x07, 0x08, 0x08, 0x0C, 0x10, 0x00,
  0
};

const uint8_t block_high[] = 
{
  0x07, 0x08, 0x08, 0x0C, 0x10, 0x30,
  0
};

const uint8_t block_ew[] = 
{
  0x36, 0x08, 0x08, 0x0C, 0x10, 0x00,
  0
};

const uint8_t block_ns[] = 
{
  0x37, 0x08, 0x08, 0x0C, 0x10, 0x00,
  0
};

const uint8_t moveable_block[] = 
{
  0x3E, 0x08, 0x08, 0x0C, 0x14, 0x00,
  0
};

const uint8_t dropping_block[] = 
{
  0x5B, 0x08, 0x08, 0x0C, 0x10, 0x00,
  0
};

const uint8_t collapsing_block[] = 
{
  0x8F, 0x08, 0x08, 0x0C, 0x10, 0x00,
  0
};

const uint8_t fire[] = 
{
  0xB0, 0x06, 0x06, 0x0C, 0x10, 0x00,
  0
};

const uint8_t ball_ud_y[] = 
{
  0xB2, 0x07, 0x07, 0x0C, 0x10, 0x02,
  0
};

const uint8_t ball_ud_xy[] = 
{
  0xB2, 0x07, 0x07, 0x0C, 0x10, 0x03,
  0
};

const uint8_t ball_ud[] = 
{
  0xB2, 0x07, 0x07, 0x0C, 0x10, 0x00,
  0
};

const uint8_t ball_ud_x[] = 
{
  0xB2, 0x07, 0x07, 0x0C, 0x10, 0x01,
  0
};

const uint8_t ball_bounce[] = 
{
  0xB6, 0x07, 0x07, 0x0C, 0x10, 0x00,
  0
};

const uint8_t rock[] = 
{
  0x06, 0x08, 0x08, 0x0C, 0x10, 0x00,
  0
};

const uint8_t gargoyle[] = 
{
  0x16, 0x06, 0x06, 0x0C, 0x10, 0x00,
  0
};

const uint8_t spike[] = 
{
  0x17, 0x06, 0x06, 0x0C, 0x50, 0x00,
  0
};

const uint8_t spike_high[] = 
{
  0x17, 0x06, 0x06, 0x0C, 0x50, 0x30,
  0
};

const uint8_t spike_ball_fall[] = 
{
  0x3F, 0x06, 0x06, 0x0C, 0x10, 0x00,
  0
};

const uint8_t spike_ball_high_fall[] = 
{
  0x3F, 0x06, 0x06, 0x0C, 0x10, 0x30,
  0
};

const uint8_t chest[] = 
{
  0x55, 0x09, 0x06, 0x0C, 0x14, 0x00,
  0
};

const uint8_t table[] = 
{
  0x54, 0x06, 0x0A, 0x0C, 0x14, 0x00,
  0
};

const uint8_t guard_ew[] = 
{
  0x96, 0x06, 0x06, 0x18, 0x10, 0x02,
  0x90, 0x06, 0x06, 0x00, 0x12, 0x02,
  0
};

const uint8_t guard_square[] = 
{
  0x1E, 0x06, 0x06, 0x18, 0x10, 0x00,
  0x90, 0x06, 0x06, 0x00, 0x12, 0x00,
  0
};

const uint8_t ghost[] = 
{
  0x52, 0x06, 0x06, 0x0C, 0x10, 0x00,
  0
};

const uint8_t fire_ns[] = 
{
  0xB5, 0x06, 0x06, 0x0C, 0x10, 0x00,
  0
};

const uint8_t fire_ew[] = 
{
  0x56, 0x06, 0x06, 0x0C, 0x10, 0x00,
  0
};

const uint8_t repel_spell[] = 
{
  0xA4, 0x05, 0x05, 0x0C, 0x10, 0x00,
  0
};

const uint8_t gate_ud_1[] = 
{
  0x08, 0x0C, 0x01, 0x20, 0x50, 0x01,
  0
};

const uint8_t gate_ud_2[] = 
{
  0x08, 0x01, 0x0C, 0x20, 0x10, 0x02,
  0
};

uint8_t const *block_type_tbl[] __FORCE_RODATA__ = 
{
  block,
  fire,
  ball_ud_y,
  rock,
  gargoyle,
  spike,
  chest,
  table,
  guard_ew,
  ghost,
  fire_ns,
  block_high,
  ball_ud_xy,
  guard_square,
  block_ew,
  block_ns,
  moveable_block,
  spike_high,
  spike_ball_fall,
  spike_ball_high_fall,
  fire_ew,
  dropping_block,
  collapsing_block,
  ball_bounce,
  ball_ud,
  repel_spell,
  gate_ud_1,
  gate_ud_2,
  ball_ud_x
};

// not const
SPECOBJ special_objs_tbl[] = 
{
  { 0x00, 0x88, 0x80, 0xA4, 0x6D, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x80, 0x80, 0x8C, 0x27, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0x78, 0xB0, 0xD0, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x88, 0x80, 0x0A, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x88, 0x80, 0xBA, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0x78, 0xB0, 0x42, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0xB8, 0xBC, 0x8D, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0xA8, 0xA8, 0x80, 0xFF, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x80, 0x80, 0x80, 0x87, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0xB8, 0x80, 0xF3, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0xA8, 0x68, 0xB0, 0xA8, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0xB8, 0x48, 0xB0, 0xD2, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x48, 0x48, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0xB8, 0x80, 0x22, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0xB8, 0xB8, 0xB0, 0x7A, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0xB8, 0xB8, 0x80, 0xF9, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0x98, 0xB0, 0xD6, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x88, 0xB0, 0xE8, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x78, 0xB0, 0xF6, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0x78, 0x8C, 0x0F, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0xB8, 0xB8, 0x80, 0x6F, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x48, 0xB8, 0xA4, 0xFD, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x78, 0xB0, 0x08, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x88, 0x88, 0xA4, 0xBB, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x78, 0xB0, 0xDF, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x80, 0x80, 0x80, 0x5E, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x88, 0xB0, 0xB4, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x78, 0x78, 0xB0, 0x04, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x48, 0xB8, 0x80, 0x74, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x80, 0x80, 0x80, 0x40, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x68, 0x78, 0xB0, 0x38, 0x00, 0x00, 0x00, 0x00 },
  { 0x00, 0x48, 0xB8, 0x98, 0xF0, 0x00, 0x00, 0x00, 0x00 },
};

const uint8_t start_game_tune[] = 
{
  0x59, 0x5C, 0x5B, 0x54, 0x19, 0x17, 0x14, 0x17, 
  0xD9, 0xFF
};

const uint8_t game_over_tune[] = 
{
  0x2E, 0x17, 0x27, 0x17, 0x2E, 0x17, 0x27, 0x17, 
  0x2C, 0x19, 0x27, 0x19, 0x2C, 0x19, 0x27, 0x19, 
  0x2A, 0x1B, 0x27, 0x1B, 0x2A, 0x1B, 0x27, 0x1B, 
  0x2A, 0x1B, 0x27, 0x1B, 0x2A, 0x1B, 0x27, 0x1B, 
  0xFF
};

const uint8_t game_complete_tune[] = 
{
  0x1B, 0x1D, 0x1E, 0x1B, 0x1D, 0x1E, 0x20, 0x1D, 
  0x1E, 0x20, 0x22, 0x1E, 0x1D, 0x1E, 0x20, 0x1D, 
  0x1B, 0x1D, 0x1E, 0x1B, 0x1A, 0x1B, 0x1D, 0x1A, 
  0x9B, 0xFF
};

const uint8_t menu_tune[] = 
{
  0x1B, 0x27, 0x1B, 0x27, 0x1B, 0x2A, 0x2E, 0x1B, 
  0x27, 0x1B, 0x27, 0x1B, 0x2A, 0x1B, 0x2E, 0x16, 
  0x25, 0x16, 0x24, 0x16, 0x22, 0x16, 0x22, 0x16, 
  0x25, 0x16, 0x24, 0x16, 0x22, 0x16, 0x22, 0x16, 
  0x22, 0x1B, 0x27, 0x1B, 0x27, 0x1B, 0x2A, 0x2E, 
  0x1B, 0x27, 0x1B, 0x27, 0x1B, 0x2A, 0x1B, 0x2E, 
  0x16, 0x25, 0x16, 0x24, 0x16, 0x22, 0x16, 0x22, 
  0x16, 0x25, 0x16, 0x24, 0x16, 0x22, 0x16, 0x22, 
  0x16, 0x22, 0x17, 0x2E, 0x17, 0x2E, 0x17, 0x2E, 
  0x17, 0x2E, 0x19, 0x2E, 0x19, 0x2E, 0x19, 0x2E, 
  0x19, 0x2E, 0x1B, 0x2E, 0x1B, 0x2E, 0x1B, 0x2E, 
  0x1B, 0x2E, 0x1B, 0x2E, 0x1B, 0x2E, 0x1B, 0x2E, 
  0x1B, 0x2E, 0xFF
};

const uint8_t cauldron_bubbles[] = 
{
  0xA0, 0x80, 0x80, 0x80, 0x05, 0x05, 0x0C, 0x10, 
  0xB4, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00, 0x00, 
  0x00, 0x00
};

const uint8_t complete_colours[] = 
{
  0x47, 0x46, 0x45, 0x44, 0x43, 0x42 };

const uint8_t complete_xy[] = 
{
  0x40, 0x87, 0x40, 0x77, 0x30, 0x67, 0x30, 0x57, 
  0x50, 0x47, 0x30, 0x37 };

const char *complete_text[] __FORCE_RODATA__ = 
{
  "THE POTION CASTS", 
  "ITS MAGIC STRONG", 
  "ALL EVIL MUST BEWARE", 
  "THE SPELL HAS BROKEN", 
  "YOU ARE FREE", 
  "GO FORTH TO MIREMARE"
};

const uint8_t gameover_colours[] = 
{
  0x47, 0x46, 0x45, 0x45, 0x43, 0x44 };

const uint8_t gameover_xy[] = 
{
  0x58, 0x9F, 0x50, 0x7F, 0x30, 0x6F, 0x40, 0x5F, 
  0x30, 0x4F, 0x48, 0x37 };

char const *gameover_text[] __FORCE_RODATA__ = 
{
  "GAME  OVER", 
  "TIME    DAYS", 
  "PERCENTAGE OF QUEST", 
  "COMPLETED     %", 
  "CHARMS COLLECTED   ", 
  "OVERALL RATING"
};

const uint8_t object_attributes[] = 
{
  0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x42, 0x47
};

const RATING rating_tbl[] = 
{
  { 0x42, "   POOR"     }, 
  { 0x42, " AVERAGE"    }, 
  { 0x42, "   FAIR"     }, 
  { 0x42, "   GOOD"     }, 
  { 0x42, "EXCELLENT"   }, 
  { 0x42, "MARVELLOUS"  }, 
  { 0x42, "   HERO"     }, 
  { 0x42, "ADVENTURER"  }
};

const uint8_t day_txt[] = 
{
  0x00, 0x00, 0x01, 0x02, 0x83
};

// not const
// - yes, for now because no flashing
const uint8_t menu_colours[] = 
{
  0x43, 0xC4, 0x44, 0x44, 0x44, 0x45, 0x47, 0x47
};

const uint8_t menu_xy[] = 
{
  0x58, 0x9F, 0x30, 0x8F, 0x30, 0x7F, 0x30, 0x6F, 
  0x30, 0x5F, 0x30, 0x4F, 0x30, 0x3F, 0x50, 0x27
};

char const *menu_text[] __FORCE_RODATA__ = 
{
  "KNIGHT LORE", 
  "1 KEYBOARD", 
  "2 KEMPSTON JOYSTICK", 
  "3 CURSOR   JOYSTICK", 
  "4 INTERFACE II", 
  "5 DIRECTIONAL CONTROL", 
  "0 START GAME", 
  "@ 1984 A.C.G."
};

// not const
uint8_t objects_required[] = 
{
  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x03, 
  0x05, 0x00, 0x06, 0x01, 0x02, 0x04
};

const uint8_t sun_moon_yoff[] = 
{
  0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0A, 0x09, 
  0x08, 0x07, 0x06, 0x05, 0x05
};

const uint8_t plyr_spr_init_data[] = 
{
  0x78, 0x80, 0x80, 0x80, 0x05, 0x05, 0x17, 0x1C, 
  0x78, 0x80, 0x80, 0x8C, 0x05, 0x05, 0x00, 0x1E

};

const uint8_t start_locations[] = 
{
  0x2F, 0x44, 0xB3, 0x8F
};

const uint8_t panel_data[] = 
{
  0x86, 0x00, 0x10, 0x34,
  0x87, 0x00, 0xF0, 0x00,
  0x88, 0x00, 0x90, 0x04,
  0x86, 0x40, 0xA0, 0x14,
  0x87, 0x40, 0x00, 0x00,
  0x88, 0x40, 0x60, 0x04,
};

const uint8_t border_data[][4] =
{
  // sprite index, flags, x, y
  { 0x89, 0x00, 0x00, 0xA0 },
  { 0x89, 0x40, 0xE0, 0xA0 },
  { 0x89, 0xC0, 0xE0, 0x00 },
  { 0x89, 0x80, 0x00, 0x00 },
  { 0x8B, 0x00, 0x20, 0xA8 },
  { 0x8B, 0x00, 0x20, 0x00 },
  { 0x8A, 0x00, 0x00, 0x20 },
  { 0x8A, 0x00, 0xE8, 0x20 } 
};

