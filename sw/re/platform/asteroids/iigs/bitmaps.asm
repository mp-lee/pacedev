.export chr_tbl
.export ship_tbl
.export extra_ship
.export large_ufo
.export small_ufo
.export shrapnel_tbl
.export asteroid_tbl
.export copyright

char_SPACE:
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00

char_0:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00

char_1:
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00

char_2:
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00

char_3:
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $11, $11, $10, $00

char_4:
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00

char_5:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $11, $11, $10, $00

char_6:
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00

char_7:
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00

char_8:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00

char_9:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00

char_A:
    .BYTE  $00, $10, $00, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00

char_B:
    .BYTE  $11, $11, $00, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $00, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $00, $00
char_C:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00
char_D:
    .BYTE  $11, $10, $00, $00
    .BYTE  $10, $01, $00, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $01, $00, $00
    .BYTE  $11, $10, $00, $00
char_E:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00
char_F:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
char_G:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
char_H:
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
char_I:
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $11, $11, $10, $00
char_J:
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $00, $11, $10, $00
char_K:
    .BYTE  $10, $01, $00, $00
    .BYTE  $10, $10, $00, $00
    .BYTE  $11, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $00, $00, $00
    .BYTE  $10, $10, $00, $00
    .BYTE  $10, $01, $00, $00
char_L:
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00
char_M:
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $01, $10, $00
    .BYTE  $10, $10, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
char_N:
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $00, $10, $00
    .BYTE  $10, $10, $10, $00
    .BYTE  $10, $10, $10, $00
    .BYTE  $10, $01, $10, $00
    .BYTE  $10, $01, $10, $00
    .BYTE  $10, $00, $10, $00
char_O:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
char_P:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
char_Q:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $10, $10, $00
    .BYTE  $10, $01, $00, $00
    .BYTE  $11, $10, $10, $00
char_R:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $10, $00, $00
    .BYTE  $10, $01, $00, $00
    .BYTE  $10, $00, $10, $00
char_S:
    .BYTE  $11, $11, $10, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $11, $11, $10, $00
char_T:
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
char_U:
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $11, $11, $10, $00
char_V:
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
char_W:
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $10, $10, $00
    .BYTE  $11, $01, $10, $00
    .BYTE  $10, $00, $10, $00
char_X:
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $10, $00, $10, $00
    .BYTE  $10, $00, $10, $00
char_Y:
    .BYTE  $10, $00, $10, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
char_Z:
    .BYTE  $11, $11, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $01, $00, $00, $00
    .BYTE  $10, $00, $00, $00
    .BYTE  $11, $11, $10, $00

chr_tbl:
		.word char_SPACE
		.word char_0, char_1, char_2, char_3
		.word char_4, char_5, char_6, char_7
		.word char_8, char_9
		.word char_A, char_B, char_C, char_D
		.word char_E, char_F, char_G, char_H
		.word char_I, char_J, char_K, char_L
		.word char_M, char_N, char_O, char_P
		.word char_Q, char_R, char_S, char_T
		.word char_U, char_V, char_W, char_X
		.word char_Y, char_Z

ship_0:
    .BYTE  $00, $00, $00, $00
    .BYTE  $11, $00, $00, $00
    .BYTE  $01, $11, $10, $00
    .BYTE  $01, $00, $01, $10
    .BYTE  $01, $11, $10, $00
    .BYTE  $11, $00, $00, $00
    .BYTE  $00, $00, $00, $00
ship_1:
    .BYTE  $00, $00, $00, $00
    .BYTE  $11, $11, $00, $00
    .BYTE  $01, $00, $11, $10
    .BYTE  $01, $00, $11, $00
    .BYTE  $01, $11, $00, $00
    .BYTE  $01, $00, $00, $00
    .BYTE  $00, $00, $00, $00
ship_2:
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $01, $11, $10
    .BYTE  $11, $10, $01, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $00, $00, $00
ship_3:
    .BYTE  $00, $00, $01, $10
    .BYTE  $00, $01, $11, $00
    .BYTE  $01, $10, $01, $00
    .BYTE  $11, $10, $10, $00
    .BYTE  $00, $01, $10, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $01, $00, $00
ship_4:
    .BYTE  $00, $00, $01, $00
    .BYTE  $00, $00, $11, $00
    .BYTE  $00, $01, $01, $00
    .BYTE  $00, $11, $10, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
ship_5:
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $01, $10, $00
    .BYTE  $00, $01, $10, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $10, $01, $00
    .BYTE  $01, $11, $11, $00
    .BYTE  $00, $00, $01, $00
ship_6:
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $01, $11, $11, $00
    .BYTE  $01, $00, $01, $00
ship_7:
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $01, $11, $11, $00
    .BYTE  $01, $00, $00, $00
ship_8:
    .BYTE  $01, $00, $00, $00
    .BYTE  $01, $10, $00, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $00, $11, $01, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
ship_9:
    .BYTE  $11, $00, $00, $00
    .BYTE  $10, $11, $00, $00
    .BYTE  $01, $00, $11, $00
    .BYTE  $01, $00, $11, $10
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $01, $00, $00
ship_10:
    .BYTE  $00, $00, $00, $00
    .BYTE  $11, $11, $00, $00
    .BYTE  $01, $00, $11, $10
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $00, $00
ship_11:
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $01, $11, $10
    .BYTE  $11, $10, $01, $00
    .BYTE  $01, $10, $01, $00
    .BYTE  $00, $01, $11, $00
    .BYTE  $00, $00, $01, $00
    .BYTE  $00, $00, $00, $00
ship_12:
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $01, $10
    .BYTE  $00, $11, $11, $00
    .BYTE  $11, $00, $01, $00
    .BYTE  $00, $11, $11, $00
    .BYTE  $00, $00, $01, $10
    .BYTE  $00, $00, $00, $00
ship_13:
    .BYTE  $00, $00, $01, $00
    .BYTE  $00, $01, $11, $00
    .BYTE  $01, $10, $01, $00
    .BYTE  $11, $11, $01, $00
    .BYTE  $00, $00, $11, $10
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
ship_14:
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $01, $01, $11, $10
    .BYTE  $11, $10, $00, $00
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00
ship_15:
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $01, $00, $11, $10
    .BYTE  $01, $01, $10, $00
    .BYTE  $11, $10, $00, $00
    .BYTE  $10, $00, $00, $00
ship_16:
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $11, $01, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $01, $01, $00, $00
    .BYTE  $01, $10, $00, $00
    .BYTE  $01, $00, $00, $00
ship_17:
    .BYTE  $01, $00, $00, $00
    .BYTE  $01, $11, $11, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $01, $00, $10, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $11, $00, $00
    .BYTE  $00, $10, $00, $00
ship_18:
    .BYTE  $01, $00, $01, $00
    .BYTE  $01, $11, $11, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $01, $00, $00
ship_19:
    .BYTE  $00, $00, $01, $00
    .BYTE  $01, $11, $11, $00
    .BYTE  $00, $10, $01, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $01, $10, $00
    .BYTE  $00, $01, $10, $00
    .BYTE  $00, $00, $10, $00
ship_20:
    .BYTE  $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00
    .BYTE  $01, $01, $10, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $00, $01, $01, $00
    .BYTE  $00, $00, $11, $00
    .BYTE  $00, $00, $01, $00
ship_21:
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $01, $10, $00
    .BYTE  $11, $10, $10, $00
    .BYTE  $00, $11, $01, $00
    .BYTE  $00, $00, $11, $00
    .BYTE  $00, $00, $00, $10
ship_22:
    .BYTE  $00, $00, $00, $00
    .BYTE  $00, $10, $00, $00
    .BYTE  $00, $01, $00, $00
    .BYTE  $00, $10, $10, $00
    .BYTE  $11, $11, $01, $00
    .BYTE  $00, $00, $11, $10
    .BYTE  $00, $00, $00, $00
ship_23:
    .BYTE  $00, $00, $00, $00
    .BYTE  $01, $00, $00, $00
    .BYTE  $01, $11, $00, $00
    .BYTE  $01, $00, $11, $00
    .BYTE  $01, $01, $11, $10
    .BYTE  $11, $10, $00, $00
    .BYTE  $00, $00, $00, $00

ship_tbl:
		.word ship_0,   ship_1,  ship_2,  ship_3
		.word ship_4,   ship_5,  ship_6,  ship_7
		.word ship_8,   ship_9, ship_10,  ship_11
		.word ship_12, ship_13, ship_14,  ship_15
		.word ship_16, ship_17, ship_18,  ship_19
		.word ship_20, ship_21, ship_22,  ship_23
		
extra_ship:
		.byte	$00, $10, $00, $00
		.byte $00, $10, $00, $00
		.byte $01, $01, $00, $00		
		.byte $01, $01, $00, $00		
		.byte $01, $01, $00, $00		
		.byte $11, $11, $10, $00
		.byte $10, $00, $10, $00

asteroid_0:
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $01, $01, $00, $00, $10, $10, $00
    .BYTE  $00, $10, $00, $10, $01, $00, $01, $00
    .BYTE  $01, $00, $00, $01, $01, $00, $00, $10
    .BYTE  $10, $00, $00, $00, $10, $00, $00, $01
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $10, $00, $00, $00, $00, $00, $01, $00
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $01, $00, $00, $00, $00, $00, $01, $10
    .BYTE  $00, $10, $00, $00, $00, $01, $10, $00
    .BYTE  $00, $01, $10, $00, $00, $10, $00, $00
    .BYTE  $00, $00, $01, $11, $11, $00, $00, $00
asteroid_1:
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $01, $10, $10, $00, $00
    .BYTE  $00, $00, $10, $00, $10, $01, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $10, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $10, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $01, $00, $01, $10, $00, $00
    .BYTE  $00, $00, $00, $11, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_2:
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_3:
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $01, $01, $10, $01, $10, $10, $00
    .BYTE  $00, $10, $00, $01, $10, $00, $01, $00
    .BYTE  $01, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $01, $00, $00, $00, $00, $00, $11, $10
    .BYTE  $01, $00, $00, $00, $00, $01, $00, $00
    .BYTE  $00, $10, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $10, $00, $00, $00, $00, $01, $10
    .BYTE  $01, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $01, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $01, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $00, $10, $00, $11, $00, $00, $01, $00
    .BYTE  $00, $01, $01, $00, $11, $00, $10, $00
    .BYTE  $00, $00, $10, $00, $00, $11, $00, $00
asteroid_4:
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $01, $10, $10, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $01, $00, $01, $10, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $10, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $01, $01, $10, $10, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_5:
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_6:
    .BYTE  $00, $00, $00, $11, $11, $11, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00, $00, $00, $10, $00
    .BYTE  $00, $01, $00, $00, $00, $00, $01, $00
    .BYTE  $00, $10, $00, $00, $00, $00, $00, $10
    .BYTE  $01, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $11, $11, $00, $00, $00, $00, $00, $01
    .BYTE  $00, $00, $10, $00, $00, $00, $00, $01
    .BYTE  $01, $11, $00, $00, $00, $00, $00, $01
    .BYTE  $10, $00, $00, $00, $10, $00, $00, $01
    .BYTE  $01, $00, $00, $01, $10, $00, $00, $10
    .BYTE  $01, $00, $00, $10, $10, $00, $00, $10
    .BYTE  $00, $10, $00, $10, $10, $00, $01, $00
    .BYTE  $00, $10, $01, $00, $10, $00, $01, $00
    .BYTE  $00, $01, $01, $00, $10, $00, $10, $00
    .BYTE  $00, $00, $10, $00, $11, $11, $00, $00
asteroid_7:
    .BYTE  $00, $00, $00, $01, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $00, $10, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $10, $00, $00
    .BYTE  $00, $00, $11, $10, $00, $01, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $01, $00, $10, $10, $00, $00
    .BYTE  $00, $00, $01, $01, $10, $10, $00, $00
    .BYTE  $00, $00, $00, $10, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_8:
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $01, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_9:
    .BYTE  $00, $00, $11, $11, $11, $00, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $11, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $10, $00, $00, $01, $10
    .BYTE  $11, $11, $11, $10, $00, $00, $00, $01
    .BYTE  $10, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $10, $00, $00, $00, $00, $00, $01, $11
    .BYTE  $10, $00, $00, $00, $01, $11, $10, $00
    .BYTE  $10, $00, $00, $00, $00, $10, $00, $00
    .BYTE  $10, $00, $00, $00, $00, $01, $10, $00
    .BYTE  $01, $00, $00, $00, $00, $00, $01, $10
    .BYTE  $01, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $00, $10, $00, $00, $00, $00, $00, $01
    .BYTE  $00, $01, $00, $00, $01, $00, $00, $10
    .BYTE  $00, $01, $00, $11, $10, $10, $01, $00
    .BYTE  $00, $00, $11, $00, $00, $01, $10, $00
asteroid_10:
    .BYTE  $00, $00, $00, $11, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $10, $00, $00
    .BYTE  $00, $00, $11, $10, $00, $01, $00, $00
    .BYTE  $00, $00, $10, $00, $01, $11, $00, $00
    .BYTE  $00, $00, $10, $00, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $10, $00, $00
    .BYTE  $00, $00, $01, $00, $10, $01, $00, $00
    .BYTE  $00, $00, $00, $11, $01, $10, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
asteroid_11:
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $11, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    
large_ufo:
    .BYTE  $00, $00, $00, $11, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $11, $11, $10, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $01, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $11, $11, $11, $11, $11, $11, $00
    .BYTE  $00, $01, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $10, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $01, $11, $11, $10, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    
small_ufo:
    .BYTE  $00, $00, $00, $01, $10, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $01, $10, $10, $00, $00
    .BYTE  $00, $00, $00, $11, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    
shrapnel_0:
    .BYTE  $00, $01, $00, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $00, $10, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $01, $00, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $00, $00, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $01, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    
shrapnel_1:
    .BYTE  $00, $10, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $10, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $01, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $10, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $01, $00, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    
shrapnel_2:
    .BYTE  $01, $00, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $10
    .BYTE  $00, $00, $10, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $01, $00, $00, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $00, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $00, $10, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    
shrapnel_3:
    .BYTE  $10, $00, $00, $00, $00, $00, $01, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $01
    .BYTE  $00, $00, $10, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $10, $00, $00, $00, $00, $00, $01, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $01, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $10, $00, $00, $00, $01, $00
		
shrapnel_tbl:
		.word shrapnel_0
		.word shrapnel_1
		.word shrapnel_2, shrapnel_2
		.word shrapnel_3, shrapnel_3
    
player_ship_0:
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $11, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $10, $00, $11, $00, $00
    .BYTE  $00, $00, $00, $10, $11, $00, $00, $00
    .BYTE  $00, $00, $00, $11, $00, $00, $00, $00
    .BYTE  $00, $00, $01, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
    .BYTE  $00, $00, $00, $00, $00, $00, $00, $00
				
asteroid_tbl:
		; 4 asteroid patterns; large, medium, small
		.word asteroid_0,  asteroid_1,  asteroid_2
		.word asteroid_3,  asteroid_4,  asteroid_5
		.word asteroid_6,  asteroid_7,  asteroid_8
		.word asteroid_9,  asteroid_10, asteroid_11

; "(c)1979 ATARI INC " 60x5 pixels
copyright:
		.byte $00, $00, $01, $00, $11, $10, $11, $10, $11, $10, $00, $00, $01, $00, $11
		.byte $10, $01, $00, $11, $10, $11, $10, $00, $00, $11, $10, $10, $01, $01, $11
		.byte $11, $00, $01, $00, $10, $10, $00, $10, $10, $10, $00, $00, $10, $10, $01
		.byte $00, $10, $10, $10, $10, $01, $00, $00, $00, $01, $00, $11, $01, $01, $00
		.byte $10, $00, $01, $00, $11, $10, $00, $10, $11, $10, $00, $00, $11, $10, $01
		.byte $00, $11, $10, $11, $10, $01, $00, $00, $00, $01, $00, $10, $11, $01, $00
		.byte $11, $00, $01, $00, $00, $10, $00, $10, $00, $10, $00, $00, $10, $10, $01
		.byte $00, $10, $10, $11, $00, $01, $00, $00, $00, $01, $00, $10, $01, $01, $00
		.byte $00, $00, $01, $00, $00, $10, $00, $10, $00, $10, $00, $00, $10, $10, $01
		.byte $00, $10, $10, $10, $10, $11, $10, $00, $00, $11, $10, $10, $01, $01, $11 