
        ; **
        ; InitSNES -- basically clears and sets registers to defaults
        ; **

initsnes:
        pha
        php             ; save all registers and status flag

        sep   #$20      ; A = 8-bit mode
        lda   #$8F      ; screen off, full brightness (while initializing)
        sta   $2100     ; store to screen register
        stz   $2101     ; sprite register (size + address in VRAM)
        stz   $2102     ; sprite registers (address of sprite memory [OAM])
        stz   $2103     ; "
        stz   $2105     ; set graphics Mode 0
        stz   $2106     ; no planes, no mosiac
        stz   $2107     ; plane 0 map VRAM location ($0000 vram)
        stz   $2108     ; plane 1 map VRAM location
        stz   $2109     ; plane 2 "
        stz   $210A     ; plane 3 "
        stz   $210B     ; plane 0+1 tile data location
        stz   $210C     ; plane 0+2 "
        stz   $210D     ; plane 0 scroll x (first 8 bits)
        stz   $210D     ; plane 0 scroll x (last 3 bits) write to reg twice
        stz   $210E     ; plane 0 scroll y "
        stz   $210E     ; plane 0 scroll y "
        stz   $210F     ; plane 1 scroll x (first 8 bits)
        stz   $210F     ; plane 1 scroll x (last 3 bits) write to reg twice
        stz   $2110     ; plane 1 scroll y "
        stz   $2110     ; plane 1 scroll y "
        stz   $2111     ; plane 2 scroll x (first 8 bits)
        stz   $2111     ; plane 2 scroll x (last 3 bits) write to reg twice
        stz   $2112     ; plane 2 scroll y "
        stz   $2112     ; plane 2 scroll y "
        stz   $2113     ; plane 3 scroll x (first 8 bits)
        stz   $2113     ; plane 3 scroll x (last 3 bits) write to reg twice
        stz   $2114     ; plane 3 scroll y "
        stz   $2114     ; plane 3 scroll y "
        lda   #$80      ; increase VRAM after writes to $2118.19
        sta   $2115     ; store to VRAM increment register
        stz   $2116     ; VRAM address low
        stz   $2117     ; VRAM address hi
        stz   $211A     ; init mode 7 setting reg
        stz   $211B     ; mode 7 matrix parameter A register (low)
        stz   $211B	; Mode 7 matrix parameter A register (low)
        lda   #$01
        sta   $211B	; Mode 7 matrix parameter A register (high)
        stz   $211C	; Mode 7 matrix parameter B register (low)
        stz   $211C	; Mode 7 matrix parameter B register (high)
        stz   $211D	; Mode 7 matrix parameter C register (low)
        stz   $211D	; Mode 7 matrix parameter C register (high)
        stz   $211E	; Mode 7 matrix parameter D register (low)
        lda   #$01
        sta   $211E	; Mode 7 matrix parameter D register (high)
        stz   $211F	; Mode 7 center position X register (low)
        stz   $211F	; Mode 7 center position X register (high)
        stz   $2120	; Mode 7 center position Y register (low)
        stz   $2120	; Mode 7 center position Y register (high)
        stz   $2121	; Color number register ($0-ff)
        stz   $2123	; BG1 & BG2 Window mask setting register
        stz   $2124	; BG3 & BG4 Window mask setting register
        stz   $2125	; OBJ & Color Window mask setting register
        stz   $2126	; Window 1 left position register
        stz   $2127	; Window 2 left position register
        stz   $2128	; Window 3 left position register
        stz   $2129	; Window 4 left position register
        stz   $212A	; BG1, BG2, BG3, BG4 Window Logic register
        stz   $212B     ; OBJ, Color Window Logic Register (or,and,xor,xnor)
        lda   #$01
        sta   $212C	; Main Screen designation (planes, sprites enable)
        stz   $212D	; Sub Screen designation
        stz   $212E	; Window mask for Main Screen
        stz   $212F	; Window mask for Sub Screen
        lda   #$30
        sta   $2130	; Color addition & screen addition init setting
        stz   $2131	; Add/Sub sub designation for screen, sprite, color
        lda   #$E0
        sta   $2132	; color data for addition/subtraction
        stz   $2133	; Screen setting (interlace x,y/enable SFX data)
        stz   $4200	; Enable V-blank, interrupt, Joypad register
        lda   #$FF
        sta   $4201	; Programmable I/O port
        stz   $4202	; Multiplicand A
        stz   $4203	; Multiplier B
        stz   $4204	; Multiplier C
        stz   $4205	; Multiplicand C
        stz   $4206	; Divisor B
        stz   $4207	; Horizontal Count Timer
        stz   $4208	; Horizontal Count Timer MSB (most significant bit)
        stz   $4209	; Vertical Count Timer
        stz   $420A	; Vertical Count Timer MSB
        stz   $420B	; General DMA enable (bits 0-7)
        stz   $420C	; Horizontal DMA (HDMA) enable (bits 0-7)
        stz   $420D	; Access cycle designation (slow/fast rom)

        plp             ; restore processor status (8 or 16 bit mode)
        pla             ; restore all registers
        rts

        ; **
        ; ClearVRAM - Clear 64k of VRAM with 0's
        ; **

clearvram:
        pha
        phx
        php                     ; save all registers and status flag

        sep     #$20            ; A = 8 bit mode
        rep     #$10            ; X, Y = 16 bit mode
        ldx.v   #$0
        stx.v   spareword       ; transfer all 0's (clear 64k VRAM)
        lda     #$09            ; transfer word mode, fixed address
        sta     $4300
        lda     #$18            ; transfer to VRAM $2118
        sta     $4301
        ldx.v   #spareword
        stx.v   $4302           ; write source address $4302.03
        lda     #spareword/$10000
        sta     $4304           ; write source bank byte
        ldx.v   #$FFFF
        stx.v   $4305           ; write bytes to transfer, $4305.06
        lda     #$01
        sta     $420B           ; enable DMA channel #0

        plp
        plx
        pla                     ; restore all registers and status
        rts

; **
; PosXY - Point VRAM to the position denoted by X, Y coordinates
; X, Y must be in 16-bit mode.
; **

PosXY:
        pha
        php                     ; save processor mode
        rep     #$20            ; A = 16 bit mode
        tya
        asl
        asl
        asl
        asl
        asl                     ; multiply Y coord. by 32
        phx
        clc
        .dcb    $63,$01         ; adc     1,s    ; add X coordinate (?)
        adc.w   #$F800          ; offset in VRAM where font map starts
        plx
        sta.w   $2116           ; point VRAM to this address
        plp                     ; restore processor mode
        pla
        rts

; **
; WriteStr - write a character string to screen.  A contains address of
;            string.  X,Y are x,y coordinates (32x28 area)
; Enter: axy16bit  Font address: VRAM $F800
; **

writestr:
        phy
        pha                     ; save y, a
        jsr     PosXY           ; position VRAM to X, Y
        tay                     ; and transfer to Y for addressing
        sep     #$20            ; A = 8bit mode
writechar:
        lda     $0000,y         ; load in one character
        beq     endwrite        ; if 0 (terminator), jump to the end
        and     #$3f            ; get only 0-63
        sta     $2118
        lda     #$20            ; make tile attribute priority (show thru)
        sta     $2119           ; store tile attribute
        iny
        bra     writechar
endwrite:
        rep     #$30            ; restore 16 bit mode
        pla
        ply                     ; restore y, a registers
        rts

; **
; WriteNybble - Writes low nybble from A low byte to VRAM $F800
; **

writenybble:
.mem 8
        cmp     #$0A
        bmi     makenum
        sec
        sbc     #$09
        bra     writeletter
makenum:
        clc
        adc     #$30
writeletter:
        sta     $2118           ; store character
        lda     #$24
        sta     $2119           ; store attribute (priority bit)
        rts

; **
; writebyte - writes a single byte (in hex) to the screen.
; enter: a8/16bit, xy16bit.  modify: none, font map at $F800
; **

writebyte:
        php
        jsr     PosXY           ; position VRAM to X, Y
        sep     #$20            ; A = 8 bit mode
        pha
        and     #$F0            ; get high nybble
        lsr
        lsr
        lsr
        lsr                     ; shift into low nybble
        jsr     writenybble
        .dcb    $A3,$01         ; lda 1,s, restore A
        and     #$0F            ; get low nybble
        jsr     writenybble
        pla
        plp
        rts

; **
; Writeword - converts a word to hex letters, written to screen.
; A is the word to write, X, Y are x,y coordinates.
; Modify regs- none.  Enter in 16-bit mode
; **

writeword:
        phx
        sep     #$20
        pha                     ; save low byte of accumulator
        xba                     ; display high byte
        jsr     writebyte
        pla                     ; restore low byte
        inx
        inx                     ; move two tile positions over
        jsr     writebyte       ; display low byte
        rep     #$20
        plx
        rts
