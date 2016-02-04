
// osd stuff

#include <exec/memory.h>
#include <proto/intuition.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <devices/keyboard.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <hardware/blit.h>
#include <stdlib.h>

#include "osd_types.h"
#include "kl_osd.h"

#define ENABLE_MASK

// bitmaps
#define VIDBUF          0
#define VIDEO           1
#define BLANK           2
#define BM_WIDTH        256
#define BM_HEIGHT       192
#define BM_WIDTH_BYTES  (BM_WIDTH/8)
#define PL_SIZE         (BM_WIDTH_BYTES*BM_HEIGHT)

extern void knight_lore (void);
extern uint8_t *flip_sprite (POBJ32 p_obj);

static struct IntuitionBase *IntuitionBase;
static struct GfxBase *GfxBase;
static struct BitMap *myBitMaps[BLANK+1];
static struct Screen *screen;
static struct NewScreen myNewScreen;
static struct IOStdReq *KeyIO;
static struct MsgPort *KeyMP;
static uint8_t *keyMatrix;
  
const char __ver[40] = "$VER: Knight Lore 0.1 (03.02.2016)";

void osd_delay (unsigned ms)
{
  Delay (ms/50);
}

void osd_clear_scrn (void)
{
  //SetRast (&(screen->RastPort), ON_PEN);
  BltClear (myBitMaps[VIDEO]->Planes[0], PL_SIZE, 1);
}

void osd_clear_scrn_buffer (void)
{
  BltClear (myBitMaps[VIDBUF]->Planes[0], PL_SIZE, 1);
}

int osd_key (int _key)
{
  KeyIO->io_Command = KBD_READMATRIX;
  KeyIO->io_Data = (APTR)keyMatrix;
  //KeyIO->io_Length= SysBase->lib_Version >= 36 ? MATRIX_SIZE : 13;
  KeyIO->io_Length = 13;
  DoIO ((struct IORequest *)KeyIO);

  if (keyMatrix[_key>>3] & (1<<(_key&7)))
    return (1);
      
	return (0);
}

int osd_keypressed (void)
{
	#if 0
  return (keypressed ());
	#endif
	return (0);
}

int osd_readkey (void)
{
	#if 0
  return (readkey ());
	#endif
	return (0);
}

void osd_print_text_raw (uint8_t *gfxbase_8x8, uint8_t x, uint8_t y, uint8_t *str)
{
  uint8_t *p = (uint8_t *)myBitMaps[VIDBUF]->Planes[0];
  p += (191-y)*BM_WIDTH_BYTES+x/8;

  unsigned c, l, b;
  
  for (c=0; ; c++, str++)
  {
    uint8_t code = *str & 0x7f;

    unsigned char *q = p;    
    for (l=0; l<8; l++)
    {
      uint8_t d = gfxbase_8x8[code*8+l];
      
      *p = d;
      p += BM_WIDTH_BYTES;
    }  
    if (*str & (1<<7))
      break;
    p = ++q;
  }
}

static uint8_t from_ascii (char ch)
{
  const char *chrset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.� %";
  uint8_t i;
  
  for (i=0; chrset[i]; i++)
    if (chrset[i] == ch)
      return (i);
      
    return ((uint8_t)-1);
}

// always on byte boundary
// - original code calls print_8x8
void osd_print_text (uint8_t *gfxbase_8x8, uint8_t x, uint8_t y, char *str)
{
  uint8_t *p = (uint8_t *)myBitMaps[VIDBUF]->Planes[0];
  p += (191-y)*BM_WIDTH_BYTES+x/8;

  unsigned c, l, b;

  for (c=0; *str; c++)
  {
    uint8_t ascii = (uint8_t)*(str++);
    uint8_t code = from_ascii (ascii);

    unsigned char *q = p;    
    for (l=0; l<8; l++)
    {
      uint8_t d = gfxbase_8x8[code*8+l];
      if (d == (uint8_t)-1)
        break;

      *p = d;
      p += BM_WIDTH_BYTES;

    }  
    p = ++q;
  }
}

uint8_t osd_print_8x8 (uint8_t *gfxbase_8x8, uint8_t x, uint8_t y, uint8_t code)
{
  uint8_t *p = (uint8_t *)myBitMaps[VIDBUF]->Planes[0];
  p += (191-y)*BM_WIDTH_BYTES+x/8;

  unsigned l, b;

  for (l=0; l<8; l++)
  {
    uint8_t d = gfxbase_8x8[code*8+l];
    if (d == (uint8_t)-1)
      break;

    *p = d;
    p += BM_WIDTH_BYTES;    
  }  
  return (x+8);
}

void osd_fill_window (uint8_t x, uint8_t y, uint8_t width_bytes, uint8_t height_lines, uint8_t c)
{
  BltBitMap (myBitMaps[BLANK], x, 191-(y+height_lines-1),
              myBitMaps[VIDBUF], x, 191-(y+height_lines-1),
              width_bytes<<3, height_lines, 0xc0, 0xff, 0);
}

void osd_update_screen (void)
{
  BltBitMapRastPort (myBitMaps[VIDBUF], 0, 0, 
                      &(screen->RastPort), 0, 0, 
                      BM_WIDTH, BM_HEIGHT, 0xC0);
}

void osd_blit_to_screen (uint8_t x, uint8_t y, uint8_t width_bytes, uint8_t height_lines)
{
  BltBitMapRastPort (myBitMaps[VIDBUF], x, 191-(y+height_lines-1), 
                      &(screen->RastPort), x, 191-(y+height_lines-1), 
                      width_bytes<<3, height_lines, 
                      0xC0);
}

void osd_print_sprite (POBJ32 p_obj)
{
  uint8_t *psprite;

  uint8_t *p = (uint8_t *)myBitMaps[VIDBUF]->Planes[0];
  uint8_t o = p_obj->pixel_x & 7;
  
  p += (191-p_obj->pixel_y)*BM_WIDTH_BYTES + p_obj->pixel_x/8;

  //DBGPRINTF("(%d,%d)\n", p_obj->x, p_obj->y);

  // references p_obj
  psprite = flip_sprite (p_obj);

  uint8_t w = *(psprite++) & 0x3f;
  uint8_t h = *(psprite++);

  unsigned x, y, b;
  
  for (y=0; y<h; y++)
  {
    for (x=0; x<w; x++)
    {
      uint8_t m = *(psprite++);
      uint8_t d = *(psprite++);
      
      // handle bit-shift
      uint8_t v = *p;
#ifdef ENABLE_MASK
      v &= ~(m>>o);
#endif
      v |= (d>>o);
      *p++ = v;
      if (o != 0)
      {
        v = *p;
#ifdef ENABLE_MASK
        v &= ~(m<<(8-o));
#endif
        v |= (d<<(8-o));
        *p = v;
      }
    }
    p -= BM_WIDTH_BYTES+w;
  }
}

int main (int argc, char *argv[])
{
  unsigned i;
  
  IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 0);
  GfxBase = (struct GfxBase *)OpenLibrary ("graphics.library", 0);

  KeyMP = (struct MsgPort *)CreatePort (NULL, NULL);
  KeyIO = (struct IOStdReq *)CreateExtIO (KeyMP, sizeof(struct IOStdReq));
  OpenDevice ("keyboard.device", NULL, (struct IORequest *)KeyIO, NULL);
  keyMatrix = AllocMem (16, MEMF_PUBLIC|MEMF_CLEAR);

#if 1
  myBitMaps[VIDBUF] = (struct BitMap *)AllocMem ((LONG)sizeof(struct BitMap), MEMF_CLEAR);
  myBitMaps[VIDEO] = (struct BitMap *)AllocMem ((LONG)sizeof(struct BitMap), MEMF_CLEAR);
  myBitMaps[BLANK] = (struct BitMap *)AllocMem ((LONG)sizeof(struct BitMap), MEMF_CLEAR);
  
  InitBitMap (myBitMaps[VIDBUF], 1, BM_WIDTH, BM_HEIGHT);
  InitBitMap (myBitMaps[VIDEO], 1, BM_WIDTH, BM_HEIGHT);
  InitBitMap (myBitMaps[BLANK], 1, BM_WIDTH, BM_HEIGHT);

  myBitMaps[VIDBUF]->Planes[0] = (PLANEPTR)AllocRaster (BM_WIDTH, BM_HEIGHT);
  BltClear (myBitMaps[VIDBUF]->Planes[0], PL_SIZE, 1);
  myBitMaps[VIDEO]->Planes[0] = (PLANEPTR)AllocRaster (BM_WIDTH, BM_HEIGHT);
  BltClear (myBitMaps[VIDEO]->Planes[0], PL_SIZE, 1);
  // for fill_window
  myBitMaps[BLANK]->Planes[0] = (PLANEPTR)AllocRaster (BM_WIDTH, BM_HEIGHT);
  BltClear (myBitMaps[BLANK]->Planes[0], PL_SIZE, 1);

  myNewScreen.LeftEdge=0;
  myNewScreen.TopEdge=0;
  myNewScreen.Width=BM_WIDTH;
  myNewScreen.Height=BM_HEIGHT;
  myNewScreen.Depth=1;
  myNewScreen.DetailPen=0;
  myNewScreen.BlockPen=1;
  myNewScreen.ViewModes=0; //HIRES;
  myNewScreen.Type=CUSTOMSCREEN | CUSTOMBITMAP | SCREENQUIET;
  myNewScreen.Font=NULL;
  myNewScreen.DefaultTitle=NULL;
  myNewScreen.Gadgets=NULL;
  myNewScreen.CustomBitMap=myBitMaps[VIDEO];
  screen = OpenScreen (&myNewScreen);

  screen->RastPort.BitMap = myBitMaps[VIDEO];
  screen->ViewPort.RasInfo->BitMap = myBitMaps[VIDEO];
  
	knight_lore ();

  CloseScreen (screen);
  
  FreeRaster (myBitMaps[VIDBUF]->Planes[0], BM_WIDTH, BM_HEIGHT);
  FreeRaster (myBitMaps[VIDEO]->Planes[0], BM_WIDTH, BM_HEIGHT);
  FreeRaster (myBitMaps[BLANK]->Planes[0], BM_WIDTH, BM_HEIGHT);
  FreeMem (myBitMaps[VIDBUF], (ULONG)sizeof(struct BitMap));
  FreeMem (myBitMaps[VIDEO], (ULONG)sizeof(struct BitMap));
  FreeMem (myBitMaps[BLANK], (ULONG)sizeof(struct BitMap));
#endif

#if 0
  {
    unsigned i, j;
    
    for (j=0; j<10; )
    {
      KeyIO->io_Command = KBD_READMATRIX;
      KeyIO->io_Data = (APTR)keyMatrix;
      //KeyIO->io_Length= SysBase->lib_Version >= 36 ? MATRIX_SIZE : 13;
      KeyIO->io_Length = 13;
      DoIO ((struct IORequest *)KeyIO);
      for (i=0; i<13; i++)
        if (keyMatrix[i])
        {
          DBGPRINTF ("pressed keyMatrix[%02X]=%02X\n", i, keyMatrix[i]);
          break;
        }
      Delay (10);
    }
  }    
#endif

  FreeMem (keyMatrix, 16);
  CloseDevice ((struct IORequest *)KeyIO);
  DeleteExtIO ((struct IORequest *)KeyIO);
  DeletePort (KeyMP);
  
  if (GfxBase)
    CloseLibrary ((struct Library *)GfxBase);
  if (IntuitionBase) 
    CloseLibrary ((struct Library *)IntuitionBase);
    
  return (0);
}
