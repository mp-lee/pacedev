;
; Star Wars SDK
; - Example 7

        .list   (meb)                   ; macro expansion binary
        .module ex7

.include "swsdk.inc"

; *** BUILD OPTIONS
;.define BUILD_OPT_PROFILE
; *** end of BUILD OPTIONS

; *** derived - do not edit
; *** end of derived

        .area   DATA (ABS,OVR)
        .org    SWSDK_CpuRAMStart

                .ds     256                     ; for DP (MAIN)
cnt     .equ    0x80
delay   .equ    0x81                
in01    .equ    0x82
snd     .equ    0x83
                .ds     256                     ; for DP (IRQ)

        .bank   ROM (BASE=0xE000,SIZE=0x1FE0)
        .area   ROM (REL,CON,BANK=ROM)

RESET::
        ; this MUST be the first instruction       
        jmp     SWSDK_Init

        SWSDK_ACK_IRQ
        andcc   #~(1<<4)                        ; enable IRQ

        ldy     #SWSDK_VectorRAMStart
        SWSDK_JMPL 0x1802                       ; simulate other buffer
        SWSDK_HALT                              ; empty 1st half

        ; copy 3D logo from ROM to vector RAM
        ldx     #starwars
        ldy     #0x2800
1$:     ldd     ,x++
        std     ,y++
        cmpx    #starwars_end
        bne     1$
        
        clr     *cnt
        clr     *snd

loop:

wait_AVG:
        SWSDK_KICK_WDOG
        SWSDK_AVG_HALTED                        ; Z=running
        beq     wait_AVG

        ; ping-pong display list buffer       
        lda     SWSDK_VectorRAMStart            ; MSB of JMPL
        tfr     a,b
        eorb    #0x0A                           ; $0000<->$1400
        stb     SWSDK_VectorRAMStart
        SWSDK_RESET_AVG
        SWSDK_GO_AVG

        ; calculate new address
        anda    #0x1F
        asla                                    ; convert MSB to address
        ldb     #0x02
        tfr     d,y                             ; new display list

        ; The routine that initialises a new display list @$6112 (BANK0)
        ; - which presumably is done every frame -
        ; calls this routine, which renders blue dots in each corner.
        ;SWSDK_JSRL SWSDK_BlueCornerDots

        ; The 3D "STAR WARS" logo is stored in 6809 ROM @$CEDE 
        ; and copied, along with other routines, into vector RAM at $2800.
        ; Of course, the AVG can jump anywhere from $0000-$3FFF
        ; which comprises vector RAM and vector ROM areas.
        ; - this example ping-pongs between $0000 & $1400 and
        ;   will not overwrite the logo vector routines at $2800.

        SWSDK_CNTR
        SWSDK_COLOR SWSDK_BLUE,255
        SWSDK_SCAL 2,0

SW_Y = 850

        ; "ST"
        SWSDK_VCTR 0,SW_Y,0
        SWSDK_SCAL 4,0
        SWSDK_JSRL 0x2800

        ; "A"
        SWSDK_VCTR 0,SW_Y,0
        SWSDK_SCAL 4,0
        SWSDK_JSRL 0x2868

        ; "R"
        SWSDK_VCTR 0,SW_Y,0
        SWSDK_SCAL 4,0
        SWSDK_JSRL 0x28B0
        
        ; "W"
        SWSDK_VCTR 0,SW_Y,0
        SWSDK_SCAL 4,0
        SWSDK_JSRL 0x2910

        ; "A"        
        SWSDK_VCTR 0,SW_Y,0
        SWSDK_SCAL 4,0
        SWSDK_JSRL 0x295C

        ; "RS"        
        SWSDK_VCTR 0,SW_Y,0
        SWSDK_SCAL 4,0
        SWSDK_JSRL 0x29A4

				SWSDK_ENDFRAME
        jmp     loop

sdk_msg:
        .ascii  "STAR WARS SDK "
        SWSDK_SZ_VERSION

title_msg:
        .ascii  "EX7: VECTREX CHARACTER SE"
        .byte   (1<<7)|'T

; 3D logo data and other routines copied from 6809 ROM
; - 3D logo
; - enemy lasers?
; - writing on death star?

starwars:
        .db 0x1A, 0xF6, 0x1D, 0xA8, 0, 0, 0xE2, 8,  0x1F, 0x7E, 0xE0, 0, 0
        .db 0, 0xFF, 0x74,  0xBB, 0x91, 0x1E, 0xC0, 0xFF, 0xCE, 0xBB, 0x8B
        .db 0, 0, 0xFF, 0x4C, 0xBB, 0x91, 1, 0x40,  0xE0, 0x50, 0, 0, 0xFF
        .db 0x4C, 0x51, 0xFB, 0x1F, 0xEC, 0xE0, 0x32, 0x1F, 0xA6, 0xE0, 0x32
        .db 0xBB, 0x91, 0x1F, 0xB0, 0xFF, 0xEC, 0xBB, 0x91, 0x1F, 0x9C, 0xFF
        .db 0x88, 0xBB, 0x8B, 0, 0, 0xFE, 0xC, 0xBB, 0x8B,  0, 0x8C, 0xE0
        .db 0x5A, 0, 0, 0xE1, 0x40, 0x4A, 0xE5, 0,  0x14, 0xFF, 0xD8, 0xBB
        .db 0x85, 0, 0x5A,  0xFF, 0xCE, 0xBB, 0x8B, 0, 0x50, 0xE0, 0x28, 0
        .db 0x64, 0xE0, 0x82, 0x72, 0, 0x80, 0x40,  0xC0, 0, 0x1A, 0xF6, 0
        .db 0xB4, 0x1E, 0x3E, 0xE0, 0xB4, 0xBB, 0x8B, 0, 0, 0xFF, 0x60, 0xBB
        .db 0x8B, 0, 0x46,  0xFF, 0xE2, 0xBB, 0x8E, 0, 0, 0xFF, 0x56, 0xBB
        .db 0x91, 0x1F, 0xBA, 0xFF, 0xF6, 0xBB, 0x91, 0, 0, 0xFF, 0x60, 0xBB
        .db 0x8B, 1, 0xC2,  0xE0, 0x78, 0, 0, 0xE0, 0xE6, 0x1F, 0x88, 0x1F
        .db 0x92, 0xBB, 0x8B, 0x1F, 0x74, 0xE0, 0x46, 0, 0, 0xFF, 0x92, 0
        .db 0x8C, 0xE0, 0x28, 0x72, 0, 0x80, 0x40,  0xC0, 0, 0x1A, 0xF6, 2
        .db 0x26, 0, 0, 0xFE, 0xE8, 0xBB, 0x91, 0x1E, 0x3E, 0xE0, 0x5A, 0
        .db 0, 0xE0, 0xAA,  0xBB, 0x8E, 0, 0x8C, 0xFF, 0xD8, 0x1F, 0x74, 0xE1
        .db 0x22, 0xBB, 0x8B, 0, 0, 0xE1, 0x54, 0xBB, 0x8B, 0, 0x8C, 0xFF
        .db 0xA6, 0, 0, 0xFE, 0xF2, 0, 0x14, 0xFF,  0xD8, 0, 0x3C, 0xE0, 0x3C
        .db 0xBB, 0x88, 0,  0x6E, 0xFF, 0xCE, 0, 0x78, 0xFF, 0x4C, 0x1F, 0x88
        .db 0, 0xA, 0xBB, 0x88, 0x1F, 0xD8, 0xE0, 0x3C, 0x56, 0xE5, 0x1F
        .db 0xCE, 0xFF, 0xD8, 0, 0, 0xFF, 0x7E, 0,  0x6E, 0xFF, 0xD8, 0, 0
        .db 0xE0, 0x8C, 0x72, 0, 0x80, 0x40, 0xC0,  0, 0x18, 0xBC, 0x1C, 0x4A
        .db 0xBB, 0x9A, 0x1F, 0x24, 0xFF, 0xBA, 0,  0xDC, 0xE0, 0xA0, 0, 0
        .db 0xE0, 0x8C, 0xBB, 0x9A, 0x1F, 0x24, 0xFF, 0xBA, 0, 0xDC, 0xE0
        .db 0xAA, 0, 0, 0xE0, 0x8C, 0xBB, 0x9D, 0x1D, 0xE4, 0xFE, 0xE8, 0xBB
        .db 0xA3, 0, 0, 0xFF, 0x10, 0xBB, 0xA3, 0,  0x96, 0xE0, 0x32, 0x1F
        .db 0x6A, 0xFF, 0x7E, 0xBB, 0xA3, 0, 0, 0xFF, 0x10, 0xBB, 0xA3, 2
        .db 0x1C, 0xE0, 0xB4, 0, 0, 0xE0, 0xBE, 0x72, 0, 0x80, 0x40, 0xC0
        .db 0, 0x18, 0xBC,  0x1F, 0xB0, 0x1D, 0xE4, 0xE0, 0x82, 0xBB, 0xA3
        .db 0, 0, 0xFF, 0x38, 0xBB, 0xA3, 0, 0x50,  0xFF, 0xE2, 0xBB, 0xA3
        .db 0, 0, 0xFF, 0x2E, 0xBB, 0xA3, 0x1F, 0xB0, 0xFF, 0xC4, 0xBB, 0xA3
        .db 0, 0, 0xFF, 0x24, 0xBB, 0xA3, 2, 0x1C,  0xE1, 0x18, 0, 0, 0xE1
        .db 0x36, 0x1F, 0x88, 0x1F, 0x56, 0xBB, 0xA0, 0x1F, 0x2E, 0xE0, 0x3C
        .db 0, 0, 0xFF, 0x56, 0, 0xD2, 0xE0, 0x6E,  0x72, 0, 0x80, 0x40, 0xC0
        .db 0, 0x18, 0xBC,  1, 0x9A, 0, 0, 0xFE, 0x84, 0x1D, 0xE4, 0xE0, 0xA
        .db 0, 0, 0xE0, 0xC8, 0xBB, 0xA3, 0, 0xB4,  0xFF, 0xEC, 0x1F, 0x4C
        .db 0xE1, 0x54, 0xBB, 0xA3, 0, 0, 0xE2, 0x58, 0xBB, 0xA3, 0, 0x78
        .db 0xE0, 0x78, 0xBB, 0xA3, 0, 0x6E, 0xFF,  0xC4, 0, 0x78, 0xFF, 0x1A
        .db 0, 0x14, 0xFF,  0xA6, 0, 0x28, 0xFF, 0xEC, 0, 0, 0xE1, 0x68, 0xBB
        .db 0x9D, 0, 0x82,  0xFF, 0xB0, 0, 0, 0xFE, 0x70, 0x1F, 0x9C, 0xFF
        .db 0x9C, 0xBB, 0x9A, 0x1F, 0x9C, 0xE0, 0x28, 0xBB, 0x9D, 0x1F, 0x92
        .db 0xE0, 0xBE, 0xBB, 0x94, 0x1F, 0xEC, 0xE0, 0x50, 0x51, 0xE5, 0
        .db 0, 0xFE, 0xE8,  0, 0x1E, 0xFF, 0x42, 0, 0x50, 0xE0, 0x8C, 0xBB
        .db 0x97, 0, 0x82,  0xFF, 0xD8, 0, 0x78, 0xFF, 0x38, 0x1F, 0x88, 0x1F
        .db 0xCE, 0xBB, 0x9A, 0x1F, 0xC4, 0xE0, 0x64, 0x1F, 0xD8, 0xE0, 0xA
        .db 0x1F, 0xE2, 0xFF, 0xB0, 0, 0, 0xFF, 0x2E, 0, 0x82, 0xFF, 0xF6
        .db 0, 0, 0xE0, 0xBE, 0x72, 0, 0x80, 0x40,  0xC0, 0, 0x64, 0xFF, 0
        .db 0x78, 0xE0, 0xA, 0x1F,  0xD3, 0, 0x1E, 0x1F, 0xB5, 0xFF, 0xD8
        .db 0, 0x3C, 0xE0,  0x4B, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F
        .db 0xD3, 0x1F, 0xFB, 0x1F, 0xF1, 0xFF, 0xBA, 0x1F, 0xD3, 0xE0, 0x50
        .db 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0xD3, 0x1F, 0xEC, 0
        .db 0x5A, 0xFF, 0xC4, 0x1F, 0xB5, 0xE0, 0x1E, 0x51, 0x16, 0, 0x69
        .db 0xFF, 0xF6, 0x1F, 0x88, 0xFF, 0xE2, 0xA0, 0x18, 0xA0, 0x16, 0x64
        .db 0xFF, 0, 0x2D,  0x1F, 0xF6, 0, 0x4B, 0xE0, 0x28, 0x1F, 0xC4, 0xFF
        .db 0xC4, 0, 0x2D,  0, 0xA, 0, 0xF, 0xE0, 0x32, 0, 0xF, 0xFF, 0xB0
        .db 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0,  0x2D, 0, 0, 0x1F, 0xC4
        .db 0xE0, 0x50, 0,  0x3C, 0xFF, 0xE2, 0, 0x3C, 0, 0, 0xA0, 0x18, 0xA0
        .db 0x16, 0x64, 0xFF, 0x1F, 0x88, 0xE0, 0x1E, 0xA0, 0x18, 0xA0, 0x16
        .db 0x64, 0xFF, 0xC0, 0, 0x64, 0xFF, 0, 0x5A, 0xE0, 0xF, 0x1F, 0xF1
        .db 0, 0xF, 0x1F, 0xB5, 0xFF, 0xE2, 0, 0x2D, 0xE0,  0x50, 0xA0, 0x18
        .db 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0xCC, 0,  5, 0, 7, 0xFF, 0xAB, 0x1F
        .db 0xB5, 0xE0, 0x46, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0xF1
        .db 0x1F, 0xCE, 0,  0x5A, 0xFF, 0xEC, 0x1F, 0x88, 0xE0, 0, 0x4F, 0x16
        .db 0, 0x5A, 0xE0,  0x14, 0x1F, 0x90, 0xFF, 0xCE, 0xA0, 0x18, 0xA0
        .db 0x16, 0x64, 0xFF, 0, 0x3C, 0x1F, 0xF1,  0, 0x34, 0xE0, 0x41, 0x1F
        .db 0xE2, 0xFF, 0xB0, 0, 0x2D, 0, 0x14, 0x1F, 0xF1, 0xE0, 0x3C, 0
        .db 0x2D, 0xFF, 0xB0, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x4F, 5
        .db 0x1F, 0xB5, 0xE0, 0x46, 0, 0x5A, 0xFF,  0xE2, 0, 0x25, 0, 0x1E
        .db 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0x81, 0xE0, 0, 0xA0
        .db 0x18, 0xA0, 0x16, 0x64, 0xFF, 0xC0, 0,  0x64, 0xFF, 0, 0x5A, 0xE0
        .db 0xA, 0x4B, 0xF, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0x90
        .db 0xFF, 0xD8, 0,  0x4B, 0xE0, 0x3C, 0x1F, 0xD3, 0x1F, 0xF6, 0x1F
        .db 0xE2, 0xFF, 0xCE, 0, 0xF, 0xE0, 0x55, 0xA0, 0x18, 0xA0, 0x16
        .db 0x64, 0xFF, 0x1F, 0xE2, 0x1F, 0xF1, 0,  0xF, 0xFF, 0xBA, 0x1F
        .db 0xC4, 0xE0, 0x46, 0x1F, 0xD3, 0x1F, 0xEC, 0xA0, 0x18, 0xA0, 0x16
        .db 0x64, 0xFF, 0,  0x69, 0xFF, 0xCE, 0x1F, 0x97, 0xFF, 0xF6, 0x4F
        .db 0x16, 0, 0x4B,  0xE0, 0x1E, 0x1F, 0xA6, 0xFF, 0xBA, 0, 0x26, 0x1F
        .db 0xF6, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0, 0x34, 0xE0, 0x50
        .db 0x1F, 0xF1, 0xFF, 0xA6, 0, 0x2D, 0, 0x28, 0x1F, 0xE2, 0xE0, 0x32
        .db 0, 0x5A, 0xFF,  0xC4, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0, 0x2D
        .db 0, 0x32, 0x1F,  0x79, 0xE0, 0xA, 0xA0, 0x18, 0xA0, 0x16, 0x64
        .db 0xFF, 0xC0, 0,  0x64, 0xFF, 0x1F, 0x81, 0xE0, 0xF, 0xA0, 0x18
        .db 0xA0, 0x16, 0x64, 0xFF, 0, 0x34, 0, 0x19, 0, 0x4B, 0xFF, 0xD8
        .db 0x1F, 0xB5, 0xE0, 0x3C, 0, 0x35, 0, 5,  0, 0x16, 0xFF, 0xBF, 0x1F
        .db 0xF1, 0xE0, 0x55, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0, 0x2D
        .db 0x1F, 0xF1, 0x1F, 0xE2, 0xFF, 0xBA, 0,  0x4B, 0xE0, 0x46, 0, 0x16
        .db 0x1F, 0xF1, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0x9F, 0xFF
        .db 0xC9, 0, 0x69,  0xFF, 0xF1, 0x40, 0x11, 0xA0, 0x18, 0xA0, 0x16
        .db 0x64, 0xFF, 0x1F, 0x97, 0xE0, 0x2D, 0,  0x4B, 0xFF, 0xBA, 0x1F
        .db 0xDA, 0x1F, 0xF6, 0x1F, 0xDB, 0xE0, 0x50, 0, 0, 0xFF, 0xAB, 0xA0
        .db 0x18, 0xA0, 0x16, 0x64, 0xFF, 0x1F, 0xE2, 0, 0x23, 0, 0x1E, 0xE0
        .db 0x32, 0x1F, 0xA6, 0xFF, 0xC4, 0x1F, 0xE2, 0, 0x28, 0, 0x78, 0xE0
        .db 0x14, 0xA0, 0x18, 0xA0, 0x16, 0x64, 0xFF, 0xC0, 0, 0x4F, 0xE0
        .db 0, 0, 0, 0x3C,  0x1F, 0xE2, 0xFF, 0xC4, 0x1F, 0xE2, 0xE0, 0x28
        .db 0x1F, 0xE2, 0x1F, 0xD8, 0, 0x3C, 0xE0,  0, 0x1F, 0xE2, 0xFF, 0xD8
        .db 0, 0x5A, 0, 0,  0x1F, 0xC4, 0xE0, 0x28, 0xC0, 0, 0x40, 0xF6, 0
        .db 0x5A, 0, 0, 0x1F, 0xA6, 0xE0, 0x14, 0,  0x3C, 0xE0, 0x14, 0x1F
        .db 0xC4, 0, 0x14,  0, 0, 0xFF, 0xD8, 0x1F, 0xC4, 0xE0, 0x14, 0, 0
        .db 0x1F, 0xC4, 0,  0x3C, 0xE0, 0x28, 0xC0, 0, 0x51, 0xE0, 0, 0, 0x1F
        .db 0xC4, 0, 0x1E,  0xE0, 0x3C, 0, 0x1E, 0xFF, 0xD8, 0, 0x1E, 0, 0x28
        .db 0x1F, 0xC4, 0xE0, 0, 0, 0x1E, 0xE0, 0x28, 0x1F, 0xA6, 0, 0, 0
        .db 0x3C, 0xFF, 0xD8, 0xC0, 0, 0x40, 0xEA,  0x1F, 0xA6, 0, 0, 0, 0x5A
        .db 0xFF, 0xEC, 0x1F, 0xC4, 0xFF, 0xEC, 0,  0x3C, 0x1F, 0xEC, 0, 0
        .db 0xE0, 0x28, 0,  0x3C, 0xFF, 0xEC, 0, 0, 0, 0x3C, 0x1F, 0xC4, 0xFF
        .db 0xD8, 0xC0, 0,  0x44, 0x1A, 0xB9, 0xEF, 0x56, 0x22, 0xB9, 0xEF
        .db 0x42, 0x2A, 0xB9, 0xEF, 0x46, 4, 0xC0,  0, 0x46, 4, 0xB9, 0xEF
        .db 0x5E, 0x36, 0xF6, 0x71, 0x5C, 6, 0x4A,  0x3E, 0xF6, 0x79, 0x41
        .db 5, 0xB9, 0xEF,  0x5F, 0x3B, 0xB9, 0xEF, 0xF6, 0x7C, 0x5C, 6, 0x45
        .db 0x3F, 0xB9, 0xEF, 0x5F, 0x3B, 0xB9, 0xEF, 0xF6, 0x78, 0x5C, 6
        .db 0x4A, 0x3E, 0xB9, 0xEF, 0x5E, 0x16, 0xF6, 0x71, 0xB9, 0xEF, 0x5B
        .db 1, 0xB9, 0xEF,  0x4A, 0x3E, 0xB9, 0xEF, 0x5F, 0x1B, 0xB9, 0xEF
        .db 0x42, 0x2A, 0xB9, 0xEF, 0x5C, 6, 0xC0,  0, 0xB9, 0xEF, 0x5A, 0x1C
        .db 0xB9, 0xEF, 0x42, 0x2A, 0xB9, 0xEF, 0x5F, 0x1B, 0xF6, 0x91, 0x5A
        .db 0x1C, 0xB9, 0xEF, 0x4A, 0x3E, 0xB9, 0xEF, 0x42, 0x2A, 0xB9, 0xEF
        .db 0x59, 0x17, 0xB9, 0xEF, 0x41, 0x25, 0xB9, 0xEF, 0x42, 0xA, 0xC0
        .db 0, 0x5C, 6, 0xB9, 0xEF, 0x5E, 0x36, 0xF6, 0xA2, 0x5F, 0x1B, 0x47
        .db 0x29, 0xB9, 0xEF, 0x5E, 0x16, 0xB9, 0xEF, 0x56, 0x22, 0xB9, 0xEF
        .db 0x42, 0xA, 0xB9, 0xEF,  0x43, 0x35, 0xB9, 0xEF, 0xF6, 0xD2, 0xB9
        .db 0xEF, 0x5F, 0x1B, 0x42, 0x2A, 0xB9, 0xEF, 0x45, 0x3F, 0xB9, 0xEF
        .db 0x5E, 0x36, 0xF6, 0xB5, 0xB9, 0xEF, 0x5A, 0x1C, 0xB9, 0xEF, 0x45
        .db 0x3F, 0xB9, 0xEF, 0x46, 0x24, 0xB9, 0xEF, 0x5C, 0x26, 0xB9, 0xEF
        .db 0x5B, 0x21, 0xB9, 0xEF, 0x45, 0x1F, 0x5E, 0x36, 0x43, 0xF, 0xC0
        .db 0, 0x5A, 0x1C,  0xB9, 0xEF, 0x4A, 0x3E, 0xB9, 0xEF, 0x41, 0x25
        .db 0xB9, 0xEF, 0x5C, 0x26, 0xB9, 0xEF, 0x5A, 0x3C, 0xB9, 0xEF, 0x5F
        .db 0x3B, 0x48, 0xE, 0xC0,  0, 0x5A, 0x1C, 0xB9, 0xEF, 0x4A, 0x3E
        .db 0xB9, 0xEF, 0x58, 0x2C, 0xF7, 0x1A, 0xB9, 0xEF, 0x5A, 0x1C, 0xB9
        .db 0xEF, 0x4A, 0x3E, 0xB9, 0xEF, 0x5B, 1,  0xB9, 0xEF, 0x42, 0x2A
        .db 0xB9, 0xEF, 0x45, 0x1F, 0xF6, 0xF9, 0x5A, 0x1C, 0xB9, 0xEF, 0x4A
        .db 0x3E, 0xB9, 0xEF, 0x5C, 0x26, 0xB9, 0xEF, 0x46, 0x24, 0xB9, 0xEF
        .db 0x56, 0x22, 0xF6, 0x75, 0xB9, 0xEF, 0x5A, 0x1C, 0xB9, 0xEF, 0x42
        .db 0x2A, 0xB9, 0xEF, 0x45, 0x3F, 0xB9, 0xEF, 0x5E, 0x36, 0xB9, 0xEF
        .db 0x45, 0x3F, 0xB9, 0xEF, 0x42, 0x2A, 0xF7, 0x25, 0x44, 0x1A, 0xB9
        .db 0xEF, 0x5B, 0x21, 0xB9, 0xEF, 0x5C, 0x26, 0xB9, 0xEF, 0x46, 0x24
        .db 0xB9, 0xEF, 0x45, 0x3F, 0xF7, 0x25, 0x44, 0x1A, 0xB9, 0xEF, 0x56
        .db 0x22, 0xB9, 0xEF, 0x46, 0x24, 0xB9, 0xEF, 0x5C, 0x26, 0xB9, 0xEF
        .db 0x4A, 0x3E, 0xF7, 0x25, 0x5B, 1, 0xB9,  0xEF, 0x45, 0x3F, 0xB9
        .db 0xEF, 0x44, 0x3A, 0xB9, 0xEF, 0x5C, 6,  0x46, 0x24, 0xB9, 0xEF
        .db 0x5C, 6, 0xC0,  0, 0, 0x96, 0x1F, 0x9C, 0xB6, 0xF2, 0xB6, 0xC5
        .db 0xB7, 0x1D, 0x1F, 0xBE, 0x1F, 0xD8, 0xB6, 0x8F, 0xB6, 0xE7, 0xB6
        .db 0xAD, 0x1F, 0xA6, 0x1F, 0xB0, 0xB6, 0xA1, 0xB6, 0x7C, 0xB6, 0xBD
        .db 0xB6, 0x78, 0xB6, 0xAD, 0x72, 0, 0x80,  0x40, 0xC0, 0, 0, 0x1E
        .db 0x1F, 0x9C, 0xB6, 0xF2, 0xB6, 0xC5, 0xB6, 0xBD, 0xB6, 0x84, 0xB6
        .db 0x7C, 0xB6, 0x70, 0xB6, 0x9A, 0xB6, 0xE1, 0x72, 0, 0x80, 0x40
        .db 0xC0, 0, 0, 0x5A, 0x1F, 0xB0, 0xB6, 0xBD, 0xB6, 0x9A, 0xB7, 9
        .db 0xB6, 0xAD, 0xB6, 0xBD, 0xB6, 0xC5, 0x72, 0, 0x80, 0x40, 0xC0
        .db 0, 0, 0x96, 0x1F, 0xC4, 0xB6, 0xE7, 0xB6, 0xC5, 0xB6, 0x70, 0xB6
        .db 0x70, 0xB7, 0x1D, 0x72, 0, 0x80, 0x40,  0xC0, 0, 0x1F, 0xA0, 0x1F
        .db 0xB0, 0xB6, 0x7F, 0xB6, 0xAD, 0x1F, 0xDA, 0, 0x14, 0xB7, 0x13
        .db 0xB6, 0x9A, 0xB6, 0x8F, 0xB6, 0xE7, 0x1F, 0xAE, 0x1F, 0x9C, 0xB7
        .db 0x1D, 0xB6, 0x7C, 0xB6, 0x8A, 0x72, 0,  0x80, 0x40, 0xC0, 0, 0x1F
        .db 0x88, 0x1F, 0xB0, 0xB6, 0xC5, 0xB7, 9,  0xB6, 0xAD, 0xB6, 0x70
        .db 0xB6, 0x70, 0xB6, 0xC5, 0xB6, 0xBD, 0x72, 0, 0x80, 0x40, 0xC0
        .db 0, 0x1F, 0x5E,  0x1F, 0xC4, 0xB7, 9, 0xB6, 0x9A, 0xB6, 0x78, 0xB6
        .db 0xB1, 0xB6, 0xAD, 0xB6, 0xBD, 0xB6, 0xFC, 0x72, 0, 0x80, 0x40
        .db 0xC0, 0, 0x1F,  0x2E, 0x1F, 0xD8, 0xB6, 0xD4, 0xB6, 0x8A, 0xB6
        .db 0xBD, 0xB6, 0xA1, 0xB6, 0xAD, 0xB7, 0x1D, 0x72, 0, 0x80, 0x40
        .db 0xC0, 0, 0x61,  0xFF, 0x62, 0xFF, 0x63, 0xFF, 0x64, 0xFF, 0x65
        .db 0xFF, 0x66, 0xFF, 0x67, 0xFF, 0x61, 0x80, 0x62, 0x80, 0x63, 0x80
        .db 0x64, 0x80, 0x65, 0x80, 0x66, 0x80, 0x67, 0x80, 0xF9, 0x17, 0xF9
        .db 0x19, 0xF9, 0x1B, 0xF9, 0x1D, 0xF9, 0x1F, 0xF9, 0x21, 0xF9, 0x23
        .db 0xF9, 0x25, 0xF9, 0x27, 0xF9, 0x29, 0xF9, 0x2B, 0xF9, 0x2D, 0xF9
        .db 0x2F, 0xF9, 0x31, 0xF9, 0x33, 0xF9, 0x35, 0xF9, 0x37, 0xF9, 0x39
        .db 0xF9, 0x3B, 0xF9, 0x3D, 0xF5, 0x1E, 0xF5, 0x61, 0xF5, 0xA3, 0xF5
        .db 0xE5, 0xF9, 0x3F, 0xF9, 0x4F, 0xF9, 0x5F, 0xF9, 0x6F, 0xF6, 0x28
        .db 0xF6, 0x3A, 0xF6, 0x4C, 0xF6, 0x5E

starwars_end  .equ    .
