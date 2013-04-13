
org $8000

int
res = reset
nmi = nmi
end

; Reset Handler Code [in EMU=6502 MODE!] © 1993 by FWS & Delphi

rh_idbyte = $100
rh_lowram = $80

reset lda rh_idbyte ; first run?
cmp #"!"
bne endresetroutine

; goto back to SUPERCOM PRO.2 SCREEN

ldx #0 ; no go back to supercom
copy lda resetroutine,x
sta rh_lowram,x
inx
cpx #endresetroutine-resetroutine
bne copy
jmp rh_lowram

; This piece of code to be copied down to RAM

resetroutine lda #0
sta rh_idbyte

lda #$ff
sta $e004 ; tell magicom to disable ROM!
jmp ($fffc)

endresetroutine lda #"!" ; start file first & save mode
sta rh_idbyte


main
sei
jsr snes_init
jsr music
jsr snes_init
jsr logozoom
lda #$80
sta $4200
cli
jsr blurin

- lda logozoom_done
cmp #2
bne -
jsr blurout
jmp main

blurcount = $0300

blurin lda #15
sta blurcount
lda #$00
sta blurcount+1

blurin10
- bit $4212
bpl -
- bit $4212
bmi -
- bit $4212
bpl -
- bit $4212
bmi -
lda blurcount+1
sta $2100
inc blurcount+1
lda blurcount
asl
asl
asl
asl
ora #%1111
sta $2106
dec blurcount
bpl blurin10
stz $2106
rts

blurout lda #0
sta blurcount
lda #$0f
sta blurcount+1

blurout10
- bit $4212
bpl -
- bit $4212
bmi -
- bit $4212
bpl -
- bit $4212
bmi -
lda blurcount
asl
asl
asl
asl
ora #%1111
sta $2106
inc blurcount
lda blurcount+1
sta $2100
dec blurcount+1
bpl blurout10
stz $2106
rts


snes_init phk
plb
clc
xce ; 16-bit mode
php
sep #$20 ; A,X,Y 8-bit mode
lda #$8f
sta $2100
lda #$00
sta $420c
stz $2101
stz $2102
stz $2103
stz $2104
stz $2105
stz $2106
stz $2107
stz $2108
stz $2109
stz $210a
stz $210b
stz $210c
lda #$00
sta $210d
sta $210d
sta $210e
sta $210e
sta $210f
sta $210f
sta $2110
sta $2110
sta $2111
sta $2111
sta $2112
sta $2112
sta $2113
sta $2113
sta $2114
sta $2114
lda #$80
sta $2115
stz $2116
stz $2117
stz $211a
stz $211b
lda #$01
sta $211b
stz $211c
stz $211c
stz $211d
stz $211d
stz $211e
lda #$01
sta $211e
stz $211f
stz $211f
stz $2120
stz $2120
stz $2121
stz $2123
stz $2124
stz $2125
stz $2126
stz $2127
stz $2128
stz $2129
stz $212a
stz $212b
stz $212c
stz $212d
stz $212e
stz $212f
lda #$30
sta $2130
stz $2131
lda #$e0
sta $2132
stz $2133
stz $4200
lda #$ff
sta $4201
stz $4202
stz $4203
stz $4204
stz $4205
stz $4206
stz $4207
stz $4208
stz $4209
stz $420a
stz $420b
stz $420c
stz $420d
lda #$81
sta $4212
plp

rep #$30 ; x,y,a fixed -> 16 bit mode
sep #$20 ; accumulator ->  8 bit mode
rts


logozoom_tab bin trxzoom.tab
logozoom_pal bin trxzoom.m7p
logozoom_bmp bin trxzoom.m7b
logozoom_scr
dcb 00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15
dcb 00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15
dcb 00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15
dcb 00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15

dcb 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
dcb 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
dcb 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
dcb 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31

dcb 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47
dcb 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47
dcb 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47
dcb 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47

dcb 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
dcb 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
dcb 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
dcb 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63

logozoom stz $2121
ldx.w #0
- lda logozoom_pal,x
sta $2122
inx
cpx #512
bne -

; copy mode 7 tile data
lda #$80
sta $2115
ldx.w #$0000 ; tile data is at VRAM $0000
stx $2116
ldx.w #0
- lda logozoom_bmp,x
sta $2119
inx
cpx #4096
bne -

; copy mode 7 screen data
stz $2115
ldx.w #$0000
stx $2116
ldy.w #8*16
-- ldx.w #$0
- lda logozoom_scr,x
sta $2118
inx
cpx #512
bne -
dey
bne --

; now setup page info
lda #$07 ; mode 7
sta $2105
lda #%00000000
sta $211a
lda #$40 ; screen 0 at VRAM $0000
sta $2107
lda #$00 ; screen 0 tile data at VRAM $0000
sta $210b
lda #$01 ; enable screen 0
sta $212c
lda #%01000100
sta $2133 ; no screen attributes
; lda #$0f
; sta $2100

logorotate_index = $200
logocenter_index = $202
logozoom_index = $204
logozoom_add = $206
logozoom_last = $208
logozoom_done = $20a

ldx.w #68
stx logorotate_index
ldx.w #246
stx logocenter_index
ldx.w #0
stx logozoom_index
stx logozoom_done
rts


nmi
pha
phx
phy

lda logozoom_done
cmp #1
bne logozoom10

ldx logozoom_last
dex
stx logozoom_last
lda logozoom_last
sta $211b
lda logozoom_last+1
sta $211b
lda logozoom_last
sta $211e
lda logozoom_last+1
sta $211e
ldx logozoom_last
beq logozoom50
stz $4200
inc logozoom_done

logozoom50
jmp logozoom90

logozoom10
ldx logozoom_index
ldy logozoom_tab+4096,x
sty logozoom_add
inx
inx
cpx #256*2*5
bne logozoom13
inc logozoom_done
ldx.w #0

logozoom13 stx logozoom_index

ldx logorotate_index
lda logozoom_tab,x
adc logozoom_add
sta $211b
sta logozoom_last
lda logozoom_tab+1,x
adc logozoom_add+1
sta $211b
sta logozoom_last+1
lda logozoom_tab+512,x
sta $211c
lda logozoom_tab+1+512,x
sta $211c
lda logozoom_tab+1024,x
sta $211d
lda logozoom_tab+1+1024,x
sta $211d
lda logozoom_tab+1536,x
adc logozoom_add
sta $211e
lda logozoom_tab+1+1536,x
adc logozoom_add+1
sta $211e
inx
inx
cpx #256*2
bne logozoom11
ldx.w #0
logozoom11 stx logorotate_index

ldx logocenter_index
lda logozoom_tab+2048,x
sta $211f
lda logozoom_tab+1+2048,x
sta $211f
lda logozoom_tab+3072,x
sta $2120
lda logozoom_tab+1+3072,x
sta $2120
inx
inx
cpx #512*2
bne logozoom12
ldx.w #0
logozoom12 stx logocenter_index

logozoom90
ply
plx
pla
rti



music   sep     #$30

;* bincon (c)1992 by h.bühler, codex design *

	dc.b	$a9,$ff,$8d,$40,$21,$c2,$10,$a2,$ff,$7f,$bf
	dc.b	$00,$80,$01,$9f,$00,$00,$7f,$bf,$00,$80,$02,$9f,$00,$80,$7f,$ca
	dc.b	$10,$ed,$a9,$80,$8d,$00,$21,$a9,$00,$8d,$fd,$00,$a9,$00,$8d,$fe
	dc.b	$00,$a9,$7f,$8d,$ff,$00,$9c,$00,$42,$78
	jsr	restart
	dc.b	$e2,$30,$ad
	dc.b	$40,$21,$d0,$fb,$a9,$e0,$8d,$43,$21,$a9,$ff,$8d,$42,$21,$a9,$01
	dc.b	$8d,$41,$21,$a9,$01,$8d,$40,$21,$ad,$40,$21,$c9,$01,$d0,$f9,$ad
	dc.b	$40,$21,$c9,$55,$d0,$f9,$ad,$07,$02,$8d,$41,$21,$a9,$07,$8d,$40
	dc.b	$21,$ad,$40,$21,$c9,$07,$d0,$f9,$ad,$40,$21,$c9,$55,$d0,$f9

;* 128 bytes from 'e967' saved. *
	dc.b	$58
loopdgh	rts
restart

	dc.b	$08
	jsr	restart2
	dc.b	$28,$a9,$00,$8d,$40,$21,$60
restart2	dc.b	$08,$c2,$30,$a0,$00
	dc.b	$00,$a9,$aa,$bb,$cd,$40,$21,$d0,$fb,$e2,$20
	dc.b	$a9,$cc,$80,$26,$b7
	dc.b	$fd,$c8,$eb,$a9,$00,$80,$0b,$eb,$b7
	dc.b	$fd,$c8,$eb,$cd,$40,$21,$d0
	dc.b	$fb,$1a,$c2,$20,$8d,$40,$21,$e2,$20,$ca,$d0
	dc.b	$eb,$cd,$40,$21,$d0
	dc.b	$fb,$69,$03,$f0,$fc,$48,$c2,$20,$b7,$fd
	dc.b	$c8,$c8,$aa,$b7,$fd,$c8
	dc.b	$c8,$8d,$42,$21,$e2,$20,$e0,$01,$00
	dc.b	$a9,$00,$2a,$8d,$41,$21,$69
	dc.b	$7f,$68,$8d,$40,$21,$cd,$40,$21,$d0,$fb,$70,$b3,$28,$60
	DC.B	$68,$8d,$40,$21,$cd,$40,$21,$d0,$fb,$70,$b3,$28,$60

;* 111 bytes from 'fdca' saved. *
	pad
        bin     music1.bin
        bin     music2.bin


