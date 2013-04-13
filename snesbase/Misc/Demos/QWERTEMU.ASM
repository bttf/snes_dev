; Emulator test program - by David Piepgrass
; Made for the X816 assembler.

        .smc
        ; variables
bg1scrolly = $0
scrolldir = $2
bg2scrollx = $3
bg2scrolly = $5
framecount = $7
numballs = $8
        ; arrays
ballx = $10
bally = $30
balldirx = $50
balldiry = $70
spritenum = $90


vrammode = $2115
vramaddress = $2116
vramdata_low = $2118
vramdata_high = $2119
bg1vscroll = $210E
bg2hscroll = $210F
bg2vscroll = $2110
cgramentry = $2121


        .org $8000

        sei
        clc
        xce

        jsr init_snes

        .detect on      ; autodetect size of immediate values
        rep #$30
        lda #0
        sta bg1scrolly
        sep #$20
        sta scrolldir
        
        jsr upload_palette
        
        sep #$30
        lda #$11                ; BG1 and BG2 chars at $2000
        sta $210B
        lda #2      ; BG1 32x64; starts at $0
        sta $2107
        lda #8      ; BG2 32x32; starts at $800
        sta $2108
        
        rep #$10        ; 16-bit X/Y
        sep #$20        ; 8-bit A
        lda #$80        ; inc when high byte is written
        sta vrammode
        ldx #$1000 ; Word address
        stx vramaddress
        ldx #0          ; load font into vram at $2000
-       lda font8,x
        sta vramdata_low
        lda #0
        sta vramdata_high
        inx
        cpx #8*128
        bne -
        
        ldx #$0
        stx vramaddress ; put text into the BG map at $0
-       lda textscreen,x
        sta vramdata_low
        ldy #$4
        cmp #65
        blt +
        ldy #0
+       tya
        sta vramdata_high
        inx
        cpx #32*60
        bne -

        sep #$20
        ldx #$800
        stx vramaddress ; put background into the BG map at $800 words
        ldx #0
-       lda #8
        sta vramdata_low
        ldy #0  ; BG2's palette #0
        txa     ; if x&1=1 && x&32=0 or x&1=0 && x&32=1
        and #33
        cmp $1
        beq +
        cmp $32
        beq +
        ldy #4 ; BG2's palette #1
+       tya
        sta vramdata_high
        inx
        cpx #32*32
        bne -
        
        ;Now, do the sprite thing.
        sep #$30
        lda #$62  ; Yummy! 16x16 or 32x32, base 2<<14=$8000 bytes
        sta $2101
        lda #$0
        sta $2102 ; oam addr
        stz $2103
        ldx #$0
-       stz $2104
        inx
        cpx #544
        bne -
        
        rep #$20
        lda #$4000
        jsr upload_tiles

        ;whew. Screen on.
        sep #$20
        lda #$0F
        sta $2100
        lda #$81    ; NMI and Joypad enable
        sta $4200
        lda #$13        ; BG1&2; sprites
        sta $212C       ; Main screen designation

        ;set up hdma
        sep #$20
        rep #$10
    lda #$02        ; word format HDMA (count, word)
    sta $4300
    lda #$0D        ; plane 0 x-scroll at $210D
    sta $4301
    ldx.w #hdma_table&$FFFF ; hdma table offset
    stx $4302
    lda #hdma_table/$10000 ; hdma table bank
    sta $4304
    lda #$01        ; enable HDMA channel 0
    sta $420c
        
    lda #$01        ; HDMA test channel 1, mode 1
    sta $4310
    lda #$16        ; $2116 - Upload address
    sta $4311
    ldx.w #testhdma1&$FFFF ; hdma table offset
    stx $4312
    lda #testhdma1/$10000 ; hdma table bank
    sta $4314

    lda #$01        ; HDMA test channel 2, test
    sta $4320
    lda #$18        ; $2118 - Upload data
    sta $4321
    ldx.w #testhdma2&$FFFF ; hdma table offset
    stx $4322
    lda #testhdma2/$10000 ; hdma table bank
    sta $4324
    lda #$07        ; enable HDMA channel 0, 1, 2
    sta $420c
        
        lda #123                ; just for fun...
        sta framecount 

---     sep #$30
--      ;lda $4212
;       and.b #$1       ; Wait for joypad to be ready to read
;       beq --
        
        ; make almost random delay
        ;ldx #0
        ;-      inc a
        ;cmp framecount
        ;bne -
        ;lda #0
;       inx
        ;bpl -
        
        rep #$20
-       lda $4218       ; button pressed?
        beq -           ; of course not
;       lda numballs
;       cmp #7
;       bge --
        
        sep #$30
        ldx numballs ; ball number to create
        lda $2137       ; garbage value; ignored.  used as latch to find scanline
        lda $213D       ; lo byte of vertical counter
        ldy $213D  ; hi byte, ignored but must be read
        sta ballx,x ; random position x
        and #7
        sec
        sbc #4  ; random direction y
        bne +
        inc a
+       sta balldiry,x
        lda $213C       ; lo byte of horiz. counter
        ldy $213C
        sta bally,x ; random position y
        and #7
        sec
        sbc #4  ; random direction x
        bne +
        inc a
+       sta balldirx,x
        
        txa     ; now figure out what sprite to start with
        and #1
        asl a
        asl a
        sta spritenum,x
        
        inx         ; increment ball counter
        cpx #20    ; max balls=20
        blt +
        ldx #1
+       stx numballs

        rep #$20
-       lda $4218       ; Wait for release
        bne -
        
        bra ---

hdma_table:
        .dcb 3 : .dcw 1    ; This makes the cool wavey BG effect.
        .dcb 4 : .dcw 2
        .dcb 6 : .dcw 3
        .dcb 7 : .dcw 4
        .dcb 6 : .dcw 3
        .dcb 4 : .dcw 2
        .dcb 3 : .dcw 1
        .dcb 2 : .dcw 0
        .dcb 3 : .dcw 511
        .dcb 4 : .dcw 510
        .dcb 6 : .dcw 509
        .dcb 7 : .dcw 508
        .dcb 6 : .dcw 509
        .dcb 4 : .dcw 510
        .dcb 3 : .dcw 511
        .dcb 2 : .dcw 0

        .dcb 3 : .dcw 1
        .dcb 4 : .dcw 2
        .dcb 6 : .dcw 3
        .dcb 7 : .dcw 4
        .dcb 6 : .dcw 3
        .dcb 4 : .dcw 2
        .dcb 3 : .dcw 1
        .dcb 2 : .dcw 0
        .dcb 3 : .dcw 511
        .dcb 4 : .dcw 510
        .dcb 6 : .dcw 509
        .dcb 7 : .dcw 508
        .dcb 6 : .dcw 509
        .dcb 4 : .dcw 510
        .dcb 3 : .dcw 511
        .dcb 2 : .dcw 0

        .dcb 3 : .dcw 1
        .dcb 4 : .dcw 2
        .dcb 6 : .dcw 3
        .dcb 7 : .dcw 4
        .dcb 6 : .dcw 3
        .dcb 4 : .dcw 2
        .dcb 3 : .dcw 1
        .dcb 2 : .dcw 0
        .dcb 3 : .dcw 511
        .dcb 4 : .dcw 510
        .dcb 6 : .dcw 509
        .dcb 7 : .dcw 508
        .dcb 6 : .dcw 509
        .dcb 4 : .dcw 510
        .dcb 3 : .dcw 511
        .dcb 2 : .dcw 0

        .dcb 3 : .dcw 1
        .dcb 4 : .dcw 2
        .dcb 5 : .dcw 3
        .dcb 6 : .dcw 4
        .dcb 0

testhdma1:
        .dcb 8 : .dcw $1040
        .dcb 8 : .dcw $1040
        .dcb 0, 0, 0
testhdma2:
        .dcb 1 : .dcw $007C
        .dcb 1 : .dcw $00C6
        .dcb 1 : .dcw $00C6
        .dcb 1 : .dcw $00FE
        .dcb 1 : .dcw $00C6
        .dcb 1 : .dcw $00C6
        .dcb 1 : .dcw $00C6
        .dcb 1 : .dcw $0000

        .dcb 1 : .dcw $0055
        .dcb 1 : .dcw $00AA
        .dcb 1 : .dcw $0055
        .dcb 1 : .dcw $00AA
        .dcb 1 : .dcw $0055
        .dcb 1 : .dcw $00AA
        .dcb 1 : .dcw $0055
        .dcb 1 : .dcw $00AA

        .dcb 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

nmi_int:
        ; In here is where the scrolling gets changed.
        rep #$30
        pha
        phx
        phy

        lda #$1080              ; ???? for HDMA channel 1 thing
        sta $2116
        
        ;only change vertical every other frame
        sep #$20
        lda framecount
        inc a
        sta framecount
        and #$1
        beq +
        jmp noscroll
+
        sep #$20
        lda scrolldir  ; 0=scroll down
        rep #$20
        beq +
        lda bg1scrolly
        dec a
        dec a
        sta bg1scrolly
+       lda bg1scrolly
        inc a
        sta bg1scrolly
        sep #$20
        sta bg1vscroll
        xba
        sta bg1vscroll  ; set new scroll offset
        cmp #$0
        beq +                   ; change direction if bg1scrolly <> 0, otherwise skip
        sep #$20
        lda scrolldir
        beq setto1
        lda #0
        sta scrolldir
        bra +
setto1:
        lda #1
        sta scrolldir
+
noscroll
        
        sep #$20
        lda framecount
        and #$7F
        bne +
        
        ; now change the scrolling for BG2
        rep #$20
        lda bg2scrollx
        inc a
        and #$01FF
        sta bg2scrollx
        sep #$20
        sta bg2hscroll
        xba
        sta bg2hscroll
        
        rep #$20
        lda bg2scrolly
        dec a
        and #$01FF
        sta bg2scrolly
        sep #$20
        sta bg2vscroll
        xba
        sta bg2vscroll

+       sep #$30
        lda #$80  ; OAM prio rtation?
        sta $2102

        stz $2102 ; upload ball sprite data
        stz $2103
        ldx #0

        ; create ball info table
uploadballs
-       cpx numballs
        blt +   ; upload actual locations of balls
                        ; else upload values to put the sprite off the screen
        lda #0
        sta $2104
        lda #239
        sta $2104
        bra ++
+
        lda ballx,x
        sta $2104
        lda bally,x
        sta $2104
++      lda spritenum,x
        asl a
        sta $2104
        lda #$30
        sta $2104
        inx
        cpx #128
        bne -
        
        ldx #0
        cpx numballs
        bne moveballs
        jmp noballs
moveballs
        lda ballx,x
        clc
        adc balldirx,x  ; add direction value to x
        sta ballx,x
        cmp #8
        bge +   ; if smaller than 8, make direction positive.
        lda balldirx,x
        bpl +   ; already positive
        eor #$FF ; two's complement
        inc a
        sta balldirx,x  
+       
        lda ballx,x
        cmp #$E8        ; if greater, make direction negative
        blt +
        lda balldirx,x
        bmi +   ; already negative
        eor #$FF ; two's complement
        inc a
        sta balldirx,x  
+
        lda bally,x
        clc
        adc balldiry,x  ; add direction value to y
        sta bally,x
        cmp #8
        bge +   ; if smaller than 8, make direction positive.
        lda balldiry,x
        bpl +   ; already positive
        eor #$FF ; two's complement
        inc a
        sta balldiry,x
+       
        lda bally,x
        cmp #$D0        ; if greater, make direction negative
        blt +
        lda balldiry,x
        bmi +   ; already negative
        eor #$FF ; two's complement
        inc a
        sta balldiry,x
+
        lda framecount
        and #7
        bne ++
        
        lda spritenum,x ; time to change sprite num
        and #$3
        cmp #$3
        beq +
        lda spritenum,x
        inc a
        sta spritenum,x
        bra ++
+       lda spritenum,x
        and #$FC
        sta spritenum,x
++
        inx
        cpx numballs
        bge noballs
        jmp moveballs
        
noballs:
        rep #$30
        ply
        plx
        pla
        rti

; *** Initialize SNES to default startup values
; Last revision: 10.24.1996
; Call:
;       Native mode
init_snes:
                pha                             ; Save registers used.
                php                             ; Save processor status.

                rep     #$30                    ; Set AXY to 16-bit
                sep     #$20                    ; Set A to 8-bit
                lda     #$8f                    ; Screen off, full brightness.
                sta     $2100                   ; Store to screen register.
                stz     $2101                   ; sprite register (size + address in VRAM)
                stz     $2102                   ; sprite registers (address of sprite memory [OAM])
                stz     $2103                   ; "
                stz     $2105                   ; set graphics Mode 0
                stz     $2106                   ; no planes, no mosiac
;                stz     $2107                   ; plane 0 map VRAM location ($0000 vram)
;                stz     $2108                   ; plane 1 map VRAM location
;                stz     $2109                   ; plane 2 "
;                stz     $210a                   ; plane 3 "
;                stz     $210b                   ; plane 0+1 tile data location
                stz     $210c                   ; plane 0+2 "
                stz     $210d                   ; plane 0 scroll x (first 8 bits)
                stz     $210d                   ; plane 0 scroll x (last 3 bits) write to reg twice
                stz     $210e                   ; plane 0 scroll y "
                stz     $210e                   ; plane 0 scroll y "
                stz     $210f                   ; plane 1 scroll x (first 8 bits)
                stz     $210f                   ; plane 1 scroll x (last 3 bits) write to reg twice
                stz     $2110                   ; plane 1 scroll y "
                stz     $2110                   ; plane 1 scroll y "
                stz     $2111                   ; plane 2 scroll x (first 8 bits)
                stz     $2111                   ; plane 2 scroll x (last 3 bits) write to reg twice
                stz     $2112                   ; plane 2 scroll y "
                stz     $2112                   ; plane 2 scroll y "
                stz     $2113                   ; plane 3 scroll x (first 8 bits)
                stz     $2113                   ; plane 3 scroll x (last 3 bits) write to reg twice
                stz     $2114                   ; plane 3 scroll y "
                stz     $2114                   ; plane 3 scroll y "
                lda     #$80                    ; increase VRAM after writes to $2118.19
                sta     $2115                   ; store to VRAM increment register
                stz     $2116                   ; VRAM address low
                stz     $2117                   ; VRAM address hi
                stz     $211a                   ; init mode 7 setting reg
                stz     $211b                   ; mode 7 matrix parameter A register (low)
                stz     $211b                   ; Mode 7 matrix parameter A register (low)
                lda     #$01
                sta     $211b                   ; Mode 7 matrix parameter A register (high)
                stz     $211c                   ; Mode 7 matrix parameter B register (low)
                stz     $211c                   ; Mode 7 matrix parameter B register (high)
                stz     $211d                   ; Mode 7 matrix parameter C register (low)
                stz     $211d                   ; Mode 7 matrix parameter C register (high)
                stz     $211e                   ; Mode 7 matrix parameter D register (low)
                lda     #$01
                sta     $211e                   ; Mode 7 matrix parameter D register (high)
                stz     $211f                   ; Mode 7 center position X register (low)
                stz     $211f                   ; Mode 7 center position X register (high)
                stz     $2120                   ; Mode 7 center position Y register (low)
                stz     $2120                   ; Mode 7 center position Y register (high)
                stz     $2121                   ; Color number register ($0-ff)
                stz     $2123                   ; BG1 & BG2 Window mask setting register
                stz     $2124                   ; BG3 & BG4 Window mask setting register
                stz     $2125                   ; OBJ & Color Window mask setting register
                stz     $2126                   ; Window 1 left position register
                stz     $2127                   ; Window 2 left position register
                stz     $2128                   ; Window 3 left position register
                stz     $2129                   ; Window 4 left position register
                stz     $212a                   ; BG1, BG2, BG3, BG4 Window Logic register
                stz     $212b                   ; OBJ, Color Window Logic Register (or,and,xor,xnor)
                stz     $212c                   ; Main Screen designation (planes, sprites enable)
                stz     $212d                   ; Sub Screen designation
                stz     $212e                   ; Window mask for Main Screen
                stz     $212f                   ; Window mask for Sub Screen
                lda     #$30
                sta     $2130                   ; Color addition & screen addition init setting
                stz     $2131                   ; Add/Sub sub designation for screen, sprite, color
                lda     #$e0
                sta     $2132                   ; color data for addition/subtraction
                stz     $2133                   ; Screen setting (interlace x,y/enable SFX data)
                stz     $4200                   ; Enable V-blank, interrupt, Joypad register
                lda     #$ff
                stz     $4201                   ; Programmable I/O port
                stz     $4202                   ; Multiplicand A
                stz     $4203                   ; Multiplier B
                stz     $4204                   ; Multiplier C
                stz     $4205                   ; Multiplicand C
                stz     $4206                   ; Divisor B
                stz     $4207                   ; Horizontal Count Timer
                stz     $4208                   ; Horizontal Count Timer MSB (most significant bit)
                stz     $4209                   ; Vertical Count Timer
                stz     $420a                   ; Vertical Count Timer MSB
                stz     $420b                   ; General DMA enable (bits 0-7)
                stz     $420c                   ; Horizontal DMA (HDMA) enable (bits 0-7)
                stz     $420d                   ; Access cycle designation (slow/fast rom)
                                ldx #0
                        -       stz $0,x
                                inx
                                cpx #$10
                                blt -

                plp                             ; Restore processor status.
                pla                             ; Restore all registers.
                rts

; Generated by the SNEqr Font Editor.

font8:
        .dcb $00, $00, $00, $00, $00, $00, $00, $00 ; Char #0
        .dcb $78, $84, $B4, $A4, $B4, $84, $78, $00 ; Char #1
        .dcb $7C, $82, $B2, $AA, $B2, $AA, $82, $7C ; Char #2
        .dcb $50, $F8, $F8, $F8, $70, $20, $00, $00 ; Char #3
        .dcb $20, $70, $F8, $F8, $70, $20, $00, $00 ; Char #4
        .dcb $7C, $10, $28, $6C, $28, $10, $7C, $00 ; Char #5
        .dcb $38, $7C, $FE, $FE, $6C, $10, $7C, $00 ; Char #6
        .dcb $02, $22, $32, $FA, $32, $22, $02, $00 ; Char #7
        .dcb $55, $AA, $55, $AA, $55, $AA, $55, $AA ; Char #8
        .dcb $00, $38, $6C, $6C, $6C, $6C, $38, $00 ; Char #9
        .dcb $00, $24, $64, $FC, $60, $20, $00, $00 ; Char #10
        .dcb $0E, $06, $0A, $38, $6C, $6C, $38, $00 ; Char #11
        .dcb $38, $6C, $6C, $38, $10, $7C, $10, $00 ; Char #12
        .dcb $00, $24, $64, $FC, $60, $20, $00, $00 ; Char #13
        .dcb $7E, $66, $7E, $66, $E6, $EE, $6E, $04 ; Char #14
        .dcb $92, $54, $38, $6C, $6C, $38, $54, $92 ; Char #15
        .dcb $80, $C0, $E0, $F0, $E0, $C0, $80, $00 ; Char #16
        .dcb $10, $30, $70, $F0, $70, $30, $10, $00 ; Char #17
        .dcb $20, $70, $F8, $20, $F8, $70, $20, $00 ; Char #18
        .dcb $CC, $CC, $CC, $CC, $00, $CC, $CC, $00 ; Char #19
        .dcb $3E, $4A, $4A, $4A, $3E, $0A, $0A, $00 ; Char #20
        .dcb $3C, $44, $30, $48, $30, $88, $F0, $00 ; Char #21
        .dcb $00, $00, $00, $00, $00, $FF, $FF, $00 ; Char #22
        .dcb $30, $30, $30, $30, $30, $30, $30, $30 ; Char #23
        .dcb $20, $70, $F8, $20, $20, $20, $00, $00 ; Char #24
        .dcb $20, $20, $20, $F8, $70, $20, $00, $00 ; Char #25
        .dcb $00, $10, $18, $FC, $18, $10, $00, $00 ; Char #26
        .dcb $00, $20, $60, $FC, $60, $20, $00, $00 ; Char #27
        .dcb $00, $00, $FF, $FF, $00, $00, $00, $00 ; Char #28
        .dcb $00, $28, $6C, $FE, $6C, $28, $00, $00 ; Char #29
        .dcb $00, $00, $10, $38, $7C, $FE, $00, $00 ; Char #30
        .dcb $00, $00, $FE, $7C, $38, $10, $00, $00 ; Char #31
        .dcb $00, $00, $00, $00, $00, $00, $00, $00 ; Char #32
        .dcb $10, $38, $38, $38, $10, $00, $10, $00 ; Char #33
        .dcb $6C, $6C, $24, $00, $00, $00, $00, $00 ; Char #34
        .dcb $6C, $FE, $6C, $FE, $6C, $00, $00, $00 ; Char #35
        .dcb $30, $7C, $B0, $78, $34, $F8, $30, $00 ; Char #36
        .dcb $00, $C6, $CC, $18, $30, $66, $C6, $00 ; Char #37
        .dcb $20, $50, $20, $34, $58, $4C, $34, $00 ; Char #38
        .dcb $30, $30, $10, $00, $00, $00, $00, $00 ; Char #39
        .dcb $18, $30, $60, $60, $60, $30, $18, $00 ; Char #40
        .dcb $30, $18, $0C, $0C, $0C, $18, $30, $00 ; Char #41
        .dcb $B4, $78, $FC, $FC, $78, $B4, $00, $00 ; Char #42
        .dcb $30, $30, $FC, $FC, $30, $30, $00, $00 ; Char #43
        .dcb $00, $00, $00, $00, $00, $30, $30, $40 ; Char #44
        .dcb $00, $00, $FC, $FC, $00, $00, $00, $00 ; Char #45
        .dcb $00, $00, $00, $00, $00, $30, $30, $00 ; Char #46
        .dcb $06, $0C, $18, $18, $30, $60, $C0, $00 ; Char #47
        .dcb $7C, $C6, $C6, $D6, $C6, $C6, $7C, $00 ; Char #48
        .dcb $30, $70, $B0, $30, $30, $30, $FC, $00 ; Char #49
        .dcb $78, $CC, $0C, $18, $30, $60, $FC, $00 ; Char #50
        .dcb $7C, $C6, $06, $1E, $06, $C6, $7C, $00 ; Char #51
        .dcb $1C, $3C, $6C, $FE, $0C, $0C, $0C, $00 ; Char #52
        .dcb $FE, $C0, $C0, $FE, $06, $C6, $7C, $00 ; Char #53
        .dcb $7C, $C6, $C0, $FC, $C6, $C6, $7C, $00 ; Char #54
        .dcb $7E, $C6, $06, $0C, $0C, $18, $18, $00 ; Char #55
        .dcb $7C, $C6, $C6, $7C, $C6, $C6, $7C, $00 ; Char #56
        .dcb $7C, $C6, $C6, $7E, $06, $C6, $7C, $00 ; Char #57
        .dcb $00, $30, $30, $00, $00, $30, $30, $00 ; Char #58
        .dcb $00, $30, $30, $00, $00, $30, $30, $40 ; Char #59
        .dcb $0C, $18, $30, $60, $30, $18, $0C, $00 ; Char #60
        .dcb $00, $7C, $7C, $00, $00, $7C, $7C, $00 ; Char #61
        .dcb $60, $30, $18, $0C, $18, $30, $60, $00 ; Char #62
        .dcb $78, $CC, $18, $30, $30, $00, $30, $00 ; Char #63
        .dcb $7C, $C6, $D6, $D6, $DC, $C0, $7C, $00 ; Char #64
        .dcb $7C, $C6, $C6, $FE, $C6, $C6, $C6, $00 ; Char #65
        .dcb $FC, $C6, $C6, $FC, $C6, $C6, $FC, $00 ; Char #66
        .dcb $7C, $C6, $C0, $C0, $C0, $C6, $7C, $00 ; Char #67
        .dcb $F8, $CC, $C6, $C6, $C6, $CC, $F8, $00 ; Char #68
        .dcb $FE, $C6, $C0, $FC, $C0, $C6, $FE, $00 ; Char #69
        .dcb $FE, $C6, $C0, $FC, $C0, $C0, $C0, $00 ; Char #70
        .dcb $7C, $C6, $C0, $DE, $C6, $C6, $7C, $00 ; Char #71
        .dcb $C6, $C6, $C6, $FE, $C6, $C6, $C6, $00 ; Char #72
        .dcb $FC, $30, $30, $30, $30, $30, $FC, $00 ; Char #73
        .dcb $1E, $0C, $0C, $0C, $0C, $CC, $78, $00 ; Char #74
        .dcb $C6, $CC, $D8, $F0, $D8, $CC, $C6, $00 ; Char #75
        .dcb $C0, $C0, $C0, $C0, $C0, $C6, $FE, $00 ; Char #76
        .dcb $82, $C6, $EE, $D6, $D6, $C6, $C6, $00 ; Char #77
        .dcb $86, $C6, $E6, $D6, $CE, $C6, $C2, $00 ; Char #78
        .dcb $38, $6C, $C6, $C6, $C6, $6C, $38, $00 ; Char #79
        .dcb $FC, $C6, $C6, $FC, $C0, $C0, $C0, $00 ; Char #80
        .dcb $38, $6C, $C6, $C6, $D6, $6C, $3A, $00 ; Char #81
        .dcb $FC, $C6, $C6, $FC, $D8, $CC, $C6, $00 ; Char #82
        .dcb $7C, $C6, $C0, $7C, $06, $C6, $7C, $00 ; Char #83
        .dcb $FC, $30, $30, $30, $30, $30, $30, $00 ; Char #84
        .dcb $C6, $C6, $C6, $C6, $C6, $C6, $7C, $00 ; Char #85
        .dcb $C6, $C6, $C6, $C6, $6C, $38, $10, $00 ; Char #86
        .dcb $C6, $C6, $C6, $D6, $D6, $D6, $6C, $00 ; Char #87
        .dcb $C6, $EE, $7C, $38, $7C, $EE, $C6, $00 ; Char #88
        .dcb $CC, $CC, $CC, $78, $78, $30, $30, $00 ; Char #89
        .dcb $FE, $CC, $18, $30, $60, $C6, $FE, $00 ; Char #90
        .dcb $7C, $60, $60, $60, $60, $60, $7C, $00 ; Char #91
        .dcb $C0, $60, $30, $30, $18, $0C, $06, $00 ; Char #92
        .dcb $7C, $0C, $0C, $0C, $0C, $0C, $7C, $00 ; Char #93
        .dcb $10, $38, $6C, $C6, $00, $00, $00, $00 ; Char #94
        .dcb $00, $00, $00, $00, $00, $00, $FE, $00 ; Char #95
        .dcb $30, $30, $10, $00, $00, $00, $00, $00 ; Char #96
        .dcb $00, $00, $78, $0C, $7C, $CC, $7A, $00 ; Char #97
        .dcb $C0, $C0, $FC, $C6, $C6, $C6, $FC, $00 ; Char #98
        .dcb $00, $00, $7C, $C6, $C0, $C6, $7C, $00 ; Char #99
        .dcb $06, $06, $7E, $C6, $C6, $C6, $7E, $00 ; Char #100
        .dcb $00, $00, $7C, $C6, $FC, $C0, $7C, $00 ; Char #101
        .dcb $18, $34, $30, $FC, $30, $30, $30, $00 ; Char #102
        .dcb $00, $00, $7C, $C6, $C6, $7E, $06, $7C ; Char #103
        .dcb $C0, $C0, $FC, $C6, $C6, $C6, $C6, $00 ; Char #104
        .dcb $30, $30, $00, $70, $30, $30, $78, $00 ; Char #105
        .dcb $0C, $0C, $00, $0C, $0C, $0C, $CC, $78 ; Char #106
        .dcb $C0, $C0, $CC, $D8, $F0, $D8, $CC, $00 ; Char #107
        .dcb $70, $30, $30, $30, $30, $30, $78, $00 ; Char #108
        .dcb $00, $00, $AC, $D6, $D6, $D6, $D6, $00 ; Char #109
        .dcb $00, $00, $BC, $EE, $C6, $C6, $C6, $00 ; Char #110
        .dcb $00, $00, $7C, $C6, $C6, $C6, $7C, $00 ; Char #111
        .dcb $00, $00, $FC, $C6, $C6, $FC, $C0, $C0 ; Char #112
        .dcb $00, $00, $78, $CC, $CC, $7C, $0E, $0C ; Char #113
        .dcb $00, $00, $BC, $E6, $C0, $C0, $C0, $00 ; Char #114
        .dcb $00, $00, $7C, $C0, $7C, $06, $7C, $00 ; Char #115
        .dcb $30, $30, $FC, $30, $30, $34, $18, $00 ; Char #116
        .dcb $00, $00, $CC, $CC, $CC, $CC, $7A, $00 ; Char #117
        .dcb $00, $00, $C6, $C6, $6C, $38, $10, $00 ; Char #118
        .dcb $00, $00, $C6, $C6, $D6, $D6, $6C, $00 ; Char #119
        .dcb $00, $00, $C6, $6C, $38, $6C, $C6, $00 ; Char #120
        .dcb $00, $00, $C6, $C6, $C6, $7E, $06, $7C ; Char #121
        .dcb $00, $00, $FC, $18, $30, $60, $FC, $00 ; Char #122
        .dcb $18, $30, $30, $60, $30, $30, $18, $00 ; Char #123
        .dcb $30, $30, $30, $30, $30, $30, $30, $00 ; Char #124
        .dcb $60, $30, $30, $18, $30, $30, $60, $00 ; Char #125
        .dcb $76, $DC, $00, $00, $00, $00, $00, $00 ; Char #126
        .dcb $10, $28, $28, $44, $44, $FE, $00, $00 ; Char #127

textscreen:
        .dcb "                                " ;
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb " This is a little test program. " 
        .dcb "                                " 
        .dcb " The purpose of the program is  " 
        .dcb " to test a few things.  Also,   " 
        .dcb " I wrote it because I'm curious " 
        .dcb " whether I can actually program " 
        .dcb " the SNES.  Now that I've       " 
        .dcb " written the program, and--     " 
        .dcb " gasp--it runs, I think I'll    " 
        .dcb " use it to test other stuff     " 
        .dcb " doesn't want to work on my     " 
        .dcb " emulator, such as HDMA and     " 
        .dcb " sprites.  But that's a bit,    " 
        .dcb " shall we say, tricky.          " 
        .dcb "                                " 
        .dcb " In the meantime, greetings to  " 
        .dcb " all who bother to run this     " 
        .dcb " simple little mode 0 demo.     " 
        .dcb "                                " 
        .dcb " Thanks to the x816 assembler   " 
        .dcb " dude for the init code... of   " 
        .dcb " course I could have ripped     " 
        .dcb " code from anybody, but I have  " 
        .dcb " to have a credits section,     " 
        .dcb " after all.  I mean, how else   " 
        .dcb " am I gonna use up all this     " 
        .dcb " empty space?  I have sixty-    " 
        .dcb " four fricking lines of text to " 
        .dcb " deal with, even though I only  " 
        .dcb " get 30 chars per line.  Life   " 
        .dcb " sucks, don't it?               " 
        .dcb "                                " 
        .dcb " Remember, the latest version   " 
        .dcb " of my emulator, SNEqr, is      " 
        .dcb " always available on the 'net   " 
        .dcb " at qemu.home.ml.org.           " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb "                                " 
        .dcb " How kind of you to read the    " 
        .dcb " text at the bottom.  Bless     " 
        .dcb " you.                           " 
        .dcb "                                " 
        .dcb "                                " 

; SNES Palette code generated by Qwertie's Tile Editor. (meant for use in X816.)
; Call upload_palette in native mode.  Some MMIO and CPU registers affected.
.detect on      ; autodetect size of immediate values

upload_palette
        sep #$20
        rep #$10
        ldx #$0
        lda #$0
        sta $2121
-       lda palette_data,x
        sta $2122
        inx
        cpx #$200
        bne -
        rts

palette_data
        .dcw $0000,$7FEF,$7FFF,$7FFF,$0000,$3FFF,$7FFF,$7FFF,$0000,$7DFF,$7FFF,$7FFF,$0000,$3FEF,$7FFF,$7FFF ; 0 to 15
        .dcw $0000,$0C60,$7FFF,$7FFF,$0000,$3DE0,$7FFF,$7FFF,$0000,$6B40,$7FFF,$7FFF,$0000,$7FEC,$7FFF,$7FFF ; 16 to 31
        .dcw $0000,$1084,$7FFF,$7FFF,$0000,$1860,$7FFF,$7FFF,$0000,$28C0,$7FFF,$7FFF,$0000,$3523,$7FFF,$7FFF ; 32 to 47
        .dcw $0060,$00E0,$0160,$01E0,$0260,$02E0,$0360,$03E0,$0FE3,$1FE7,$2BEA,$3BEE,$47F1,$57F5,$63F8,$73FC ; 48 to 63
        .dcw $0061,$00C3,$0124,$0186,$01E8,$0269,$02CB,$032C,$038E,$03F0,$13F2,$27F4,$37F6,$4BF9,$5BFB,$6FFD ; 64 to 79
        .dcw $0042,$0084,$00C6,$0129,$016B,$01AD,$01EF,$0252,$0294,$02D6,$0339,$037B,$03BD,$03FF,$2BFF,$57FF ; 80 to 95
        .dcw $0023,$0066,$0089,$00CC,$010F,$0133,$0176,$0199,$01DC,$021F,$125F,$269F,$36DF,$4B3F,$5B7F,$6FBF ; 96 to 111
        .dcw $0004,$0009,$000D,$0012,$0016,$001B,$001F,$0C7F,$18DF,$253F,$319F,$3DFF,$4E7F,$5ADF,$673F,$739F ; 112 to 127
        .dcw $0000,$001F,$03E0,$03FF,$7C00,$7C1F,$7FE0,$7FFF,$0842,$18C6,$294A,$4631,$56B5,$6739,$7ED6,$6FF7 ; 128 to 143
        .dcw $0C03,$1806,$2409,$300C,$3C0F,$4C13,$5816,$6419,$701C,$7C1F,$7C9F,$7D3F,$7DBF,$7E5F,$7EDF,$7F7F ; 144 to 159
        .dcw $1002,$2404,$3406,$4809,$580B,$6C0D,$7C10,$7C71,$7CD3,$7D34,$7D96,$7DF7,$7E79,$7EDB,$7F3C,$7F9E ; 160 to 175
        .dcw $1000,$2400,$3400,$4800,$5800,$6C00,$7C00,$7C63,$7CC6,$7D29,$7D8C,$7DEF,$7E73,$7ED6,$7F39,$7F9C ; 176 to 191
        .dcw $0C40,$1C80,$2CC0,$3D00,$4D40,$5D80,$6DC0,$7E00,$7E23,$7E67,$7EAA,$7EEE,$7F11,$7F55,$7F98,$7FDC ; 192 to 207
        .dcw $0C01,$1C23,$2845,$3867,$4488,$54AA,$60CC,$70EE,$7D10,$7D51,$7DB3,$7E15,$7E77,$7ED9,$7F3B,$7F9D ; 208 to 223
        .dcw $0440,$08A1,$10E2,$1542,$19A3,$21E4,$2644,$2AA5,$32E6,$3746,$3BA7,$43E8,$4FEC,$5BF1,$67F6,$73FB ; 224 to 239
        .dcw $0022,$0445,$0888,$08AB,$0CEE,$1111,$1554,$1577,$19BA,$1DDC,$221F,$2E5F,$3EBF,$4EFF,$5F5F,$6FBF ; 240 to 255
; Whew.

; SNES tile code generated by Qwertie's Tile Editor. (meant for use in X816.)
; Call upload_tiles in native mode; 16-bit A should be set to the word VRAM
; address (location to start upload).  Some MMIO and CPU registers affected.
; Manually edit the code if you don't want to upload all 448 tiles.
.detect on      ; autodetect size of immediate values

upload_tiles
        sta $2116
        sep #$20
        rep #$10
        lda #$80
        sta $2115
        ldx #$0
        rep #$20
-       lda tile_data,x
        sta $2118
        inx
        inx
        cpx #$400
        bne -
        rts

tile_data
        .dcd $1F000708,$7F073F41,$F8187888,$E123E023,$1F1C0F07,$7F607F30,$FF87FF47,$FEDFFF9F ; Tile #0
        .dcd $C0308060,$F0ECE0D8,$3C333866,$9EFD1ED9,$F000E080,$FC00F800,$FFC0FEC0,$7FE0FFE0 ; Tile #1
        .dcd $0718030C,$3F471F61,$789838C8,$61A362A1,$1F000F03,$7F007F00,$FF07FF07,$FE1FFF1F ; Tile #2
        .dcd $F0008060,$FCE0F8C0,$3E313E60,$DEB9DE11,$F070E080,$FC0CF818,$FFC2FEC6,$7FE2FFE2 ; Tile #3
        .dcd $0718000F,$3F471F61,$789838C8,$63A363A3,$1F000F00,$7F007F00,$FF07FF07,$FE1FFF1F ; Tile #4
        .dcd $C03000E0,$F0ECE0D8,$3C333866,$FEF9DCD3,$F000E000,$FC00F800,$FFC0FEC0,$7FE2FFE0 ; Tile #5
        .dcd $0718000F,$3F471F61,$78983CCC,$E122F033,$1F000F00,$7F007F00,$FF07FF03,$FEDFFFCF ; Tile #6
        .dcd $C03000E0,$F0ECE0D8,$3C333866,$9C7B1CD3,$F000E000,$FC00F800,$FFC0FEC0,$7FE0FFE0 ; Tile #7
        .dcd $00000000,$003C003F,$07340726,$0E2D0635,$00000000,$3F3F3F3F,$3F383F38,$3F303F38 ; Tile #8
        .dcd $00000000,$001C00FC,$F034C04C,$30D47094,$00000000,$FCFCFCFC,$FC0CFC3C,$FC0CFC0C ; Tile #9
        .dcd $06000700,$1B030800,$36061303,$2E082E0C,$01070007,$071C070F,$0E390F1C,$1E311E31 ; Tile #10
        .dcd $6000C000,$CFC01800,$7B18F130,$52107A18,$80E000C0,$F03FE0F8,$7C87FE0F,$5CAE7C86 ; Tile #11
        .dcd $03000100,$18000600,$27003300,$CC024C03,$03030101,$1F1F0707,$3F383F3C,$FEF17F70 ; Tile #12
        .dcd $C0008000,$30006000,$98009000,$23C04E80,$C0C08080,$F0F0E0E0,$F878F070,$FF1FFE3E ; Tile #13
        .dcd $00000000,$F8FE0F0F,$C7E4C1D1,$66654665,$00000000,$FFFF0F0F,$FFF8FFFE,$7F787F78 ; Tile #14
        .dcd $E8F83838,$68688888,$F43CECEC,$32D2F616,$F8F83838,$F898F8F8,$FC0CFC1C,$FE0EFE0E ; Tile #15
        .dcd $789971B3,$3F473E4E,$0F301F61,$0007011E,$FF07FE0F,$7F007F01,$3F007F00,$07001F00 ; Tile #16
        .dcd $0ECD16F5,$FCFA1E1D,$F08CF8E6,$00F0E018,$FFF0FFE8,$FE00FFE0,$FC00FE00,$F000F800 ; Tile #17
        .dcd $789973B0,$3F473E4E,$0F301F61,$0007011E,$FF07FF0F,$7F007F01,$3F007F00,$07001F00 ; Tile #18
        .dcd $1E91DE39,$FCE27C73,$F00CF8C6,$00F0E018,$FFE2FFE2,$FE00FF80,$FC00FE00,$F000F800 ; Tile #19
        .dcd $789873B3,$3F473E4E,$0F301F61,$0304011E,$FF07FF0F,$7F007F01,$3F007F00,$07031F00 ; Tile #20
        .dcd $1E11FEF9,$FCE27E71,$F804F8C6,$8070F008,$FFE2FFE2,$FE0CFF86,$FC18FE08,$F080F8F0 ; Tile #21
        .dcd $789BF132,$3F477E0E,$1F203F41,$03040D12,$FF47FECF,$7F207F61,$3F187F30,$07031F0C ; Tile #22
        .dcd $1C939CFB,$FCE27C73,$F00CF8C6,$8070E018,$FFE07FE0,$FE00FF80,$FC00FE00,$F080F800 ; Tile #23
        .dcd $0F280E29,$09290727,$003F0030,$00000000,$3F303F30,$3F363F38,$3F3F3F3F,$00000000 ; Tile #24
        .dcd $F01430D4,$E0E4E024,$00FC000C,$00000000,$FC0CFC0C,$FC1CFC1C,$FCFCFCFC,$00000000 ; Tile #25
        .dcd $4F0F6F0C,$7C00C000,$01000F00,$00000000,$3F701F70,$037F3FFF,$0001000F,$00000000 ; Tile #26
        .dcd $F4F0F630,$2C20E4E0,$F8008800,$00003000,$F80CF80E,$F0DCF81C,$00F870F8,$00000030 ; Tile #27
        .dcd $2403E402,$12003300,$0E001800,$01000300,$3F38FEF9,$1F1D3F3C,$0F0F1F1F,$01010303 ; Tile #28
        .dcd $66803140,$3000DC00,$C0006000,$00008000,$FE1E7F8F,$F0F0FC3C,$C0C0E0E0,$00008080 ; Tile #29
        .dcd $26312621,$13103730,$1A1E131B,$0F0F0808,$3F383F38,$1F1C3F38,$1F1D1F1C,$0F0F0F0F ; Tile #30
        .dcd $3ACABA4A,$F1F1FB1B,$F8F88F8F,$80808080,$FE067E06,$FF0FFF07,$F8F8FF7F,$80808080 ; Tile #31


        .dcd $66001C00,$8200C200,$4400C200,$00003800,$66001C00,$8200C200,$4400C200,$00003800 ; Tile #0
        .dcd $10000000,$10003000,$10001000,$00007C00,$10000000,$10003000,$10001000,$00007C00 ; Tile #1
        .dcd $3C000000,$0C002400,$20003800,$00003C00,$3C000000,$0C002400,$20003800,$00003C00 ; Tile #2
        .dcd $66003C00,$1E000200,$02000600,$00007E00,$66003C00,$1E000200,$02000600,$00007E00 ; Tile #3
        .dcd $24002400,$1E003400,$04000400,$00000400,$24002400,$1E003400,$04000400,$00000400 ; Tile #4
        .dcd $7E000000,$40004000,$02007E00,$00007E00,$7E000000,$40004000,$02007E00,$00007E00 ; Tile #5
        .dcd $3E000000,$7E006000,$7A004200,$00000E00,$3E000000,$7E006000,$7A004200,$00000E00 ; Tile #6
        .dcd $3E000000,$0C000600,$30001800,$00004000,$3E000000,$0C000600,$30001800,$00004000 ; Tile #7
        .dcd $3C000000,$3C004200,$42004200,$00003C00,$3C000000,$3C004200,$42004200,$00003C00 ; Tile #8
        .dcd $7E000000,$7E004600,$62000200,$00007E00,$7E000000,$7E004600,$62000200,$00007E00 ; Tile #9
        .dcd $1E000000,$22003200,$42007E00,$00004200,$1E000000,$22003200,$42007E00,$00004200 ; Tile #10
        .dcd $7C000000,$4C006400,$4C007800,$00007C00,$7C000000,$4C006400,$4C007800,$00007C00 ; Tile #11
        .dcd $3E000000,$60002000,$42004000,$00007E00,$3E000000,$60002000,$42004000,$00007E00 ; Tile #12
        .dcd $3C000000,$26002600,$26002600,$00003C00,$3C000000,$26002600,$26002600,$00003C00 ; Tile #13
        .dcd $7C000000,$78004000,$40004000,$00007C00,$7C000000,$78004000,$40004000,$00007C00 ; Tile #14
        .dcd $3E000000,$20002000,$20003C00,$00002000,$3E000000,$20002000,$20003C00,$00002000 ; Tile #15
        .dcd $0066001C,$008200C2,$004400C2,$00000038,$00000000,$00000000,$00000000,$00000000 ; Tile #16
        .dcd $00100000,$00100030,$00100010,$0000007C,$00000000,$00000000,$00000000,$00000000 ; Tile #17
        .dcd $003C0000,$000C0024,$00200038,$0000003C,$00000000,$00000000,$00000000,$00000000 ; Tile #18
        .dcd $0066003C,$001E0002,$00020006,$0000007E,$00000000,$00000000,$00000000,$00000000 ; Tile #19
        .dcd $00240024,$001E0034,$00040004,$00000004,$00000000,$00000000,$00000000,$00000000 ; Tile #20
        .dcd $007E0000,$00400040,$0002007E,$0000007E,$00000000,$00000000,$00000000,$00000000 ; Tile #21
        .dcd $003E0000,$007E0060,$007A0042,$0000000E,$00000000,$00000000,$00000000,$00000000 ; Tile #22
        .dcd $003E0000,$000C0006,$00300018,$00000040,$00000000,$00000000,$00000000,$00000000 ; Tile #23
        .dcd $003C0000,$003C0042,$00420042,$0000003C,$00000000,$00000000,$00000000,$00000000 ; Tile #24
        .dcd $007E0000,$007E0046,$00620002,$0000007E,$00000000,$00000000,$00000000,$00000000 ; Tile #25
        .dcd $001E0000,$00220032,$0042007E,$00000042,$00000000,$00000000,$00000000,$00000000 ; Tile #26
        .dcd $007C0000,$004C0064,$004C0078,$0000007C,$00000000,$00000000,$00000000,$00000000 ; Tile #27
        .dcd $003E0000,$00600020,$00420040,$0000007E,$00000000,$00000000,$00000000,$00000000 ; Tile #28
        .dcd $003C0000,$00260026,$00260026,$0000003C,$00000000,$00000000,$00000000,$00000000 ; Tile #29
        .dcd $007C0000,$00780040,$00400040,$0000007C,$00000000,$00000000,$00000000,$00000000 ; Tile #30
        .dcd $003E0000,$00200020,$0020003C,$00000020,$00000000,$00000000,$00000000,$00000000 ; Tile #31
        .dcd $66001C00,$8200C200,$4400C200,$00003800,$00000000,$00000000,$00000000,$00000000 ; Tile #32
        .dcd $10000000,$10003000,$10001000,$00007C00,$00000000,$00000000,$00000000,$00000000 ; Tile #33
        .dcd $3C000000,$0C002400,$20003800,$00003C00,$00000000,$00000000,$00000000,$00000000 ; Tile #34
        .dcd $66003C00,$1E000200,$02000600,$00007E00,$00000000,$00000000,$00000000,$00000000 ; Tile #35
        .dcd $24002400,$1E003400,$04000400,$00000400,$00000000,$00000000,$00000000,$00000000 ; Tile #36
        .dcd $7E000000,$40004000,$02007E00,$00007E00,$00000000,$00000000,$00000000,$00000000 ; Tile #37
        .dcd $3E000000,$7E006000,$7A004200,$00000E00,$00000000,$00000000,$00000000,$00000000 ; Tile #38
        .dcd $3E000000,$0C000600,$30001800,$00004000,$00000000,$00000000,$00000000,$00000000 ; Tile #39
        .dcd $3C000000,$3C004200,$42004200,$00003C00,$00000000,$00000000,$00000000,$00000000 ; Tile #40
        .dcd $7E000000,$7E004600,$62000200,$00007E00,$00000000,$00000000,$00000000,$00000000 ; Tile #41
        .dcd $1E000000,$22003200,$42007E00,$00004200,$00000000,$00000000,$00000000,$00000000 ; Tile #42
        .dcd $7C000000,$4C006400,$4C007800,$00007C00,$00000000,$00000000,$00000000,$00000000 ; Tile #43
        .dcd $3E000000,$60002000,$42004000,$00007E00,$00000000,$00000000,$00000000,$00000000 ; Tile #44
        .dcd $3C000000,$26002600,$26002600,$00003C00,$00000000,$00000000,$00000000,$00000000 ; Tile #45
        .dcd $7C000000,$78004000,$40004000,$00007C00,$00000000,$00000000,$00000000,$00000000 ; Tile #46
        .dcd $3E000000,$20002000,$20003C00,$00002000,$00000000,$00000000,$00000000,$00000000 ; Tile #47
        .dcd $66661C1C,$8282C2C2,$4444C2C2,$00003838,$00000000,$00000000,$00000000,$00000000 ; Tile #48
        .dcd $10100000,$10103030,$10101010,$00007C7C,$00000000,$00000000,$00000000,$00000000 ; Tile #49
        .dcd $3C3C0000,$0C0C2424,$20203838,$00003C3C,$00000000,$00000000,$00000000,$00000000 ; Tile #50
        .dcd $66663C3C,$1E1E0202,$02020606,$00007E7E,$00000000,$00000000,$00000000,$00000000 ; Tile #51
        .dcd $24242424,$1E1E3434,$04040404,$00000404,$00000000,$00000000,$00000000,$00000000 ; Tile #52
        .dcd $7E7E0000,$40404040,$02027E7E,$00007E7E,$00000000,$00000000,$00000000,$00000000 ; Tile #53
        .dcd $3E3E0000,$7E7E6060,$7A7A4242,$00000E0E,$00000000,$00000000,$00000000,$00000000 ; Tile #54
        .dcd $3E3E0000,$0C0C0606,$30301818,$00004040,$00000000,$00000000,$00000000,$00000000 ; Tile #55
        .dcd $3C3C0000,$3C3C4242,$42424242,$00003C3C,$00000000,$00000000,$00000000,$00000000 ; Tile #56
        .dcd $7E7E0000,$7E7E4646,$62620202,$00007E7E,$00000000,$00000000,$00000000,$00000000 ; Tile #57
        .dcd $1E1E0000,$22223232,$42427E7E,$00004242,$00000000,$00000000,$00000000,$00000000 ; Tile #58
        .dcd $7C7C0000,$4C4C6464,$4C4C7878,$00007C7C,$00000000,$00000000,$00000000,$00000000 ; Tile #59
        .dcd $3E3E0000,$60602020,$42424040,$00007E7E,$00000000,$00000000,$00000000,$00000000 ; Tile #60
        .dcd $3C3C0000,$26262626,$26262626,$00003C3C,$00000000,$00000000,$00000000,$00000000 ; Tile #61
        .dcd $7C7C0000,$78784040,$40404040,$00007C7C,$00000000,$00000000,$00000000,$00000000 ; Tile #62
        .dcd $3E3E0000,$20202020,$20203C3C,$00002020,$00000000,$00000000,$00000000,$00000000 ; Tile #63
        .dcd $00000000,$00000000,$00000000,$00000000,$0066001C,$008200C2,$004400C2,$00000038 ; Tile #64
        .dcd $00000000,$00000000,$00000000,$00000000,$00100000,$00100030,$00100010,$0000007C ; Tile #65
        .dcd $00000000,$00000000,$00000000,$00000000,$003C0000,$000C0024,$00200038,$0000003C ; Tile #66
        .dcd $00000000,$00000000,$00000000,$00000000,$0066003C,$001E0002,$00020006,$0000007E ; Tile #67
        .dcd $00000000,$00000000,$00000000,$00000000,$00240024,$001E0034,$00040004,$00000004 ; Tile #68
        .dcd $00000000,$00000000,$00000000,$00000000,$007E0000,$00400040,$0002007E,$0000007E ; Tile #69
        .dcd $00000000,$00000000,$00000000,$00000000,$003E0000,$007E0060,$007A0042,$0000000E ; Tile #70
        .dcd $00000000,$00000000,$00000000,$00000000,$003E0000,$000C0006,$00300018,$00000040 ; Tile #71
        .dcd $00000000,$00000000,$00000000,$00000000,$003C0000,$003C0042,$00420042,$0000003C ; Tile #72
        .dcd $00000000,$00000000,$00000000,$00000000,$007E0000,$007E0046,$00620002,$0000007E ; Tile #73
        .dcd $00000000,$00000000,$00000000,$00000000,$001E0000,$00220032,$0042007E,$00000042 ; Tile #74
        .dcd $00000000,$00000000,$00000000,$00000000,$007C0000,$004C0064,$004C0078,$0000007C ; Tile #75
        .dcd $00000000,$00000000,$00000000,$00000000,$003E0000,$00600020,$00420040,$0000007E ; Tile #76
        .dcd $00000000,$00000000,$00000000,$00000000,$003C0000,$00260026,$00260026,$0000003C ; Tile #77
        .dcd $00000000,$00000000,$00000000,$00000000,$007C0000,$00780040,$00400040,$0000007C ; Tile #78
        .dcd $00000000,$00000000,$00000000,$00000000,$003E0000,$00200020,$0020003C,$00000020 ; Tile #79
        .dcd $0066001C,$008200C2,$004400C2,$00000038,$0066001C,$008200C2,$004400C2,$00000038 ; Tile #80
        .dcd $00100000,$00100030,$00100010,$0000007C,$00100000,$00100030,$00100010,$0000007C ; Tile #81
        .dcd $003C0000,$000C0024,$00200038,$0000003C,$003C0000,$000C0024,$00200038,$0000003C ; Tile #82
        .dcd $0066003C,$001E0002,$00020006,$0000007E,$0066003C,$001E0002,$00020006,$0000007E ; Tile #83
        .dcd $00240024,$001E0034,$00040004,$00000004,$00240024,$001E0034,$00040004,$00000004 ; Tile #84
        .dcd $007E0000,$00400040,$0002007E,$0000007E,$007E0000,$00400040,$0002007E,$0000007E ; Tile #85
        .dcd $003E0000,$007E0060,$007A0042,$0000000E,$003E0000,$007E0060,$007A0042,$0000000E ; Tile #86
        .dcd $003E0000,$000C0006,$00300018,$00000040,$003E0000,$000C0006,$00300018,$00000040 ; Tile #87
        .dcd $003C0000,$003C0042,$00420042,$0000003C,$003C0000,$003C0042,$00420042,$0000003C ; Tile #88
        .dcd $007E0000,$007E0046,$00620002,$0000007E,$007E0000,$007E0046,$00620002,$0000007E ; Tile #89
        .dcd $001E0000,$00220032,$0042007E,$00000042,$001E0000,$00220032,$0042007E,$00000042 ; Tile #90
        .dcd $007C0000,$004C0064,$004C0078,$0000007C,$007C0000,$004C0064,$004C0078,$0000007C ; Tile #91
        .dcd $003E0000,$00600020,$00420040,$0000007E,$003E0000,$00600020,$00420040,$0000007E ; Tile #92
        .dcd $003C0000,$00260026,$00260026,$0000003C,$003C0000,$00260026,$00260026,$0000003C ; Tile #93
        .dcd $007C0000,$00780040,$00400040,$0000007C,$007C0000,$00780040,$00400040,$0000007C ; Tile #94
        .dcd $003E0000,$00200020,$0020003C,$00000020,$003E0000,$00200020,$0020003C,$00000020 ; Tile #95
        .dcd $66001C00,$8200C200,$4400C200,$00003800,$0066001C,$008200C2,$004400C2,$00000038 ; Tile #96
        .dcd $10000000,$10003000,$10001000,$00007C00,$00100000,$00100030,$00100010,$0000007C ; Tile #97
        .dcd $3C000000,$0C002400,$20003800,$00003C00,$003C0000,$000C0024,$00200038,$0000003C ; Tile #98
        .dcd $66003C00,$1E000200,$02000600,$00007E00,$0066003C,$001E0002,$00020006,$0000007E ; Tile #99
        .dcd $24002400,$1E003400,$04000400,$00000400,$00240024,$001E0034,$00040004,$00000004 ; Tile #100
        .dcd $7E000000,$40004000,$02007E00,$00007E00,$007E0000,$00400040,$0002007E,$0000007E ; Tile #101
        .dcd $3E000000,$7E006000,$7A004200,$00000E00,$003E0000,$007E0060,$007A0042,$0000000E ; Tile #102
        .dcd $3E000000,$0C000600,$30001800,$00004000,$003E0000,$000C0006,$00300018,$00000040 ; Tile #103
        .dcd $3C000000,$3C004200,$42004200,$00003C00,$003C0000,$003C0042,$00420042,$0000003C ; Tile #104
        .dcd $7E000000,$7E004600,$62000200,$00007E00,$007E0000,$007E0046,$00620002,$0000007E ; Tile #105
        .dcd $1E000000,$22003200,$42007E00,$00004200,$001E0000,$00220032,$0042007E,$00000042 ; Tile #106
        .dcd $7C000000,$4C006400,$4C007800,$00007C00,$007C0000,$004C0064,$004C0078,$0000007C ; Tile #107
        .dcd $3E000000,$60002000,$42004000,$00007E00,$003E0000,$00600020,$00420040,$0000007E ; Tile #108
        .dcd $3C000000,$26002600,$26002600,$00003C00,$003C0000,$00260026,$00260026,$0000003C ; Tile #109
        .dcd $7C000000,$78004000,$40004000,$00007C00,$007C0000,$00780040,$00400040,$0000007C ; Tile #110
        .dcd $3E000000,$20002000,$20003C00,$00002000,$003E0000,$00200020,$0020003C,$00000020 ; Tile #111
        .dcd $66661C1C,$8282C2C2,$4444C2C2,$00003838,$66661C1C,$8282C2C2,$4444C2C2,$00003838 ; Tile #112
        .dcd $10100000,$10103030,$10101010,$00007C7C,$10100000,$10103030,$10101010,$00007C7C ; Tile #113
        .dcd $3C3C0000,$0C0C2424,$20203838,$00003C3C,$3C3C0000,$0C0C2424,$20203838,$00003C3C ; Tile #114
        .dcd $66663C3C,$1E1E0202,$02020606,$00007E7E,$66663C3C,$1E1E0202,$02020606,$00007E7E ; Tile #115
        .dcd $24242424,$1E1E3434,$04040404,$00000404,$24242424,$1E1E3434,$04040404,$00000404 ; Tile #116
        .dcd $7E7E0000,$40404040,$02027E7E,$00007E7E,$7E7E0000,$40404040,$02027E7E,$00007E7E ; Tile #117
        .dcd $3E3E0000,$7E7E6060,$7A7A4242,$00000E0E,$3E3E0000,$7E7E6060,$7A7A4242,$00000E0E ; Tile #118
        .dcd $3E3E0000,$0C0C0606,$30301818,$00004040,$3E3E0000,$0C0C0606,$30301818,$00004040 ; Tile #119
        .dcd $3C3C0000,$3C3C4242,$42424242,$00003C3C,$3C3C0000,$3C3C4242,$42424242,$00003C3C ; Tile #120
        .dcd $7E7E0000,$7E7E4646,$62620202,$00007E7E,$7E7E0000,$7E7E4646,$62620202,$00007E7E ; Tile #121
        .dcd $1E1E0000,$22223232,$42427E7E,$00004242,$1E1E0000,$22223232,$42427E7E,$00004242 ; Tile #122
        .dcd $7C7C0000,$4C4C6464,$4C4C7878,$00007C7C,$7C7C0000,$4C4C6464,$4C4C7878,$00007C7C ; Tile #123
        .dcd $3E3E0000,$60602020,$42424040,$00007E7E,$3E3E0000,$60602020,$42424040,$00007E7E ; Tile #124
        .dcd $3C3C0000,$26262626,$26262626,$00003C3C,$3C3C0000,$26262626,$26262626,$00003C3C ; Tile #125
        .dcd $7C7C0000,$78784040,$40404040,$00007C7C,$7C7C0000,$78784040,$40404040,$00007C7C ; Tile #126
        .dcd $3E3E0000,$20202020,$20203C3C,$00002020,$3E3E0000,$20202020,$20203C3C,$00002020 ; Tile #127
        .dcd $E0000000,$AE00AE00,$AE00AE00,$0000E000,$E0000000,$AE00AE00,$AE00AE00,$0000E000 ; Tile #128
        .dcd $40000000,$5E005E00,$5E005E00,$00004000,$40000000,$5E005E00,$5E005E00,$00004000 ; Tile #129
        .dcd $E0000000,$2E002E00,$8000EE00,$0000E000,$E0000000,$2E002E00,$8000EE00,$0000E000 ; Tile #130
        .dcd $E0000000,$AE002E00,$2E006E00,$0000E000,$E0000000,$AE002E00,$2E006E00,$0000E000 ; Tile #131
        .dcd $A0008000,$EE00AE00,$20002E00,$00002000,$A0008000,$EE00AE00,$20002E00,$00002000 ; Tile #132
        .dcd $E0000000,$EE008E00,$20002E00,$0000E000,$E0000000,$EE008E00,$20002E00,$0000E000 ; Tile #133
        .dcd $E0000000,$EE008E00,$A000AE00,$0000E000,$E0000000,$EE008E00,$A000AE00,$0000E000 ; Tile #134
        .dcd $F0000000,$36001000,$C6006600,$00008000,$F0000000,$36001000,$C6006600,$00008000 ; Tile #135
        .dcd $E0000000,$EE00AE00,$AE00AE00,$0000E000,$E0000000,$EE00AE00,$AE00AE00,$0000E000 ; Tile #136
        .dcd $E0000000,$EE00A000,$2E002E00,$0000E000,$E0000000,$EE00A000,$2E002E00,$0000E000 ; Tile #137
        .dcd $E0000000,$AE00AE00,$AE00EE00,$0000A000,$E0000000,$AE00AE00,$AE00EE00,$0000A000 ; Tile #138
        .dcd $C0000000,$CE00AE00,$AE00AE00,$0000C000,$C0000000,$CE00AE00,$AE00AE00,$0000C000 ; Tile #139
        .dcd $E0000000,$8E00A000,$AE008E00,$0000E000,$E0000000,$8E00A000,$AE008E00,$0000E000 ; Tile #140
        .dcd $C0000000,$AE00A000,$AE00AE00,$0000C000,$C0000000,$AE00A000,$AE00AE00,$0000C000 ; Tile #141
        .dcd $E0000000,$CE008000,$8E008E00,$0000E000,$E0000000,$CE008000,$8E008E00,$0000E000 ; Tile #142
        .dcd $E0000000,$9C009C00,$8000DC00,$00008000,$E0000000,$9C009C00,$8000DC00,$00008000 ; Tile #143
        .dcd $00E00000,$00AE00AE,$00AE00AE,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #144
        .dcd $00400000,$005E005E,$005E005E,$00000040,$00000000,$00000000,$00000000,$00000000 ; Tile #145
        .dcd $00E00000,$002E002E,$008000EE,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #146
        .dcd $00E00000,$00AE002E,$002E006E,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #147
        .dcd $00A00080,$00EE00AE,$0020002E,$00000020,$00000000,$00000000,$00000000,$00000000 ; Tile #148
        .dcd $00E00000,$00EE008E,$0020002E,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #149
        .dcd $00E00000,$00EE008E,$00A000AE,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #150
        .dcd $00F00000,$00360010,$00C60066,$00000080,$00000000,$00000000,$00000000,$00000000 ; Tile #151
        .dcd $00E00000,$00EE00AE,$00AE00AE,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #152
        .dcd $00E00000,$00EE00A0,$002E002E,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #153
        .dcd $00E00000,$00AE00AE,$00AE00EE,$000000A0,$00000000,$00000000,$00000000,$00000000 ; Tile #154
        .dcd $00C00000,$00CE00AE,$00AE00AE,$000000C0,$00000000,$00000000,$00000000,$00000000 ; Tile #155
        .dcd $00E00000,$008E00A0,$00AE008E,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #156
        .dcd $00C00000,$00AE00A0,$00AE00AE,$000000C0,$00000000,$00000000,$00000000,$00000000 ; Tile #157
        .dcd $00E00000,$00CE0080,$008E008E,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #158
        .dcd $00E00000,$009C009C,$008000DC,$00000080,$00000000,$00000000,$00000000,$00000000 ; Tile #159
        .dcd $E0000000,$AE00AE00,$AE00AE00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #160
        .dcd $40000000,$5E005E00,$5E005E00,$00004000,$00000000,$00000000,$00000000,$00000000 ; Tile #161
        .dcd $E0000000,$2E002E00,$8000EE00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #162
        .dcd $E0000000,$AE002E00,$2E006E00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #163
        .dcd $A0008000,$EE00AE00,$20002E00,$00002000,$00000000,$00000000,$00000000,$00000000 ; Tile #164
        .dcd $E0000000,$EE008E00,$20002E00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #165
        .dcd $E0000000,$EE008E00,$A000AE00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #166
        .dcd $F0000000,$36001000,$C6006600,$00008000,$00000000,$00000000,$00000000,$00000000 ; Tile #167
        .dcd $E0000000,$EE00AE00,$AE00AE00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #168
        .dcd $E0000000,$EE00A000,$2E002E00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #169
        .dcd $E0000000,$AE00AE00,$AE00EE00,$0000A000,$00000000,$00000000,$00000000,$00000000 ; Tile #170
        .dcd $C0000000,$CE00AE00,$AE00AE00,$0000C000,$00000000,$00000000,$00000000,$00000000 ; Tile #171
        .dcd $E0000000,$8E00A000,$AE008E00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #172
        .dcd $C0000000,$AE00A000,$AE00AE00,$0000C000,$00000000,$00000000,$00000000,$00000000 ; Tile #173
        .dcd $E0000000,$CE008000,$8E008E00,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #174
        .dcd $E0000000,$9C009C00,$8000DC00,$00008000,$00000000,$00000000,$00000000,$00000000 ; Tile #175
        .dcd $E0E00000,$AEAEAEAE,$AEAEAEAE,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #176
        .dcd $40400000,$5E5E5E5E,$5E5E5E5E,$00004040,$00000000,$00000000,$00000000,$00000000 ; Tile #177
        .dcd $E0E00000,$2E2E2E2E,$8080EEEE,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #178
        .dcd $E0E00000,$AEAE2E2E,$2E2E6E6E,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #179
        .dcd $A0A08080,$EEEEAEAE,$20202E2E,$00002020,$00000000,$00000000,$00000000,$00000000 ; Tile #180
        .dcd $E0E00000,$EEEE8E8E,$20202E2E,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #181
        .dcd $E0E00000,$EEEE8E8E,$A0A0AEAE,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #182
        .dcd $F0F00000,$36361010,$C6C66666,$00008080,$00000000,$00000000,$00000000,$00000000 ; Tile #183
        .dcd $E0E00000,$EEEEAEAE,$AEAEAEAE,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #184
        .dcd $E0E00000,$EEEEA0A0,$2E2E2E2E,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #185
        .dcd $E0E00000,$AEAEAEAE,$AEAEEEEE,$0000A0A0,$00000000,$00000000,$00000000,$00000000 ; Tile #186
        .dcd $C0C00000,$CECEAEAE,$AEAEAEAE,$0000C0C0,$00000000,$00000000,$00000000,$00000000 ; Tile #187
        .dcd $E0E00000,$8E8EA0A0,$AEAE8E8E,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #188
        .dcd $C0C00000,$AEAEA0A0,$AEAEAEAE,$0000C0C0,$00000000,$00000000,$00000000,$00000000 ; Tile #189
        .dcd $E0E00000,$CECE8080,$8E8E8E8E,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #190
        .dcd $E0E00000,$9C9C9C9C,$8080DCDC,$00008080,$00000000,$00000000,$00000000,$00000000 ; Tile #191
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00AE00AE,$00AE00AE,$000000E0 ; Tile #192
        .dcd $00000000,$00000000,$00000000,$00000000,$00400000,$005E005E,$005E005E,$00000040 ; Tile #193
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$002E002E,$008000EE,$000000E0 ; Tile #194
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00AE002E,$002E006E,$000000E0 ; Tile #195
        .dcd $00000000,$00000000,$00000000,$00000000,$00A00080,$00EE00AE,$0020002E,$00000020 ; Tile #196
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00EE008E,$0020002E,$000000E0 ; Tile #197
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00EE008E,$00A000AE,$000000E0 ; Tile #198
        .dcd $00000000,$00000000,$00000000,$00000000,$00F00000,$00360010,$00C60066,$00000080 ; Tile #199
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00EE00AE,$00AE00AE,$000000E0 ; Tile #200
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00EE00A0,$002E002E,$000000E0 ; Tile #201
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00AE00AE,$00AE00EE,$000000A0 ; Tile #202
        .dcd $00000000,$00000000,$00000000,$00000000,$00C00000,$00CE00AE,$00AE00AE,$000000C0 ; Tile #203
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$008E00A0,$00AE008E,$000000E0 ; Tile #204
        .dcd $00000000,$00000000,$00000000,$00000000,$00C00000,$00AE00A0,$00AE00AE,$000000C0 ; Tile #205
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00CE0080,$008E008E,$000000E0 ; Tile #206
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$009C009C,$008000DC,$00000080 ; Tile #207
        .dcd $00E00000,$00AE00AE,$00AE00AE,$000000E0,$00E00000,$00AE00AE,$00AE00AE,$000000E0 ; Tile #208
        .dcd $00400000,$005E005E,$005E005E,$00000040,$00400000,$005E005E,$005E005E,$00000040 ; Tile #209
        .dcd $00E00000,$002E002E,$008000EE,$000000E0,$00E00000,$002E002E,$008000EE,$000000E0 ; Tile #210
        .dcd $00E00000,$00AE002E,$002E006E,$000000E0,$00E00000,$00AE002E,$002E006E,$000000E0 ; Tile #211
        .dcd $00A00080,$00EE00AE,$0020002E,$00000020,$00A00080,$00EE00AE,$0020002E,$00000020 ; Tile #212
        .dcd $00E00000,$00EE008E,$0020002E,$000000E0,$00E00000,$00EE008E,$0020002E,$000000E0 ; Tile #213
        .dcd $00E00000,$00EE008E,$00A000AE,$000000E0,$00E00000,$00EE008E,$00A000AE,$000000E0 ; Tile #214
        .dcd $00F00000,$00360010,$00C60066,$00000080,$00F00000,$00360010,$00C60066,$00000080 ; Tile #215
        .dcd $00E00000,$00EE00AE,$00AE00AE,$000000E0,$00E00000,$00EE00AE,$00AE00AE,$000000E0 ; Tile #216
        .dcd $00E00000,$00EE00A0,$002E002E,$000000E0,$00E00000,$00EE00A0,$002E002E,$000000E0 ; Tile #217
        .dcd $00E00000,$00AE00AE,$00AE00EE,$000000A0,$00E00000,$00AE00AE,$00AE00EE,$000000A0 ; Tile #218
        .dcd $00C00000,$00CE00AE,$00AE00AE,$000000C0,$00C00000,$00CE00AE,$00AE00AE,$000000C0 ; Tile #219
        .dcd $00E00000,$008E00A0,$00AE008E,$000000E0,$00E00000,$008E00A0,$00AE008E,$000000E0 ; Tile #220
        .dcd $00C00000,$00AE00A0,$00AE00AE,$000000C0,$00C00000,$00AE00A0,$00AE00AE,$000000C0 ; Tile #221
        .dcd $00E00000,$00CE0080,$008E008E,$000000E0,$00E00000,$00CE0080,$008E008E,$000000E0 ; Tile #222
        .dcd $00E00000,$009C009C,$008000DC,$00000080,$00E00000,$009C009C,$008000DC,$00000080 ; Tile #223
        .dcd $E0000000,$AE00AE00,$AE00AE00,$0000E000,$00E00000,$00AE00AE,$00AE00AE,$000000E0 ; Tile #224
        .dcd $40000000,$5E005E00,$5E005E00,$00004000,$00400000,$005E005E,$005E005E,$00000040 ; Tile #225
        .dcd $E0000000,$2E002E00,$8000EE00,$0000E000,$00E00000,$002E002E,$008000EE,$000000E0 ; Tile #226
        .dcd $E0000000,$AE002E00,$2E006E00,$0000E000,$00E00000,$00AE002E,$002E006E,$000000E0 ; Tile #227
        .dcd $A0008000,$EE00AE00,$20002E00,$00002000,$00A00080,$00EE00AE,$0020002E,$00000020 ; Tile #228
        .dcd $E0000000,$EE008E00,$20002E00,$0000E000,$00E00000,$00EE008E,$0020002E,$000000E0 ; Tile #229
        .dcd $E0000000,$EE008E00,$A000AE00,$0000E000,$00E00000,$00EE008E,$00A000AE,$000000E0 ; Tile #230
        .dcd $F0000000,$36001000,$C6006600,$00008000,$00F00000,$00360010,$00C60066,$00000080 ; Tile #231
        .dcd $E0000000,$EE00AE00,$AE00AE00,$0000E000,$00E00000,$00EE00AE,$00AE00AE,$000000E0 ; Tile #232
        .dcd $E0000000,$EE00A000,$2E002E00,$0000E000,$00E00000,$00EE00A0,$002E002E,$000000E0 ; Tile #233
        .dcd $E0000000,$AE00AE00,$AE00EE00,$0000A000,$00E00000,$00AE00AE,$00AE00EE,$000000A0 ; Tile #234
        .dcd $C0000000,$CE00AE00,$AE00AE00,$0000C000,$00C00000,$00CE00AE,$00AE00AE,$000000C0 ; Tile #235
        .dcd $E0000000,$8E00A000,$AE008E00,$0000E000,$00E00000,$008E00A0,$00AE008E,$000000E0 ; Tile #236
        .dcd $C0000000,$AE00A000,$AE00AE00,$0000C000,$00C00000,$00AE00A0,$00AE00AE,$000000C0 ; Tile #237
        .dcd $E0000000,$CE008000,$8E008E00,$0000E000,$00E00000,$00CE0080,$008E008E,$000000E0 ; Tile #238
        .dcd $E0000000,$9C009C00,$8000DC00,$00008000,$00E00000,$009C009C,$008000DC,$00000080 ; Tile #239
        .dcd $E0E00000,$AEAEAEAE,$AEAEAEAE,$0000E0E0,$00E00000,$00AE00AE,$00AE00AE,$000000E0 ; Tile #240
        .dcd $40400000,$5E5E5E5E,$5E5E5E5E,$00004040,$00400000,$005E005E,$005E005E,$00000040 ; Tile #241
        .dcd $E0E00000,$2E2E2E2E,$8080EEEE,$0000E0E0,$00E00000,$002E002E,$008000EE,$000000E0 ; Tile #242
        .dcd $E0E00000,$AEAE2E2E,$2E2E6E6E,$0000E0E0,$00E00000,$00AE002E,$002E006E,$000000E0 ; Tile #243
        .dcd $A0A08080,$EEEEAEAE,$20202E2E,$00002020,$00A00080,$00EE00AE,$0020002E,$00000020 ; Tile #244
        .dcd $E0E00000,$EEEE8E8E,$20202E2E,$0000E0E0,$00E00000,$00EE008E,$0020002E,$000000E0 ; Tile #245
        .dcd $E0E00000,$EEEE8E8E,$A0A0AEAE,$0000E0E0,$00E00000,$00EE008E,$00A000AE,$000000E0 ; Tile #246
        .dcd $F0F00000,$36361010,$C6C66666,$00008080,$00F00000,$00360010,$00C60066,$00000080 ; Tile #247
        .dcd $E0E00000,$EEEEAEAE,$AEAEAEAE,$0000E0E0,$00E00000,$00EE00AE,$00AE00AE,$000000E0 ; Tile #248
        .dcd $E0E00000,$EEEEA0A0,$2E2E2E2E,$0000E0E0,$00E00000,$00EE00A0,$002E002E,$000000E0 ; Tile #249
        .dcd $E0E00000,$AEAEAEAE,$AEAEEEEE,$0000A0A0,$00E00000,$00AE00AE,$00AE00EE,$000000A0 ; Tile #250
        .dcd $C0C00000,$CECEAEAE,$AEAEAEAE,$0000C0C0,$00C00000,$00CE00AE,$00AE00AE,$000000C0 ; Tile #251
        .dcd $E0E00000,$8E8EA0A0,$AEAE8E8E,$0000E0E0,$00E00000,$008E00A0,$00AE008E,$000000E0 ; Tile #252
        .dcd $C0C00000,$AEAEA0A0,$AEAEAEAE,$0000C0C0,$00C00000,$00AE00A0,$00AE00AE,$000000C0 ; Tile #253
        .dcd $E0E00000,$CECE8080,$8E8E8E8E,$0000E0E0,$00E00000,$00CE0080,$008E008E,$000000E0 ; Tile #254
        .dcd $E0E00000,$9C9C9C9C,$8080DCDC,$00008080,$00E00000,$009C009C,$008000DC,$00000080 ; Tile #255
        .dcd $E0000000,$A000A000,$A000A000,$0000E000,$E0000000,$A000A000,$A000A000,$0000E000 ; Tile #256
        .dcd $40000000,$40004000,$40004000,$00004000,$40000000,$40004000,$40004000,$00004000 ; Tile #257
        .dcd $E0000000,$20002000,$8000E000,$0000E000,$E0000000,$20002000,$8000E000,$0000E000 ; Tile #258
        .dcd $E0000000,$A0002000,$20006000,$0000E000,$E0000000,$A0002000,$20006000,$0000E000 ; Tile #259
        .dcd $A0008000,$E000A000,$20002000,$00002000,$A0008000,$E000A000,$20002000,$00002000 ; Tile #260
        .dcd $E0000000,$E0008000,$20002000,$0000E000,$E0000000,$E0008000,$20002000,$0000E000 ; Tile #261
        .dcd $E0000000,$E0008000,$A000A000,$0000E000,$E0000000,$E0008000,$A000A000,$0000E000 ; Tile #262
        .dcd $F0000000,$30001000,$C0006000,$00008000,$F0000000,$30001000,$C0006000,$00008000 ; Tile #263
        .dcd $E0000000,$E000A000,$A000A000,$0000E000,$E0000000,$E000A000,$A000A000,$0000E000 ; Tile #264
        .dcd $E0000000,$E000A000,$20002000,$0000E000,$E0000000,$E000A000,$20002000,$0000E000 ; Tile #265
        .dcd $E0000000,$A000A000,$A000E000,$0000A000,$E0000000,$A000A000,$A000E000,$0000A000 ; Tile #266
        .dcd $C0000000,$C000A000,$A000A000,$0000C000,$C0000000,$C000A000,$A000A000,$0000C000 ; Tile #267
        .dcd $E0000000,$8000A000,$A0008000,$0000E000,$E0000000,$8000A000,$A0008000,$0000E000 ; Tile #268
        .dcd $C0000000,$A000A000,$A000A000,$0000C000,$C0000000,$A000A000,$A000A000,$0000C000 ; Tile #269
        .dcd $E0000000,$C0008000,$80008000,$0000E000,$E0000000,$C0008000,$80008000,$0000E000 ; Tile #270
        .dcd $E0000000,$80008000,$8000C000,$00008000,$E0000000,$80008000,$8000C000,$00008000 ; Tile #271
        .dcd $00E00000,$00A000A0,$00A000A0,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #272
        .dcd $00400000,$00400040,$00400040,$00000040,$00000000,$00000000,$00000000,$00000000 ; Tile #273
        .dcd $00E00000,$00200020,$008000E0,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #274
        .dcd $00E00000,$00A00020,$00200060,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #275
        .dcd $00A00080,$00E000A0,$00200020,$00000020,$00000000,$00000000,$00000000,$00000000 ; Tile #276
        .dcd $00E00000,$00E00080,$00200020,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #277
        .dcd $00E00000,$00E00080,$00A000A0,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #278
        .dcd $00F00000,$00300010,$00C00060,$00000080,$00000000,$00000000,$00000000,$00000000 ; Tile #279
        .dcd $00E00000,$00E000A0,$00A000A0,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #280
        .dcd $00E00000,$00E000A0,$00200020,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #281
        .dcd $00E00000,$00A000A0,$00A000E0,$000000A0,$00000000,$00000000,$00000000,$00000000 ; Tile #282
        .dcd $00C00000,$00C000A0,$00A000A0,$000000C0,$00000000,$00000000,$00000000,$00000000 ; Tile #283
        .dcd $00E00000,$008000A0,$00A00080,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #284
        .dcd $00C00000,$00A000A0,$00A000A0,$000000C0,$00000000,$00000000,$00000000,$00000000 ; Tile #285
        .dcd $00E00000,$00C00080,$00800080,$000000E0,$00000000,$00000000,$00000000,$00000000 ; Tile #286
        .dcd $00E00000,$00800080,$008000C0,$00000080,$00000000,$00000000,$00000000,$00000000 ; Tile #287
        .dcd $E0000000,$A000A000,$A000A000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #288
        .dcd $40000000,$40004000,$40004000,$00004000,$00000000,$00000000,$00000000,$00000000 ; Tile #289
        .dcd $E0000000,$20002000,$8000E000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #290
        .dcd $E0000000,$A0002000,$20006000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #291
        .dcd $A0008000,$E000A000,$20002000,$00002000,$00000000,$00000000,$00000000,$00000000 ; Tile #292
        .dcd $E0000000,$E0008000,$20002000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #293
        .dcd $E0000000,$E0008000,$A000A000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #294
        .dcd $F0000000,$30001000,$C0006000,$00008000,$00000000,$00000000,$00000000,$00000000 ; Tile #295
        .dcd $E0000000,$E000A000,$A000A000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #296
        .dcd $E0000000,$E000A000,$20002000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #297
        .dcd $E0000000,$A000A000,$A000E000,$0000A000,$00000000,$00000000,$00000000,$00000000 ; Tile #298
        .dcd $C0000000,$C000A000,$A000A000,$0000C000,$00000000,$00000000,$00000000,$00000000 ; Tile #299
        .dcd $E0000000,$8000A000,$A0008000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #300
        .dcd $C0000000,$A000A000,$A000A000,$0000C000,$00000000,$00000000,$00000000,$00000000 ; Tile #301
        .dcd $E0000000,$C0008000,$80008000,$0000E000,$00000000,$00000000,$00000000,$00000000 ; Tile #302
        .dcd $E0000000,$80008000,$8000C000,$00008000,$00000000,$00000000,$00000000,$00000000 ; Tile #303
        .dcd $E0E00000,$A0A0A0A0,$A0A0A0A0,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #304
        .dcd $40400000,$40404040,$40404040,$00004040,$00000000,$00000000,$00000000,$00000000 ; Tile #305
        .dcd $E0E00000,$20202020,$8080E0E0,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #306
        .dcd $E0E00000,$A0A02020,$20206060,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #307
        .dcd $A0A08080,$E0E0A0A0,$20202020,$00002020,$00000000,$00000000,$00000000,$00000000 ; Tile #308
        .dcd $E0E00000,$E0E08080,$20202020,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #309
        .dcd $E0E00000,$E0E08080,$A0A0A0A0,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #310
        .dcd $F0F00000,$30301010,$C0C06060,$00008080,$00000000,$00000000,$00000000,$00000000 ; Tile #311
        .dcd $E0E00000,$E0E0A0A0,$A0A0A0A0,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #312
        .dcd $E0E00000,$E0E0A0A0,$20202020,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #313
        .dcd $E0E00000,$A0A0A0A0,$A0A0E0E0,$0000A0A0,$00000000,$00000000,$00000000,$00000000 ; Tile #314
        .dcd $C0C00000,$C0C0A0A0,$A0A0A0A0,$0000C0C0,$00000000,$00000000,$00000000,$00000000 ; Tile #315
        .dcd $E0E00000,$8080A0A0,$A0A08080,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #316
        .dcd $C0C00000,$A0A0A0A0,$A0A0A0A0,$0000C0C0,$00000000,$00000000,$00000000,$00000000 ; Tile #317
        .dcd $E0E00000,$C0C08080,$80808080,$0000E0E0,$00000000,$00000000,$00000000,$00000000 ; Tile #318
        .dcd $E0E00000,$80808080,$8080C0C0,$00008080,$00000000,$00000000,$00000000,$00000000 ; Tile #319
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00A000A0,$00A000A0,$000000E0 ; Tile #320
        .dcd $00000000,$00000000,$00000000,$00000000,$00400000,$00400040,$00400040,$00000040 ; Tile #321
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00200020,$008000E0,$000000E0 ; Tile #322
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00A00020,$00200060,$000000E0 ; Tile #323
        .dcd $00000000,$00000000,$00000000,$00000000,$00A00080,$00E000A0,$00200020,$00000020 ; Tile #324
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00E00080,$00200020,$000000E0 ; Tile #325
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00E00080,$00A000A0,$000000E0 ; Tile #326
        .dcd $00000000,$00000000,$00000000,$00000000,$00F00000,$00300010,$00C00060,$00000080 ; Tile #327
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00E000A0,$00A000A0,$000000E0 ; Tile #328
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00E000A0,$00200020,$000000E0 ; Tile #329
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00A000A0,$00A000E0,$000000A0 ; Tile #330
        .dcd $00000000,$00000000,$00000000,$00000000,$00C00000,$00C000A0,$00A000A0,$000000C0 ; Tile #331
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$008000A0,$00A00080,$000000E0 ; Tile #332
        .dcd $00000000,$00000000,$00000000,$00000000,$00C00000,$00A000A0,$00A000A0,$000000C0 ; Tile #333
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00C00080,$00800080,$000000E0 ; Tile #334
        .dcd $00000000,$00000000,$00000000,$00000000,$00E00000,$00800080,$008000C0,$00000080 ; Tile #335
        .dcd $00E00000,$00A000A0,$00A000A0,$000000E0,$00E00000,$00A000A0,$00A000A0,$000000E0 ; Tile #336
        .dcd $00400000,$00400040,$00400040,$00000040,$00400000,$00400040,$00400040,$00000040 ; Tile #337
        .dcd $00E00000,$00200020,$008000E0,$000000E0,$00E00000,$00200020,$008000E0,$000000E0 ; Tile #338
        .dcd $00E00000,$00A00020,$00200060,$000000E0,$00E00000,$00A00020,$00200060,$000000E0 ; Tile #339
        .dcd $00A00080,$00E000A0,$00200020,$00000020,$00A00080,$00E000A0,$00200020,$00000020 ; Tile #340
        .dcd $00E00000,$00E00080,$00200020,$000000E0,$00E00000,$00E00080,$00200020,$000000E0 ; Tile #341
        .dcd $00E00000,$00E00080,$00A000A0,$000000E0,$00E00000,$00E00080,$00A000A0,$000000E0 ; Tile #342
        .dcd $00F00000,$00300010,$00C00060,$00000080,$00F00000,$00300010,$00C00060,$00000080 ; Tile #343
        .dcd $00E00000,$00E000A0,$00A000A0,$000000E0,$00E00000,$00E000A0,$00A000A0,$000000E0 ; Tile #344
        .dcd $00E00000,$00E000A0,$00200020,$000000E0,$00E00000,$00E000A0,$00200020,$000000E0 ; Tile #345
        .dcd $00E00000,$00A000A0,$00A000E0,$000000A0,$00E00000,$00A000A0,$00A000E0,$000000A0 ; Tile #346
        .dcd $00C00000,$00C000A0,$00A000A0,$000000C0,$00C00000,$00C000A0,$00A000A0,$000000C0 ; Tile #347
        .dcd $00E00000,$008000A0,$00A00080,$000000E0,$00E00000,$008000A0,$00A00080,$000000E0 ; Tile #348
        .dcd $00C00000,$00A000A0,$00A000A0,$000000C0,$00C00000,$00A000A0,$00A000A0,$000000C0 ; Tile #349
        .dcd $00E00000,$00C00080,$00800080,$000000E0,$00E00000,$00C00080,$00800080,$000000E0 ; Tile #350
        .dcd $00E00000,$00800080,$008000C0,$00000080,$00E00000,$00800080,$008000C0,$00000080 ; Tile #351
        .dcd $E0000000,$A000A000,$A000A000,$0000E000,$00E00000,$00A000A0,$00A000A0,$000000E0 ; Tile #352
        .dcd $40000000,$40004000,$40004000,$00004000,$00400000,$00400040,$00400040,$00000040 ; Tile #353
        .dcd $E0000000,$20002000,$8000E000,$0000E000,$00E00000,$00200020,$008000E0,$000000E0 ; Tile #354
        .dcd $E0000000,$A0002000,$20006000,$0000E000,$00E00000,$00A00020,$00200060,$000000E0 ; Tile #355
        .dcd $A0008000,$E000A000,$20002000,$00002000,$00A00080,$00E000A0,$00200020,$00000020 ; Tile #356
        .dcd $E0000000,$E0008000,$20002000,$0000E000,$00E00000,$00E00080,$00200020,$000000E0 ; Tile #357
        .dcd $E0000000,$E0008000,$A000A000,$0000E000,$00E00000,$00E00080,$00A000A0,$000000E0 ; Tile #358
        .dcd $F0000000,$30001000,$C0006000,$00008000,$00F00000,$00300010,$00C00060,$00000080 ; Tile #359
        .dcd $E0000000,$E000A000,$A000A000,$0000E000,$00E00000,$00E000A0,$00A000A0,$000000E0 ; Tile #360
        .dcd $E0000000,$E000A000,$20002000,$0000E000,$00E00000,$00E000A0,$00200020,$000000E0 ; Tile #361
        .dcd $E0000000,$A000A000,$A000E000,$0000A000,$00E00000,$00A000A0,$00A000E0,$000000A0 ; Tile #362
        .dcd $C0000000,$C000A000,$A000A000,$0000C000,$00C00000,$00C000A0,$00A000A0,$000000C0 ; Tile #363
        .dcd $E0000000,$8000A000,$A0008000,$0000E000,$00E00000,$008000A0,$00A00080,$000000E0 ; Tile #364
        .dcd $C0000000,$A000A000,$A000A000,$0000C000,$00C00000,$00A000A0,$00A000A0,$000000C0 ; Tile #365
        .dcd $E0000000,$C0008000,$80008000,$0000E000,$00E00000,$00C00080,$00800080,$000000E0 ; Tile #366
        .dcd $E0000000,$80008000,$8000C000,$00008000,$00E00000,$00800080,$008000C0,$00000080 ; Tile #367
        .dcd $E0E00000,$A0A0A0A0,$A0A0A0A0,$0000E0E0,$E0E00000,$A0A0A0A0,$A0A0A0A0,$0000E0E0 ; Tile #368
        .dcd $40400000,$40404040,$40404040,$00004040,$40400000,$40404040,$40404040,$00004040 ; Tile #369
        .dcd $E0E00000,$20202020,$8080E0E0,$0000E0E0,$E0E00000,$20202020,$8080E0E0,$0000E0E0 ; Tile #370
        .dcd $E0E00000,$A0A02020,$20206060,$0000E0E0,$E0E00000,$A0A02020,$20206060,$0000E0E0 ; Tile #371
        .dcd $A0A08080,$E0E0A0A0,$20202020,$00002020,$A0A08080,$E0E0A0A0,$20202020,$00002020 ; Tile #372
        .dcd $E0E00000,$E0E08080,$20202020,$0000E0E0,$E0E00000,$E0E08080,$20202020,$0000E0E0 ; Tile #373
        .dcd $E0E00000,$E0E08080,$A0A0A0A0,$0000E0E0,$E0E00000,$E0E08080,$A0A0A0A0,$0000E0E0 ; Tile #374
        .dcd $F0F00000,$30301010,$C0C06060,$00008080,$F0F00000,$30301010,$C0C06060,$00008080 ; Tile #375
        .dcd $E0E00000,$E0E0A0A0,$A0A0A0A0,$0000E0E0,$E0E00000,$E0E0A0A0,$A0A0A0A0,$0000E0E0 ; Tile #376
        .dcd $E0E00000,$E0E0A0A0,$20202020,$0000E0E0,$E0E00000,$E0E0A0A0,$20202020,$0000E0E0 ; Tile #377
        .dcd $E0E00000,$A0A0A0A0,$A0A0E0E0,$0000A0A0,$E0E00000,$A0A0A0A0,$A0A0E0E0,$0000A0A0 ; Tile #378
        .dcd $C0C00000,$C0C0A0A0,$A0A0A0A0,$0000C0C0,$C0C00000,$C0C0A0A0,$A0A0A0A0,$0000C0C0 ; Tile #379
        .dcd $E0E00000,$8080A0A0,$A0A08080,$0000E0E0,$E0E00000,$8080A0A0,$A0A08080,$0000E0E0 ; Tile #380
        .dcd $C0C00000,$A0A0A0A0,$A0A0A0A0,$0000C0C0,$C0C00000,$A0A0A0A0,$A0A0A0A0,$0000C0C0 ; Tile #381
        .dcd $E0E00000,$C0C08080,$80808080,$0000E0E0,$E0E00000,$C0C08080,$80808080,$0000E0E0 ; Tile #382
        .dcd $E0E00000,$80808080,$8080C0C0,$00008080,$E0E00000,$80808080,$8080C0C0,$00008080 ; Tile #383

empty_irq: rti
restart: jml $008000

.cartridge
TITLE = "Qwertie's Test Cart"
MODE = $20
ROMSIZE = $09
RAMSIZE = $00
COUNTRY = $01
.end

.int
all = empty_irq
nmi = nmi_int
reset = restart
.end
