					Jormungandr


				;	#LoROM

				;	# Constants ========================= Size ====
				;	#Name $0100 SNAKE_LENGTH_MIN
				;	#Name $0010 SNAKE_LENGTH_DELTA
				;	#Name $4000 SNAKE_LENGTH_MAX
				;	#Name $0004 SNAKE_RATE_DEAD
				;	#Name $0008 GAUGE_DISCHARGE_RATE

				;	# SNES Registers ==================== Size ====
				;	#Name $2100 INIDISP		b
				;	#Name $2101 OBJSEL		b
				;	#Name $2102 OAMADD		w
				;	#Name $2104 OAMDATA		b,LH
				;	#Name $2105 BGMODE		b
				;	#Name $2106 MOSAIC		b
				;	#Name $2107 BG1SC		b
				;	#Name $2108 BG2SC		b
				;	#Name $2109 BG3SC		b
				;	#Name $210A BG4SC		b
				;	#Name $210B BG12NBA		b
				;	#Name $210C BG34NBA		b
				;	#Name $210D BG1HOFS		b,LH
				;	#Name $210E BG1VOFS		b,LH
				;	#Name $210F BG2HOFS		b,LH
				;	#Name $2110 BG2VOFS		b,LH
				;	#Name $2111 BG3HOFS		b,LH
				;	#Name $2112 BG3VOFS		b,LH
				;	#Name $2113 BG4HOFS		b,LH
				;	#Name $2114 BG4VOFS		b,LH
				;	#Name $2115 VMAINC		b
				;	#Name $2116 VMADD		w
				;	#Name $2118 VMDATA		w
				;	#Name $211A M7SEL		b
				;	#Name $211B M7A		b,LH
				;	#Name $211C M7B		b,LH
				;	#Name $211D M7C		b,LH
				;	#Name $211E M7D		b,LH
				;	#Name $211F M7X		b,LH
				;	#Name $2120 M7Y		b,LH
				;	#Name $2121 CGADD		b
				;	#Name $2122 CGDATA		b,LH
				;	#Name $2123 W12SEL		b
				;	#Name $2124 W34SEL		b
				;	#Name $2125 WOBJSEL		b
				;	#Name $2126 WH0		b
				;	#Name $2127 WH1		b
				;	#Name $2128 WH2		b
				;	#Name $2129 WH3		b
				;	#Name $212A WBGLOG		b
				;	#Name $212B WOBJLOG		b
				;	#Name $212C TM		b
				;	#Name $212D TS		b
				;	#Name $212E TMW_		b
				;	#Name $212F TSW_		b
				;	#Name $2130 CGSWSEL		b
				;	#Name $2131 CGADSUB		b
				;	#Name $2132 COLDATA		b
				;	#Name $2133 SETINI		b
				;	#Name $2134 RDMPY24		l,ro
				;	#Name $2137 SLHV		b,ro
				;	#Name $2138 RDOAMDATA		b,ro,LH
				;	#Name $2139 RDVMDATA		w,ro
				;	#Name $213B RDCGDATA		b,ro,LH
				;	#Name $213C OPHCT		b,ro,LH
				;	#Name $213D OPVCT		b,ro,LH
				;	#Name $213E STAT77		b,ro
				;	#Name $213F STAT78		b,ro
				;	#Name $2140 APUIO0		b
				;	#Name $2141 APUIO1		b
				;	#Name $2142 APUIO2		b
				;	#Name $2143 APUIO3		b
				;	#Name $2180 WMDATA		b
				;	#Name $2181 WMADD		l
				;	#Name $4016 JOYIO		w
				;	#Name $4200 NMITIMEN		b
				;	#Name $4201 WRIO		b
				;	#Name $4202 WRMPYA		b
				;	#Name $4203 WRMPYB		b
				;	#Name $4204 WRDIVA		w
				;	#Name $4206 WRDIVB		b
				;	#Name $4207 HTIME		w
				;	#Name $4209 VTIME		w
				;	#Name $420B MDMAEN		b
				;	#Name $420C HDMAEN		b
				;	#Name $420D MEMSEL		b
				;	#Name $4210 RDNMI		b,ro
				;	#Name $4211 TIMEUP		b,ro
				;	#Name $4212 HVBJOY		b,ro
				;	#Name $4213 RDIO		b,ro
				;	#Name $4214 RDDIV		w,ro
				;	#Name $4216 RDMPY16		w,ro
				;	#Name $4218 JOY1		w
				;	#Name $421A JOY2		w
				;	#Name $421C JOY3		w
				;	#Name $421E JOY4		w
				;	#Name $4300 DMAP		b
				;	#Name $4301 DMAB		b
				;	#Name $4302 DMAA		l
				;	#Name $4305 DMAD		l
				;	#Name $4308 DMAI		w
				;	#Name $430A DMAL		b
				;	#Name $4300 DMAP0		b
				;	#Name $4301 DMAB0		b
				;	#Name $4302 DMAA0		l
				;	#Name $4305 DMAD0		l
				;	#Name $4308 DMAI0		w
				;	#Name $430A DMAL0		b
				;	#Name $4310 DMAP1		b
				;	#Name $4311 DMAB1		b
				;	#Name $4312 DMAA1		l
				;	#Name $4315 DMAD1		l
				;	#Name $4318 DMAI1		w
				;	#Name $431A DMAL1		b
				;	#Name $4320 DMAP2		b
				;	#Name $4321 DMAB2		b
				;	#Name $4322 DMAA2		l
				;	#Name $4325 DMAD2		l
				;	#Name $4328 DMAI2		w
				;	#Name $432A DMAL2		b
				;	#Name $4330 DMAP3		b
				;	#Name $4331 DMAB3		b
				;	#Name $4332 DMAA3		l
				;	#Name $4335 DMAD3		l
				;	#Name $4338 DMAI3		w
				;	#Name $433A DMAL3		b
				;	#Name $4340 DMAP4		b
				;	#Name $4341 DMAB4		b
				;	#Name $4342 DMAA4		l
				;	#Name $4345 DMAD4		l
				;	#Name $4348 DMAI4		w
				;	#Name $434A DMAL4		b
				;	#Name $4350 DMAP5		b
				;	#Name $4351 DMAB5		b
				;	#Name $4352 DMAA5		l
				;	#Name $4355 DMAD5		l
				;	#Name $4358 DMAI5		w
				;	#Name $435A DMAL5		b
				;	#Name $4360 DMAP6		b
				;	#Name $4361 DMAB6		b
				;	#Name $4362 DMAA6		l
				;	#Name $4365 DMAD6		l
				;	#Name $4368 DMAI6		w
				;	#Name $436A DMAL6		b
				;	#Name $4370 DMAP7		b
				;	#Name $4371 DMAB7		b
				;	#Name $4372 DMAA7		l
				;	#Name $4375 DMAD7		l
				;	#Name $4378 DMAI7		w
				;	#Name $437A DMAL7		b



				;	# WRAM $7E:0000-$7F:FFFF ======================

				;	# Direct Page ======================= Size ====
				;	#Name $00 scratch_pad		$10
				;	#Name $10 inidisp		b
				;	#Name $11 objsel		b
				;	#Name $12 oamadd		w
				;	#Name $14 bgmode		b
				;	#Name $15 mosaic		b
				;	#Name $16 bg1sc		b
				;	#Name $17 bg2sc		b
				;	#Name $18 bg3sc		b
				;	#Name $19 bg4sc		b
				;	#Name $1A bg12nba		b
				;	#Name $1B bg34nba		b
				;	#Name $1C bg1hofs		w
				;	#Name $1E bg1vofs		w
				;	#Name $20 bg2hofs		w
				;	#Name $22 bg2vofs		w
				;	#Name $24 bg3hofs		w
				;	#Name $26 bg3vofs		w
				;	#Name $28 bg4hofs		w
				;	#Name $2A bg4vofs		w
				;	#Name $2C vmainc		b
				;	#Name $2D vmadd		w
				;	#Name $2F m7sel		b
				;	#Name $30 m7a		w
				;	#Name $32 m7b		w
				;	#Name $34 m7c		w
				;	#Name $36 m7d		w
				;	#Name $38 m7x		w
				;	#Name $3A m7y		w
				;	#Name $3C cgadd		b
				;	#Name $3D w12sel		b
				;	#Name $3E w34sel		b
				;	#Name $3F wobjsel		b
				;	#Name $40 wh0		b
				;	#Name $41 wh1		b
				;	#Name $42 wh2		b
				;	#Name $43 wh3		b
				;	#Name $44 wbglog		b
				;	#Name $45 wobjlog		b
				;	#Name $46 tm		b
				;	#Name $47 ts		b
				;	#Name $48 tmw		b
				;	#Name $49 tsw		b
				;	#Name $4A cgswsel		b
				;	#Name $4B cgadsub		b
				;	#Name $4C coldata_blue		b
				;	#Name $4D coldata_green		b
				;	#Name $4E coldata_red		b
				;	#Name $4F setini		b
				;	#Name $50 ophct		w
				;	#Name $52 opvct		w
				;	#Name $54 stat77		b
				;	#Name $55 stat78		b
				;	#Name $56 apuio0		b
				;	#Name $57 apuio1		b
				;	#Name $58 apuio2		b
				;	#Name $59 apuio3		b
				;	#Name $5A wmadd		l
				;	#Name $5D nmitimen		b
				;	#Name $5E wrio		b
				;	#Name $5F htime		w
				;	#Name $61 vtime		w
				;	#Name $63 mdmaen		b
				;	#Name $64 hdmaen		b
				;	#Name $65 memsel		b
				;	#Name $66 rdnmi		b
				;	#Name $67 timeup		b
				;	#Name $68 hvbjoy		b
				;	#Name $69 rdio		b
				;	#Name $006A joy		w[4]
				;	#Name $6A joy1		w
				;	#Name $6C joy2		w
				;	#Name $6E joy3		w
				;	#Name $70 joy4		w

				;	#Name $0072 joy.last		w[4]
				;	#Name $72 joy1.last		w
				;	#Name $74 joy2.last		w
				;	#Name $76 joy3.last		w
				;	#Name $78 joy4.last		w
				;	#Name $007A joy.edge		w[4]
				;	#Name $7A joy1.edge		w
				;	#Name $7C joy2.edge		w
				;	#Name $7E joy3.edge		w
				;	#Name $80 joy4.edge		w
				;	#Name $0082 joy.hold		b[4]
				;	#Name $82 joy1.hold		b
				;	#Name $83 joy2.hold		b
				;	#Name $84 joy3.hold		b
				;	#Name $85 joy4.hold		b
				;	#Name $0086 joy.cool		b[4]
				;	#Name $86 joy1.cool		b
				;	#Name $87 joy2.cool		b
				;	#Name $88 joy3.cool		b
				;	#Name $89 joy4.cool		b

				;	#Name $8A Nmi.ready		b
				;	#Name $8B Nmi.count		w
				;	#Name $8D Nmi.HDMA.data		l
				;	#Name $90 Nmi.VRAM_DMA.data		l
				;	#Name $93 Nmi.VRAM_DMA.data_i		w
				;	#Name $95 Nmi.VRAM_Write.table_i		w

				;	#Name $97 irq_program		l

				;	#Name $9A Main.count		w
				;	#Name $9C Main.program		w
				;	#Name $9E Sub.program		w

				;	#Name $A0 oam_i		w
				;	#Name $A2 oam2_byte_i		b
				;	#Name $A3 oam2_bit_i		b

				;	#Name $A6 Rng.number		w
				;	#Name $A8 pause		b
				;	#Name $AA Ship.Death.blossom		w
				;	#Name $AC ship_index		w
				;	#Name $AE Snake_Tail.i		w

				;	#Name $00C0 ship_1		$20
				;	#Name $C0 ship_1.status		w	// 0=Ghost, 1=Alive, 2=Death, 3=Dead
				;	#Name $C2 ship_1.timer		w	// Ghost=>status,Alive=>weapon,Dead=>status
				;	#Name $C4 ship_1.deaths		w	// Deaths
				;	#Name $C6 ship_1.charge		w	// Max 0x10
				;	#Name $C8 ship_1.polarity		w	// F=Red, T=Blue
				;	#Name $CA ship_1.length		w	// Snake pixel length
				;	#Name $CC ship_1.snake_r		w	// Snake read pointer
				;	#Name $CE ship_1.snake_w		w	// Snake write pointer
				;	#Name $D0 ship_1.render		w	// F=Hide, T=Draw
				;	#Name $D2 ship_1.x		w	// 0xII.FF
				;	#Name $D4 ship_1.y		w	// 0xII.FF
				;	#Name $D6 ship_1.x_last		w	// 0xII.FF
				;	#Name $D8 ship_1.y_last		w	// 0xII.FF
				;	#Name $DA ship_1.v		w	// 0xII.FF
				;	#Name $DC ship_1.direction		w	// 0=Right, 1=Down, 2=Left, 3=Up
				;	#Name $DE ship_1.weapon		w	// 0=Lengthen, 1=Wall

				;	#Name $00E0 ship_2		$20
				;	#Name $E0 ship_2.status		w
				;	#Name $E2 ship_2.timer		w
				;	#Name $E4 ship_2.deaths		w
				;	#Name $E6 ship_2.charge		w
				;	#Name $E8 ship_2.polarity		w
				;	#Name $EA ship_2.length		w
				;	#Name $EC ship_2.snake_r		w
				;	#Name $EE ship_2.snake_w		w
				;	#Name $F0 ship_2.render		w
				;	#Name $F2 ship_2.x		w
				;	#Name $F4 ship_2.y		w
				;	#Name $F6 ship_2.x_last		w
				;	#Name $F8 ship_2.y_last		w
				;	#Name $FA ship_2.v		w
				;	#Name $FC ship_2.direction		w
				;	#Name $FE ship_2.weapon		w

				;	# Structures ======================== Size ====
				;	#Name $00 ship.status		w
				;	#Name $02 ship.timer		w
				;	#Name $04 ship.deaths		w
				;	#Name $06 ship.charge		w
				;	#Name $08 ship.polarity		w
				;	#Name $0A ship.length		w
				;	#Name $0C ship.snake_r		w
				;	#Name $0E ship.snake_w		w
				;	#Name $10 ship.render		w
				;	#Name $12 ship.x		w
				;	#Name $14 ship.y		w
				;	#Name $16 ship.x_last		w
				;	#Name $18 ship.y_last		w
				;	#Name $1A ship.v		w
				;	#Name $1C ship.direction		w
				;	#Name $1E ship.weapon		w

				;	# Scratch Pad ======================= Size ====

				;	#Name $00 Plot.x		w
				;	#Name $02 Plot.y		w
				;	#Name $04 Plot.bitmap_i		w
				;	#Name $06 Plot.trailmap_i		w
				;	#Name $08 Plot.color		w

				;	#Name $00 Bitmap_Index.x		w
				;	#Name $02 Bitmap_Index.y		w
				;	#Name $04 Bitmap_Index.i		w

				;	#Name $00 Trailmap_Index.x		w
				;	#Name $02 Trailmap_Index.y		w
				;	#Name $04 Trailmap_Index.i		w

				;	#Name $00 Multiply_16.m1		w
				;	#Name $02 Multiply_16.m2		w
				;	#Name $04 Multiply_16.p		w

				;	#Name $00 Divide_16.n		w	// Numerator
				;	#Name $02 Divide_16.d		w	// Denomenator
				;	#Name $04 Divide_16.q		w	// Quotient
				;	#Name $08 Divide_16.r		w	// Remainder

				;	#Name $00 Draw_Sprite.data_i		l
				;	#Name $02 Draw_Sprite.data_bank		b
				;	#Name $03 Draw_Sprite.obj_count		b
				;	#Name $04 Draw_Sprite.x		b
				;	#Name $05 Draw_Sprite.y		b
				;	#Name $06 Draw_Sprite.char_i		w
				;	#Name $08 Draw_Sprite.obj_p_override		b


				;	# WRAM $7E:0000-$7E:2000============= Size ====
				;	#Name $0100 oam		$200
				;	#Name $0100 oam.x		b
				;	#Name $0101 oam.y		b
				;	#Name $0102 oam.c		b
				;	#Name $0103 oam.p		b
				;	#Name $0300 oam2		$20

				;	#Name $0320 cgram		$200

				;	#Name $0520 Nmi.VRAM_Write.table		$E0
				;	#Name $0520 Nmi.VRAM_Write.addr		w
				;	#Name $0522 Nmi.VRAM_Write.data		w

				;	#Name $0600 fragment		0x10 [0x80]
				;	#Name $0600 fragment.active		w
				;	#Name $0602 fragment.polarity		w
				;	#Name $0604 fragment.x		w
				;	#Name $0606 fragment.y		w
				;	#Name $0608 fragment.vx		w
				;	#Name $060A fragment.vy		w



				;	# WRAM $7E:2000-$7E:FFFF============= Size ====
				;	#Name $2000 snake_1		w[0x2000]
				;	#Name $6000 snake_2		w[0x2000]
				;	#Name $C000 bitmap		w[0x2000]

				;	# WRAM $7F:0000-$7F:FFFF============= Size ====
				;	#Name $0000 trailmap		b[0x10000]

				;	#Code w RESET_Vector
				;	#Code w NMI_Vector
				;	#Code w IRQ_Vector
				;	#Code l Reset
				;	#Code w Reset.Registers
				;	#Code w Reset.VRAM
				;	#Code w Reset.OAM
				;	#Code w Reset.CGRAM
				;	#Code w Reset.APU

				;	#Code l Nmi.Wait
				;	#Code l Nmi
				;	#Code w Nmi.Registers
				;	#Code w Nmi.HDMA
				;	#Code w Nmi.VRAM_DMA
				;	#Code w Nmi.VRAM_Write

				;	#Code l Irq

				;	#Code l Main
				;	#Data w Main.programs
				;	#Code w Engine.Initiate
				;	#Code w Engine.Fadein
				;	#Code w Engine.Run
				;	#Code w Test_Joy
				;	#Code w Pause
				;	#Code w Ship
				;	#Data w Ship.programs
				;	#Code w Ship.Ghost
				;	#Code w Ship.Live
				;	#Code w Ship.Death
				;	#Code w Ship.Dead
				;	#Code w Snake_Tail
				;	#Code w Collision
				;	#Code w Snake_Head
				;	#Code w Plot
				;	#Code w Bitmap_Index
				;	#Code w Trailmap_Index
				;	#Code w Update_Fragment
				;	#Code w Update_Cgram
				;	#Code w Update_Frame
				;	#Code w Clear_Bitmap

				;	#Code l Multiply_16
				;	#Code l Divide
				;	#Code l Immediate_DMA
				;	#Code l Ready_Oam
				;	#Code l Hide_Unused_Oam
				;	#Code l Draw_Sprite
				;	#Code l Rng

				;	#Data w ship_1_sprite
				;	#Data w ship_2_sprite
				;	#Data w fragment_sprite
				;	#Data l sinusoid
				;	#Data l char_set
				;	#Data l frame_map
				;	#Data l floor_map
				;	#Data l trail_map
				;	#Data l color_set
				;	#Data l rom_header
				;	#Data l vector_table


				;	# Program ===========================



				;	#Code w {RESET_Vector}
				;	SEI
				;	CLC
				;	XCE
				;	JML	Reset

				;	#Code w {NMI_Vector}
				;	JML	Nmi

				;	#Code w {IRQ_Vector}
				;	JML	Reset

				;	#Code l {Reset}
				;	REP	#$38
				;	PHK
				;	PLB
				;	LDA	#$0000
				;	TCD
				;	LDX	#$1FFF
				;	TXS
				;	JSR	Reset.Registers
				;	JSR	Reset.VRAM
				;	JSR	Reset.OAM
				;	JSR	Reset.CGRAM
				;	JSR	Reset.APU
				;	LDA	#$0000	// Clear.WRAM
				;	LDX	#$4000
		;	{-}	;	DEX
				;	DEX
				;	STA	$7E:0000,X
				;	STA	$7E:4000,X
				;	STA	$7E:8000,X
				;	STA	$7E:C000,X
				;	STA	$7F:0000,X
				;	STA	$7F:4000,X
				;	STA	$7F:8000,X
				;	STA	$7F:C000,X
				;	BNE	{-}
				;	TAX
				;	TAY
				;	JML	Main

				;	#Code w {Reset.Registers}
				;	PHP
				;	SEP	#$20
				;	LDA	#$00
				;	STA	MEMSEL
				;	LDA	#$80
				;	STA	INIDISP
				;	STZ	OBJSEL
				;	STZ	OAMADD.l
				;	STZ	OAMADD.h
				;	STZ	BGMODE
				;	STZ	MOSAIC
				;	STZ	BG1SC
				;	STZ	BG2SC
				;	STZ	BG3SC
				;	STZ	BG4SC
				;	STZ	BG12NBA
				;	STZ	BG34NBA
				;	STZ	BG1HOFS
				;	STZ	BG1HOFS
				;	STZ	BG1VOFS
				;	STZ	BG1VOFS
				;	STZ	BG2HOFS
				;	STZ	BG2HOFS
				;	STZ	BG2VOFS
				;	STZ	BG2VOFS
				;	STZ	BG3HOFS
				;	STZ	BG3HOFS
				;	STZ	BG3VOFS
				;	STZ	BG3VOFS
				;	STZ	BG4HOFS
				;	STZ	BG4HOFS
				;	STZ	BG4VOFS
				;	STZ	BG4VOFS
				;	STZ	VMAINC
				;	STZ	VMADD.l
				;	STZ	VMADD.h
				;	STZ	M7SEL
				;	STZ	M7A
				;	STZ	M7A
				;	STZ	M7B
				;	STZ	M7B
				;	STZ	M7C
				;	STZ	M7C
				;	STZ	M7D
				;	STZ	M7D
				;	STZ	M7X
				;	STZ	M7X
				;	STZ	M7Y
				;	STZ	M7Y
				;	STZ	CGADD
				;	STZ	W12SEL
				;	STZ	W34SEL
				;	STZ	WOBJSEL
				;	STZ	WH0
				;	STZ	WH1
				;	STZ	WH2
				;	STZ	WH3
				;	STZ	WBGLOG
				;	STZ	WOBJLOG
				;	STZ	TM
				;	STZ	TS
				;	STZ	TMW_
				;	STZ	TSW_
				;	STZ	CGSWSEL
				;	STZ	CGADSUB
				;	STZ	COLDATA
				;	STZ	SETINI
				;	LDA	STAT78
				;	STZ	WMADD.l
				;	STZ	WMADD.h
				;	STZ	WMADD.b
				;	STZ	NMITIMEN
				;	STZ	WRIO
				;	STZ	WRMPYA
				;	STZ	WRMPYB
				;	STZ	WRDIVA.l
				;	STZ	WRDIVA.h
				;	STZ	WRDIVB
				;	STZ	HTIME.l
				;	STZ	HTIME.h
				;	STZ	VTIME.l
				;	STZ	VTIME.h
				;	STZ	MDMAEN
				;	STZ	HDMAEN
				;	LDA	RDNMI
				;	LDA	TIMEUP
				;	PLP
				;	RTS

				;	#Code w {Reset.VRAM}
				;	PHP
				;	SEP	#$20
				;	LDA	#$80
				;	STA	VMAINC
				;	REP	#$20
				;	STZ	VMADD
				;	JSL	Immediate_DMA
				;	#Data {$09 $18 $80:FFF0 $0000}
				;	PLP
				;	RTS

				;	#Code w {Reset.OAM}
				;	PHP
				;	REP	#$20
				;	STZ	OAMADD
				;	JSL	Immediate_DMA
				;	#Data {$0A $04 $80:FFF0 $0220}
				;	PLP
				;	RTS

				;	#Code w {Reset.CGRAM}
				;	PHP
				;	SEP	#$20
				;	STZ	CGADD
				;	JSL	Immediate_DMA
				;	#Data {$0A $22 $80:FFF0 $0200}
				;	PLP
				;	RTS

				;	#Code w {Reset.APU}
				;	RTS









				;	# NMI ===============================



				;	#Code l {Nmi.Wait}
				;	PHP
				;	SEP	#$20
				;	LDA	#$FF
				;	STA	Nmi.ready
		;	{Wait}	;	LDA	Nmi.ready
				;	BNE	{Wait}
				;	PLP
				;	RTL

				;	#Code l {Nmi}
				;	SEI
				;	PHA
				;	PHX
				;	PHY
				;	PHP
				;	PHB
				;	PHK
				;	PLB
				;	SEP	#$20
				;	LDA	Nmi.ready
				;	BEQ	{+}
				;	STZ	CGADD
				;	JSL	Immediate_DMA
				;	#Data {$02 $22 $7E:0320 $0200}
				;	REP	#$20
				;	LDA	#$8000
				;	STA	OAMADD
				;	JSL	Immediate_DMA
				;	#Data {$02 $04 $7E:0100 $0220}
				;	JSR	Nmi.Registers
				;	JSR	Nmi.HDMA
				;	JSR	Nmi.VRAM_DMA
				;	JSR	Nmi.VRAM_Write
				;	INC	Nmi.count
				;	SEP	#$20
				;	STZ	Nmi.ready
		;	{+}	;	PLB
				;	PLP
				;	PLY
				;	PLX
				;	PLA
				;	CLI
				;	RTI

				;	#Code w {Nmi.Registers}
				;	PHP
				;	SEP	#$20
				;	LDA	inidisp
				;	STA	INIDISP
				;	LDA	objsel
				;	STA	OBJSEL
				;	LDA	bgmode
				;	STA	BGMODE
				;	LDA	mosaic
				;	STA	MOSAIC
				;	LDA	bg1sc
				;	STA	BG1SC
				;	LDA	bg2sc
				;	STA	BG2SC
				;	LDA	bg3sc
				;	STA	BG3SC
				;	LDA	bg4sc
				;	STA	BG4SC
				;	LDA	bg12nba
				;	STA	BG12NBA
				;	LDA	bg34nba
				;	STA	BG34NBA
				;	LDA	bg1hofs.l
				;	STA	BG1HOFS
				;	LDA	bg1hofs.h
				;	STA	BG1HOFS
				;	LDA	bg1vofs.l
				;	STA	BG1VOFS
				;	LDA	bg1vofs.h
				;	STA	BG1VOFS
				;	LDA	bg2hofs.l
				;	STA	BG2HOFS
				;	LDA	bg2hofs.h
				;	STA	BG2HOFS
				;	LDA	bg2vofs.l
				;	STA	BG2VOFS
				;	LDA	bg2vofs.h
				;	STA	BG2VOFS
				;	LDA	bg3hofs.l
				;	STA	BG3HOFS
				;	LDA	bg3hofs.h
				;	STA	BG3HOFS
				;	LDA	bg3vofs.l
				;	STA	BG3VOFS
				;	LDA	bg3vofs.h
				;	STA	BG3VOFS
				;	LDA	bg4hofs.l
				;	STA	BG4HOFS
				;	LDA	bg4hofs.h
				;	STA	BG4HOFS
				;	LDA	bg4vofs.l
				;	STA	BG4VOFS
				;	LDA	bg4vofs.h
				;	STA	BG4VOFS
				;	LDA	vmainc
				;	STA	VMAINC
				;	LDA	m7sel
				;	STA	M7SEL
				;	LDA	m7a.l
				;	STA	M7A
				;	LDA	m7a.h
				;	STA	M7A
				;	LDA	m7b.l
				;	STA	M7B
				;	LDA	m7b.h
				;	STA	M7B
				;	LDA	m7c.l
				;	STA	M7C
				;	LDA	m7c.h
				;	STA	M7C
				;	LDA	m7d.l
				;	STA	M7D
				;	LDA	m7d.h
				;	STA	M7D
				;	LDA	m7x.l
				;	STA	M7X
				;	LDA	m7x.h
				;	STA	M7X
				;	LDA	m7y.l
				;	STA	M7Y
				;	LDA	m7y.h
				;	STA	M7Y
				;	LDA	w12sel
				;	STA	W12SEL
				;	LDA	w34sel
				;	STA	W34SEL
				;	LDA	wobjsel
				;	STA	WOBJSEL
				;	LDA	wh0
				;	STA	WH0
				;	LDA	wh1
				;	STA	WH1
				;	LDA	wh2
				;	STA	WH2
				;	LDA	wh3
				;	STA	WH3
				;	LDA	wbglog
				;	STA	WBGLOG
				;	LDA	wobjlog
				;	STA	WOBJLOG
				;	LDA	tm
				;	STA	TM
				;	LDA	ts
				;	STA	TS
				;	LDA	tmw
				;	STA	TMW_
				;	LDA	tsw
				;	STA	TSW_
				;	LDA	cgswsel
				;	STA	CGSWSEL
				;	LDA	cgadsub
				;	STA	CGADSUB
				;	LDA	coldata_blue
				;	STA	COLDATA
				;	LDA	coldata_green
				;	STA	COLDATA
				;	LDA	coldata_red
				;	STA	COLDATA
				;	LDA	setini
				;	STA	SETINI
				;	LDA	STAT77
				;	STA	stat77
				;	LDA	STAT78
				;	STA	stat78
				;	LDA	nmitimen
				;	STA	NMITIMEN
				;	LDA	wrio
				;	STA	WRIO
				;	LDA	htime.l
				;	STA	HTIME.l
				;	LDA	htime.h
				;	STA	HTIME.h
				;	LDA	vtime.l
				;	STA	VTIME.l
				;	LDA	vtime.h
				;	STA	VTIME.h
				;	LDA	memsel
				;	STA	MEMSEL
				;	LDA	RDNMI
				;	STA	rdnmi
				;	LDA	TIMEUP
				;	STA	timeup
				;	LDA	RDIO
				;	STA	rdio
		;	{Wait}	;	LDA	HVBJOY
				;	STA	hvbjoy
				;	AND	#$01
				;	BNE	{Wait}
				;	REP	#$20
				;	LDA	joy1
				;	STA	joy1.last
				;	LDA	joy2
				;	STA	joy2.last
				;	LDA	joy3
				;	STA	joy3.last
				;	LDA	joy4
				;	STA	joy4.last
				;	LDA	JOY1
				;	STA	joy1
				;	LDA	JOY2
				;	STA	joy2
				;	LDA	JOY3
				;	STA	joy3
				;	LDA	JOY4
				;	STA	joy4
				;	PLP
				;	RTS

				;	#Code w {Nmi.HDMA}
				;	PHP
				;	SEP	#$10
				;	LDX	#$10
				;	LDY	#$00
		;	{-}	;	REP	#$20
				;	LDA	[Nmi.HDMA.data],Y
				;	CMP	#$0000
				;	BEQ	{+}
				;	STA	DMAP,X
				;	INY
				;	INY
				;	LDA	[Nmi.HDMA.data],Y
				;	INY
				;	INY
				;	STA	DMAA.l,X
				;	LDA	[Nmi.HDMA.data],Y
				;	INY
				;	INY
				;	STA	DMAA.b,X
				;	LDA	[Nmi.HDMA.data],Y
				;	INY
				;	INY
				;	STA	DMAD,X
		;	{+}	;	SEP	#$20
				;	TXA
				;	CLC
				;	ADC	#$10
				;	CMP	#$80
				;	BEQ	{+}
				;	TAX
				;	BRA	{-}
		;	{+}	;	LDA	hdmaen
				;	STA	HDMAEN
				;	PLP
				;	RTS

				;	#Code w {Nmi.VRAM_DMA}
				;	PHP
		;	{-}	;	REP	#$30
				;	LDA	Nmi.VRAM_DMA.data_i
				;	BEQ	{+}
				;	SEC
				;	SBC	#$000A
				;	STA	Nmi.VRAM_DMA.data_i
				;	TAY
				;	SEP	#$20
				;	LDA	[Nmi.VRAM_DMA.data],Y
				;	INY
				;	STA	VMAINC
				;	REP	#$20
				;	LDA	[Nmi.VRAM_DMA.data],Y
				;	INY
				;	INY
				;	STA	VMADD
				;	LDA	[Nmi.VRAM_DMA.data],Y
				;	INY
				;	INY
				;	STA	DMAP
				;	LDA	[Nmi.VRAM_DMA.data],Y
				;	INY
				;	INY
				;	STA	DMAA.l
				;	LDA	[Nmi.VRAM_DMA.data],Y
				;	INY
				;	INY
				;	STA	DMAA.b
				;	SEP	#$20
				;	LDA	[Nmi.VRAM_DMA.data],Y
				;	STA	DMAD
				;	LDA	#$01
				;	STA	MDMAEN
				;	BRA	{-}
		;	{+}	;	PLP
				;	RTS

				;	#Code w {Nmi.VRAM_Write}
				;	PHP
				;	REP	#$20
				;	LDA	Nmi.VRAM_Write.table_i
				;	BEQ	{+}
				;	SEP	#$20
				;	LDA	#$80
				;	STA	VMAINC
				;	REP	#$30
				;	LDX	#$0000
		;	{-}	;	LDA	Nmi.VRAM_Write.addr,X
				;	STA	VMADD
				;	LDA	Nmi.VRAM_Write.data,X
				;	STA	VMDATA
				;	INX
				;	INX
				;	INX
				;	INX
				;	CPX	Nmi.VRAM_Write.table_i
				;	BNE	{-}
				;	STZ	Nmi.VRAM_Write.table_i
		;	{+}	;	PLP
				;	RTS









				;	# Main Program ======================


				;	#Code l {Main}
				;	REP	#$30
		;	{Loop}	;	LDA	Main.program
				;	ASL	A
				;	TAX
				;	JSR	(Main.programs,X)
				;	INC	Main.count
				;	BRA	{Loop}
				;	#Data w Main.programs
				{
					Engine.Initiate
					Engine.Fadein
					Engine.Run
				}

				;	#Code w {Engine.Initiate}
				;	PHP
				;	PHB
				;
				;	PHK		// Load Graphics
				;	PLB
				;	SEP	#$20
				;	LDA	#$80
				;	STA	VMAINC
				;	REP	#$30
				;	LDA	#$0000
				;	STA	VMADD
				;	JSL	Immediate_DMA
				;	#Data {$01 $18 frame_map $0800}
				;	LDA	#$0400
				;	STA	VMADD
				;	JSL	Immediate_DMA
				;	#Data {$01 $18 floor_map $0800}
				;	LDA	#$0800
				;	STA	VMADD
				;	JSL	Immediate_DMA
				;	#Data {$01 $18 trail_map $0800}
				;	LDA	#$1000
				;	STA	VMADD
				;	JSL	Immediate_DMA
				;	#Data {$01 $18 char_set $1000}
				;	LDA	#$7E03
				;	STA	WMADD.h
				;	LDA	#$0320
				;	STA	WMADD.l
				;	JSL	Immediate_DMA
				;	#Data {$00 $80 color_set $0200}
				;
				;	LDA	#$000D	// Seed RNG
				;	STA	Rng.number
				;
				;	LDX	#ship_1	// Initiate ship common
				;	BRA	{+ship_1}
		;	{-ship_2}	;	LDX	#ship_2
		;	{+ship_1}	;	LDA	#$002D
				;	STA	ship.timer,X
				;	STZ	ship.length,X
				;	STZ	ship.snake_r,X
				;	STZ	ship.snake_w,X
				;	LDA	#$0100
				;	STA	ship.v,X
				;	CPX	#ship_2
				;	BNE	{-ship_2}
				;
				;	LDA	#$0000	// Initiate ship 1
				;	STA	ship_1.polarity,X
				;	LDA	#$2700
				;	STA	ship_1.x
				;	STA	ship_1.x_last
				;	LDA	#$3800
				;	STA	ship_1.y
				;	STA	ship_1.y_last
				;	LDA	#$0000
				;	STA	ship_1.direction
				;
				;	LDA	#$FFFF	// Initiate ship 2
				;	STA	ship_2.polarity
				;	LDA	#$D800
				;	STA	ship_2.x
				;	STA	ship_2.x_last
				;	LDA	#$B700
				;	STA	ship_2.y
				;	STA	ship_2.y_last
				;	LDA	#$0002
				;	STA	ship_2.direction
				;
				;	SEP	#$20	// Initiate registers
				;	LDA	#$09
				;	STA	bgmode
				;	LDA	#$00
				;	STA	bg1sc
				;	LDA	#$04
				;	STA	bg2sc
				;	LDA	#$08
				;	STA	bg3sc
				;	LDA	#$11
				;	STA	bg12nba
				;	LDA	#$02
				;	STA	bg34nba
				;	LDA	#$17
				;	STA	tm
				;	LDA	#$81
				;	STA	nmitimen
				;	STA	NMITIMEN
				;	LDA	#$00
				;	STA	inidisp
				;	STA	INIDISP
				;	CLI
				;
				;	REP	#$20	// Engine.Fadein
				;	INC	Main.program
				;
				;	PLB
				;	PLP
				;	RTS

				;	#Code w {Engine.Fadein}
				;	PHP
				;	SEP	#$20
					LDA	Main.count	// Investigate DEBUG
					AND	#$10
					BEQ	{+}
				;	LDA	inidisp
				;	INC	A
				;	AND	#$0F
				;	STA	inidisp
				;	CMP	#$0F
				;	BNE	{+}
				;	INC	Main.program	// Engine.Run
		;	{+}	;	JSR	Test_Joy
				;	JSR	Update_Cgram
				;	LDA	#$FF
				;	STA	Nmi.ready
				;	JSL	Nmi.Wait
				;	REP	#$20
				;	STZ	pause
				;	PLP
				;	RTS

				;	#Code w {Engine.Run}
				;	PHP
				;	SEP	#$20
				;
				;	JSR	Test_Joy
				;	LDA	pause
				;	BEQ	{+Go}
				;
				;	LDA	#$09
				;	STA	inidisp
				;	JSR	Pause
				;	BRA	{Done}
				;
		;	{+Go}	;	LDA	#$0F
				;	STA	inidisp
				;	JSL	Ready_Oam
				;	JSL	Rng
				;	JSR	Ship
				;	JSR	Snake_Tail
				;	JSR	Collision
				;	JSR	Snake_Head
				;	JSR	Update_Fragment
				;	JSR	Update_Cgram
				;	JSR	Update_Frame
				;	JSL	Hide_Unused_Oam
				;
				;	LDA	#$FF
				;	STA	Nmi.ready
		;	{Done}	;	JSL	Nmi.Wait
				;
				;	PLP
				;	RTS

				;	#Code w {Pause}
				;	RTS

				;	#Code w {Test_Joy}
				;	PHP
				;	REP	#$30
				;
				;	LDX	#$0000
		;	{-}	;	LDA	joy,X
				;	BEQ	{Trigger}
				;	CMP	#$3030	// Soft reset
				;	BNE	{+}
				;	JMP	RESET_Vector
		;	{+}	;	CLC
				;	EOR	joy.last,X
				;	BNE	{++}
				;	LDA	joy.hold,X
				;	BEQ	{+}
				;	DEC	joy.hold,X
				;	LDA	#$0000
				;	BRA	{Trigger}
		;	{+}	;	SEC
				;	DEC	joy.cool,X
				;	BEQ	{+}
				;	LDA	#$0000
				;	BRA	{Trigger}
		;	{++}	;	LDA	#$000F
				;	STA	joy.hold,X
		;	{+}	;	LDA	#$000F
				;	STA	joy.cool,X
				;	LDA	joy,X
				;	BCS	{Trigger}
				;	EOR	joy.last,X
				;	AND	joy,X
		;	{Trigger}	;	STA	joy.edge,X
				;	AND	#$1000	// Pause
				;	BEQ	{+}
				;	LDA	#$FFFF
				;	EOR	pause
				;	STA	pause
				;
		;	{+}	;	INX
				;	INX
				;	CPX	#$0008
				;	BCC	{-}
				;
				;	PLP
				;	RTS

				;	#Code w {Ship}
				;	PHP
				;	REP	#$30
				;
				;	LDX	#ship_1
				;	BRA	{+ship_1}
		;	{-ship_2}	;	LDX	#ship_2
		;	{+ship_1}	;	STX	ship_index
				;	LDA	ship.status,X
				;	ASL	A
				;	TAX
				;	JSR	(Ship.programs,X)
				;	LDX	ship_index
				;	CPX	#ship_2
				;	BNE	{-ship_2}
				;
				;	PLP
				;	RTS
				;	#Data w Ship.programs
				{
					Ship.Ghost
					Ship.Live
					Ship.Death
					Ship.Dead
				}

				;	#Code w {Ship.Ghost}
				;	LDX	ship_index
				;	LDA	#$FFFF
				;	EOR	ship.render,X
				;	STA	ship.render,X
				;	BEQ	{+}
				;	DEC	ship.timer,X
				;	BNE	{+}
				;	INC	ship.status,X
				;	LDA	#SNAKE_LENGTH_MIN
				;	STA	ship.length,X
				;	#Code w {Ship.Live}
				;	LDX	ship_index	// Joy
		;	{+}	;	CPX	#ship_1
				;	BNE	{+ship_2}
				;	LDY	#$0000
				;	BRA	{+ship_1}
		;	{+ship_2}	;	LDY	#$0002
		;	{+ship_1}	;
				;	LDA	joy.edge,Y	// Polarity (A,B)
				;	BIT	#$8080
				;	BEQ	{+}
				;	LDA	ship.polarity,X
				;	EOR	#$FFFF
				;	STA	ship.polarity,X
		;	{+}	;
				;	LDA	ship.status,X	// Weapons
				;	CMP	#$0001
				;	BNE	{+}
				;	LDA	ship.timer,X
				;	BNE	{+drain}
				;
				;	LDA	joy,Y	// Lengthen (X)
				;	BIT	#$0040
				;	BEQ	{+wall}
				;	LDA	ship.charge,X
				;	BEQ	{+}
				;	LDA	ship.length,X
				;	CLC
				;	ADC	#SNAKE_LENGTH_DELTA
				;	STA	ship.length,X
				;	LDA	#$0000
				;	STA	ship.weapon,X
				;	BRA	{+set}
		;	{+wall}	;	LDA	joy,Y	// Wall (Y)
				;	BIT	#$4000
				;	BEQ	{+}
				;	LDA	ship.charge,X
				;	AND	#$001C
				;	BEQ	{+}
				;	STA	ship.charge,X
				;	LDA	#$0001
				;	STA	ship.weapon,X
				;	BRA	{+set}
		;	{+drain}	;	DEC	ship.timer,X
				;	BNE	{+}
				;	LDA	ship.weapon,X
				;	CMP	#$0000
				;	BEQ	{+}
				;	LDA	ship.charge,X
				;	BEQ	{+}
		;	{+set}	;	DEC	ship.charge,X
				;	LDA	#GAUGE_DISCHARGE_RATE
				;	STA	ship.timer,X
		;	{+}	;
				;
				;	LDA	joy,Y	// Movement (D-Pad)
				;	BIT	#$0100	// Right
				;	BEQ	{+left}
				;	LDA	ship.direction,X
				;	CMP	#$0002
				;	BEQ	{+down_up}
				;	LDA	#$0000
				;	STA	ship.direction,X
				;	BRA	{+down_up}
		;	{+left}	;	BIT	#$0200	// Left
				;	BEQ	{+down}
				;	LDA	ship.direction,X
				;	CMP	#$0000
				;	BEQ	{+down_up}
				;	LDA	#$0002
				;	STA	ship.direction,X
		;	{+down_up}	;	LDA	joy,Y
		;	{+down}	;	BIT	#$0400	// Down
				;	BEQ	{+up}
				;	LDA	ship.direction,X
				;	CMP	#$0003
				;	BEQ	{+}
				;	LDA	#$0001
				;	STA	ship.direction,X
				;	BRA	{+}
		;	{+up}	;	BIT	#$0800	// Up
				;	BEQ	{+}
				;	LDA	ship.direction,X
				;	CMP	#$0001
				;	BEQ	{+}
				;	LDA	#$0003
				;	STA	ship.direction,X
		;	{+}	;
				;	LDA	ship.x,X	// Update Position
				;	STA	ship.x_last,X
				;	LDA	ship.y,X
				;	STA	ship.y_last,X
				;	LDA	ship.direction,X
				;	CMP	#$0000	// Right
				;	BNE	{+switch}
				;	LDA	ship.x,X
				;	CLC
				;	ADC	ship.v,X
				;	CMP	#$F800
				;	BCC	{+in}
				;	LDA	#$0800
		;	{+in}	;	STA	ship.x,X
				;	BRA	{+break}
		;	{+switch}	;	CMP	#$0001	// Down
				;	BNE	{+switch}
				;	LDA	ship.y,X
				;	CLC
				;	ADC	ship.v,X
				;	CMP	#$D800
				;	BCC	{+in}
				;	LDA	#$1800
		;	{+in}	;	STA	ship.y,X
				;	BRA	{+break}
		;	{+switch}	;	CMP	#$0002	// Left
				;	BNE	{+switch}
				;	LDA	ship.x,X
				;	SEC
				;	SBC	ship.v,X
				;	CMP	#$0800
				;	BCS	{+in}
				;	LDA	#$F700
		;	{+in}	;	STA	ship.x,X
				;	BRA	{+break}
		;	{+switch}	;	CMP	#$0003	// Up
				;	BNE	{+break}
				;	LDA	ship.y,X
				;	SEC
				;	SBC	ship.v,X
				;	CMP	#$1800
				;	BCS	{+in}
				;	LDA	#$D700
		;	{+in}	;	STA	ship.y,X
		;	{+break}	;
				;	LDA	ship.render,X	// Render Ship
				;	BEQ	{+hide}
				;	STZ	Draw_Sprite.char_i
				;	STZ	Draw_Sprite.data_i.h
				;	CPX	#ship_1
				;	BNE	{+ship_2}
				;	LDA	#ship_1_sprite
				;	BRA	{+ship_1}
		;	{+ship_2}	;	LDA	#ship_2_sprite
		;	{+ship_1}	;	STA	Draw_Sprite.data_i
				;	SEP	#$20
				;	LDA	ship.x.h,X
				;	STA	Draw_Sprite.x
				;	LDA	ship.y.h,X
				;	STA	Draw_Sprite.y
				;	LDA	ship.polarity,X
				;	BNE	{+blue}
				;	LDA	#$21
				;	BRA	{+red}
		;	{+blue}	;	LDA	#$23
		;	{+red}	;	STA	Draw_Sprite.obj_p_override
				;	JSL	Draw_Sprite
				;	REP	#$20
		;	{+hide}	;
				;	RTS

				;	#Code w {Ship.Death}
				;	PHB
				;	PEA	$7E00
				;	PLB
				;	PLB
				;	LDX	ship_index	// Death Blossom
				;	LDA	#$0008
				;	CLC
				;	ADC	ship.charge,X
				;	STA	Ship.Death.blossom
				;	LDY	#$FFF0
		;	{-}	;	TYA
				;	CLC
				;	ADC	#$0010
				;	TAY
				;	CMP	#$0800
				;	BCS	{+max}
				;	LDA	fragment.active,Y
				;	BNE	{-}
				;
				;	LDA	#$FFFF	// Color, position
				;	STA	fragment.active,Y
				;	LDA	ship.polarity,X
				;	STA	fragment.polarity,Y
				;	LDA	ship.x,X
				;	STA	fragment.x,Y
				;	LDA	ship.y,X
				;	STA	fragment.y,Y
				;
		;	{-zero}	;	JSL	Rng	// Random velocity
				;	AND	#$001F
				;	CLC
				;	ADC	#$0008
				;	ASL	A
				;	PHX
				;	TAX
				;	LDA	sinusoid,X
				;	STA	Multiply_16.m1
				;	LDA	#$0001
				;	STA	Multiply_16.m2
				;	JSL	Multiply_16
				;	LDA	Multiply_16.p
				;	PLX
				;	STA	fragment.vx,Y
				;	JSL	Rng
				;	AND	#$001F
				;	ASL	A
				;	PHX
				;	TAX
				;	LDA	sinusoid,X
				;	STA	Multiply_16.m1
				;	LDA	#$0001
				;	STA	Multiply_16.m2
				;	JSL	Multiply_16
				;	LDA	Multiply_16.p
				;	CLC
				;	PLX
				;	STA	fragment.vy,Y
				;	ORA	fragment.vx,Y
				;	BEQ	{-zero}
				;
				;	DEC	Ship.Death.blossom
				;	BNE	{-}
		;	{+max}	;
				;	STZ	ship.render,X	// Update Ship
				;	STZ	ship.charge,X
				;	STZ	ship.timer,X
				;	STZ	ship.length,X
				;	JSL	Rng
				;	AND	#$FF00
				;	CMP	#$0800
				;	BCS	{+}
				;	LDA	#$0800
		;	{+}	;	CMP	#$F800
				;	BCC	{+}
				;	LDA	#$F700
		;	{+}	;	STA	ship.x,X
				;	JSL	Rng
				;	AND	#$FF00
				;	CMP	#$1800
				;	BCS	{+}
				;	LDA	#$1800
		;	{+}	;	CMP	#$D800
				;	BCC	{+}
				;	LDA	#$D700
		;	{+}	;	STA	ship.y,X
				;	JSL	Rng
				;	AND	#$0003
				;	STA	ship.direction,X
				;	INC	ship.status,X
				;	LDA	#$0020
				;	STA	ship.timer,X
				;	LDA	#$FFFF
				;
				;	PLB
				;	RTS

				;	#Code w {Ship.Dead}
				;	LDX	ship_index
				;	LDA	ship.snake_r,X
				;	CMP	ship.snake_w,X
				;	BNE	{+}
				;	STZ	ship.status,X
				;	LDA	#$002D
				;	STA	ship.timer,X
		;	{+}	;	RTS

				;	#Code w {Snake_Tail}
				;	PHP
				;	REP	#$30
				;	PHB
				;
				;	PEA	$7E00
				;	PLB
				;	PLB
				;	LDX	#ship_1
				;	BRA	{+ship_1}
		;	{-ship_2}	;	LDX	#ship_2
		;	{+ship_1}	;	STX	ship_index
				;	LDA	#SNAKE_RATE_DEAD
				;	STA	Snake_Tail.i
		;	{-dead}	;	LDA	ship.snake_w,X	// r = w
				;	SEC
				;	SBC	ship.snake_r,X
				;	BEQ	{+wait}
				;	BCC	{+}	// r < w
				;	CMP	ship.length,X
				;	BCC	{+wait}
				;	BRA	{+eat}
		;	{+}	;	CLC		// r > w
				;	ADC	#SNAKE_LENGTH_MAX
				;	CMP	ship.length,X
				;	BCC	{+wait}
				;
		;	{+eat}	;	INC	ship.snake_r,X	// Delete pixel
				;	INC	ship.snake_r,X
				;	LDA	ship.snake_r,X
				;	CMP	#SNAKE_LENGTH_MAX
				;	BCC	{+}
				;	STZ	ship.snake_r,X
				;	LDA	#$0000
		;	{+}	;	CPX	#ship_1
				;	BNE	{+ship_2}
				;	CLC
				;	ADC	#snake_1
				;	BRA	{+ship_1}
		;	{+ship_2}	;	CLC
				;	ADC	#snake_2
		;	{+ship_1}	;	TAX
				;	LDA	$0000,X
				;	AND	#$00FF
				;	XBA
				;	STA	Plot.x
				;	LDA	$0000,X
				;	AND	#$FF00
				;	STA	Plot.y
				;	STZ	Plot.color
				;	JSR	Plot
		;	{+wait}	;
				;	LDX	ship_index
				;	LDA	ship.status,X
				;	CMP	#$0001
				;	BEQ	{+}
				;	DEC	Snake_Tail.i
				;	BNE	{-dead}
		;	{+}	;	CPX	#ship_2
				;	BNE	{-ship_2}
				;
				;	PLB
				;	PLP
				;	RTS

				;	#Code w {Collision}
				;	PHP
				;	REP	#$30
				;	PHB
				;
				;	LDA	ship_1.status	// Ghost check
				;	CMP	#$0001
				;	BNE	{+miss}
				;	LDA	ship_2.status
				;	CMP	#$0001
				;	BNE	{+miss}
				;
				;	SEP	#$20	// Ship on Ship
				;	LDA	ship_1.x.h
				;	CMP	ship_2.x.h
				;	BNE	{+}
				;	LDA	ship_1.y.h
				;	CMP	ship_2.y.h
				;	BNE	{+}
				;	BRA	{+hit}
				;
		;	{+}	;	LDA	ship_1.x.h	// Ship through Ship
				;	CMP	ship_2.x_last.h
				;	BNE	{+miss}
				;	LDA	ship_1.y.h
				;	CMP	ship_2.y_last.h
				;	BNE	{+miss}
				;	LDA	ship_2.x.h
				;	CMP	ship_1.x_last.h
				;	BNE	{+miss}
				;	LDA	ship_2.y.h
				;	CMP	ship_1.y_last.h
				;	BNE	{+miss}
				;
		;	{+hit}	;	INC	ship_1.status	// Hit
				;	INC	ship_2.status
				;	BRA	{+done}
		;	{+miss}	;
				;	REP	#$20	// Ship on trail
				;	LDX	#ship_1
				;	BRA	{+ship_1}
		;	{-ship_2}	;	LDX	#ship_2
		;	{+ship_1}	;	STX	ship_index
				;	LDA	ship.status,X
				;	CMP	#$0001
				;	BNE	{+}
				;	LDA	ship.x,X
				;	STA	Trailmap_Index.x
				;	LDA	ship.y,X
				;	STA	Trailmap_Index.y
				;	JSR	Trailmap_Index
				;	PEA	$7F00
				;	PLB
				;	PLB
				;	TAX
				;	LDA	trailmap,X
				;	LDX	ship_index
				;	AND	#$0003
				;	CMP	#$0000
				;	BEQ	{+}
				;	CMP	#$0003
				;	BEQ	{collide}
				;	CMP	#$0002
				;	BEQ	{+blue}
				;	LDA	ship.polarity,X
				;	BEQ	{+charge}
		;	{collide}	;	INC	ship.status,X
				;	INC	ship.deaths,X
				;	BRA	{+}
		;	{+blue}	;	LDA	ship.polarity,X
				;	BEQ	{collide}
		;	{+charge}	;	LDA	ship.charge,X
				;	CMP	#$0010
				;	BCS	{+}
				;	INC	ship.charge,X
		;	{+}	;	LDX	ship_index
				;	CPX	#ship_2
				;	BNE	{-ship_2}
				;
		;	{+done}	;	PLB
				;	PLP
				;	RTS

				;	#Code w {Snake_Head}
				;	PHP
				;	PHB
				;
				;	PEA	$7E00	// Plot bitmap
				;	PLB
				;	PLB
				;	REP	#$30
				;	LDX	#ship_1
				;	BRA	{+ship_1}
		;	{-ship_2}	;	LDX	#ship_2
		;	{+ship_1}	;	STX	ship_index
				;
				;	LDA	ship.status,X
				;	CMP	#$0000
				;	BEQ	{+wait}
				;	CMP	#$0003
				;	BEQ	{+wait}
				;	LDA	ship.y,X
				;	AND	#$FF00
				;	STA	Plot.y
				;	LDA	ship.x,X
				;	AND	#$FF00
				;	STA	Plot.x
				;	XBA
				;	ORA	Plot.y
				;	PHA
				;	LDA	ship.timer,X
				;	BEQ	{+color}
				;	LDA	ship.weapon,X
				;	CMP	#$0001
				;	BNE	{+color}
				;	LDA	#$0003
				;	BRA	{+}
		;	{+color}	;	LDA	ship.polarity,X
				;	BEQ	{+red}
				;	LDA	#$0002
				;	BRA	{+}
		;	{+red}	;	LDA	#$0001
		;	{+}	;	STA	Plot.color
				;	JSR	Plot
				;
				;	LDX	ship_index	// Snake
				;	INC	ship.snake_w,X
				;	INC	ship.snake_w,X
				;	LDA	ship.snake_w,X
				;	CMP	#$4000
				;	BCC	{+}
				;	STZ	ship.snake_w,X
				;	LDA	#$0000
		;	{+}	;	CPX	#ship_1
				;	BNE	{+ship_2}
				;	CLC
				;	ADC	#snake_1
				;	BRA	{+ship_1}
		;	{+ship_2}	;	CLC
				;	ADC	#snake_2
		;	{+ship_1}	;	TAX
				;	PLA
				;	STA	$0000,X
		;	{+wait}	;
				;	LDX	ship_index
				;	CPX	#ship_2
				;	BNE	{-ship_2}
				;
				;	PLB
				;	PLP
				;	RTS

				;	#Code w {Plot}		// Plot(color,x,y)
				;	PHB
				;
				;	PEA	$7E00	// VRAM Address
				;	PLB
				;	PLB
				;	JSR	Trailmap_Index
				;	STA	Plot.trailmap_i
				;	JSR	Bitmap_Index
				;	CLC
				;	ADC	#$2000
				;	LDX	Nmi.VRAM_Write.table_i
				;	STA	Nmi.VRAM_Write.addr,X
				;
				;	LDA	Plot.x	// VRAM Data
				;	XBA
				;	AND	#$0007
				;	TAX
				;	LDA	Plot.color
				;	CMP	#$0003
				;	BNE	{+}
				;	LDA	#$8080
				;	BRA	{roll}
		;	{+}	;	CMP	#$0002
				;	BNE	{+}
				;	LDA	#$8000
				;	BRA	{roll}
		;	{+}	;	CMP	#$0001
				;	BNE	{+}
				;	LDA	#$0080
				;	BRA	{roll}
		;	{+}	;	LDA	#$8080
		;	{roll}	;	DEX
				;	BMI	{+}
				;	LSR	A
				;	BRA	{roll}
		;	{+}	;	TAY
				;	LDA	Plot.bitmap_i
				;	ASL	A
				;	TAX
				;	LDA	Plot.color
				;	BEQ	{+zero}
				;	TYA
				;	ORA	bitmap,X
				;	BRA	{+}
		;	{+zero}	;	TYA
				;	EOR	#$FFFF
				;	AND	bitmap,X
		;	{+}	;	STA	bitmap,X
				;	LDX	Nmi.VRAM_Write.table_i
				;	STA	Nmi.VRAM_Write.data,X
				;	INX
				;	INX
				;	INX
				;	INX
				;	STX	Nmi.VRAM_Write.table_i
				;
				;	PEA	$7F00	// Trailmap
				;	PLB
				;	PLB
				;	LDX	Plot.trailmap_i
				;	SEP	#$20
				;	LDA	Plot.color
				;	BEQ	{+}
				;	ORA	trailmap,X
		;	{+}	;	STA	trailmap,X
				;	REP	#$20
				;
				;	PLB
				;	RTS

				;	#Code w {Bitmap_Index}
				;	LDA	Bitmap_Index.x
				;	AND	#$F800
				;	XBA
				;	STA	Bitmap_Index.i
				;	LDA	Bitmap_Index.y
				;	AND	#$F800
				;	LSR	A
				;	LSR	A
				;	LSR	A
				;	CLC
				;	ADC	Bitmap_Index.i
				;	STA	Bitmap_Index.i
				;	LDA	Bitmap_Index.y
				;	XBA
				;	AND	#$0007
				;	CLC
				;	ADC	Bitmap_Index.i
				;	STA	Bitmap_Index.i
				;	RTS

				;	#Code w {Trailmap_Index}
				;	LDA	Trailmap_Index.x
				;	AND	#$FF00
				;	XBA
				;	STA	Trailmap_Index.i
				;	LDA	Trailmap_Index.y
				;	AND	#$FF00
				;	CLC
				;	ADC	Trailmap_Index.i
				;	STA	Trailmap_Index.i
				;	RTS

				;	#Code w {Update_Fragment}
				;	PHP
				;	PHB
				;	PEA	$7E00
				;	PLB
				;	PLB
				;	REP	#$30
				;
				;	LDX	#$0000	// Update position
		;	{-}	;	LDA	fragment.active,X
				;	BEQ	{+Next}
				;	LDA	fragment.vx,X
				;	BMI	{+Minus}
				;	CLC
				;	ADC	fragment.x,X
				;	BCC	{+}
				;	STZ	fragment.active,X
				;	BRA	{+Next}
		;	{+Minus}	;	DEC	A
				;	SEC
				;	ADC	fragment.x,X
				;	BCS	{+}
				;	STZ	fragment.active,X
				;	BRA	{+Next}
		;	{+}	;	STA	fragment.x,X
				;
				;	LDA	fragment.vy,X
				;	BMI	{+Minus}
				;	CLC
				;	ADC	fragment.y,X
				;	BCC	{+}
				;	STZ	fragment.active,X
				;	BRA	{+Next}
		;	{+Minus}	;	DEC	A
				;	SEC
				;	ADC	fragment.y,X
				;	BCS	{+}
				;	STZ	fragment.active,X
				;	BRA	{+Next}
		;	{+}	;	STA	fragment.y,X
				;
		;	{+Next}	;	TXA
				;	CLC
				;	ADC	#$0010
				;	CMP	#$0800
				;	BEQ	{+Done}
				;	TAX
				;	BRA	{-}
		;	{+Done}	;
				;
				;
				;	STZ	Draw_Sprite.data_i.h	// Draw
				;	LDA	#fragment_sprite
				;	STA	Draw_Sprite.data_i
				;	STZ	Draw_Sprite.char_i
				;	LDX	#$0000
		;	{-}	;	SEP	#$20
				;	LDA	fragment.active,X
				;	BEQ	{+Next}
				;
				;	LDA	fragment.x.h,X
				;	STA	Draw_Sprite.x
				;	LDA	fragment.y.h,X
				;	STA	Draw_Sprite.y
				;	LDA	fragment.polarity,X
				;	BNE	{Blue}
				;	LDA	#$21
				;	BRA	{+}
		;	{Blue}	;	LDA	#$23
		;	{+}	;	STA	Draw_Sprite.obj_p_override
				;	PHX
				;	JSL	Draw_Sprite
				;	PLX
		;	{+Next}	;	REP	#$20
				;	TXA
				;	CLC
				;	ADC	#$0010
				;	TAX
				;	CMP	#$0800
				;	BCC	{-}
				;
				;	PLB
				;	PLP
				;	RTS

				;	#Code w {Update_Cgram}
				;	PHP
				;	REP	#$30
				;
				;	LDA	Main.count	// Charge Gauge
				;	AND	#$0002
				;	BNE	{+Dim}
				;
				;	LDA	#$001C
				;	STA	$035C
				;	LDA	#$41BC
				;	STA	$035E
				;	LDA	#$7000
				;	STA	$037C
				;	LDA	#$71B0
				;	STA	$037E
				;	BRA	{+Bright}
				;
		;	{+Dim}	;	LDA	#$000C
				;	STA	$035C
				;	LDA	#$0018
				;	STA	$035E
				;	LDA	#$3000
				;	STA	$037C
				;	LDA	#$6000
				;	STA	$037E
		;	{+Bright}	;
				;
				;	PLP
				;	RTS

				;	#Code w {Update_Frame}
				;	PHP
				;	REP	#$30
				;
				;	LDX	Nmi.VRAM_Write.table_i	// Ship 1 Kills
				;	LDY	#$002A	// Name Address
				;	LDA	ship_2.deaths	// Draw high number
				;	AND	#$00F0
				;	LSR	A
				;	LSR	A
				;	LSR	A
				;	LSR	A
				;	ORA	#$2400	// Priority=1,Pallet=1 (mode1=>pallet0=bg3's)
				;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INY
				;	INX
				;	INX
				;	INX
				;	INX
				;	LDA	ship_2.deaths	// Draw low number
				;	AND	#$000F
				;	ORA	#$2400
				;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INX
				;	INX
				;	INX
				;	INX
				;
				;	LDY	#$0034	// Ship 2 Kills
				;	LDA	ship_1.deaths
				;	AND	#$00FF
				;	LSR	A
				;	LSR	A
				;	LSR	A
				;	LSR	A
				;	ORA	#$2400
				;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INY
				;	INX
				;	INX
				;	INX
				;	INX
				;	LDA	ship_1.deaths
				;	AND	#$000F
				;	ORA	#$2400
				;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INX
				;	INX
				;	INX
				;	INX
				;
				;	LDA	ship_1.charge	// Ship 1 Charge Gauge
				;	LDY	#$0025
		;	{-}	;	CPY	#$0029
				;	BEQ	{++}
				;	SEC
				;	SBC	#$0004
				;	BCC	{+}
				;	PHA
				;	LDA	ship_1.polarity
				;	BNE	{Blue}
				;	LDA	#$2437
				;	BRA	{Red}
		;	{Blue}	;	LDA	#$2837
		;	{Red}	;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INY
				;	INX
				;	INX
				;	INX
				;	INX
				;	PLA
				;	BRA	{-}
				;
		;	{+}	;	ADC	#$2037
				;	PHA
				;	LDA	ship_1.polarity
				;	BNE	{Blue}
				;	PLA
				;	ORA	#$0400
				;	BRA	{Red}
		;	{Blue}	;	PLA
				;	ORA	#$0800
		;	{Red}	;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INY
				;	INX
				;	INX
				;	INX
				;	INX
				;
		;	{-}	;	CPY	#$0029
				;	BEQ	{++}
				;	LDA	#$2433
				;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	INY
				;	INX
				;	INX
				;	INX
				;	INX
				;	BRA	{-}
		;	{++}	;
				;	LDA	ship_2.charge	// Ship 2 Charge Gauge
				;	LDY	#$003A
		;	{-}	;	CPY	#$0036
				;	BEQ	{++}
				;	SEC
				;	SBC	#$0004
				;	BCC	{+}
				;	PHA
				;	LDA	ship_2.polarity
				;	BNE	{Blue}
				;	LDA	#$6437
				;	BRA	{Red}
		;	{Blue}	;	LDA	#$6837
		;	{Red}	;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	DEY
				;	INX
				;	INX
				;	INX
				;	INX
				;	PLA
				;	BRA	{-}
				;
		;	{+}	;	ADC	#$6037
				;	PHA
				;	LDA	ship_2.polarity
				;	BNE	{Blue}
				;	PLA
				;	ORA	#$0400
				;	BRA	{Red}
		;	{Blue}	;	PLA
				;	ORA	#$0800
		;	{Red}	;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	DEY
				;	INX
				;	INX
				;	INX
				;	INX
				;
		;	{-}	;	CPY	#$0036
				;	BEQ	{++}
				;	LDA	#$6433
				;	STA	Nmi.VRAM_Write.data,X
				;	TYA
				;	STA	Nmi.VRAM_Write.addr,X
				;	DEY
				;	INX
				;	INX
				;	INX
				;	INX
				;	BRA	{-}
		;	{++}	;	STX	Nmi.VRAM_Write.table_i
				;
				;	PLP
				;	RTS










				;	# General Functions =================


				;	#Code l {Multiply_16}     // 16*16=16
				;	PHP
				;	REP	#$30
				;	LDA	#$0000
		;	{-}	;	LDX	Multiply_16.m1
				;	BEQ	{+Return}
				;	LSR	Multiply_16.m1
				;	BCC	{+}
				;	CLC
				;	ADC	Multiply_16.m2
		;	{+}	;	ASL	Multiply_16.m2
				;	BRA	{-}
		;	{+Return}	;	STA	Multiply_16.p
				;	PLP
				;	RTL

				;	#Code l {Divide_16}       // 16/16=16
				;	PHP
				;	REP	#$30
				;	STZ	Divide_16.q
				;	LDA	Divide_16.d
				;	LDX	Divide_16.n
				;	LDY	#$0001
		;	{-}	;	ASL	A
				;	BCS	{+}
				;	INY
				;	CPY	#$0011
				;	BNE	{-}
		;	{+}	;	ROR	A
		;	{-}	;	PHA
				;	TXA
				;	SEC
				;	SBC	$01,S
				;	BCC	{+}
				;	TAX
		;	{+}	;	ROL	Divide_16.q
				;	PLA
				;	LSR	A
				;	DEY
				;	BNE	{-}
				;	LDA	Divide_16.q
				;	STX	Divide_16.r
				;	PLP
				;	RTL


				;	#Code l {Immediate_DMA}
				;	PHP
				;	PHB
				;	SEP	#$20
				;	LDA	$05,S
				;	PHA
				;	PLB
				;	REP	#$20
				;	LDA	$03,S
				;	INC	A
				;	TAX
				;	LDA	$0000,X
				;	STA	DMAP
				;	LDA	$0002,X
				;	STA	DMAA.l
				;	LDA	$0004,X
				;	STA	DMAA.b
				;	SEP	#$20
				;	LDA	$0006,X
				;	STA	DMAD.h
				;	LDA	#$01
				;	STA	MDMAEN
				;	REP	#$20
				;	TXA
				;	CLC
				;	ADC	#$0006
				;	STA	$03,S
				;	PLB
				;	PLP
				;	RTL


				;	#Code l {Ready_Oam}
				;	PHP
				;	PHB
				;	PEA	$7E00
				;	PLB
				;	PLB
				;	REP	#$30
				;	STZ	oam_i
				;	STZ	oam2_byte_i	// and bit OS
				;	LDX	#$001E
		;	{-}	;	STZ	oam2,X
				;	DEX
				;	DEX
				;	BPL	{-}
				;	PLB
				;	PLP
				;	RTL

				;	#Code l {Hide_Unused_Oam}
				;	PHP
				;	REP	#$20
				;	LDA	oam_i
				;	CMP	#$0200
				;	BMI	{+}
				;	PLP
				;	RTL
		;	{+}	;	LSR	A
				;	STA	$00
				;	LSR	A
				;	ADC	$00
				;	STA	$00
				;	CLC
				;	PER	$000C
				;	PLA
				;	ADC	$00
				;	STA	$00
				;	SEP	#$20
				;	LDA	#$F0
				;	JMP	($0000)
				;	STA	$0101
				;	STA	$0105
				;	STA	$0109
				;	STA	$010D
				;	STA	$0111
				;	STA	$0115
				;	STA	$0119
				;	STA	$011D
				;	STA	$0121
				;	STA	$0125
				;	STA	$0129
				;	STA	$012D
				;	STA	$0131
				;	STA	$0135
				;	STA	$0139
				;	STA	$013D
				;	STA	$0141
				;	STA	$0145
				;	STA	$0149
				;	STA	$014D
				;	STA	$0151
				;	STA	$0155
				;	STA	$0159
				;	STA	$015D
				;	STA	$0161
				;	STA	$0165
				;	STA	$0169
				;	STA	$016D
				;	STA	$0171
				;	STA	$0175
				;	STA	$0179
				;	STA	$017D
				;	STA	$0181
				;	STA	$0185
				;	STA	$0189
				;	STA	$018D
				;	STA	$0191
				;	STA	$0195
				;	STA	$0199
				;	STA	$019D
				;	STA	$01A1
				;	STA	$01A5
				;	STA	$01A9
				;	STA	$01AD
				;	STA	$01B1
				;	STA	$01B5
				;	STA	$01B9
				;	STA	$01BD
				;	STA	$01C1
				;	STA	$01C5
				;	STA	$01C9
				;	STA	$01CD
				;	STA	$01D1
				;	STA	$01D5
				;	STA	$01D9
				;	STA	$01DD
				;	STA	$01E1
				;	STA	$01E5
				;	STA	$01E9
				;	STA	$01ED
				;	STA	$01F1
				;	STA	$01F5
				;	STA	$01F9
				;	STA	$01FD
				;	STA	$0201
				;	STA	$0205
				;	STA	$0209
				;	STA	$020D
				;	STA	$0211
				;	STA	$0215
				;	STA	$0219
				;	STA	$021D
				;	STA	$0221
				;	STA	$0225
				;	STA	$0229
				;	STA	$022D
				;	STA	$0231
				;	STA	$0235
				;	STA	$0239
				;	STA	$023D
				;	STA	$0241
				;	STA	$0245
				;	STA	$0249
				;	STA	$024D
				;	STA	$0251
				;	STA	$0255
				;	STA	$0259
				;	STA	$025D
				;	STA	$0261
				;	STA	$0265
				;	STA	$0269
				;	STA	$026D
				;	STA	$0271
				;	STA	$0275
				;	STA	$0279
				;	STA	$027D
				;	STA	$0281
				;	STA	$0285
				;	STA	$0289
				;	STA	$028D
				;	STA	$0291
				;	STA	$0295
				;	STA	$0299
				;	STA	$029D
				;	STA	$02A1
				;	STA	$02A5
				;	STA	$02A9
				;	STA	$02AD
				;	STA	$02B1
				;	STA	$02B5
				;	STA	$02B9
				;	STA	$02BD
				;	STA	$02C1
				;	STA	$02C5
				;	STA	$02C9
				;	STA	$02CD
				;	STA	$02D1
				;	STA	$02D5
				;	STA	$02D9
				;	STA	$02DD
				;	STA	$02E1
				;	STA	$02E5
				;	STA	$02E9
				;	STA	$02ED
				;	STA	$02F1
				;	STA	$02F5
				;	STA	$02F9
				;	STA	$02FD
				;	PLP
				;	RTL

				;	#Code l {Draw_Sprite}		(sprite,x,y,char_i,override)
				;	PHP
				;	REP	#$10
				;	LDY	oam_i
				;	CPY	#$0200	// OAM Overflow
				;	BCC	{+}
				;	PLP
				;	RTL
		;	{+}	;	PHB
				;	SEP	#$20
				;	LDA	Draw_Sprite.data_bank
				;	PHA
				;	PLB
				;	LDX	Draw_Sprite.data_i
				;	LDA	$0000,X	// OBJ Count
				;	BRA	{+}
		;	{--}	;	CPY	#$0200	// OAM Overflow
				;	BCC	{++}
				;	BRL	{+Return}
		;	{++}	;	INX
				;	INX
				;	INX
				;	INX
		;	{+}	;	INX
				;	STA	Draw_Sprite.obj_count
				;	LDA	$0000,X	// OBJ X Position
				;	PHX
				;	CLC
				;	ADC	Draw_Sprite.x
				;	STA	oam.x,Y
				;	LDA	$0004,X	// OBJ OAM II
				;	AND	#$03
				;	BCC	{+}
				;	EOR	#$01
		;	{+}	;	STY	oam_i
				;	SEP	#$10
				;	LDY	oam2_bit_i
		;	{-}	;	BEQ	{+}
				;	ASL	A
				;	ASL	A
				;	DEY
				;	DEY
				;	BRA	{-}
		;	{+}	;	LDY	oam2_byte_i
				;	ORA	oam2,Y
				;	STA	oam2,Y
				;	LDY	oam2_bit_i
				;	INY
				;	INY
				;	CPY	#$08
				;	BCC	{+}
				;	LDY	#$00
				;	INC	oam2_byte_i
		;	{+}	;	STY	oam2_bit_i
				;	REP	#$10
				;	LDY	oam_i
				;	PLX
				;	LDA	$0001,X	// OBJ Y Position
				;	CLC
				;	ADC	Draw_Sprite.y
				;	STA	oam.y,Y
				;	REP	#$20
				;	LDA	$0002,X	// OBJ Character/Settings
				;	AND	#$01FF
				;	CLC
				;	ADC	Draw_Sprite.char_i
				;	AND	#$01FF
				;	SEP	#$20
				;	STA	oam.c,Y
				;	XBA
				;	EOR	$0003,X
				;	PHA
				;	LDA	Draw_Sprite.obj_p_override
				;	BEQ	{+}
				;	PLA
				;	AND	#$C1
				;	EOR	Draw_Sprite.obj_p_override
				;	BRA	{++}
		;	{+}	;	PLA
		;	{++}	;	STA	oam.p,Y	// Draw Sprite OBJ P
				;	INY
				;	INY
				;	INY
				;	INY
				;	LDA	Draw_Sprite.obj_count
				;	DEC	A
				;	BMI	{+Return}
				;	BRL	{--}
		;	{+Return}	;	STY	oam_i
				;	PLB
				;	PLP
				;	RTL


				;	#Code l {Rng}
				;	PHP
				;	PHB
				;	PEA	$0000
				;	PLB
				;	PLB
				;	REP	#$20
				;	LDA	Rng.number
				;	SEP	#$20
				;	STA	M7A
				;	XBA
				;	STA	M7A
				;	LDA	#$D3
				;	STA	M7B
				;	REP	#$20
				;	LDA	RDMPY24
				;	INC	A
				;	XBA
				;	STA	Rng.number
				;	PLB
				;	PLP
				;	RTL

				;	#Data w ship_1_sprite
				{	$00
					$FE $FD $253C $01
				}
				;	#Data w ship_2_sprite
				{	$00
					$FE $FD $253D $01
				}
				;	#Data w fragment_sprite
				{	$00
					$FE $FD $2540 $01
				}

				;	#Data l sinusoid
				{	$0000
					$0032
					$0062
					$008E
					$00B5
					$00D5
					$00ED
					$00FB
					$0100
					$00FB
					$00ED
					$00D5
					$00B5
					$008E
					$0062
					$0032
					$0000
					$FFCE
					$FF9E
					$FF72
					$FF4B
					$FF2B
					$FF13
					$FF05
					$FF00
					$FF05
					$FF13
					$FF2B
					$FF4B
					$FF72
					$FF9E
					$FFCE
					$0000
					$0032
					$0062
					$008E
					$00B5
					$00D5
					$00ED
					$00FB
				}

				;	#Data l char_set  {#JormungandrChar.dat}
				;	#Data l frame_map {#JormungandrFrameMap.dat}
				;	#Data l floor_map {#JormungandrFloorMap.dat}
				;	#Data l trail_map {#JormungandrTrailMap.dat}
				;	#Data l color_set {#JormungandrColor.dat}

				;	#Data $00:FFB0 rom_header
					{$52 $3A $4A $4F $52 $4D $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
					 $52 $3A $4A $6F $72 $6D $75 $6E $67 $61 $6E $64 $72 $20 $20 $20
					 $20 $20 $20 $20 $20 $20 $02 $09 $01 $01 $33 $00 $00 $00 $00 $00 }

				;	#Data $00:FFE0 vector_table
					{$0000 $0000 $8000 $8000 $8000 $8007 $0000 $8000
					 $0000 $0000 $8000 $0000 $8000 $8000 $8000 $8000}
