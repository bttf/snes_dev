;
;
;
;           CODE: THE WHITE KNIGHT
;       COMPUTER: AMIGA 2000/030/25Mhz/4Mb RAM
;      ASSEMBLER: DASM V2.12, high level Macro Assembler
;         EDITOR: CygnusEd Professional V3.5
;    OTHER TOOLS: DPAINT, 1084S Monitor, BINCON
;           FONT: PAN
;           LOGO: MICRO
;
; HARDWARE TOOLS: SUPER MAGICOM from FRONT FAREAST
;                 AMIGA <-> SUPER MAGICOM TRANSFER CABLE
;                 YES! all Hobbyists tools!  No need to pay $8,000.00 or
;                 whatever the other commercial tools cost
;
; for more info, EMAIL: ANTIROX@TNP.COM
;
;
;
;
;
;
;
;

	processor 65816

	org	$0000
	rorg	$8000
START	sei
	phk
	plb
	clc
	xce		; 16 bit mode
	rep	#$30	; X,Y,A fixed -> 16 bit mode
	sep	#$20	; Accumulator ->  8 bit mode

	lda	#$01
	sta	$4200	; DMA clear
	stz	$420b	; DMA clear
	stz	$420c	; DMA clear


	lda	#$80	; Video Controller INIT
	sta	$2115	

	stz	$2105	; Screen mode = Normal

	lda	#$01	; Plane 0 = $0000 - Width = 64
	sta	$2107	
	lda	#$04	; Plane 1 = $0400
	sta	$2108	
	lda	#$08	; Plane 2 = $0800
	sta	$2109
	lda	#$0c	; Plane 3 = $0c00
	sta	$210a

	lda	#$11	; plane 0 & 1 Vram = $1000
	sta	$210b	
	lda	#$21	; Plane 2 VRAM = $1000
	sta	$210c	; plane 3 VRAM = $2000

	lda	#$0f	; Plane 0,1,2,3 = ENABLED
	sta	$212c	;

	stz	$2133	; Normal Screen


	lda	#$00		; color 0
	sta	$2121
	lda	palette0
	sta	$2122
	lda	palette0+1
	sta	$2122



	lda	#$01		; color 1
	sta	$2121
	lda	palette1
	sta	$2122
	lda	palette1+1
	sta	$2122


	lda	#$21		; color 2
	sta	$2121
	lda	palette2
	sta	$2122
	lda	palette2+1
	sta	$2122
	
	lda	#$41		; color 3
	sta	$2121
	lda	palette3
	sta	$2122
	lda	palette3+1
	sta	$2122

	lda	#$61		; color 4
	sta	$2121
	lda	palette4
	sta	$2122
	lda	palette4+1
	sta	$2122

	lda	#$62
	sta	$2121
	lda	palette4a
	sta	$2122
	lda	palette4a+1
	sta	$2122

	lda	#$63
	sta	$2121
	lda	palette4b
	sta	$2122
	lda	palette4b+1
	sta	$2122


;	clc
;	cld
;	lda	numo
;	sbc	#$21
;	asl
;	asl
;	asl	
;	sbc	#$18
;	sta	$1000
;	sta	$2112
;	stz	$2112
;	sta	$2110
;	stz	$2110
;	sta	$0809




	ldx	#$1000		; Transfer CHAR at Tile VRAM 
	stx	$2116		; location = $1000

	ldx.v	#$0000
LOOP1	lda	CHAR+2,x	; copy
	eor	#$ff		; char data
	sta	$2118		; to current vram
	stz	$2119		; location
	inx			;
	cpx	#$0200		;	$1000
	bne	LOOP1		;

	ldx.v	#$2000		; Transfer LOGO at tile VRAM0
	stx	$2116		; location = $2000
	ldx.v	#$00
LOOP1a	lda	Plane0,x
	sta	$2118
	lda	Plane1-256,x
	sta	$2119
	inx
	cpx.v	#$0800
	bne	LOOP1a

	ldx.v	#$00		; CLEAR
LOOP2	lda	#$08
	sta	$210d,x
	stz	$210d,x
	inx			; REGISTERS
	cpx.v	#$0008
	bne	LOOP2		; LOOP

	ldx	#$0004		; CLEAR
LOOP3	stz	$212d,x		; more 
	dex			; VIDEO
	bpl	LOOP3		; REGISTERS



	ldx.v	#$00
	lda	#$01
	sta	$2121
loop4	lda	pcselect,x
	sta	$2122
	inx
	lda	pcselect,x
	sta	$2122
	stz	$2122
	stz	$2122
	inx
	cpx.v	#$20
	bne	loop4






	stz	$0800		; scrolltext shake counter
	stz	$0801		; Scroll Address Offset
	stz	$0802		 
	stz	$0803		; 32 counter for scroll
	stz	$0804		; 16 counter for $d800
	stz	$0805		
	stz	$0806		; $d800 timer
	stz	$0807		; JoyPad DATA
	stz	$0808
				; $0809 = Text Center Value
	stz	$080a		; Pointer Place
	stz	$080b		; EXPANDED for Y counter
	stz	$080c		; arrow bounce pointer
	stz	$080d
	stz	$080e		; animation counter
	stz	$080f		; animation UD
	stz	$0810		; offset for ANIM char
	stz	$0811

	stz	$0812		; Y stretch pointer
	stz	$0813


	lda	#$00			; clear BYTES in battery
	dc.b	$8f,$00,$80,$70		; clear $708000 - $70809
	dc.b	$8f,$01,$80,$70		; 10 bytes for 10 options
	dc.b	$8f,$02,$80,$70		
	dc.b	$8f,$03,$80,$70
	dc.b	$8f,$04,$80,$70	
	dc.b	$8f,$05,$80,$70	
	dc.b	$8f,$06,$80,$70	
	dc.b	$8f,$07,$80,$70
	dc.b	$8f,$08,$80,$70	
	dc.b	$8f,$09,$80,$70	
	

	lda	#$ff
	sta	$2113
	stz	$2113
	lda	#$f0
	sta	$2111
	stz	$2111
				;	CENTERING
	lda	#$18		; 	
	sta	$0809
	sta	$2112
	stz	$2112
	sta	$2110
	stz	$2110
	




	jsr	screenoff
	jsr	cls
	ldx	#$a01
	stx	$2116
	ldx.v	#$00
myname	lda	introby,x
	and	#$3f
	jsr	print
	inx
	cpx.v	#$1a
	bne	myname
	jsr	showit
	jsr	ridit

	jsr	screenoff
	jsr	cls
	ldx	#$0608
	stx	$2116
	ldx.v	#$00
mrkname	lda	trainer,x
	and	#$3f
	jsr	print
	inx
	cpx.v	#$10
	bne	mrkname
	jsr	showit
	jsr	ridit

	jmp	continue


ridit	lda	#$0f
riddly	jsr	showlp
	dec
	cmp	#$00
	bne	riddly
	rts

showit	lda	#$00
delayr	jsr	showlp
	inc
	cmp	#$0f
	bne	delayr
	
showlp	sta	$2100
	ldx	#$6fff
ymlp	ldy.v	#$01
ysulp	dey
	bne	ysulp
	dex
	bne	ymlp
	rts	
	

cls	lda	#$80
	sta	$2115
	ldx.v	#$0000
	stx	$2116
	lda	#$20
clslp	jsr	print
	inx
	cpx	#$fff
	bne	clslp
	rts

screenoff	lda	#$8f
		sta	$2100
		rts

continue
	jsr	screenoff
	jsr	cls
	ldx	#$05be
	stx	$2116
	ldx.v	#$0
arrowlp	lda	arrow,x
	and	#$3f
	jsr	print
	inx
	cpx.v	#$2
	bne	arrowlp

	ldx	#$0c20
	stx	$2116
	lda	#$00
	ldx.v	#$00
	stx	$0807
logolp	lda	$0807
	sta	$2118
	lda	$0808
	sta	$2119
	inx
	stx	$0807
	cpx.v	#$0e0
	bne	logolp


	ldx	#$09a0	; video port VRAM set to $0000
	stx	$2116	
	lda	#$80	; Video controller INIT
	sta	$2115	
	ldx.v	#$0	; Display DATA
texton	lda	scrtxt,x
	and	#$3f
	jsr	print
	inx
	inc
	LDA	scrtxt,x
	cmp	#$00
	bne	texton
	lda	#$0f
	sta	$2100	;turn screen on (#0) and make it bright (#F)
	cli





vrtb	lda	$4210
	and	#$80
	cmp	#$00
	beq	vrtb

	stz	$2121
	lda	#$00
	sta	$2122
	sta	$2122

	ldx	#$05f9		; wait till proper raster position
scrwait	dex
	bne	scrwait

	ldx.v	#$00		; start doing rasters
	ldy	$0812
scrwat	stz	$2121
	lda	rastercolors,x
	sta	$2122
	inx
	lda	rastercolors,x
	sta	$2122
	lda	vertib,y
	sta	$2114
	stz	$2114
	lda	vertib,y
	sta	$2121
	stz	$2121
	lda	#$18		; wait until next rasterline
strait	dec			;
	bne strait		;
	iny
	inx
	cpx.v	#$78		; repeat until 78
	bne	scrwat		;

	stz	$2121
	stz	$2122
	stz	$2122
	stz	$2114
	stz	$2114

	ldx.v	#$00
passcrl inx	
	cpx	#$900
	bne	passcrl




	jsr	JOYPAD
	jsr	animchar	; 10 16 1e
	jsr	arbnce
	jsr	scroller
	inc	$0812
	lda	$0812
	cmp	#$3c
	bne	nostz
	stz	$0812
nostz
				;jsr	JOYPAD
	jsr	animchar
;	jsr	animchar

forever: jmp 	vrtb





scroller  lda	$0800

	  inc
	  sta	$0800
	  cmp	#$08
	  bne	nosctext
	  ldx	$0801
	  inx
	  stx	$0801
	  stz	$0800
	  jmp	scrollit
nosctext  

scrollit
	lda	$0800
	sta	$210d
	stz	$210d
	lda	#$8f		; Screen Off
	sta	$2100
	stz	$0803		; reset 32 counter
	lda	#$80		; Video Controller INIT
	sta	$2115
	ldx	#$02a0		; Video DATA location
	stx	$2116
	ldx	$0801		; Scroll Text Offset
	ldy	$0804		; $d800 pointer

realsc  lda	scrolltext,x
	and	#$3f
	sta	$2118
	lda	pselect,y
	sta	$2119
	iny
	inx	
	inc	$0803
	lda	$0803
	cmp	#$20
	bne	realsc
	lda	#$0f
	sta	$2100

	ldx	$0801
	lda	scrolltext+32,x
	cmp	#$00
	bne	itsokay
	stz	$0801
	stz	$0802
itsokay	
	stz	$0806
	ldy	$0804
	iny
	cpy.v	#$0d*2
	bne	noyrest
	ldy.v	#$00
noyrest	sty	$0804
donone	rts
	
JOYPAD	lda	$0800
	cmp	#$00
	bne	donone
JOYPADL	LDA	$4212
	and	#$01
	bne	JOYPADL
	lda	$4218
	sta	$0807
	lda	$4219
	sta	$0808

	lda	$0808
	and	#$04
	beq	notdown
	lda	$080a
	cmp	numo
	beq	joycomn
	inc	$080a
	clc
	cld
	lda	$0809
	sbc	#$07
	sta	$0809
	sta	$2110
	stz	$2110
notdown lda	$0808
	and	#$08
	beq	notup
	lda	$080a
	cmp	#$00
	beq	joycomn
	dec	$080a
	clc
	cld
	lda	$0809
	adc	#$08
	sta	$0809
	sta	$2110
	stz	$2110
notup	lda	$0808
	and	#$80
	beq	nobuttn
	ldx	$080a			;
	dc.b	$bf,$00,$80,$70		; LDA $708000,x
	eor	#$ff			;
	dc.b	$9f,$00,$80,$70		; sta $708000,x

	lda	$080a
	inc
	ldx	#$099a
where	ldy.v	#$20
wherel	inx
	dey
	cpy.v	#$00
	bne	wherel
	dec
	bne	where

	stx	$2116
	lda	#$8f			; Screen OFF
	sta	$2100
	ldx	$080a
	dc.b	$bf,$00,$80,$70		; LDA	$708000,x
	cmp	#$00
	bne	testy
	lda	#$0e
testy	cmp	#$ff
	bne	none
	lda	#$19
none	jsr	print
	
	lda	#$0f			; Screen ON
	sta	$2100


nobuttn
joycomn
	lda	$0808
	and	#$10
	beq	nobtns
	jmp	reset
nobtns	rts

reset	jmp	START			;dc.b	$5c,$08,$80,$00









print	sta	$2118
	stz	$2119
	rts


animchar	lda	$0800		
		cmp	#$00
		bne	noanimchar
		lda	$080f
		cmp	#$00
		bne	animback
		jmp	animforward
noanimchar	rts

animforward	inc	$080e
		lda	$080e
		cmp	#$06
		bne	nofuzz
		lda	#$ff
		sta	$080f
nofuzz		jmp	animcopy

animback	dec	$080e
		lda	$080e
		cmp	#$00
		bne	nofuzzy
		stz	$080f
nofuzzy		;jmp	animcopy

animcopy	clc
		cld
		lda	$080e
		asl
		asl
		asl
		sta	$0810
		stz	$0811
		lda	#$80
		sta	$2115
		lda	#$8f		; screen off
		sta	$2100		; 
		ldx	#$1128
		stx	$2116
					;lda	#$80
					;sta	$2115
		ldy.v	#$00
		ldx	$0810
animcopyloop	lda	ball,x
		sta	$2118
		stz	$2119
		inx
		iny
		cpy.v	#$0007
		bne	animcopyloop

animbox		ldx	#$1150
		stx	$2116
		lda	#$80
		sta	$2115
		ldy.v	#$00
		ldx	$0810
animcopyloop2	lda	box,x
		sta	$2118
		stz	$2119
		inx
		iny
		cpy.v	#$0008
		bne	animcopyloop2
		lda	#$0f
		sta	$2100
		rts



ball	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00010000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00010000
	dc.b	%00111000
	dc.b	%00010000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00010000
	dc.b	%00010000
	dc.b	%01111100
	dc.b	%00010000
	dc.b	%00010000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00010000
	dc.b	%00111000
	dc.b	%01111100
	dc.b	%00111000
	dc.b	%00010000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00010000
	dc.b	%00010000
	dc.b	%00111000
	dc.b	%11111110
	dc.b	%00111000
	dc.b	%00010000
	dc.b	%00010000
	dc.b	%00000000

	dc.b	%00010000
	dc.b	%00010000
	dc.b	%00111000
	dc.b	%11111110
	dc.b	%00111000
	dc.b	%00010000
	dc.b	%00010000
	dc.b	%00000000


box	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000
	dc.b	%00000000

	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00011000
	dc.b	%00011000
	dc.b	%00000000



rastercolors	dc.w	%111111111111111
		dc.w	%111110000000000
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%0
		dc.w	%111110000000000
		dc.w	%111111111111111

vertib
 dc.b  0,0,0,0,0,1,1,1,1,2,2,2,3,3,4,4,4,5,5,6,6,6,7,7,7,7,8,8,8,8
 dc.b  8,8,8,8,8,7,7,7,7,6,6,6,5,5,4,4,4,3,3,2,2,2,1,1,1,1,0,0,0,0
 dc.b  0,0,0,0,0,1,1,1,1,2,2,2,3,3,4,4,4,5,5,6,6,6,7,7,7,7,8,8,8,8
 dc.b  8,8,8,8,8,7,7,7,7,6,6,6,5,5,4,4,4,3,3,2,2,2,1,1,1,1,0,0,0,0



palette0	dc.w	%000000000000000
palette1	dc.w	%000000000011111
palette2	dc.w	%101110000001011
palette3	dc.w	%101100010110110

palette4	dc.w	%000000110000110;00000	; logo colors
palette4a	dc.w	%000001001101110;00000
palette4b	dc.w	%000001111110110;00000

palette5	dc.w	%111110000011111
palette6	dc.w	%111111111111111
palette7	dc.w	%000000000011000
palette8	dc.w	%000001100000000


pcselect

	dc.w	%000110001100011
	dc.w	0
	dc.w	%010110101101011
	dc.w	0
	dc.w	%100111001110011
	dc.w	0
	dc.w	%110111101111011
	dc.w	0
	dc.w	%110111101111011
	dc.w	0
	dc.w	%100111001110011
	dc.w	0
	dc.w	%010110101101011
	dc.w	0
	dc.w	%000110001100011



pselect	
	dc.b	%00100
		dc.b	%00100
	dc.b	%01000
		dc.b	%01000
	dc.b	%01100
		dc.b	%01100
	dc.b	%10000
		dc.b	%10000
	dc.b	%10100
		dc.b	%10100
	dc.b	%11000
		dc.b	%11000
	dc.b	%11100
		dc.b	%11100
	dc.b	%11000
		dc.b	%11000
	dc.b	%10100
		dc.b	%10100
	dc.b	%10000
		dc.b	%10000
	dc.b	%01100
		dc.b	%01100
	dc.b	%01000
		dc.b	%01000

	dc.b	%00100
		dc.b	%00100
	dc.b	%01000
		dc.b	%01000
	dc.b	%01100
		dc.b	%01100
	dc.b	%10000
		dc.b	%10000
	dc.b	%10100
		dc.b	%10100
	dc.b	%11000
		dc.b	%11000
	dc.b	%11100
		dc.b	%11100
	dc.b	%11000
		dc.b	%11000
	dc.b	%10100
		dc.b	%10100
	dc.b	%10000
		dc.b	%10000
	dc.b	%01100
		dc.b	%01100
	dc.b	%01000
		dc.b	%01000

	dc.b	%00100
		dc.b	%00100
	dc.b	%01000
		dc.b	%01000
	dc.b	%01100
		dc.b	%01100
	dc.b	%10000
		dc.b	%10000
	dc.b	%10100
		dc.b	%10100
	dc.b	%11000
		dc.b	%11000
	dc.b	%11100
		dc.b	%11100
	dc.b	%11000
		dc.b	%11000
	dc.b	%10100
		dc.b	%10100
	dc.b	%10000
		dc.b	%10000
	dc.b	%01100
		dc.b	%01100
	dc.b	%01000
		dc.b	%01000


arbnce	ldy	$080c
	lda	arbdata,y
	sta	$210f
	stz	$210f
	iny
	sty	$080c
	lda	arbdata,y
	cmp	#$0f
	bne	arkpbn
	stz	$080c
	stz	$080d
arkpbn	rts
	

arbdata	dc.b	0,0,0,0,0
	dc.b	1,1,1,1,1
	dc.b	2,2,2,2
	dc.b	3,3,3,3
	dc.b	4,4,4
	dc.b	5,5,5
	dc.b	6,6
	dc.b	7,7
	dc.b	8
	dc.b	7,7
	dc.b	6,6
	dc.b	5,5,5
	dc.b	4,4,4
	dc.b	3,3,3,3
	dc.b	2,2,2,2
	dc.b	1,1,1,1,1
	dc.b	$f



;
; NUMBER of OPTIONS	0 = 1 option
;		|	1 = 2 options
;	        |	.   .   ..
;	      \ | /	.   .   ..
;	       \|/	9 = 10 oprions
numo	dc.b	4
arrow	dc.b	"<-"
scrtxt	dc.b	" UNLIMITED OPTION 0.......N     "
	dc.b	" UNLIMITED OPTION 1.......N     "
	dc.b	" UNLIMITED OPTION 2.......N     "
	dc.b	" UNLIMITED OPTION 3.......N     "
	dc.b	" UNLIMITED OPTION 4.......N     "
	dc.b	"                                "
	dc.b	" STREET FIGHTER PAN VERSION   "
	DC.B	"    RELEASED ON 11-12-92      "
	DC.B	0


introby	dc.b	"INTRO BY: THE WHITE KNIGHT"
trainer	dc.b	"TRAINED BY: PAN!"
;		 123456789abcedf0123456789a

scrolltext
	dc.b	"                                "
	dc.b	"%THE WHITE KNIGHT% HERE WITH A NEW *BASELINE* INTRO. "
	DC.B	"IT IS FINALLY COMPLETED AND THE SCROLL IS FIXED. "
	DC.B	"THE LOGO IS 4 COLOR... 3 + BACKGROUND BY *PAN* "
	DC.B	"CHECK OUT THE TWO %ANIMATED% CHARS AND THE "
	DC.B	"%LOGO% *STRETCHES* AND *SHRINKS*.. COOL EFFECT EH? "
	DC.B	"                     *BASELINE 2091*                 "
	DC.B	"IF WE DO THIS WITHOUT THE SNES PROGRAMMERS MANUAL, IMAGINE "
	DC.B	"WHAT WE WOULD BE DOING IF WE DIDNT HAVE TO FIGURE OUT "
	DC.B	"HALF THE REGISTERS. "
	DC.B	"                                      "
	DC.B	0,0


Plane0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,2,0,0 
        dc.b 0,64,0,0,64,232,64,18 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,244 
        dc.b 0,0,0,0,0,0,0,180 
        dc.b 0,0,0,0,0,0,0,191 
        dc.b 0,0,0,0,0,0,0,253 
        dc.b 0,0,0,0,0,0,0,32 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,2,0,2,10,3 
        dc.b 0,0,0,0,0,0,128,233 
        dc.b 0,0,0,0,0,0,0,105 
        dc.b 0,0,0,0,0,0,0,127 
        dc.b 0,0,0,0,0,0,0,250 
        dc.b 0,0,0,0,0,0,0,90 
        dc.b 0,0,0,0,0,0,0,95 
        dc.b 0,0,0,0,0,0,0,192 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,5 
        dc.b 0,0,0,0,0,0,0,165 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,64,0,80 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 21,68,25,34,21,59,39,31 
        dc.b 255,189,122,244,233,210,165,75 
        dc.b 233,45,90,180,105,210,164,74 
        dc.b 105,45,90,180,105,210,90,180 
        dc.b 127,47,94,189,122,244,22,45 
        dc.b 250,75,150,45,90,180,169,18 
        dc.b 88,68,149,44,90,180,105,210 
        dc.b 0,0,0,192,192,224,96,224 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 13,30,52,41,50,69,43,118 
        dc.b 210,90,180,105,210,165,75,150 
        dc.b 210,90,180,105,210,165,72,156 
        dc.b 255,94,189,122,244,233,45,90 
        dc.b 244,150,45,90,180,105,0,0 
        dc.b 180,150,45,90,180,105,18,69 
        dc.b 191,151,47,94,189,122,244,233 
        dc.b 240,184,84,152,32,92,178,110 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 3,1,2,1,3,2,1,6 
        dc.b 75,105,210,165,75,151,47,94 
        dc.b 255,123,245,232,211,164,74,151 
        dc.b 128,192,0,128,0,0,128,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 46,13,10,4,25,34,21,59 
        dc.b 150,45,90,180,105,210,165,75 
        dc.b 151,44,91,181,105,211,165,75 
        dc.b 0,128,128,128,128,128,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 5,11,6,13,10,4,25,34 
        dc.b 165,75,151,47,94,189,122,244 
        dc.b 240,240,176,112,160,16,96,192 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 77,58,84,9,18,5,11,22 
        dc.b 45,90,180,105,210,165,75,151 
        dc.b 44,92,188,124,252,236,220,168 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 171,119,79,62,93,5,11,0 
        dc.b 210,165,75,150,45,160,64,0 
        dc.b 212,162,76,146,44,2,6,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 8,5,14,9,7,11,3,2 
        dc.b 189,122,244,233,210,165,75,150 
        dc.b 44,91,181,104,211,164,74,151 
        dc.b 128,128,0,128,0,0,128,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 38,29,42,4,9,2,5,11 
        dc.b 150,45,90,180,105,210,165,75 
        dc.b 151,47,95,189,122,244,233,210 
        dc.b 128,128,233,210,90,180,105,210 
        dc.b 0,0,105,210,90,180,105,210 
        dc.b 21,59,119,239,94,189,122,244 
        dc.b 233,210,165,74,149,43,86,168 
        dc.b 96,128,0,192,128,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 13,26,4,25,42,25,4,0 
        dc.b 47,94,189,122,244,233,210,101 
        dc.b 68,152,34,93,180,105,210,165 
        dc.b 0,0,210,165,180,105,210,165 
        dc.b 0,0,255,255,189,122,244,233 
        dc.b 0,0,244,233,45,90,180,105 
        dc.b 0,0,180,105,34,91,180,105 
        dc.b 0,0,0,0,224,240,248,124 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 1,6,8,5,14,9,7,10 
        dc.b 45,90,180,105,210,165,75,150 
        dc.b 44,91,181,105,211,165,75,151 
        dc.b 128,128,128,128,128,128,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 6,13,10,4,25,34,21,59 
        dc.b 151,47,94,189,122,244,233,210 
        dc.b 165,74,151,44,91,181,104,211 
        dc.b 165,0,1,128,128,0,128,0 
        dc.b 165,180,105,0,0,0,0,0 
        dc.b 233,210,69,59,38,29,42,4 
        dc.b 102,212,165,76,154,52,105,210 
        dc.b 0,0,0,192,192,224,96,224 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,122 
        dc.b 183,40,0,0,0,0,0,90 
        dc.b 75,150,2,5,1,0,5,94 
        dc.b 75,151,208,161,0,0,64,0 
        dc.b 210,165,180,104,0,0,0,0 
        dc.b 210,165,11,6,5,2,12,17 
        dc.b 210,165,75,151,47,94,189,122 
        dc.b 252,238,212,162,76,144,42,92 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 1,2,0,1,2,1,3,2 
        dc.b 45,90,180,105,210,165,75,151 
        dc.b 47,95,189,123,245,232,211,164 
        dc.b 128,128,128,128,0,128,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 39,31,46,13,10,4,25,34 
        dc.b 165,75,150,45,90,180,105,210 
        dc.b 164,74,151,44,91,181,105,210 
        dc.b 32,128,0,160,116,255,223,212 
        dc.b 0,0,0,0,0,242,229,180 
        dc.b 9,3,6,13,10,132,201,210 
        dc.b 165,75,151,47,94,189,122,244 
        dc.b 240,240,176,112,160,16,96,192 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 52,86,45,122,84,9,18,5 
        dc.b 180,150,45,90,180,105,210,165 
        dc.b 191,151,47,95,191,123,247,232 
        dc.b 0,0,0,0,0,128,79,159 
        dc.b 0,0,0,0,0,0,203,151 
        dc.b 10,29,19,15,31,30,253,250 
        dc.b 244,233,210,165,75,150,45,90 
        dc.b 178,110,212,162,76,144,42,94 
        dc.b 0,0,0,0,0,128,0,0 
        dc.b 0,0,1,0,0,1,0,1 
        dc.b 1,6,40,5,14,41,7,171 
        dc.b 47,94,189,122,244,233,210,165 
        dc.b 74,151,44,91,181,104,211,164 
        dc.b 128,0,128,128,0,128,63,127 
        dc.b 0,0,0,0,0,0,255,254 
        dc.b 0,0,0,0,0,0,75,150 
        dc.b 0,0,0,0,0,0,75,151 
        dc.b 0,0,0,0,5,0,255,254 
        dc.b 128,0,0,128,208,128,64,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 21,59,38,29,42,0,0,0 
        dc.b 165,75,150,45,90,11,22,0 
        dc.b 165,75,151,47,94,66,133,0 
        dc.b 233,210,165,75,150,208,160,0 
        dc.b 105,211,166,77,154,11,22,0 
        dc.b 165,75,151,47,94,66,133,0 
        dc.b 233,210,165,74,148,209,160,0 
        dc.b 32,128,0,64,128,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 11,22,13,2,10,6,1,0 
        dc.b 75,151,47,94,189,133,11,0 
        dc.b 210,165,75,150,45,160,64,0 
        dc.b 210,165,75,150,45,5,11,0 
        dc.b 210,165,75,151,47,161,66,0 
        dc.b 244,233,210,165,75,104,208,0 
        dc.b 180,105,210,165,75,1,0,0 
        dc.b 182,109,220,144,32,192,0,0 
        dc.b 128,208,128,0,0,128,0,0 
        dc.b 1,1,0,1,1,1,0,0 
        dc.b 3,34,1,70,72,38,13,0 
        dc.b 75,150,45,90,180,128,0,0 
        dc.b 75,150,45,90,180,22,45,0 
        dc.b 75,151,47,94,189,133,11,0 
        dc.b 210,165,75,150,45,160,64,0 
        dc.b 210,165,75,150,45,5,11,0 
        dc.b 210,165,75,150,45,165,75,0 
        dc.b 210,165,75,150,45,160,64,0 
        dc.b 128,64,128,64,192,128,64,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,1,0,0 
        dc.b 0,0,64,64,64,240,64,111 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,75 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,208 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,2,2,7,3 
        dc.b 0,0,0,0,0,0,0,254 
        dc.b 0,0,0,0,0,0,0,151 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,165 
        dc.b 0,0,0,0,0,0,0,255 
        dc.b 0,0,0,0,0,0,0,192 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,10 
        dc.b 0,0,0,0,0,0,0,95 
        dc.b 0,0,0,0,0,0,0,254 
        dc.b 0,0,0,0,0,0,64,224 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
Plane1 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 79,11,7,15,15,15,31,47 
        dc.b 255,255,255,255,254,253,250,244 
        dc.b 254,208,160,64,128,0,0,1 
        dc.b 151,2,5,11,23,47,5,11 
        dc.b 255,255,255,255,255,255,232,208 
        dc.b 255,244,232,208,160,64,0,0 
        dc.b 164,11,3,3,5,11,23,47 
        dc.b 0,0,128,192,192,224,224,224 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 15,29,63,62,93,58,84,8 
        dc.b 253,160,64,128,0,0,0,1 
        dc.b 47,5,11,23,47,95,191,127 
        dc.b 255,255,255,255,255,254,208,160 
        dc.b 255,232,208,160,64,128,0,0 
        dc.b 75,1,2,5,11,23,47,31 
        dc.b 255,127,255,255,255,255,255,254 
        dc.b 240,248,252,236,220,162,68,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 4,0,0,0,0,1,2,1 
        dc.b 191,23,47,95,191,127,255,255 
        dc.b 255,255,255,255,253,251,245,232 
        dc.b 192,128,128,128,128,128,0,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 31,63,63,63,46,29,42,4 
        dc.b 232,208,160,64,128,0,0,0 
        dc.b 1,3,5,11,23,47,95,191 
        dc.b 128,128,128,128,128,128,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,1,2,5,11,7,15 
        dc.b 95,191,127,255,255,255,255,255 
        dc.b 240,240,240,240,240,240,176,112 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 16,0,0,0,0,0,0,1 
        dc.b 2,5,11,23,47,95,191,127 
        dc.b 252,252,252,252,252,252,252,252 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 31,31,63,95,63,122,116,0 
        dc.b 253,250,244,232,208,0,0,0 
        dc.b 2,4,2,6,6,6,2,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 3,3,3,7,11,7,15,15 
        dc.b 255,255,255,254,253,250,244,232 
        dc.b 209,160,64,129,0,1,1,1 
        dc.b 0,0,128,0,128,128,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 8,0,0,0,0,0,0,0 
        dc.b 1,2,5,11,23,47,95,191 
        dc.b 127,255,255,255,255,255,254,253 
        dc.b 128,128,254,253,160,64,128,0 
        dc.b 0,0,151,47,5,11,23,47 
        dc.b 15,15,239,255,255,255,255,255 
        dc.b 254,253,250,245,234,212,168,84 
        dc.b 160,96,192,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 2,5,11,7,7,7,11,7 
        dc.b 255,255,255,255,255,254,253,186 
        dc.b 252,238,221,162,64,128,0,0 
        dc.b 0,0,47,95,11,23,47,95 
        dc.b 0,0,255,255,255,255,255,254 
        dc.b 0,0,255,254,208,160,64,128 
        dc.b 0,0,72,151,15,5,11,23 
        dc.b 0,0,0,128,224,240,248,252 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 15,11,7,10,1,2,0,0 
        dc.b 208,160,64,128,0,0,0,1 
        dc.b 3,5,11,23,47,95,191,127 
        dc.b 128,128,128,128,128,128,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 1,2,5,11,7,15,15,15 
        dc.b 127,255,255,255,255,255,254,253 
        dc.b 250,244,232,209,160,64,129,0 
        dc.b 0,0,0,0,0,128,0,128 
        dc.b 95,11,22,0,0,0,0,0 
        dc.b 254,125,186,68,8,0,0,0 
        dc.b 136,3,3,3,5,11,23,47 
        dc.b 0,0,128,192,192,224,224,224 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 1,0,0,0,0,0,0,127 
        dc.b 64,0,0,0,0,0,0,165 
        dc.b 0,1,0,0,0,1,3,255 
        dc.b 191,127,47,94,0,0,128,0 
        dc.b 253,250,64,128,0,0,0,0 
        dc.b 0,0,0,1,2,5,3,7 
        dc.b 47,95,191,127,255,255,255,255 
        dc.b 252,254,254,254,246,238,212,162 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,1 
        dc.b 2,5,11,23,47,95,191,127 
        dc.b 255,255,255,255,255,255,253,251 
        dc.b 128,128,128,128,128,128,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 31,47,31,63,63,63,46,29 
        dc.b 250,244,232,208,160,64,128,0 
        dc.b 1,1,1,3,4,11,23,47 
        dc.b 128,160,160,160,248,255,255,255 
        dc.b 0,0,0,0,0,221,186,64 
        dc.b 0,0,1,2,5,11,23,47 
        dc.b 95,191,127,255,255,255,255,255 
        dc.b 240,240,240,240,240,240,176,96 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 127,40,80,0,0,0,0,0 
        dc.b 75,1,2,5,11,23,47,95 
        dc.b 254,127,255,255,255,255,255,255 
        dc.b 0,0,0,0,0,128,244,233 
        dc.b 0,0,0,0,0,0,191,127 
        dc.b 7,7,15,23,7,7,231,247 
        dc.b 255,254,253,250,244,232,208,160 
        dc.b 68,128,2,4,2,6,6,6 
        dc.b 0,0,0,0,0,0,128,128 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 2,1,227,67,131,231,11,231 
        dc.b 255,255,255,255,255,254,253,250 
        dc.b 245,232,209,160,64,129,0,1 
        dc.b 0,128,0,0,128,0,255,255 
        dc.b 0,0,0,0,0,0,255,255 
        dc.b 0,0,0,0,0,0,244,233 
        dc.b 0,0,0,0,0,0,191,127 
        dc.b 0,0,0,0,3,0,255,255 
        dc.b 0,128,128,128,224,128,192,192 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 42,4,8,0,0,0,0,0 
        dc.b 0,0,1,2,5,0,1,0 
        dc.b 95,191,127,255,255,189,122,0 
        dc.b 222,253,250,244,232,0,0,0 
        dc.b 128,0,1,2,5,0,1,0 
        dc.b 95,191,127,255,255,189,122,0 
        dc.b 254,253,250,245,235,6,4,0 
        dc.b 192,96,192,128,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 0,1,2,5,1,1,0,0 
        dc.b 191,127,255,255,255,122,244,0 
        dc.b 253,250,244,232,208,0,0,0 
        dc.b 0,0,0,1,2,0,0,0 
        dc.b 47,95,191,127,255,94,189,0 
        dc.b 255,254,253,250,244,128,0,0 
        dc.b 64,128,0,0,0,0,0,0 
        dc.b 14,27,44,124,248,48,0,0 
        dc.b 128,224,128,128,128,0,0,0 
        dc.b 0,0,0,0,0,0,0,0 
        dc.b 79,239,15,203,71,232,0,0 
        dc.b 244,232,208,160,64,0,0,0 
        dc.b 0,1,2,5,11,1,2,0 
        dc.b 191,127,255,255,255,122,244,0 
        dc.b 253,250,244,232,208,0,0,0 
        dc.b 0,0,0,1,2,0,0,0 
        dc.b 47,95,191,127,255,90,180,0 
        dc.b 253,250,244,232,208,0,0,0 
        dc.b 64,128,64,128,0,64,0,0 
        dc.b 0,0,0,0,0,0,0,0 



	dc.b	0
CHAR	