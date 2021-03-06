#include "osd_types.h"

const uint8_t tile_data_c2bpp[] =
{
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $00 space
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

    0xAA, 0x80, 0xA0, 0xAA, 0x80, 0xA0, 0xAA, 0x80, 0xA0, 0xAA, 0x80, 0xA0,  // $01 brick
    0x00, 0x00, 0x00, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0,
    0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0,  // $02 solid
    0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0,
    0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0, 0x3F, 0xFF, 0xC0, 0x3C, 0x03, 0xC0,  // $03 ladder
    0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0, 0x3F, 0xFF, 0xC0,
    0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0,

    0x00, 0x00, 0x00, 0xFF, 0xFF, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $04 rope
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

    0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00, 0x0F, 0xFF, 0x00,  // $05 fall-thru
    0x00, 0xF0, 0x00, 0x00, 0xF0, 0x00, 0x00, 0xF0, 0x00, 0x00, 0xF0, 0x00,
    0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x3C, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x3F, 0xFF, 0xC0, 0x3C, 0x03, 0xC0,  // $06 end ladder
    0x00, 0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xC0, 0x3C, 0x03, 0xC0,
    0x3F, 0xFF, 0xC0, 0x3C, 0x00, 0x00, 0x3C, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $07 gold
    0x00, 0x00, 0x00, 0x03, 0xFF, 0x00, 0x01, 0x55, 0x00, 0x03, 0xFF, 0x00,
    0x01, 0x55, 0x00, 0x03, 0xFF, 0x00, 0x00, 0x00, 0x00,

    0x00, 0x80, 0x00, 0x01, 0x50, 0x00, 0x01, 0x50, 0x00, 0x00, 0x10, 0x00,  // $08 guard left 0
    0x01, 0x55, 0x00, 0x10, 0x10, 0x10, 0x00, 0x3C, 0x00, 0x00, 0xFC, 0x00,
    0x03, 0xEF, 0xF0, 0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00,

    0x00, 0x08, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0xFC, 0x00,  // $09 player right 0
    0x0F, 0x7F, 0x00, 0x3E, 0xF0, 0xF0, 0x00, 0xF0, 0x00, 0x00, 0xFC, 0x00,
    0x3F, 0xEF, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00,

    0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0,  // $0A solid square
    0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0,
    0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0, 0xFF, 0xFF, 0xF0,

    0x01, 0x00, 0x00, 0x0F, 0xC0, 0x00, 0x0F, 0xC0, 0x00, 0x03, 0xF0, 0x00,  // $0B player left 0
    0x0F, 0xEF, 0x00, 0xF0, 0xF7, 0xE0, 0x00, 0xF0, 0x00, 0x03, 0xF0, 0x00,
    0x0F, 0x7F, 0xC0, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00,

    0x01, 0x00, 0x00, 0x0F, 0xC0, 0x00, 0x0F, 0xC0, 0x00, 0x03, 0xC0, 0x00,  // $0C player left 1
    0x03, 0xF0, 0x00, 0x0F, 0xFC, 0x00, 0xF7, 0xFC, 0x00, 0x0F, 0xC0, 0x00,
    0x0F, 0xF0, 0x00, 0x00, 0xFC, 0x00, 0x00, 0xF0, 0x00,

    0x01, 0x00, 0x00, 0x0F, 0xC0, 0x00, 0x0F, 0xC0, 0x00, 0x03, 0xC0, 0x00,  // $0D player left 4
    0x17, 0xFC, 0x00, 0x3F, 0xEF, 0x00, 0x03, 0xC0, 0x00, 0x0F, 0xF0, 0x00,
    0x3C, 0x3C, 0x00, 0x3C, 0x0F, 0x00, 0x00, 0x0F, 0x00,

    0x00, 0xF0, 0x00, 0x00, 0xF0, 0x10, 0x00, 0xFF, 0xF0, 0x10, 0xFC, 0x00,  // $0E player climb 0
    0x3F, 0xFC, 0x00, 0x00, 0xFC, 0x00, 0x00, 0xFC, 0x00, 0x03, 0xEF, 0x00,
    0x03, 0xEF, 0xC0, 0x03, 0xC0, 0x00, 0x0F, 0xC0, 0x00,

    0x00, 0x08, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x0F, 0x00,  // $0F player dig left
    0x00, 0xFF, 0xF0, 0x17, 0xEF, 0x50, 0x10, 0x0F, 0x00, 0x00, 0x3F, 0x00,
    0x00, 0xF7, 0xC0, 0x00, 0xF7, 0xC0, 0x00, 0xF7, 0xC0,

    0x00, 0x08, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3C, 0x00,  // $10 player right 1
    0x00, 0xFC, 0x00, 0x03, 0xFF, 0x00, 0x03, 0xFE, 0xF0, 0x00, 0x3F, 0x00,
    0x00, 0xFF, 0x00, 0x03, 0xF0, 0x00, 0x00, 0xF0, 0x00,

    0x00, 0x08, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3C, 0x00,  // $11 player right 2
    0x03, 0xFE, 0x80, 0x0F, 0x7F, 0xC0, 0x00, 0x3C, 0x00, 0x00, 0xFF, 0x00,
    0x03, 0xC3, 0xC0, 0x0F, 0x03, 0xC0, 0x0F, 0x00, 0x00,

    0x00, 0xF0, 0x00, 0x80, 0xF0, 0x00, 0xFF, 0xF0, 0x00, 0x03, 0xF0, 0x80,  // $12 player climb 1
    0x03, 0xFF, 0xC0, 0x03, 0xF0, 0x00, 0x03, 0xF0, 0x00, 0x0F, 0x7C, 0x00,
    0x3F, 0x7C, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x3F, 0x00,

    0x3C, 0x10, 0xF0, 0x3E, 0xFE, 0xF0, 0x3E, 0xFE, 0xF0, 0x0F, 0xFF, 0xC0,  // $13 player fall left
    0x00, 0x3C, 0x00, 0x00, 0x3C, 0x00, 0x03, 0xFC, 0x00, 0x0F, 0x7C, 0x00,
    0x0F, 0x7C, 0x00, 0x0F, 0x7C, 0x00, 0x00, 0x3C, 0x00,

    0xF0, 0x83, 0xE0, 0xF7, 0xF7, 0xE0, 0xF7, 0xF7, 0xE0, 0x3F, 0xFF, 0x00,  // $14 player fall right
    0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xFC, 0x00, 0x03, 0xEF, 0x00,
    0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00, 0x03, 0xC0, 0x00,

    0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0, 0x3E, 0xF7, 0xC0, 0x3E, 0xFF, 0x00,  // $15 player swing right 0
    0x0F, 0xF0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x3F, 0xC0, 0x00,
    0xF0, 0x80, 0x00, 0xF7, 0xC0, 0x00, 0xAF, 0x00, 0x00,

    0x00, 0x3C, 0x00, 0x00, 0x3C, 0x00, 0x03, 0xFC, 0x00, 0x03, 0xF0, 0x00,  // $16 player swing right 1
    0x3F, 0xC0, 0x00, 0xF7, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x0F, 0xC0, 0x00,
    0x3E, 0xF0, 0x00, 0x3E, 0xF0, 0x00, 0x3E, 0xF0, 0x00,

    0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xFC, 0x00, 0x00, 0xFE, 0xF0,  // $17 player swing right 2
    0x00, 0x3F, 0xC0, 0x00, 0x3C, 0x00, 0x00, 0x3C, 0x00, 0x00, 0xFC, 0x00,
    0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00,

    0x3C, 0x03, 0xC0, 0x3C, 0x03, 0xC0, 0x3E, 0xF7, 0xC0, 0x0F, 0xF7, 0xC0,  // $18 player swing left 0
    0x00, 0xFF, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x3F, 0xC0,
    0x00, 0x10, 0xF0, 0x00, 0x3E, 0xF0, 0x00, 0x0F, 0x50,

    0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xFC, 0x00, 0x00, 0xFC, 0x00,  // $19 player swing left 1
    0x00, 0x3F, 0xC0, 0x00, 0x3E, 0xF0, 0x00, 0x3C, 0x00, 0x00, 0x3F, 0x00,
    0x00, 0xF7, 0xC0, 0x00, 0xF7, 0xC0, 0x00, 0xF7, 0xC0,

    0x00, 0x3C, 0x00, 0x00, 0x3C, 0x00, 0x03, 0xFC, 0x00, 0xF7, 0xF0, 0x00,  // $1A player swing left 2
    0x3F, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xC0, 0x00, 0x03, 0xF0, 0x00,
    0x0F, 0x7C, 0x00, 0x0F, 0x7C, 0x00, 0x0F, 0x7C, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $1B dig spray 0
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x08, 0x10,
    0x08, 0x00, 0x10, 0x00, 0x81, 0x00, 0x00, 0x01, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,  // $1C dig spray 1
    0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x00, 0x00, 0x08, 0x00, 0x00,
    0x00, 0xA8, 0x10, 0x08, 0x01, 0x50, 0x00, 0x81, 0x00,

    0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $1D dig spray 2
    0x00, 0x00, 0x00, 0x80, 0x80, 0x00, 0x00, 0x00, 0x80, 0x80, 0x00, 0x00,
    0x08, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,  // $1E dig spray 3
    0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

    0xA8, 0x10, 0xA0, 0xAA, 0x80, 0xA0, 0xAA, 0x80, 0xA0, 0xAA, 0x80, 0xA0,  // $1F dig brick 0
    0x00, 0x00, 0x00, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0,
    0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x10, 0x00, 0x01, 0x50, 0x00, 0x80, 0x00, 0xA0, 0xAA, 0x80, 0xA0,  // $20 dig brick 1
    0x00, 0x00, 0x00, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0,
    0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x50, 0x00, 0x81, 0x50, 0xA0,  // $21 dig brick 2
    0x00, 0x00, 0x00, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0,
    0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,  // $22 dig brick 3
    0x01, 0x50, 0x00, 0x01, 0x55, 0x00, 0x00, 0x00, 0x00, 0x80, 0xAA, 0xA0,
    0x80, 0xAA, 0xA0, 0x80, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $23 dig brick 4
    0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x15, 0x00, 0x81, 0x55, 0x00,
    0x80, 0x00, 0x00, 0x80, 0xAA, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $24 dig brick 5
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
    0x01, 0x50, 0x00, 0x01, 0x55, 0x00, 0x00, 0x00, 0x00,

    0x00, 0x80, 0x00, 0x03, 0xF0, 0x00, 0x03, 0xF0, 0x00, 0x03, 0xC0, 0x00,  // $25 player dig right
    0x3F, 0xFC, 0x00, 0x17, 0xEF, 0x50, 0x03, 0xC0, 0x10, 0x03, 0xF0, 0x00,
    0x0F, 0x7C, 0x00, 0x0F, 0x7C, 0x00, 0x0F, 0x7C, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $26 dig spray 3
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x08, 0x08, 0x00,
    0x10, 0x80, 0x00, 0x15, 0x00, 0x80, 0x01, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,  // $27 dig spray 5
    0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xA8, 0x00, 0x00, 0x10, 0x00, 0x00,
    0x10, 0xA8, 0x00, 0x01, 0x01, 0x00, 0x01, 0x01, 0x00,

    0x00, 0x08, 0x00, 0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x10, 0x00,  // $28 guard right 0
    0x01, 0x55, 0x00, 0x10, 0x10, 0x10, 0x00, 0xF0, 0x00, 0x00, 0xFC, 0x00,
    0x3F, 0xEF, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00,

    0x00, 0x08, 0x00, 0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x10, 0x00,  // $29 guard right 1
    0x01, 0x50, 0x00, 0x01, 0x55, 0x00, 0x00, 0x3C, 0x10, 0x00, 0x3F, 0x00,
    0x00, 0xFF, 0x00, 0x03, 0xF0, 0x00, 0x00, 0xF0, 0x00,

    0x00, 0x08, 0x00, 0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x10, 0x00,  // $2A guard right 2
    0x01, 0x55, 0x00, 0x10, 0x15, 0x00, 0x00, 0x3C, 0x00, 0x00, 0xFF, 0x00,
    0x03, 0xC3, 0xC0, 0x0F, 0x03, 0xC0, 0x0F, 0x00, 0x00,

    0x00, 0x80, 0x00, 0x01, 0x50, 0x00, 0x01, 0x50, 0x00, 0x00, 0x10, 0x00,  // $2B guard left 0
    0x00, 0x15, 0x00, 0x01, 0x55, 0x00, 0x10, 0xF0, 0x00, 0x03, 0xF0, 0x00,
    0x03, 0xFC, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3C, 0x00,

    0x00, 0x80, 0x00, 0x01, 0x50, 0x00, 0x01, 0x50, 0x00, 0x00, 0x10, 0x00,  // $2C guard left 1
    0x01, 0x55, 0x00, 0x01, 0x50, 0x10, 0x00, 0xF0, 0x00, 0x03, 0xFC, 0x00,
    0x0F, 0x0F, 0x00, 0x0F, 0x03, 0xC0, 0x00, 0x03, 0xC0,

    0x10, 0x01, 0x00, 0x10, 0x01, 0x00, 0x10, 0x15, 0x00, 0x10, 0x15, 0x00,  // $2D guard swing right 0
    0x01, 0x50, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x3F, 0xC0, 0x00,
    0xF0, 0x80, 0x00, 0xF7, 0xC0, 0x00, 0xAF, 0x00, 0x00,

    0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x01, 0x50, 0x00, 0x01, 0x50, 0x00,  // $2E guard swing right 1
    0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x01, 0x00, 0x00, 0x0F, 0xC0, 0x00,
    0x3E, 0xF0, 0x00, 0x3E, 0xF0, 0x00, 0x00, 0xF0, 0x00,

    0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x50, 0x00, 0x00, 0x10, 0x10,  // $2F guard swing right 2
    0x00, 0x15, 0x00, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0xFC, 0x00,
    0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00,

    0x10, 0x01, 0x00, 0x10, 0x01, 0x00, 0x15, 0x01, 0x00, 0x15, 0x01, 0x00,  // $30 guard swing left 0
    0x01, 0x50, 0x00, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0xFF, 0x00,
    0x00, 0x83, 0xC0, 0x00, 0xF7, 0xC0, 0x00, 0x3E, 0x80,

    0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x50, 0x00, 0x01, 0x50, 0x00,  // $31 guard swing left 1
    0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x10, 0x00, 0x00, 0xFC, 0x00,
    0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00, 0x03, 0xEF, 0x00,

    0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x01, 0x50, 0x00, 0x01, 0x00, 0x00,  // $32 guard swing left 2
    0x15, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x0F, 0xC0, 0x00,
    0x3E, 0xF0, 0x00, 0x3E, 0xF0, 0x00, 0x3E, 0xF0, 0x00,

    0x00, 0x10, 0x00, 0x00, 0x10, 0x10, 0x00, 0x15, 0x50, 0x10, 0x10, 0x00,  // $33 guard climb 0
    0x15, 0x50, 0x00, 0x00, 0x10, 0x00, 0x00, 0xFC, 0x00, 0x03, 0xEF, 0x00,
    0x03, 0xEF, 0xC0, 0x03, 0xC0, 0x00, 0x0F, 0xC0, 0x00,

    0x00, 0x10, 0x00, 0x80, 0x10, 0x00, 0xF5, 0x50, 0x00, 0x01, 0x50, 0x80,  // $34 guard climb 1
    0x01, 0x57, 0xC0, 0x01, 0x50, 0x00, 0x03, 0xF0, 0x00, 0x0F, 0x7C, 0x00,
    0x3F, 0x7C, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x3F, 0x00,

    0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x01, 0x55, 0x00,  // $35 guard fall right
    0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xF7, 0xC0,
    0x00, 0xF7, 0xC0, 0x00, 0xF7, 0xC0, 0x00, 0xF0, 0x00,

    0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x01, 0x55, 0x00,  // $36 guard fall left
    0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x03, 0xFC, 0x00, 0x0F, 0x7C, 0x00,
    0x0F, 0x7C, 0x00, 0x0F, 0x7C, 0x00, 0x00, 0x3C, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $37 brick refill 0
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x80, 0x00, 0xA0, 0x80, 0x00, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $38 brick refill 1
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0xA0, 0x80, 0x00, 0xA0,
    0x80, 0x00, 0xA0, 0x80, 0x00, 0xA0, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $39 guard respawn 0
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x01, 0x50, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $3A guard respawn 1
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x01, 0x50, 0x00, 0x15, 0x55, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $3B '0'
    0x10, 0x01, 0x00, 0x10, 0x01, 0x00, 0x10, 0x01, 0x00, 0x10, 0x15, 0x00,
    0x10, 0x15, 0x00, 0x10, 0x15, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x50, 0x00,  // $3C '1'
    0x01, 0x50, 0x00, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00,
    0x00, 0x10, 0x00, 0x01, 0x55, 0x00, 0x01, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $3D '2'
    0x10, 0x01, 0x00, 0x00, 0x01, 0x00, 0x15, 0x55, 0x00, 0x10, 0x00, 0x00,
    0x10, 0x00, 0x00, 0x10, 0x15, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $3E '3'
    0x10, 0x01, 0x00, 0x00, 0x01, 0x00, 0x01, 0x55, 0x00, 0x00, 0x01, 0x00,
    0x00, 0x01, 0x00, 0x10, 0x01, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x01, 0x00,  // $3F '4'
    0x15, 0x01, 0x00, 0x15, 0x01, 0x00, 0x15, 0x55, 0x00, 0x00, 0x01, 0x00,
    0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $40 '5'
    0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0x15, 0x55, 0x00, 0x00, 0x15, 0x00,
    0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $41 '6'
    0x10, 0x01, 0x00, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0x15, 0x55, 0x00,
    0x10, 0x15, 0x00, 0x10, 0x15, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $42 '7'
    0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x01, 0x50, 0x00,
    0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x55, 0x00,  // $43 '8'
    0x01, 0x01, 0x00, 0x01, 0x01, 0x00, 0x15, 0x55, 0x00, 0x10, 0x01, 0x00,
    0x10, 0x01, 0x00, 0x10, 0x01, 0x00, 0x15, 0x55, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x00,  // $44 '9'
    0x10, 0x01, 0x00, 0x10, 0x01, 0x00, 0x15, 0x55, 0x00, 0x00, 0x15, 0x00,
    0x00, 0x15, 0x00, 0x00, 0x15, 0x00, 0x00, 0x15, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0xA8, 0x00,  // $45 'A'
    0x08, 0x08, 0x00, 0x08, 0x08, 0x00, 0xAA, 0xA8, 0x00, 0x80, 0x08, 0x00,
    0x80, 0x08, 0x00, 0x80, 0xA8, 0x00, 0x80, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x80, 0x00,  // $46 'B'
    0x80, 0x80, 0x00, 0x80, 0x80, 0x00, 0xAA, 0xA8, 0x00, 0x80, 0x08, 0x00,
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $47 'C'
    0x80, 0x08, 0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0xA8, 0x00, 0x00,
    0xA8, 0x00, 0x00, 0xA8, 0x08, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0x80, 0x00,  // $48 'D'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xA8, 0x08, 0x00,
    0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xAA, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $49 'E'
    0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xAA, 0x80, 0x00, 0x80, 0x00, 0x00,
    0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $4A 'F'
    0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xAA, 0x80, 0x00, 0x80, 0x00, 0x00,
    0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $4B 'G'
    0x80, 0x08, 0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0x80, 0xA8, 0x00,
    0x80, 0xA8, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $4C 'H'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00, 0xA8, 0x08, 0x00,
    0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00,  // $4D 'I'
    0x08, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,
    0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,  // $4E 'J'
    0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00,
    0x00, 0xA8, 0x00, 0x80, 0xA8, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $4F 'K'
    0x80, 0xA8, 0x00, 0x80, 0x80, 0x00, 0xAA, 0x80, 0x00, 0xAA, 0xA8, 0x00,
    0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00,  // $50 'L'
    0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x00, 0xA8, 0x00, 0x00,
    0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $51 'M'
    0xA8, 0x08, 0x00, 0xAA, 0xA8, 0x00, 0xAA, 0xA8, 0x00, 0x80, 0x08, 0x00,
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $52 'N'
    0x80, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xAA, 0xA8, 0x00, 0xAA, 0xA8, 0x00,
    0x80, 0xA8, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $53 'O'
    0x80, 0xA8, 0x00, 0x80, 0xA8, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00,
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $54 'P'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00, 0xA8, 0x00, 0x00,
    0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $55 'Q'
    0x80, 0xA8, 0x00, 0x80, 0xA8, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00,
    0x80, 0x08, 0x00, 0x80, 0x80, 0x00, 0xA8, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $56 'R'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00, 0xAA, 0x80, 0x00,
    0xAA, 0x80, 0x00, 0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $57 'S'
    0x80, 0x08, 0x00, 0x80, 0x00, 0x00, 0xAA, 0xA8, 0x00, 0x00, 0xA8, 0x00,
    0x00, 0xA8, 0x00, 0x80, 0xA8, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $58 'T'
    0x08, 0x00, 0x00, 0x08, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0A, 0x80, 0x00,
    0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $59 'U'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xA8, 0x08, 0x00,
    0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x08, 0x00,  // $5A 'V'
    0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00, 0xA8, 0x08, 0x00,
    0xAA, 0xA8, 0x00, 0x0A, 0x80, 0x00, 0x08, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $5B 'W'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0xAA, 0xA8, 0x00,
    0xAA, 0xA8, 0x00, 0xA8, 0x08, 0x00, 0x80, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x08, 0x00,  // $5C 'X'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x80, 0x08, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xA8, 0x00,  // $5D 'Y'
    0x80, 0xA8, 0x00, 0x80, 0xA8, 0x00, 0xAA, 0xA8, 0x00, 0x0A, 0x80, 0x00,
    0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xA8, 0x00,  // $5E 'Z'
    0x80, 0x08, 0x00, 0x80, 0x08, 0x00, 0x00, 0x80, 0x00, 0x0A, 0x80, 0x00,
    0x80, 0x00, 0x00, 0x80, 0xA8, 0x00, 0xAA, 0xA8, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00,  // $5F '>'
    0xA8, 0x00, 0x00, 0x0A, 0x80, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00,
    0x0A, 0x80, 0x00, 0xA8, 0x00, 0x00, 0x80, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $60 '.'
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x80, 0x00,  // $61 '('
    0x0A, 0x80, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00,
    0xA8, 0x00, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x80, 0x00,  // $62 ')'
    0x0A, 0x80, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00,
    0x00, 0xA8, 0x00, 0x0A, 0x80, 0x00, 0x0A, 0x80, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,  // $63 '/'
    0x00, 0x08, 0x00, 0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x08, 0x00, 0x00,
    0x08, 0x00, 0x00, 0x80, 0x00, 0x00, 0x80, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $64 '-'
    0x00, 0x00, 0x00, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA, 0xA0,
    0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,  // $65 '<'
    0x00, 0xA8, 0x00, 0x0A, 0x80, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0x00, 0x00,
    0x0A, 0x80, 0x00, 0x00, 0xA8, 0x00, 0x00, 0x08, 0x00,

    0x10, 0x00, 0xF0, 0xFC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $66 (unknown)
    0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
    0x00, 0x01, 0x00, 0x00, 0x01, 0x50, 0x00, 0x00, 0x00,

    0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00,  // $67 (unknown)
    0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00,
    0x80, 0x01, 0x70, 0x00, 0x01, 0x50, 0x00, 0x00, 0x00,

    // added MMc

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // $68 separator (Neo Geo)
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x00
};
