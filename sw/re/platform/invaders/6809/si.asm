;
;	SPACE INVADERS
; - ported from the original arcade game
; - by tcdev 2016 msmcdoug@gmail.com
;
				.list		(meb)										; macro expansion binary
				
       	.area   idaseg (ABS)

.define			PLATFORM_COCO3

.iifdef PLATFORM_COCO3	.include "coco3.asm"

; *** BUILD OPTIONS
; *** end of BUILD OPTIONS

; *** derived - do not edit

.ifndef BUILD_OPT_INVALID
  .define GFX_1BPP
.else
  .define GFX_2BPP
.endif

; *** end of derived

; *** INVADERS stuff here
        .org    var_base
        
        .bndry  0x100
dp_base:            .ds     256        
z80_b               .equ    0x00
z80_c               .equ    0x01
z80_d               .equ    0x02
z80_e               .equ    0x03
z80_h               .equ    0x04
z80_l               .equ    0x05
z80_a_              .equ    0x06
z80_f_              .equ    0x07
z80_r               .equ    0x08

; rgb/composite video selected (bit 4)
cmp:                            .ds 1

        .org    0x6000
wram    .equ    .                       ; 1KB

; $2000
wait_on_draw:                   .ds   1
                                .ds   1
alien_is_exploding:             .ds   1                
exp_alien_timer:                .ds   1
alien_row:                      .ds   1
alien_frame:                    .ds   1
alien_cur_index:                .ds   1
ref_alien_dyr:                  .ds   1
ref_alien_dxr:                  .ds   1
ref_alien_yr:                   .ds   1
ref_alien_xr:                   .ds   1
alien_pos_lsb:                  .ds   1
alien_pos_msb:                  .ds   1
rack_direction:                 .ds   1
rack_down_delta:                .ds   1
                                .ds   1
; $2010
; '''GameObject0 (Move/draw the player)'''
obj0_timer_msb:                 .ds   1                                
obj0_timer_lsb:                 .ds   1                                
obj0_timer_extra:               .ds   1                                
obj0_handler_lsb:               .ds   1                                
obj0_handler_msb:               .ds   1                                
player_alive:                   .ds   1                                
exp_animate_timer:              .ds   1                                
exp_animate_cnt:                .ds   1                                
plyr_spr_pic_l:                 .ds   1                                
plyr_spr_pic_m:                 .ds   1                                
player_yr:                      .ds   1                                
player_xr:                      .ds   1                                
plyr_spr_siz:                   .ds   1                                
next_demo_cmd:                  .ds   1                                
hid_mess_seq:                   .ds   1                                
                                .ds   1
; $2020
; '''GameObject1 (Move/draw the player shot)'''
obj1_timer_msb:                 .ds   1                                
obj1_timer_lsb:                 .ds   1                                
obj1_timer_extra:               .ds   1                                
obj1_handler_lsb:               .ds   1                                
obj1_handler_msb:               .ds   1                                
plyr_shot_status:               .ds   1                                
blow_up_timer:                  .ds   1                                
obj1_image_lsb:                 .ds   1                                
obj1_image_msb:                 .ds   1                                
obj1_coor_yr:                   .ds   1                                
obj1_coor_xr:                   .ds   1                                
obj1_image_size:                .ds   1                                
shot_delta_x:                   .ds   1                                
fire_bounce:                    .ds   1                                
                                .ds   2
; $2030
; '''GameObject2 (Alien rolling-shot)'''
obj2_timer_msb:                 .ds   1                                
obj2_timer_lsb:                 .ds   1                                
obj2_timer_extra:               .ds   1                                
obj2_handler_lsb:               .ds   1                                
obj2_handler_msb:               .ds   1                                
rol_shot_status:                .ds   1                                
rol_shot_step_cnt:              .ds   1                                
rol_shot_track:                 .ds   1                                
rol_shot_c_fir_lsb:             .ds   1                                
rol_shot_c_fir_msb:             .ds   1                                
rol_shot_blow_cnt:              .ds   1                                
rol_shot_image_lsb:             .ds   1                                
rol_shot_image_msb:             .ds   1                                
rol_shot_yr:                    .ds   1                                
rol_shot_xr:                    .ds   1                                
rol_shot_size:                  .ds   1                                
; $2040
; '''GameObject3 (Alien plunger-shot)'''
obj3_timer_msb:                 .ds   1                                
obj3_timer_lsb:                 .ds   1                                
obj3_timer_extra:               .ds   1                                
obj3_handler_lsb:               .ds   1                                
obj3_handler_msb:               .ds   1                                
plu_shot_status:                .ds   1                                
plu_shot_step_cnt:              .ds   1                                
plu_shot_track:                 .ds   1                                
plu_shot_c_fir_lsb:             .ds   1                                
plu_shot_c_fir_msb:             .ds   1                                
plu_shot_blow_cnt:              .ds   1                                
plu_shot_image_lsb:             .ds   1                                
plu_shot_image_msb:             .ds   1                                
plu_shot_yr:                    .ds   1                                
plu_shot_xr:                    .ds   1                                
plu_shot_size:                  .ds   1                                
; $2050
; '''GameObject4 (Flying saucer OR alien squiggly shot)'''
obj4_timer_msb:                 .ds   1                                
obj4_timer_lsb:                 .ds   1                                
obj4_timer_extra:               .ds   1                                
obj4_handler_lsb:               .ds   1                                
obj4_handler_msb:               .ds   1                                
squ_shot_status:                .ds   1                                
squ_shot_step_cnt:              .ds   1                                
squ_shot_track:                 .ds   1                                
squ_shot_c_fir_lsb:             .ds   1                                
squ_shot_c_fir_msb:             .ds   1                                
squ_shot_blow_cnt:              .ds   1                                
squ_shot_image_lsb:             .ds   1                                
squ_shot_image_msb:             .ds   1                                
squ_shot_yr:                    .ds   1                                
squ_shot_xr:                    .ds   1                                
squ_shot_size:                  .ds   1                                
; $2060
end_of_tasks:                   .ds   1
collision:                      .ds   1
exp_alien_lsb:                  .ds   1
exp_alien_msb:                  .ds   1
exp_alien_yr:                   .ds   1
exp_alien_xr:                   .ds   1
exp_alien_size:                 .ds   1
player_data_msb:                .ds   1
player_ok:                      .ds   1
enable_alien_fire:              .ds   1
alien_fire_delay:               .ds   1
one_alien:                      .ds   1
temp_206C:                      .ds   1
invaded:                        .ds   1
skip_plunger:                   .ds   1
                                .ds   1
; $2070
other_shot_1:                   .ds   1
other_shot_2:                   .ds   1
vblank_status:                  .ds   1
a_shot_status:                  .ds   1
a_shot_step_cnt:                .ds   1
a_shot_track:                   .ds   1
a_shot_c_fir_lsb:               .ds   1
a_shot_c_fir_msb:               .ds   1
a_shot_blow_cnt:                .ds   1
a_shot_image_lsb:               .ds   1
a_shot_image_msb:               .ds   1
alien_shot_yr:                  .ds   1
alien_shot_xr:                  .ds   1
alien_shot_size:                .ds   1
alien_shot_delta:               .ds   1
shot_pic_end:                   .ds   1
; $2080
shot_sync:                      .ds   1
tmp_2081:                       .ds   1
num_aliens:                     .ds   1
saucer_start:                   .ds   1
saucer_active:                  .ds   1
saucer_hit:                     .ds   1
saucer_hit_time:                .ds   1
saucer_pri_loc_lsb:             .ds   1
saucer_pri_loc_msb:             .ds   1
saucer_pri_pic_lsb:             .ds   1
saucer_pri_pic_msb:             .ds   1
saucer_pri_size:                .ds   1
saucer_delta_y:                 .ds   1
sau_score_lsb:                  .ds   1
sau_score_msb:                  .ds   1
shot_count_lsb:                 .ds   1
; $2090
shot_count_msb:                 .ds   1
till_saucer_lsb:                .ds   1
till_saucer_msb:                .ds   1
wait_start_loop:                .ds   1
sound_port_3:                   .ds   1
change_fleet_snd:               .ds   1
fleet_snd_cnt:                  .ds   1
fleet_snd_reload:               .ds   1
sound_port_5:                   .ds   1
extra_hold:                     .ds   1
tilt:                           .ds   1
fleet_snd_hold:                 .ds   1
                                .ds   4
; $20A0
; '''In the ROM mirror copied to RAM this is the image of the alien sprite pulling the upside down Y. The code expects it to be 
; 0030 below the second animation picture at 1BD0. This RAM area must be unused. The copy is wasted. '''
                                .ds   16
; $20B0
                                .ds   16
; ''' End of inialization copy from ROM mirror'''
; $20C0
; ''' Splash screen animation structure '''
isr_delay:                      .ds   1
isr_splash_task:                .ds   1
splash_an_form:                 .ds   1
splash_delta_x:                 .ds   1
splash_delta_y:                 .ds   1
splash_yr:                      .ds   1
splash_xr:                      .ds   1
splash_image_lsb:               .ds   1
splash_image_msb:               .ds   1
splash_image_size:              .ds   1
splash_target_y:                .ds   1
splash_reached:                 .ds   1
splash_image_rest_lsb:          .ds   1
splash_image_rest_msb:          .ds   1
two_players:                    .ds   1
a_shot_reload_rate:             .ds   1
; $20D0
; This is where the alien-sprite-carying-the-Y ...
; ... lives in ROM
                                .ds   16
; $20E0
                                .ds   5
player1_ex:                     .ds   1
player2_ex:                     .ds   1
player1_alive:                  .ds   1
player2_alive:                  .ds   1
suspend_play:                   .ds   1
coin_switch:                    .ds   1
num_coins:                      .ds   1
splash_animate:                 .ds   1
demo_cmd_ptr_lsb:               .ds   1
demo_cmd_ptr_msb:               .ds   1
game_mode:                      .ds   1
; $20F0
                                .ds   1
adjust_score:                   .ds   1
score_delta_lsb:                .ds   1
score_delta_msb:                .ds   1
hi_scor_l:                      .ds   1
hi_scor_m:                      .ds   1
hi_scor_lo_m:                   .ds   1     ; switched for 6809
hi_scor_lo_l:                   .ds   1
p1_scor_l:                      .ds   1
p1_scor_m:                      .ds   1
p1_scor_lo_m:                   .ds   1     ; switched for 6809
p1_scor_lo_l:                   .ds   1
p2_scor_l:                      .ds   1
p2_scor_m:                      .ds   1
p2_scor_lo_m:                   .ds   1     ; switched for 6809
p2_scor_lo_l:                   .ds   1

; $2100
; Player 1 specific data
                                .ds   55    ; Player 1 alien ship indicators (0=dead) 11*5 = 55
                                .ds   11    ; Unused 11 bytes (room for another row of aliens?)
                                .ds   0xB0  ; Player 1 shields remembered between rounds 44 bytes * 4 shields ($B0 bytes)
                                .ds   9     ; Unused 9 bytes
; $21FB                                
p1_ref_alien_dx:                .ds   1     ; Player 1 reference-alien delta X
p1_ref_alien_y:                 .ds   1     ; Player 1 reference-alien Y coordinate
p1_ref_alien_x:                 .ds   1     ; Player 1 reference-alien X coordiante
p1_rack_cnt:                    .ds   1     ; Player 1 rack-count (starts at 0 but get incremented to 1-8)
p1_ships_rem:                   .ds   1     ; Ships remaining after current dies

; $2200
; Player 2 specific data
                                .ds   55
                                .ds   11
                                .ds   0xB0
                                .ds   9
; $22FB                                
p2_ref_alien_dx:                .ds   1
p2_ref_alien_y:                 .ds   1
p2_ref_alien_x:                 .ds   1
p2_rack_cnt:                    .ds   1
p2_ships_rem:                   .ds   1

; $2300
; stack on the original game goes here
; low water-mark around $23DE
        
				.org		0xc000

start_coco:
				orcc		#0x50										; disable interrupts
				lds			#stack

.ifdef PLATFORM_COCO3

; switch in 32KB cartridge
        lda     #COCO|MMUEN|MC3|MC1|MC0 ; 32KB internal ROM
        sta     INIT0
; setup MMU to copy ROM
        lda     #CODE_PG1
        ldx     #MMUTSK1                ; $0000-$7FFF
        ldb     #4
1$:     sta     ,x+
        inca
        decb
        bne     1$                      ; map pages $30-$33
; copy ROM into RAM        
        ldx     #0x8000                 ; start of 32KB ROM
        ldy     #0x0000                 ; destination
2$:     lda     ,x+
        sta     ,y+
        cmpx    #0xff00                 ; done?
        bne     2$                      ; no, loop
; setup MMU mapping for game
        lda     #CODE_PG1
        ldx     #MMUTSK1+4              ; $8000-$FFFF
        ldb     #4
4$:     sta     ,x+
        inca
        decb
        bne     4$                      ; map pages $30-33
        lda     #VRAM_PG
        ldx     #MMUTSK1                ; $0000-
        ldb     #4
5$:     sta     ,x+
        inca
        decb
        bne     5$                      ; map pages $38-$3B        
; switch to all-RAM mode
        sta     RAMMODE        

display_splash:

        ldx     #0x400
        lda     #96                     ; green space
1$:     sta     ,x+
        cmpx    #0x600
        bne     1$
        ldx     #splash
        ldy     #0x420
2$:     pshs    y
        ldb     ,x+                     ; read 'attr'
        stb     attr
        lda     ,x                      ; leading null?
        beq     5$
3$:     lda     ,x+
        beq     4$
        eora    attr
        sta     ,y+
        bra     3$
4$:     puls    y
        leay    32,y
        bra     2$
5$:     ldx			#PIA0
        ldb     #0                      ; flag rgb
6$:     lda     #~(1<<2)
				sta     2,x
				lda     ,x
				bita    #(1<<2)                 ; 'R'?
				beq     7$
        lda     #~(1<<3)
				sta			2,x											; column strobe
				lda			,x											; active low
				bita    #(1<<0)                 ; 'C'?
				bne     6$                      ; try again
				ldb     #(1<<4)                 ; flag component
7$:     stb     cmp

setup_gime_for_game:

; initialise PLATFORM_COCO3 hardware
; - disable PIA interrupts
				lda			#0x34
				sta			PIA0+1									; PIA0, CA1,2 control
				sta			PIA0+3									; PIA0, CB1,2 control
				sta			PIA1+1									; PIA1, CA1,2 control
				sta			PIA1+3									; PIA1, CB1,2 control
; - initialise GIME
				lda			IRQENR									; ACK any pending GIME interrupt
				lda			#MMUEN|#FEN             ; enable GIME MMU, FIRQ
				sta			INIT0     							
				lda			#0x00										; slow timer, task 1
				sta			INIT1     							
				lda			#0x00										; no VBLANK IRQ
				sta			IRQENR    							
				lda			#TMR                    ; TMR FIRQ enabled
				sta			FIRQENR   							
				lda			#BP										  ; graphics mode, 60Hz, 1 line/row
				sta			VMODE     							
	  .ifdef GFX_1BPP				
				lda			#0x68										; 225 scanlines, 32 bytes/row, 2 colours (225x256)
;				lda			#0x6C										; 225 scanlines, 40 bytes/row, 2 colours (225x320)
	  .else				
				lda			#0x11										; 192 scanlines, 64 bytes/row, 4 colours (256x192)
	  .endif				
				sta			VRES      							
				lda			#0x00										; black
				sta			BRDR      							
				lda			#(VRAM_PG<<2)           ; screen at page $38
				sta			VOFFMSB
				lda			#0x00
				sta			VOFFLSB   							
				lda			#0x00										; normal display, horiz offset 0
				sta			HOFF      							

				ldx			#PALETTE
				ldy     #rgb_pal
				ldb     #16
inipal:
				lda     ,y+
				sta     ,x+
				decb
				bne     inipal
				
				sta			CPU179									; select fast CPU clock (1.79MHz)

  ; configure timer
  ; free-run, max range, used for RND atm
        lda     #<4095
        sta     TMRLSB
        lda     #>4095
        sta     TMRMSB

  ; install FIRQ handler and enable TMR FIRQ
				;lda			#TMR|HBORD|VBORD        ; TMR FIRQ enabled
				;sta			FIRQENR   							
        lda     #0x7E                   ; jmp
        sta     0xFEF4
				ldx     #main_fisr              ; address
				stx     0xFEF5
        andcc   #~0x40                  ; enable FIRQ in CPU

  ; setup the PIAS for joystick sampling
  
  ; configure joystick axis selection as outputs
  ; and also select left/right joystick
        lda     PIA0+CRA
        ldb     PIA0+CRB
        ora     #(1<<5)|(1<<4)          ; CA2 as output
        orb     #(1<<5)|(1<<4)          ; CB2 as output
.ifdef LEFT_JOYSTICK
        orb     #(1<<3)                 ; CB2=1 left joystick
.else
        andb    #~(1<<3)                ; CB2=0 right joystick
.endif
        sta     PIA0+CRA
        stb     PIA0+CRB
  ; configure comparator as input
        lda     PIA0+CRA
        anda    #~(1<<2)                ; select DDRA
        sta     PIA0+CRA
        lda     PIA0+DDRA
        anda    #~(1<<7)                ; PA7 as input
        sta     PIA0+DDRA
        lda     PIA0+CRA
        ora     #(1<<2)                 ; select DATAA
        sta     PIA0+CRA
  ; configure sound register as outputs
        lda     PIA1+CRA
        anda    #~(1<<2)                ; select DDRA
        sta     PIA1+CRA
        lda     PIA1+DDRA
        ora     #0xfc                   ; PA[7..2] as output
        sta     PIA1+DDRA
        lda     PIA1+CRA
        ora     #(1<<2)                 ; select DATAA
        sta     PIA1+CRA
          
  .ifdef HAS_SOUND				
				lda			PIA1+CRB
				ora			#(1<<5)|(1<<4)					; set CB2 as output
				ora			#(1<<3)									; enable sound
				sta			PIA1+CRB
				; bit2 sets control/data register
				lda     PIA1+CRB
				anda    #~(1<<2)                ; select DDRB
				sta     PIA1+CRB
				lda     PIA1+DDRB
				ora     #(1<<1)                 ; PB1 output
				sta     PIA1+DDRB
        ; setup for data register				
				lda     PIA1+CRB
				ora     #(1<<2)                 ; select DATAB
				sta     PIA1+CRB
  .endif  ; HAS_SOUND

.endif	; PLATFORM_COCO3
			
				lda			#>dp_base
				tfr			a,dp
        jmp     start                   ; knight lore
        
rgb_pal:
    ;.db RGB_DARK_BLACK, RGB_DARK_BLUE, RGB_DARK_RED, RGB_DARK_MAGENTA
    .db RGB_DARK_BLACK, RGB_WHITE, RGB_DARK_RED, RGB_DARK_MAGENTA
    .db RGB_DARK_GREEN, RGB_DARK_CYAN, RGB_DARK_YELLOW, RGB_GREY
    .db RGB_BLACK, RGB_BLUE, RGB_RED, RGB_MAGENTA
    .db RGB_GREEN, RGB_CYAN, RGB_YELLOW, RGB_WHITE
cmp_pal:    
    ;.db CMP_DARK_BLACK, CMP_DARK_BLUE, CMP_DARK_RED, CMP_DARK_MAGENTA
    .db CMP_DARK_BLACK, CMP_WHITE, CMP_DARK_RED, CMP_DARK_MAGENTA
    .db CMP_DARK_GREEN, CMP_DARK_CYAN, CMP_DARK_YELLOW, CMP_GREY
    .db CMP_BLACK, CMP_BLUE, CMP_RED, CMP_MAGENTA
    .db CMP_GREEN, CMP_CYAN, CMP_YELLOW, CMP_WHITE


splash:
;       .asciz  "01234567890123456789012345678901"
        .db 0
        .asciz  "`````ARCADE`SPACE`INVADERS"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "``````FOR`THE`TRSmxp`COCOs"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "````j`MONOCHROME`GRAPHICS`j"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "`````````hVERSION`pnqi"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "```````hRiGBohCiOMPOSITE"
        .db 0
        .asciz  "`"
        .db 0
        .asciz  "`"
        .db 0x40
        .asciz  "|WWWnRETROPORTSnBLOGSPOTnCOMnAU~"
        .dw     0


attr:   .ds     1

; $0A93
; Print message from DE/Y to screen at HL/X (length in B) with a
; delay between letters.
print_message_del:
        lda     ,y+
        pshs    b
        bsr     draw_char
        puls    b
        lda     #7                      ; Delay between letters
        sta     isr_delay
1$:     lda     isr_delay
        deca                            ; Is it 1?
;        bne     1$        
        decb
        bne     print_message_del
        rts

; $0AB1
one_sec_delay:
        lda     #0x40
        bra     wait_on_delay

; $0ACF

; Message to center of screen.
; Only used in one place for "SPACE  INVADERS"
sub_0ACF:
        ldx     #vram+0x714             ; Near center of screen
        ldb     #15                     ; 15 bytes in message
        bra     print_message_del

; $0AD7
; Wait on ISR counter to reach 0
wait_on_delay:
        sta     isr_delay
1$:     tst     isr_delay
        bne     1$
        rts
        
; $0AEA
; After initialization ... splash screens
loc_0AEA:
        clra
;       out     (sound1),a
;       out     (sound2),a
        bsr     sub_1982        
;       ei
        ;bsr     one_sec_delay        
        ldx     #vram+0x0C17            ; Screen coordinates (middle near top)
        ldb     #4                      ; 4 characters in "PLAY"
        tst     splash_animate          ; Splash screen type
        bne     loc_0BE8                ; Not 0 ... do "normal" PLAY
        ldy     #message_play_UY        ; "PLAy" with an upside down 'Y' for splash screen
        bsr     print_message_del
        ldy     #message_invaders       ; "SPACE  INVADERS"
loc_0B0B:
        bsr     sub_0ACF                ; Print to middle-ish of screen
        bsr     one_sec_delay
9$:     bra     9$
        
; $0BE8
loc_0BE8:
        ldy     #message_play_Y
        bsr     print_message_del
        bra     loc_0B0B

; $18D4                
start:
        lds     #stack
        ldb     #0
        bsr     sub_01E6
        jsr     draw_status

; $18DF
        lda     #8
        sta     a_shot_reload_rate
        bra     loc_0AEA                ; splash animation
                        
loop:   jmp     loop

; $1982
sub_1982:
        sta     isr_splash_task
        rts

; $01E4
; Block copy ROM mirror 1B00-1BBF to initialize RAM at 2000-20BF.
copy_ram_mirror:
        ldb     #0xc0
sub_01E6:
        ldy     #byte_0_1B00
        ldx     #wram
        jmp     block_copy

; $08F3
; Print a message on the screen
; HL/X = coordinates
; DE/Y = message buffer
; C/B = length
print_message:
        lda     ,y+                     ; get character
        pshs    b
        bsr     draw_char
        puls    b
        decb
        bne     print_message
        rts

; $08FF
; Get pointer to 8 byte sprite number in A and
; draw sprite on screen at HL/X
draw_char:
        ldu     #loc_1E00
        ldb     #8
        mul                             ; D=offset
        leau    d,u                     ; ptr data
        ldb     #8
; hit watchdog
        bra     draw_simp_sprite

; $09AD
; Print 4 digits in Y @X
print_4_digits:
        tfr     y,d
        pshs    b
        bsr     draw_hex_byte
        puls    a

; $09B2        
; Display 2 digits in A to screen at HL/X
draw_hex_byte:
        pshs    a
        lsra
        lsra
        lsra
        lsra                            ; MSN
        bsr     sub_09C5                ; to screen @X
        puls    a
        anda    #0x0f                   ; LSN
        bsr     sub_09C5                ; to screen @X
        rts

; $09C5
sub_09C5:
        adda    #0x1A                   ; convert to digit char
        bra     draw_char

; $1439
; Display character to screen
; HL/X = screen coordinates
; DE/U = character data
; B = number of rows
draw_simp_sprite:
        lda     ,u+
        sta     ,x
        leax    32,x
        decb
        bne     draw_simp_sprite
        rts

; $191A
; Print score header " SCORE<1> HI-SCORE SCORE<2> "
draw_score_head:
        ldb     #0x1c                   ; 28 bytes in message
        ldx     #vram+0x1e
        ldy     #message_score
        bra     print_message

; $1925
sub_1925:
        ldu     #p1_scor_l              ; Player 1 score descriptor
        bra     draw_score

sub_192B:        
; $192B        
        ldu     #p2_scor_l              ; Player 2 score descriptor
        bra     draw_score

; $1931
; Print score.
; HL/U = descriptor
draw_score:
        ldy     ,u++                    ; value
        ldx     ,u++                    ; coordinate
        bra     print_4_digits

; $193C
sub_193C:
        ldb     #7                      ; 7 bytes in message
        ldx     #(vram+0x1101)
        ldy     #message_credit
        bra     print_message

; $1947
draw_num_credits:
        lda     num_coins
        ldx     #0x1801
        bra     draw_hex_byte
                
; $1950
print_hi_score:
        ldu     #hi_scor_l              ; Hi Score descriptor
        bra     draw_score
                
; $1956
; Print scores (with header) and credits (with label)
draw_status:
        bsr     clear_screen
        bsr     draw_score_head
        bsr     sub_1925                ; print player 1 score
        bsr     sub_192B                ; print player 2 score
        bsr     print_hi_score
        bsr     sub_193C                ; print credit table
        bra     draw_num_credits
        
; $1A32
block_copy:
        lda     ,y+
        sta     ,x+
        decb
        bne     block_copy
        rts

; $1A5C
clear_screen:
        ldx     #vram
1$:     clr     ,x+
        cmpx    #(vram+0x1C00+32)
        bne     1$
        rts

; $1AE4
message_score:
;       " SCORE<1> HI-SCORE SCORE<2>"
        .db 0x26,0x12,2,0xE,0x11,4,0x24,0x1B,0x25,0x26,7,8,0x3F
        .db 0x12,2,0xE,0x11,4,0x26,0x12,2,0xE,0x11,4,0x24,0x1C
        .db 0x25,0x26
        
;-------------------------- RAM initialization -----------------------------
; Copied to RAM (2000) C0 bytes as initialization.
; See the description of RAM at the top of this file for the details on this data.
byte_0_1B00:    .db 1,0,0,0x10,0,0,0,0
                .db 2,0x78,0x38,0x78,0x38,0,0xF8,0
                .db 0,0x80,0,0x8E,2,0xFF,5,0xC
                .db 0x60,0x1C,0x20,0x30,0x10,1,0,0
                .db 0,0,0,0xBB,3,0,0x10,0x90
                .db 0x1C,0x28,0x30,1,4,0,0xFF,0xFF
                .db 0,0,2,0x76,4,0,0,0
                .db 0,0,4,0xEE,0x1C,0,0,3
                .db 0,0,0,0xB6,4,0,0,1
                .db 0,0x1D,4,0xE2,0x1C,0,0,3
                .db 0,0,0,0x82,6,0,0,1
                .db 6,0x1D,4,0xD0,0x1C,0,0,3
                .db 0xFF,0,0xC0,0x1C,0,0,0x10,0x21
                .db 1,0,0x30,0,0x12,0,0,0
; These don't need to be copied over to RAM (see 1BA0 below).
message_p1: 
; "PLAY PLAYER<1>"
        .db 0xF,0xB,0,0x18,0x26,0xF,0xB,0
        .db 0x18,4,0x11,0x24,0x1B,0x25,0xFC,0
        .db    1
        .db 0xFF
        .db 0xFF
ufo_init_data:
        .db 0                                           ; ufo visible flag
        .db    0
        .db    0
        .db 32                                          ; countdown after ufo hit
        .dw unk_0_1D64                                  ; ufo bitmap address
        .dw vram+0x5D0                                  ; ufo screen loc
        .db 24                                          ; ufo bitmap size
        .db    2
        .db 0x54 ; T
        .db 0x1D
        .dw 0x800                                       ; ptr to code - of which b0 determines which side ufo appears
        .db    0
        .db    6
        .db    0
        .db    0
        .db    1
        .db 0x40 ; @
        .db    0
        .db    1
        .db    0
        .db    0
        .db 0x10
        .db 0x9E ; �
        .db    0
        .db 0x20
        .db 0x1C
        .db 0,3,4,0x78,0x14,0x13,8,0x1A
        .db 0x3D,0x68,0xFC,0xFC,0x68,0x3D,0x1A,0
byte_0_1BB0:    
        .db 0, 0, 1, 0xB8, 0x98, 0xA0, 0x1B, 0x10, 0xFF, 0, 0xA0 ; inverted-y animation pt.2 data
        .db 0x1B
        .db    0
        .db    0
        .db    0
        .db    0
byte_0_1BC0:    
        .db 0, 0x10, 0, 0xE, 5, 0, 0, 0, 0, 0, 7, 0xD0, 0x1C, 0xC8 ; initialised only at startup
        .db 0x9B, 3, 0, 0, 3, 4, 0x78, 0x14, 0xB, 0x19, 0x3A, 0x6D
        .db 0xFA, 0xFA, 0x6D, 0x3A, 0x19, 0, 0, 0, 0, 0, 0, 0
        .db 0, 0, 0, 1, 0, 0, 1, 0x74, 0x1F, 0, 0x80, 0, 0, 0
; hi score and vram location        
        .db 0, 0
        ;.db 0x1C, 0x2F, 
        .dw vram+0x0b1c
; p1 score and vram location        
        .db 0, 0
        ;.db 0x1C, 0x27, 
        .dw vram+0x031c
; p2 score and vram location        
        .db 0, 0
        ;.db 0x1C, 0x39
        .dw vram+0x151c

; $1CFA
message_play_UY:
        .db 0xF, 0xB, 0, 0x29           ; "PLAY" with inverted Y
        

unk_0_1D64:

; $1DAB
message_play_Y:
        .db 0xF, 0xB, 0, 0x18           ; "PLAY" with normal Y

; $1DAF        
message_invaders:
        .db 0x12, 0xF, 0, 2, 4, 0x26, 0x26 ; "SPACE  INVADERS"
        .db 8, 0xD, 0x15, 0, 3, 4, 0x11, 0x12

loc_1E00:   
        .db 0x00, 0xF8, 0x24, 0x22, 0x24, 0xF8, 0x00, 0x00  ; "A"
        .db 0x00, 0xFE, 0x92, 0x92, 0x92, 0x6C, 0x00, 0x00  ; "B"
        .db 0x00, 0x7C, 0x82, 0x82, 0x82, 0x44, 0x00, 0x00  ; "C"
        .db 0x00, 0xFE, 0x82, 0x82, 0x82, 0x7C, 0x00, 0x00  ; "D"
        .db 0x00, 0xFE, 0x92, 0x92, 0x92, 0x82, 0x00, 0x00  ; "E"
        .db 0x00, 0xFE, 0x12, 0x12, 0x12, 0x02, 0x00, 0x00  ; "F"
        .db 0x00, 0x7C, 0x82, 0x82, 0xA2, 0xE2, 0x00, 0x00  ; "G"
        .db 0x00, 0xFE, 0x10, 0x10, 0x10, 0xFE, 0x00, 0x00  ; "H"
        .db 0x00, 0x00, 0x82, 0xFE, 0x82, 0x00, 0x00, 0x00  ; "I"
        .db 0x00, 0x40, 0x80, 0x80, 0x80, 0x7E, 0x00, 0x00  ; "J"
        .db 0x00, 0xFE, 0x10, 0x28, 0x44, 0x82, 0x00, 0x00  ; "K"
        .db 0x00, 0xFE, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00  ; "L"
        .db 0x00, 0xFE, 0x04, 0x18, 0x04, 0xFE, 0x00, 0x00  ; "M"
        .db 0x00, 0xFE, 0x08, 0x10, 0x20, 0xFE, 0x00, 0x00  ; "N"
        .db 0x00, 0x7C, 0x82, 0x82, 0x82, 0x7C, 0x00, 0x00  ; "O"
        .db 0x00, 0xFE, 0x12, 0x12, 0x12, 0x0C, 0x00, 0x00  ; "P"
        .db 0x00, 0x7C, 0x82, 0xA2, 0x42, 0xBC, 0x00, 0x00  ; "Q"
        .db 0x00, 0xFE, 0x12, 0x32, 0x52, 0x8C, 0x00, 0x00  ; "R"
        .db 0x00, 0x4C, 0x92, 0x92, 0x92, 0x64, 0x00, 0x00  ; "S"
        .db 0x00, 0x02, 0x02, 0xFE, 0x02, 0x02, 0x00, 0x00  ; "T"
        .db 0x00, 0x7E, 0x80, 0x80, 0x80, 0x7E, 0x00, 0x00  ; "U"
        .db 0x00, 0x3E, 0x40, 0x80, 0x40, 0x3E, 0x00, 0x00  ; "V"
        .db 0x00, 0xFE, 0x40, 0x30, 0x40, 0xFE, 0x00, 0x00  ; "W"
        .db 0x00, 0xC6, 0x28, 0x10, 0x28, 0xC6, 0x00, 0x00  ; "X"
        .db 0x00, 0x06, 0x08, 0xF0, 0x08, 0x06, 0x00, 0x00  ; "Y"
        .db 0x00, 0xC2, 0xA2, 0x92, 0x8A, 0x86, 0x00, 0x00  ; "Z"
        .db 0x00, 0x7C, 0xA2, 0x92, 0x8A, 0x7C, 0x00, 0x00  ; "0"
        .db 0x00, 0x00, 0x84, 0xFE, 0x80, 0x00, 0x00, 0x00  ; "1"
        .db 0x00, 0xC4, 0xA2, 0x92, 0x92, 0x8C, 0x00, 0x00  ; "2"
        .db 0x00, 0x42, 0x82, 0x92, 0x9A, 0x66, 0x00, 0x00  ; "3"
        .db 0x00, 0x30, 0x28, 0x24, 0xFE, 0x20, 0x00, 0x00  ; "4"
        .db 0x00, 0x4E, 0x8A, 0x8A, 0x8A, 0x72, 0x00, 0x00  ; "5"
        .db 0x00, 0x78, 0x94, 0x92, 0x92, 0x62, 0x00, 0x00  ; "6"
        .db 0x00, 0x02, 0xE2, 0x12, 0x0A, 0x06, 0x00, 0x00  ; "7"
        .db 0x00, 0x6C, 0x92, 0x92, 0x92, 0x6C, 0x00, 0x00  ; "8"
        .db 0x00, 0x8C, 0x92, 0x92, 0x52, 0x3C, 0x00, 0x00  ; "9"
        .db 0x00, 0x10, 0x28, 0x44, 0x82, 0x00, 0x00, 0x00  ; "<"
        .db 0x00, 0x00, 0x82, 0x44, 0x28, 0x10, 0x00, 0x00  ; ">"
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  ; " "
        .db 0x00, 0x28, 0x28, 0x28, 0x28, 0x28, 0x00, 0x00  ; "="
        .db 0x00, 0x44, 0x28, 0xFE, 0x28, 0x44, 0x00, 0x00  ; "*"
        .db 0x00, 0xC0, 0x20, 0x1E, 0x20, 0xC0, 0x00, 0x00  ; "�"

; $1F50        
message_p1_or_2:   
;       "<1 OR 2 PLAYERS>"
        .db 0x24 ; $
        .db 0x1B, 0x26, 0xE, 0x11, 0x26, 0x1C, 0x26, 0xF, 0xB
        .db 0, 0x18, 4, 0x11, 0x12
        .db 0x25 ; %
        .db 0x26 ; &
        .db 0x26 ; &

; $1F62        
message_1_coin:
;       "1 PLAYER  1 COIN"
        .db 0x28 ; (
        .db 0x1B, 0x26, 0xF, 0xB, 0, 0x18, 4, 0x11, 0x26, 0x26 
        .db 0x1B, 0x26, 2, 0xE, 8, 0xD, 0x26

; $1F74
demo_commands:
;       (1=Right, 2=Left)
        .db 1, 1, 0, 0, 1, 0, 2, 1, 0, 2, 1, 0         ; simulated controller reads
        
; $1F80
alien_spr_CA:        
        .db 0x06, 0x08, 0xF0, 0x08, 0x06, 0x0C, 0x18, 0x58  ; "Y"
        .db 0xBC, 0x16, 0x3F, 0x3F, 0x16, 0xBC, 0x58, 0x00  ; " "

; $1F90        
message_coin:    
        .db 8, 0xD, 0x12, 4, 0x11, 0x13, 0x26, 0x26, 2, 0xE, 8 ; "INSERT  COIN"
        .db 0xD

; $1F9C
credit_table:     
        .dw vram+0x60D                  ; screen loc
        .dw message_p1_or_2             ; "<1 OR 2 PLAYERS>
        .dw vram+0x60A                  ; screen loc
        .dw message_1_coin              ; "*1 PLAYER 1  COIN"
        .dw vram+0x607                  ; screen loc
        .dw message_2_coins             ; "*2 PLAYERS 2 COINS"
        .db 0xFF

; $1FA9        
message_credit:
        .db 2, 0x11, 4, 3, 8, 0x13, 0x26                ; "CREDIT "

; $1FB0        
alien_spr_CB:        
        .db 0x00, 0x06, 0x08, 0xF0, 0x08, 0x06, 0x1C, 0x98  ; "Y"
        .db 0x5C, 0xB6, 0x5F, 0x5F, 0xB6, 0x5C, 0x98, 0x00  ; " "
        
; $1FC0        
        .db 0x00, 0x04, 0x02, 0xB2, 0x0A, 0x04, 0x00, 0x00  ; "?"
        .db    0

; $1FC9        
splash_anim_3:  
        .db 0, 0, 0xFF, 0xB8, 0xFF, 0x80, 0x1F, 0x10, 0x97, 0 ; inverted-y animation pt.3 data
        .db 0x80, 0x1F

; $1FD5                
splash_anim_4:  
        .db 0, 0, 1, 0xD0, 0x22, 0x20, 0x1C, 0x10, 0x94, 0, 0x20 ; bomb-c animation data
        .db 0x1C

; $1FE1
message_2_coins:
        .db 0x28, 0x1C, 0x26, 0xF, 0xB, 0, 0x18, 4, 0x11, 0x12 ; "*2 PLAYERS 2 COINS"
        .db 0x26, 0x1C, 0x26, 2, 0xE, 8, 0xD, 0x12

; $1FF3        
message_push:          
        .db 0xF, 0x14, 0x12, 7, 0x26                    ; "PUSH "

; $1FF8
        .db 0x00, 0x10, 0x10, 0x10, 0x10, 0x10, 0x00, 0x00  ; "-"

main_fisr:
; temp hack - should do LFSR or something
; and also tune frequency
        tst     FIRQENR                 ; ACK FIRQ
        inc     *z80_r
        rti

vram_dump:
        
				.end		start_coco
