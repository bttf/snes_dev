     Phoenix


KEY:
Memory Select Index Select Semicolon Labels Semicolon Assembly Operand Notes
      Vector
      Long Subroutine  (24-bit)
      Subroutine  (16-bit)
      Jump  (16-bit)
      Long Jump  (24-bit)

      Data
      Long Data

M X  8-bit Accumulator, 8-bit Indexes
M x  8-bit Accumulator, 16-bit Indexes
m X  16-bit Accumulator, 8-bit Indexes
m x  16-bit Accumulator, 16-bit Indexes

     JSL Long Subroutine
     JSR Subroutine
     JMP Jump
     JML Long Jump
     RTS Return Subroutine
     RTL Return Subroutine Long
     RTI Return Interrupt



    ; #LoROM

    ; # SNES Registers ==================== Size ====
    ; #Name $2100 INIDISP_R  b
    ; #Name $2101 OBJSEL_R  b
    ; #Name $2102 OAMADD_R  w
    ; #Name $2104 OAMDATA_R  b,LH
    ; #Name $2105 BGMODE_R  b
    ; #Name $2106 MOSAIC_R  b
    ; #Name $2107 BG1SC_R  b
    ; #Name $2108 BG2SC_R  b
    ; #Name $2109 BG3SC_R  b
    ; #Name $210A BG4SC_R  b
    ; #Name $210B BG12NBA_R  b,LH
    ; #Name $210C BG34NBA_R  b,LH
    ; #Name $210D BG1HOFS_R  b,LH
    ; #Name $210E BG1VOFS_R  b,LH
    ; #Name $210F BG2HOFS_R  b,LH
    ; #Name $2110 BG2VOFS_R  b,LH
    ; #Name $2111 BG3HOFS_R  b,LH
    ; #Name $2112 BG3VOFS_R  b,LH
    ; #Name $2113 BG4HOFS_R  b,LH
    ; #Name $2114 BG4VOFS_R  b,LH
    ; #Name $2115 VMAINC_R  b
    ; #Name $2116 VMADD_R  w
    ; #Name $2118 VMDATA_R  w
    ; #Name $211A M7SEL_R  b
    ; #Name $211B M7A_R  b,LH
    ; #Name $211C M7B_R  b,LH
    ; #Name $211D M7C_R  b,LH
    ; #Name $211E M7D_R  b,LH
    ; #Name $211F M7X_R  b,LH
    ; #Name $2120 M7Y_R  b,LH
    ; #Name $2121 CGADD_R  b
    ; #Name $2122 CGDATA_R  b,LH
    ; #Name $2123 W12SEL_R  b
    ; #Name $2124 W34SEL_R  b
    ; #Name $2125 WOBJSEL_R  b
    ; #Name $2126 WH0_R  b
    ; #Name $2127 WH1_R  b
    ; #Name $2128 WH2_R  b
    ; #Name $2129 WH3_R  b
    ; #Name $212A WBGLOG_R  b
    ; #Name $212B WOBJLOG_R  b
    ; #Name $212C TM_R  b
    ; #Name $212D TS_R  b
    ; #Name $212E TMW_R  b
    ; #Name $212F TSW_R  b
    ; #Name $2130 CGWSEL_R  b
    ; #Name $2131 CGADSUB_R  b
    ; #Name $2132 COLDATA_R  b
    ; #Name $2133 SETINI_R  b
    ; #Name $2134 .MPY_R  l
    ; #Name $2137 .SLHV_R  b
    ; #Name $2138 .OAMDATA_R  b,LH
    ; #Name $2139 .VMDATA_R  w
    ; #Name $213B .CGDATA_R  b,LH
    ; #Name $213C .OPHCT_R  b,LH
    ; #Name $213D .OPVCT_R  b,LH
    ; #Name $213E .STAT77_R  b
    ; #Name $213F .STAT78_R  b
    ; #Name $2140 APUIO0_R  b
    ; #Name $2141 APUIO1_R  b
    ; #Name $2142 APUIO2_R  b
    ; #Name $2143 APUIO3_R  b
    ; #Name $2180 WMDATA_R  b
    ; #Name $2181 WMADD_R  l
    ; #Name $4200 NMITIMEN_R  b
    ; #Name $4201 WRIO_R  b
    ; #Name $4202 WRMPYA_R  b
    ; #Name $4203 WRMPYB_R  b
    ; #Name $4204 WRDIV_R  w
    ; #Name $4206 WRDIVB_R  b
    ; #Name $4207 HTIME_R  w
    ; #Name $4209 VTIME_R  w
    ; #Name $420B MDMAEN_R  b
    ; #Name $420C HDMAEN_R  b
    ; #Name $420D MEMSEL_R  b
    ; #Name $4210 .RDNMI_R  b
    ; #Name $4211 .TIMEUP_R  b
    ; #Name $4212 .HVBJOY_R  b
    ; #Name $4213 .RDIO_R  b
    ; #Name $4214 .RDDIV_R  w
    ; #Name $4216 .RDMPY_R  w
    ; #Name $4218 JOY1_R  w
    ; #Name $421A JOY2_R  w
    ; #Name $421C JOY3_R  w
    ; #Name $421E JOY4_R  w
    ; #Name $4300 DMAP_R  b
    ; #Name $4301 BBADD_R  b
    ; #Name $4302 ABADD_R  l
    ; #Name $4305 DMAARG_R  l
    ; #Name $4308 ABTADD_R  W
    ; #Name $430A HDMAS_R  b
    ; #Name $4300 DMAP0_R  b
    ; #Name $4301 BBADD0_R  b
    ; #Name $4302 ABADD0_R  l
    ; #Name $4305 DMAARG0_R  l
    ; #Name $4308 ABTADD0_R  W
    ; #Name $430A HDMAS0_R  b


    ; # WRAM $7E:0000-$7F:0000 ======================

    ; # Direct Page ======================= Size ====
    ; #Name $00 Scratch_Pad  $20
    ; #Name $20 INIDISP_WR  b
    ; #Name $21 OBJSEL_WR  b
    ; #Name $22 OAMADD_WR  w
    ; #Name $24 BGMODE_WR  b
    ; #Name $25 MOSAIC_WR  b
    ; #Name $26 BG1SC_WR  b
    ; #Name $27 BG2SC_WR  b
    ; #Name $28 BG3SC_WR  b
    ; #Name $29 BG4SC_WR  b
    ; #Name $2A BG12NBA_WR  w
    ; #Name $2C BG34NBA_WR  w
    ; #Name $2E BG1HOFS_WR  w
    ; #Name $30 BG1VOFS_WR  w
    ; #Name $32 BG2HOFS_WR  w
    ; #Name $34 BG2VOFS_WR  w
    ; #Name $36 BG3HOFS_WR  w
    ; #Name $38 BG3VOFS_WR  w
    ; #Name $3A BG4HOFS_WR  w
    ; #Name $3C BG4VOFS_WR  w
    ; #Name $3E VMAINC_WR  b
    ; #Name $3F VMADD_WR  w
    ; #Name $41 M7SEL_WR  b
    ; #Name $42 M7A_WR  w
    ; #Name $44 M7B_WR  w
    ; #Name $46 M7C_WR  w
    ; #Name $48 M7D_WR  w
    ; #Name $4A M7X_WR  w
    ; #Name $4C M7Y_WR  w
    ; #Name $4E CGADD_WR  b
    ; #Name $4F W12SEL_WR  b
    ; #Name $50 W34SEL_WR  b
    ; #Name $51 WOBJSEL_WR  b
    ; #Name $52 WH0_WR  b
    ; #Name $53 WH1_WR  b
    ; #Name $54 WH2_WR  b
    ; #Name $55 WH3_WR  b
    ; #Name $56 WBGLOG_WR  b
    ; #Name $57 WOBJLOG_WR  b
    ; #Name $58 TM_WR  b
    ; #Name $59 TS_WR  b
    ; #Name $5A TMW_WR  b
    ; #Name $5B TSW_WR  b
    ; #Name $5C CGWSEL_WR  b
    ; #Name $5D CGADSUB_WR  b
    ; #Name $5E COLDATA_WR_Blue  b
    ; #Name $5F COLDATA_WR_Green  b
    ; #Name $60 COLDATA_WR_Red  b
    ; #Name $61 SETINI_WR  b
    ; #Name $62 .SLHV_WR  b
    ; #Name $63 .OAMDATA_WR  w
    ; #Name $65 .VMDATA_WR  w
    ; #Name $67 .CGDATA_WR  w
    ; #Name $69 .OPHCT_WR  w
    ; #Name $6B .OPVCT_WR  w
    ; #Name $6D .STAT77_WR  b
    ; #Name $6E .STAT78_WR  b
    ; #Name $6F APUIO0_WR  b
    ; #Name $70 APUIO1_WR  b
    ; #Name $71 APUIO2_WR  b
    ; #Name $72 APUIO3_WR  b
    ; #Name $73 WMADD_WR  l
    ; #Name $76 NMITIMEN_WR  b
    ; #Name $77 WRIO_WR  b
    ; #Name $78 HTIME_WR  w
    ; #Name $7A VTIME_WR  w
    ; #Name $7C MDMAEN_WR  b
    ; #Name $7D HDMAEN_WR  b
    ; #Name $7E MEMSEL_WR  b
    ; #Name $7F .RDNMI_WR  b
    ; #Name $80 .TIMEUP_WR  b
    ; #Name $81 .HVBJOY_WR  b
    ; #Name $82 .RDIO_WR  b
    ; #Name $0083 JOY_WR  $8
    ; #Name $83 JOY1_WR  w
    ; #Name $85 JOY2_WR  w
    ; #Name $87 JOY3_WR  w
    ; #Name $89 JOY4_WR  w

    ; #Name $008B JOY_previous  $8
    ; #Name $8B JOY1_previous  w
    ; #Name $8D JOY2_previous  w
    ; #Name $8F JOY3_previous  w
    ; #Name $91 JOY4_previous  w
    ; #Name $0093 JOY_trigger  $8
    ; #Name $93 JOY1_trigger  w
    ; #Name $95 JOY2_trigger  w
    ; #Name $97 JOY3_trigger  w
    ; #Name $99 JOY4_trigger  w
    ; #Name $009B JOY_hold_T  $4 //Clip the Ts
    ; #Name $9B JOY1_hold_T  b
    ; #Name $9C JOY2_hold_T  b
    ; #Name $9D JOY3_hold_T  b
    ; #Name $9E JOY4_hold_T  b
    ; #Name $009F JOY_cooldown_T  $4
    ; #Name $9F JOY1_cooldown_T  b
    ; #Name $A0 JOY2_cooldown_T  b
    ; #Name $A1 JOY3_cooldown_T  b
    ; #Name $A2 JOY4_cooldown_T  b

    ; #Name $A3 NMI_Ready_F  b
    ; #Name $A4 NMI_Count  w
    ; #Name $A6 NMI_HDMA_Data  l
    ; #Name $A9 NMI_VRAM_DMA_Data  l
    ; #Name $AC NMI_VRAM_DMA_Data_OS  w
    ; #Name $AE NMI_VRAM_Write_Table_OS  w

    ; #Name $B0 IRQ_Program  l

    ; #Name $B3 Main_Program_Count  w
    ; #Name $B5 Main_Program_Mode  w
    ; #Name $B7 Sub_Program_Mode  w

    ; #Name $B9 OAM_OS  w
    ; #Name $BB OAM_II_byte_OS  b
    ; #Name $BC OAM_II_bit_OS  b

    ; #Name $00C0 Ship_1  $1A
    ; #Name $C0 Ship_1_Status  w
    ; #Name $C2 Ship_1_Render  w
    ; #Name $C4 Ship_1_Kills  w
    ; #Name $C6 Ship_1_Polarity  w
    ; #Name $C8 Ship_1_Charge  w
    ; #Name $CA Ship_1_Burst  w
    ; #Name $CC Ship_1_Timer  w
    ; #Name $CE Ship_1_Angle  w
    ; #Name $D0 Ship_1_X  w
    ; #Name $D2 Ship_1_Y  w
    ; #Name $D4 Ship_1_VX  w
    ; #Name $D6 Ship_1_VY  w
    ; #Name $D8 Ship_1_Gun_X  w
    ; #Name $DA Ship_1_Gun_Y  w

    ; #Name $00DC Ship_2  $1A
    ; #Name $DC Ship_2_Status  w
    ; #Name $DE Ship_2_Render  w
    ; #Name $E0 Ship_2_Kills  w
    ; #Name $E2 Ship_2_Polarity  w
    ; #Name $E4 Ship_2_Charge  w
    ; #Name $E6 Ship_2_Burst  w
    ; #Name $E8 Ship_2_Timer  w
    ; #Name $EA Ship_2_Angle  w
    ; #Name $EC Ship_2_X  w
    ; #Name $EE Ship_2_Y  w
    ; #Name $F0 Ship_2_VX  w
    ; #Name $F2 Ship_2_VY  w
    ; #Name $F4 Ship_2_Gun_X  w
    ; #Name $F6 Ship_2_Gun_Y  w

    ; #Name $F8 BG2.X  w
    ; #Name $FA BG2.Y  w

    ; #Name $FC Pause_F  w

    ; #Name $FE Random_Number  w


    ; # Access ============================ Size ====
    ; #Name $00 Ship.Status  w // 0=Ghost, 1=Live, 2=Death, 3=Dead
    ; #Name $02 Ship.Render  w
    ; #Name $04 Ship.Kills  w
    ; #Name $06 Ship.Polarity  w
    ; #Name $08 Ship.Charge  w
    ; #Name $0A Ship.Burst  w
    ; #Name $0C Ship.Timer  w
    ; #Name $0E Ship.Angle  w
    ; #Name $10 Ship.X  w
    ; #Name $12 Ship.Y  w
    ; #Name $14 Ship.VX  w
    ; #Name $16 Ship.VY  w
    ; #Name $18 Ship.Gun_X  w
    ; #Name $1A Ship.Gun_Y  w


    ; # Scratch Pad ======================= Size ====

    ; #Name $10 Max_Burst_Angle  w
    ; #Name $12 Min_Burst_Angle  w

    ; #Name $00 Multiplicand_1  w
    ; #Name $02 Multiplicand_2  w
    ; #Name $04 Product  w

    ; #Name $00 Dividend  w
    ; #Name $02 Divisor  w
    ; #Name $04 Quotient  w
    ; #Name $08 Remainder  w

    ; #Name $00 Find_Angle_X_Sign  w
    ; #Name $02 Find_Angle_X  w
    ; #Name $04 Find_Angle_Y_Sign  w
    ; #Name $06 Find_Angle_Y  w

    ; #Name $00 Draw_Sprite_Data_OS  l
    ; #Name $02 Draw_Sprite_Data_Bank  b
    ; #Name $03 Draw_Sprite_OBJ_Count  b
    ; #Name $04 Draw_Sprite_X  b
    ; #Name $05 Draw_Sprite_Y  b
    ; #Name $06 Draw_Sprite_Char_OS  w
    ; #Name $08 Draw_Sprite_OBJ_P_Override  b

    ; #Name $00 Ship_1_Hit_Box_X1  w
    ; #Name $02 Ship_1_Hit_Box_X2  w
    ; #Name $04 Ship_1_Hit_Box_Y1  w
    ; #Name $06 Ship_1_Hit_Box_Y2  w
    ; #Name $08 Ship_2_Hit_Box_X1  w
    ; #Name $0A Ship_2_Hit_Box_X2  w
    ; #Name $0C Ship_2_Hit_Box_Y1  w
    ; #Name $0E Ship_2_Hit_Box_Y2  w
    ; #Name $10 Enemy_Hit_Box_X1  w
    ; #Name $12 Enemy_Hit_Box_X2  w
    ; #Name $14 Enemy_Hit_Box_Y1  w
    ; #Name $16 Enemy_Hit_Box_Y2  w
    ; #Name $18 Hit_Box_X1  w
    ; #Name $1A Hit_Box_X2  w
    ; #Name $1C Hit_Box_Y1  w
    ; #Name $1E Hit_Box_Y2  w

    ; #Name $1E Death_Blossom_Count  w


    ; # Extended WRAM $7E:0000-$7E:2000==== Size ====
    ; #Name $0100 OAM_WR  $200
    ; #Name $0100 OAM_WR_X  b
    ; #Name $0101 OAM_WR_Y  b
    ; #Name $0102 OAM_WR_C  b
    ; #Name $0103 OAM_WR_P  b
    ; #Name $0300 OAM_II_WR  $20

    ; #Name $0320 CGRAM_WR  $200

    ; #Name $0520 NMI_VRAM_Write_Table  $E0
    ; #Name $0520 NMI_VRAM_Write.Addr  w
    ; #Name $0522 NMI_VRAM_Write.Data  w

    ; #Name $0600 Obstacle_Table  $100
    ; #Name $0600 Obstacle.Active  w
    ; #Name $0602 Obstacle.X  w
    ; #Name $0604 Obstacle.Y  w
    ; #Name $0606 Obstacle.VX  w
    ; #Name $0608 Obstacle.VY  w

    ; #Name $0800 Bullet_Table  $800
    ; #Name $0800 Bullet.Active  w
    ; #Name $0802 Bullet.Polarity  w
    ; #Name $0804 Bullet.X  w
    ; #Name $0806 Bullet.Y  w
    ; #Name $0808 Bullet.VX  w
    ; #Name $080A Bullet.VY  w


    ; #Code w RESET_Vector
    ; #Code w NMI_Vector
    ; #Code w IRQ_Vector
    ; #Code l Reset
    ; #Code w Clear_Registers
    ; #Code w Clear_VRAM
    ; #Code w Clear_OAM
    ; #Code w Clear_CGRAM
    ; #Code w Clear_ARAM

    ; #Code l Nmi
    ; #Code w NMI_Refresh_Registers
    ; #Code w NMI_HDMA
    ; #Code w NMI_VRAM_DMA
    ; #Code w NMI_VRAM_Write

    ; #Code l Main_Program
    ; #Code w Initiate_Engine
    ; #Code w Open_Engine
    ; #Code w Game_Engine
    ; #Code w Analyze_Joy
    ; #Code w Collision_Detection
    ; #Code w Update_Ships
    ; #Code w Update_Ship.Ghost
    ; #Code w Update_Ship.Live
    ; #Code w Update_Ship.Death
    ; #Code w Update_Ship.Dead
    ; #Code w Update_Enemies
    ; #Code w Update_Bullets
    ; #Code w Update_BG
    ; #Code w Update_CGRAM
    ; #Code w Draw_Frame

    ; #Code l Multiply
    ; #Code l Divide
    ; #Code l Immediate_DMA
    ; #Code l Ready_OAM
    ; #Code l Hide_Unused_OAM
    ; #Code l Draw_Sprite
    ; #Code l Find_Angle
    ; #Code l Random_Number_Generator


    ; #Data w Main_Program_PT
    ; #Data w Vector_PT
    ; #Data w Game_Engine_Sub_Program_PT
    ; #Data w Ship_Program_Table
    ; #Data w Ship_Sprite
    ; #Data w Gun_Sprite_1
    ; #Data w Gun_Sprite_2
    ; #Data w Shot_Sprite
    ; #Data w Obstacle_Sprite
    ; #Data w Angle_Array
    ; #Data l Sinusoid
    ; #Data l Char_Data
    ; #Data l Frame_BG_Map
    ; #Data l Star_BG_Map
    ; #Data l Color_Data









    ; # Program ===========================



    ; #Code w {RESET_Vector}
    ; SEI
    ; CLC
    ; XCE
    ; JML Reset

    ; #Code w {NMI_Vector}
    ; JML Nmi

    ; #Code w {IRQ_Vector}
    ; JML Reset

    ; #Code l {Reset}
    ; REP #$38
    ; PHK
    ; PLB
    ; LDA #$0000
    ; TCD
    ; LDX #$1FFF
    ; TXS
    ; JSR Clear_Registers
    ; JSR Clear_VRAM
    ; JSR Clear_OAM
    ; JSR Clear_CGRAM
    ; JSR Clear_ARAM
    ; LDA #$0000 // Clear_WRAM
    ; LDX #$4000
  ; {-} ; DEX
    ; DEX
    ; STA $7E:0000,X
    ; STA $7E:4000,X
    ; STA $7E:8000,X
    ; STA $7E:C000,X
    ; STA $7F:0000,X
    ; STA $7F:4000,X
    ; STA $7F:8000,X
    ; STA $7F:C000,X
    ; BNE {-}
    ; TAX
    ; TAY
    ; JML Main_Program

    ; #Code w {Clear_Registers}
    ; PHP
    ; SEP #$20
    ; LDA #$00
    ; STA MEMSEL_R
    ; LDA #$80
    ; STA INIDISP_R
    ; STZ OBJSEL_R
    ; STZ OAMADD_R.l
    ; STZ OAMADD_R.h
    ; STZ BGMODE_R
    ; STZ MOSAIC_R
    ; STZ BG1SC_R
    ; STZ BG2SC_R
    ; STZ BG3SC_R
    ; STZ BG4SC_R
    ; STZ BG12NBA_R
    ; STZ BG34NBA_R
    ; STZ BG1HOFS_R
    ; STZ BG1HOFS_R
    ; STZ BG1VOFS_R
    ; STZ BG1VOFS_R
    ; STZ BG2HOFS_R
    ; STZ BG2HOFS_R
    ; STZ BG2VOFS_R
    ; STZ BG2VOFS_R
    ; STZ BG3HOFS_R
    ; STZ BG3HOFS_R
    ; STZ BG3VOFS_R
    ; STZ BG3VOFS_R
    ; STZ BG4HOFS_R
    ; STZ BG4HOFS_R
    ; STZ BG4VOFS_R
    ; STZ BG4VOFS_R
    ; STZ VMAINC_R
    ; STZ VMADD_R.l
    ; STZ VMADD_R.h
    ; STZ M7SEL_R
    ; STZ M7A_R
    ; STZ M7A_R
    ; STZ M7B_R
    ; STZ M7B_R
    ; STZ M7C_R
    ; STZ M7C_R
    ; STZ M7D_R
    ; STZ M7D_R
    ; STZ M7X_R
    ; STZ M7X_R
    ; STZ M7Y_R
    ; STZ M7Y_R
    ; STZ CGADD_R
    ; STZ W12SEL_R
    ; STZ W34SEL_R
    ; STZ WOBJSEL_R
    ; STZ WH0_R
    ; STZ WH1_R
    ; STZ WH2_R
    ; STZ WH3_R
    ; STZ WBGLOG_R
    ; STZ WOBJLOG_R
    ; STZ TM_R
    ; STZ TS_R
    ; STZ TMW_R
    ; STZ TSW_R
    ; STZ CGWSEL_R
    ; STZ CGADSUB_R
    ; STZ COLDATA_R
    ; STZ SETINI_R
    ; LDA .STAT78_R
    ; STZ WMADD_R.l
    ; STZ WMADD_R.h
    ; STZ WMADD_R.b
    ; STZ NMITIMEN_R
    ; STZ WRIO_R
    ; STZ WRMPYA_R
    ; STZ WRMPYB_R
    ; STZ WRDIV_R.l
    ; STZ WRDIV_R.h
    ; STZ WRDIVB_R
    ; STZ HTIME_R.l
    ; STZ HTIME_R.h
    ; STZ VTIME_R.l
    ; STZ VTIME_R.h
    ; STZ MDMAEN_R
    ; STZ HDMAEN_R
    ; LDA .RDNMI_R
    ; LDA .TIMEUP_R
    ; PLP
    ; RTS

    ; #Code w {Clear_VRAM}
    ; PHP
    ; SEP #$20
    ; LDA #$80
    ; STA VMAINC_R
    ; REP #$20
    ; STZ VMADD_R
    ; JSL Immediate_DMA
    ; #Data {$09 $18 $80:FFF0 $0000}
    ; PLP
    ; RTS

    ; #Code w {Clear_OAM}
    ; PHP
    ; REP #$20
    ; STZ OAMADD_R
    ; JSL Immediate_DMA
    ; #Data {$0A $04 $80:FFF0 $0220}
    ; PLP
    ; RTS

    ; #Code w {Clear_CGRAM}
    ; PHP
    ; SEP #$20
    ; STZ CGADD_R
    ; JSL Immediate_DMA
    ; #Data {$0A $22 $80:FFF0 $0200}
    ; PLP
    ; RTS

    ; #Code w {Clear_ARAM}
    ; RTS









    ; # NMI ===============================



    ; #Code l {Wait_For_NMI}
    ; PHP
    ; SEP #$20
    ; LDA #$FF
    ; STA NMI_Ready_F
  ; {Wait} ; LDA NMI_Ready_F
    ; BNE {Wait}
    ; PLP
    ; RTL

    ; #Code l {Nmi}
    ; SEI
    ; PHA
    ; PHX
    ; PHY
    ; PHP
    ; PHB
    ; PHK
    ; PLB
    ; SEP #$20
    ; LDA NMI_Ready_F
    ; BEQ {+}
    ; STZ CGADD_R
    ; JSL Immediate_DMA
    ; #Data {$02 $22 $7E:0320 $0200}
    ; REP #$20
    ; LDA #$8000
    ; STA OAMADD_R
    ; JSL Immediate_DMA
    ; #Data {$02 $04 $7E:0100 $0220}
    ; JSR NMI_Refresh_Registers
    ; JSR NMI_HDMA
    ; JSR NMI_VRAM_DMA
    ; JSR NMI_VRAM_Write
    ; INC NMI_Count
    ; SEP #$20
    ; STZ NMI_Ready_F
  ; {+} ; PLB
    ; PLP
    ; PLY
    ; PLX
    ; PLA
    ; CLI
    ; RTI

    ; #Code w {NMI_Refresh_Registers}
    ; PHP
    ; SEP #$20
    ; LDA INIDISP_WR
    ; STA INIDISP_R
    ; LDA OBJSEL_WR
    ; STA OBJSEL_R
    ; LDA BGMODE_WR
    ; STA BGMODE_R
    ; LDA MOSAIC_WR
    ; STA MOSAIC_R
    ; LDA BG1SC_WR
    ; STA BG1SC_R
    ; LDA BG2SC_WR
    ; STA BG2SC_R
    ; LDA BG3SC_WR
    ; STA BG3SC_R
    ; LDA BG4SC_WR
    ; STA BG4SC_R
    ; LDA BG12NBA_WR
    ; STA BG12NBA_R
    ; LDA BG34NBA_WR
    ; STA BG34NBA_R
    ; LDA BG1HOFS_WR.l
    ; STA BG1HOFS_R
    ; LDA BG1HOFS_WR.h
    ; STA BG1HOFS_R
    ; LDA BG1VOFS_WR.l
    ; STA BG1VOFS_R
    ; LDA BG1VOFS_WR.h
    ; STA BG1VOFS_R
    ; LDA BG2HOFS_WR.l
    ; STA BG2HOFS_R
    ; LDA BG2HOFS_WR.h
    ; STA BG2HOFS_R
    ; LDA BG2VOFS_WR.l
    ; STA BG2VOFS_R
    ; LDA BG2VOFS_WR.h
    ; STA BG2VOFS_R
    ; LDA BG3HOFS_WR.l
    ; STA BG3HOFS_R
    ; LDA BG3HOFS_WR.h
    ; STA BG3HOFS_R
    ; LDA BG3VOFS_WR.l
    ; STA BG3VOFS_R
    ; LDA BG3VOFS_WR.h
    ; STA BG3VOFS_R
    ; LDA BG4HOFS_WR.l
    ; STA BG4HOFS_R
    ; LDA BG4HOFS_WR.h
    ; STA BG4HOFS_R
    ; LDA BG4VOFS_WR.l
    ; STA BG4VOFS_R
    ; LDA BG4VOFS_WR.h
    ; STA BG4VOFS_R
    ; LDA VMAINC_WR
    ; STA VMAINC_R
    ; LDA M7SEL_WR
    ; STA M7SEL_R
    ; LDA M7A_WR.l
    ; STA M7A_R
    ; LDA M7A_WR.h
    ; STA M7A_R
    ; LDA M7B_WR.l
    ; STA M7B_R
    ; LDA M7B_WR.h
    ; STA M7B_R
    ; LDA M7C_WR.l
    ; STA M7C_R
    ; LDA M7C_WR.h
    ; STA M7C_R
    ; LDA M7D_WR.l
    ; STA M7D_R
    ; LDA M7D_WR.h
    ; STA M7D_R
    ; LDA M7X_WR.l
    ; STA M7X_R
    ; LDA M7X_WR.h
    ; STA M7X_R
    ; LDA M7Y_WR.l
    ; STA M7Y_R
    ; LDA M7Y_WR.h
    ; STA M7Y_R
    ; LDA W12SEL_WR
    ; STA W12SEL_R
    ; LDA W34SEL_WR
    ; STA W34SEL_R
    ; LDA WOBJSEL_WR
    ; STA WOBJSEL_R
    ; LDA WH0_WR
    ; STA WH0_R
    ; LDA WH1_WR
    ; STA WH1_R
    ; LDA WH2_WR
    ; STA WH2_R
    ; LDA WH3_WR
    ; STA WH3_R
    ; LDA WBGLOG_WR
    ; STA WBGLOG_R
    ; LDA WOBJLOG_WR
    ; STA WOBJLOG_R
    ; LDA TM_WR
    ; STA TM_R
    ; LDA TS_WR
    ; STA TS_R
    ; LDA TMW_WR
    ; STA TMW_R
    ; LDA TSW_WR
    ; STA TSW_R
    ; LDA CGWSEL_WR
    ; STA CGWSEL_R
    ; LDA CGADSUB_WR
    ; STA CGADSUB_R
    ; LDA COLDATA_WR_Blue
    ; STA COLDATA_R
    ; LDA COLDATA_WR_Green
    ; STA COLDATA_R
    ; LDA COLDATA_WR_Red
    ; STA COLDATA_R
    ; LDA SETINI_WR
    ; STA SETINI_R
    ; LDA .STAT77_WR
    ; STA .STAT77_R
    ; LDA .STAT78_WR
    ; STA .STAT78_R
    ; LDA NMITIMEN_WR
    ; STA NMITIMEN_R
    ; LDA WRIO_WR
    ; STA WRIO_R
    ; LDA HTIME_WR.l
    ; STA HTIME_R.l
    ; LDA HTIME_WR.h
    ; STA HTIME_R.h
    ; LDA VTIME_WR.l
    ; STA VTIME_R.l
    ; LDA VTIME_WR.h
    ; STA VTIME_R.h
    ; LDA MEMSEL_WR
    ; STA MEMSEL_R
    ; LDA .RDNMI_R
    ; STA .RDNMI_WR
    ; LDA .TIMEUP_R
    ; STA .TIMEUP_WR
    ; LDA .RDIO_R
    ; STA .RDIO_WR
  ; {Wait} ; LDA .HVBJOY_R
    ; STA .HVBJOY_WR
    ; AND #$01
    ; BNE {Wait}
    ; REP #$20
    ; LDA JOY1_WR
    ; STA JOY1_previous
    ; LDA JOY2_WR
    ; STA JOY2_previous
    ; LDA JOY3_WR
    ; STA JOY3_previous
     LDA JOY4_WR
    ; STA JOY4_previous
    ; LDA JOY1_R
    ; STA JOY1_WR
    ; LDA JOY2_R
    ; STA JOY2_WR
    ; LDA JOY3_R
    ; STA JOY3_WR
    ; LDA JOY4_R
    ; STA JOY4_WR
    ; PLP
    ; RTS

    ; #Code w {NMI_HDMA}
    ; PHP
    ; SEP #$10
    ; LDX #$10
    ; LDY #$00
  ; {-} ; REP #$20
    ; LDA [NMI_HDMA_Data],Y
    ; CMP #$0000
    ; BEQ {+}
    ; STA DMAP_R,X
    ; INY
    ; INY
    ; LDA [NMI_HDMA_Data],Y
    ; INY
    ; INY
    ; STA ABADD_R.l,X
    ; LDA [NMI_HDMA_Data],Y
    ; INY
    ; INY
    ; STA ABADD_R.b,X
    ; LDA [NMI_HDMA_Data],Y
    ; INY
    ; INY
    ; STA DMAARG_R,X
  ; {+} ; SEP #$20
    ; TXA
    ; CLC
    ; ADC #$10
    ; CMP #$80
    ; BEQ {+}
    ; TAX
    ; BRA {-}
  ; {+} ; LDA HDMAEN_WR
    ; STA HDMAEN_R
    ; PLP
    ; RTS

    ; #Code w {NMI_VRAM_DMA}
    ; PHP
  ; {-} ; REP #$30
    ; LDA NMI_VRAM_DMA_Data_OS
    ; BEQ {+}
    ; SEC
    ; SBC #$000A
    ; STA NMI_VRAM_DMA_Data_OS
    ; TAY
    ; SEP #$20
    ; LDA [NMI_VRAM_DMA_Data],Y
    ; INY
    ; STA VMAINC_R
    ; REP #$20
    ; LDA [NMI_VRAM_DMA_Data],Y
    ; INY
    ; INY
    ; STA VMADD_R
    ; LDA [NMI_VRAM_DMA_Data],Y
    ; INY
    ; INY
    ; STA DMAP_R
    ; LDA [NMI_VRAM_DMA_Data],Y
    ; INY
    ; INY
    ; STA ABADD_R.l
    ; LDA [NMI_VRAM_DMA_Data],Y
    ; INY
    ; INY
    ; STA ABADD_R.b
    ; SEP #$20
    ; LDA [NMI_VRAM_DMA_Data],Y
    ; STA DMAARG_R
    ; LDA #$01
    ; STA MDMAEN_R
    ; BRA {-}
  ; {+} ; PLP
    ; RTS

    ; #Code w {NMI_VRAM_Write}
    ; PHP
    ; REP #$30
  ; {-} ; LDA NMI_VRAM_Write_Table_OS
    ; BEQ {+}
    ; SEC
    ; SBC #$0004
    ; STA NMI_VRAM_Write_Table_OS
    ; TAX
    ; SEP #$20
    ; LDA #$80
    ; STA VMAINC_R
    ; REP #$20
    ; LDA NMI_VRAM_Write.Addr,X
    ; STA VMADD_R
    ; LDA NMI_VRAM_Write.Data,X
    ; STA VMDATA_R
    ; INX
    ; INX
    ; INX
    ; INX
    ; BRA {-}
  ; {+} ; PLP
    ; RTS









    ; # Main Program ======================


    ; #Code l {Main_Program}
    ; REP #$30
  ; {Loop} ; LDA Main_Program_Mode
    ; ASL A
    ; TAX
    ; JSR (Main_Program_PT,X)
    ; INC Main_Program_Count
    ; BRA {Loop}
    ; #Data w Main_Program_PT
    { Initiate_Engine
     Open_Engine
     Game_Engine
    }




    ; #Code w {Initiate_Engine}
    ; PHP
    ; PHB
    ; PEA $8000
    ; PLB
    ; PLB
    ; SEP #$30
    ; LDA #$80
    ; STA VMAINC_R
    ; REP #$30
    ; LDA #$0000
    ; STA VMADD_R
    ; JSL Immediate_DMA
    ; #Data {$01 $18 Char_Data $1800}
    ; LDA #$4000
    ; STA VMADD_R
    ; JSL Immediate_DMA
    ; #Data {$01 $18 Frame_BG_Map $0800}
    ; LDA #$4400
    ; STA VMADD_R
    ; JSL Immediate_DMA
    ; #Data {$01 $18 Star_BG_Map $0800}
    ; LDA #$7E03
    ; STA WMADD_R.h
    ; LDA #$0320
    ; STA WMADD_R.l
    ; JSL Immediate_DMA
    ; #Data {$00 $80 Color_Data $0200}
    ;
    ; LDA #$2600 // Initiate Ships
    ; STA Ship_1_X
    ; LDA #$3500
    ; STA Ship_1_Y
    ; LDA #$0060
    ; STA Ship_1_Timer
    ;
    ; LDA #$D200
    ; STA Ship_2_X
    ; LDA #$B100
    ; STA Ship_2_Y
    ; LDA #$0060
    ; STA Ship_2_Timer
    ;
    ; LDA #$000D
    ; STA Random_Number
    ;
    ; SEP #$30 // Initiate Registers
    ; LDA #$01
    ; STA BGMODE_WR
    ; LDA #$40
    ; STA BG1SC_WR
    ; LDA #$44
    ; STA BG2SC_WR
    ; LDA #$13
    ; STA TM_WR
    ; LDA #$81
    ; STA NMITIMEN_R
    ; STA NMITIMEN_WR
    ; LDA #$00
    ; STA INIDISP_R
    ; STA INIDISP_WR
    ; CLI
    ;
    ; REP #$30
    ; INC Main_Program_Mode
    ; PLB
    ; PLP
    ; RTS




    ; #Code w {Open_Engine}
    ; PHP
    ; REP #$20
    ; LDA Main_Program_Count
    ; SEP #$20
    ; AND #$10
    ; BEQ {+}
    ; LDA INIDISP_WR
    ; INC A
    ; AND #$0F
    ; STA INIDISP_WR
    ; CMP #$0F
    ; BNE {+}
    ; INC Main_Program_Mode
  ; {+} ; JSR Analyze_Joy
    ; JSR Update_BG
    ; JSR Update_CGRAM
    ; LDA #$FF
    ; STA NMI_Ready_F
    ; JSL Wait_For_NMI
    ; REP #$20
    ; STZ Pause_F
    ; PLP
    ; RTS


    ; #Code w {Game_Engine}
    ; PHP
    ; SEP #$20
    ;
    ; JSR Analyze_Joy
    ; LDA Pause_F
    ; BEQ {+}
    ; LDA #$09
    ; STA INIDISP_WR
    ; BRA {Done}
  ; {+} ; LDA #$0F
    ; STA INIDISP_WR
    ;
    ; JSL Random_Number_Generator
    ; JSR Collision_Detection
    ; JSR Update_Ships
    ; JSR Update_Enemies
    ; JSR Update_Bullets
    ; JSR Update_BG
    ; JSR Update_CGRAM
    ; JSR Draw_Frame
    ;
    ; LDA #$FF
    ; STA NMI_Ready_F
  ; {Done} ; JSL Wait_For_NMI
    ;
    ; PLP
    ; RTS




    ; #Code w {Analyze_Joy}
    ; PHP
    ; REP #$30
    ;
    ; LDX #$0000
  ; {-} ; LDA JOY_WR,X
    ; BEQ {Trigger}
    ; CMP #$3030
    ; BNE {+}
    ; JMP RESET_Vector
  ; {+} ; EOR JOY_previous,X
    ; BNE {++}
    ; LDA JOY_hold_T,X
    ; BEQ {+}
    ; DEC JOY_hold_T,X
    ; LDA #$0000
    ; BRA {Trigger}
  ; {+} ; SEC
    ; DEC JOY_cooldown_T,X
    ; BEQ {+}
    ; LDA #$0000
    ; BRA {Trigger}
  ; {++} ; LDA #$000F
    ; STA JOY_hold_T,X
  ; {+} ; LDA #$000F
    ; STA JOY_cooldown_T,X
    ; LDA JOY_WR,X
    ; BCS {Trigger}
    ; EOR JOY_previous,X
    ; AND JOY_WR,X
  ; {Trigger} ; STA JOY_trigger,X
    ; AND #$1000
    ; BEQ {+}
    ; LDA #$FFFF
    ; EOR Pause_F
    ; STA Pause_F
    ;
  ; {+} ; INX
    ; INX
    ; CPX #$0008
    ; BCC {-}
    ;
    ; PLP
    ; RTS


    ; #Code w {Collision_Detection}
    ; PHP
    ; REP #$30
    ;
    ; LDA Ship_1_X.h // Find ship 1 hit box
    ; AND #$00FF
    ; CLC
    ; ADC #$0002
    ; STA Ship_1_Hit_Box_X1
    ; ADC #$0003
    ; STA Ship_1_Hit_Box_X2
    ; LDA Ship_1_Y.h
    ; AND #$00FF
    ; ADC #$0002
    ; STA Ship_1_Hit_Box_Y1
    ; ADC #$0003
    ; STA Ship_1_Hit_Box_Y2
    ;
    ; LDA Ship_2_X.h // Find ship 2 hit box
    ; AND #$00FF
    ; CLC
    ; ADC #$0002
    ; STA Ship_2_Hit_Box_X1
    ; ADC #$0003
    ; STA Ship_2_Hit_Box_X2
    ; LDA Ship_2_Y.h
    ; AND #$00FF
    ; ADC #$0002
    ; STA Ship_2_Hit_Box_Y1
    ; ADC #$0003
    ; STA Ship_2_Hit_Box_Y2
    ;
    ; LDY #$0000 // Ship/Obstacle-Bullet collisions
  ; {--} ; LDA Bullet.Active,Y
    ; BNE {+}
    ; BRL {+Next}
  ; {+} ;
    ; LDA Bullet.X.h,Y // Find bullet hit box
    ; AND #$00FF
    ; CLC
    ; ADC #$0002
    ; STA Hit_Box_X1
    ; ADC #$0003
    ; STA Hit_Box_X2
    ; LDA Bullet.Y.h,Y
    ; AND #$00FF
    ; ADC #$0002
    ; STA Hit_Box_Y1
    ; ADC #$0003
    ; STA Hit_Box_Y2
    ;
    ; LDX #$FFF0
  ; {-} ; TXA
    ; CLC
    ; ADC #$0010
    ; TAX
    ; CMP #$0200
    ; BEQ {+}
    ; LDA Obstacle.Active,X
    ; BEQ {-}
  ; # { ;
    ; LDA Obstacle.X.h,X // Find obstacle hit box
    ; AND #$00FF
    ; CLC
    ; ADC #$0002
    ; STA Enemy_Hit_Box_X1
    ; ADC #$000B
    ; STA Enemy_Hit_Box_X2
    ; LDA Obstacle.Y.h,X
    ; AND #$00FF
    ; ADC #$0002
    ; STA Enemy_Hit_Box_Y1
    ; ADC #$000B
    ; STA Enemy_Hit_Box_Y2
    ;
    ; LDA Hit_Box_X2 // Compare obstacle-bullet hit boxes
    ; CMP Enemy_Hit_Box_X1
    ; BCC {-}
    ; LDA Enemy_Hit_Box_X2
    ; CMP Hit_Box_X1
    ; BCC {-}
    ; LDA Hit_Box_Y2
    ; CMP Enemy_Hit_Box_Y1
    ; BCC {-}
    ; LDA Enemy_Hit_Box_Y2
    ; CMP Hit_Box_Y1
    ; BCC {-}
    ; LDA #$0000
    ; STA Bullet.Active,Y // Absorb
    ; BRA {+Next}
  ; # } ;
  ; {+} ;
    ;
    ;
    ;
    ;
    ; LDA Ship_1_Status // Compare hit boxes
    ; CMP #$0001
    ; BNE {+}
    ; LDA Hit_Box_X2
    ; CMP Ship_1_Hit_Box_X1
    ; BCC {+}
    ; LDA Ship_1_Hit_Box_X2
    ; CMP Hit_Box_X1
    ; BCC {+}
    ; LDA Hit_Box_Y2
    ; CMP Ship_1_Hit_Box_Y1
    ; BCC {+}
    ; LDA Ship_1_Hit_Box_Y2
    ; CMP Hit_Box_Y1
    ; BCC {+}
    ; LDA Ship_1_Polarity
    ; CMP Bullet.Polarity,Y
    ; BEQ {Absorb}
    ; INC Ship_2_Kills // Death
    ; LDA #$0002
    ; STA Ship_1_Status
    ; BRA {+}
  ; {Absorb} ; LDA #$0000 // Absorb
    ; STA Bullet.Active,Y
    ; LDA Ship_1_Charge
    ; CMP #$0010
    ; BCS {Max}
    ; INC Ship_1_Charge
  ; {Max} ;
    ;
    ;
  ; {+} ; LDA Ship_2_Status
    ; CMP #$0001
    ; BNE {+Next}
    ; LDA Hit_Box_X2
    ; CMP Ship_2_Hit_Box_X1
    ; BCC {+Next}
    ; LDA Ship_2_Hit_Box_X2
    ; CMP Hit_Box_X1
    ; BCC {+Next}
    ; LDA Hit_Box_Y2
    ; CMP Ship_2_Hit_Box_Y1
    ; BCC {+Next}
    ; LDA Ship_2_Hit_Box_Y2
    ; CMP Hit_Box_Y1
    ; BCC {+Next}
    ; LDA Ship_2_Polarity
    ; CMP Bullet.Polarity,Y
    ; BEQ {Absorb}
    ; INC Ship_1_Kills // Death
    ; LDA #$0002
    ; STA Ship_2_Status
    ; BRA {+}
  ; {Absorb} ; LDA #$0000 // Absorb
    ; STA Bullet.Active,Y
    ; LDA Ship_2_Charge
    ; CMP #$0010
    ; BCS {Max}
    ; INC Ship_2_Charge
  ; {Max} ;
    ;
  ; {+Next} ; TYA
    ; CLC
    ; ADC #$0010
    ; TAY
    ; CMP #$0800
    ; BCS {+}
    ; JMP {--}
  ; {+} ;
    ;
    ;
    ;
    ;
    ; LDY #$0000 // Ship-Obstacle collisions
  ; {-} ; LDA Obstacle.Active,Y
    ; BNE {+}
    ; BRL {+Next}
  ; {+} ;
    ; LDA Obstacle.X.h,Y // Find obstacle hit box
    ; AND #$00FF
    ; CLC
    ; ADC #$0000
    ; STA Hit_Box_X1
    ; ADC #$000F
    ; STA Hit_Box_X2
    ; LDA Obstacle.Y.h,Y
    ; AND #$00FF
    ; ADC #$0000
    ; STA Hit_Box_Y1
    ; ADC #$000F
    ; STA Hit_Box_Y2
    ;
    ; LDA Ship_1_Status // Compare hit boxes
    ; CMP #$0001
    ; BNE {+}
    ; LDA Hit_Box_X2
    ; CMP Ship_1_Hit_Box_X1
    ; BCC {+}
    ; LDA Ship_1_Hit_Box_X2
    ; CMP Hit_Box_X1
    ; BCC {+}
    ; LDA Hit_Box_Y2
    ; CMP Ship_1_Hit_Box_Y1
    ; BCC {+}
    ; LDA Ship_1_Hit_Box_Y2
    ; CMP Hit_Box_Y1
    ; BCC {+}
    ; LDA Ship_2_Kills // Death
    ; INC A
    ; STA Ship_2_Kills
    ; STZ Ship_1_VX
    ; STZ Ship_1_VY
    ; LDA #$0002
    ; STA Ship_1_Status
    ;
  ; {+} ; LDA Ship_2_Status
    ; CMP #$0001
    ; BNE {+Next}
    ; LDA Hit_Box_X2
    ; CMP Ship_2_Hit_Box_X1
    ; BCC {+Next}
    ; LDA Ship_2_Hit_Box_X2
    ; CMP Hit_Box_X1
    ; BCC {+Next}
    ; LDA Hit_Box_Y2
    ; CMP Ship_2_Hit_Box_Y1
    ; BCC {+Next}
    ; LDA Ship_2_Hit_Box_Y2
    ; CMP Hit_Box_Y1
    ; BCC {+Next}
    ; LDA Ship_1_Kills // Death
    ; INC A
    ; STA Ship_1_Kills
    ; STZ Ship_2_VX
    ; STZ Ship_2_VY
    ; LDA #$0002
    ; STA Ship_2_Status
    ;
  ; {+Next} ; TYA
    ; CLC
    ; ADC #$0010
    ; TAY
    ; CMP #$0200
    ; BCS {+}
    ; BRL {-}
  ; {+} ;
    ;
    ; PLP
    ; RTS


    ; #Code w {Update_Ships}
    ; PHP
    ; REP #$30
    ; LDY #Ship_1
    ; LDA Ship_1_Status
    ; ASL A
    ; TAX
    ; JSR (Ship_Program_Table,X)
    ; LDY #Ship_2
    ; LDA Ship_2_Status
    ; ASL A
    ; TAX
    ; JSR (Ship_Program_Table,X)
    ; PLP
    ; RTS

    ; #Data w Ship_Program_Table
    { Update_Ship.Ghost
     Update_Ship.Live
     Update_Ship.Death
     Update_Ship.Dead
    }


    ; #Code w {Update_Ship.Ghost}
    ; #Code w {Update_Ship.Live}
    ; PHP
    ; REP #$30
    ; TYX
    ; CPY #Ship_1
    ; BNE {+}
    ; LDY #$0000
    ; BRA{++}
  ; {+} ; LDY #$0002
  ; {++} ;
    ; LDA Ship.Status,X // Ghost logic
    ; CMP #$0000
    ; BNE {+}
    ; LDA #$FFFF
    ; EOR Ship.Render,X
    ; STA Ship.Render,X
    ; BEQ {+}
    ; DEC Ship.Timer,X
    ; BNE {+}
    ; INC Ship.Status,X
    ; STZ Ship.Timer,X
    ;
  ; {+} ; LDA JOY_trigger,Y // Polarity
    ; AND #$0080
    ; BEQ {+}
    ; LDA #$FFFF
    ; EOR Ship.Polarity,X
    ; STA Ship.Polarity,X
    ;
  ; {+} ; LDA JOY_WR,Y // Right
    ; AND #$0100
    ; BEQ {+}
    ; LDA Ship.VX,X
    ; CLC
    ; ADC #$0020
    ; BMI {++}
    ; CMP #$0201
    ; BCC {++}
    ; LDA #$0200
  ; {++} ; STA Ship.VX,X
    ;
  ; {+} ; LDA JOY_WR,Y // Left
    ; AND #$0200
    ; BEQ {+}
    ; LDA Ship.VX,X
    ; SEC
    ; SBC #$0020
    ; BPL {++}
    ; CMP #$FE01
    ; BCS {++}
    ; LDA #$FE00
  ; {++} ; STA Ship.VX,X
    ;
  ; {+} ; LDA JOY_WR,Y // Down
    ; AND #$0400
    ; BEQ {+}
    ; LDA Ship.VY,X
    ; CLC
    ; ADC #$0020
    ; BMI {++}
    ; CMP #$0201
    ; BCC {++}
    ; LDA #$0200
  ; {++} ; STA Ship.VY,X
    ;
  ; {+} ; LDA JOY_WR,Y // Up
    ; AND #$0800
    ; BEQ {+}
    ; LDA Ship.VY,X
    ; SEC
    ; SBC #$0020
    ; BPL {++}
    ; CMP #$FE01
    ; BCS {++}
    ; LDA #$FE00
  ; {++} ; STA Ship.VY,X
    ;
  ; {+} ; LDA Ship.VX,X // Update X position
    ; CLC
    ; ADC Ship.X,X
    ; STA Ship.X,X
    ;
    ; LDA Ship.VY,X // Update Y position
    ; CLC
    ; ADC Ship.Y,X
    ; STA Ship.Y,X
    ;
    ; PHY
    ; PHX
    ; LDY Ship.VY,X // Find angle
    ; LDA Ship.VX,X
    ; TAX
    ; JSL Find_Angle
    ; PLX
    ; PLY
    ; STA Ship.Angle,X
    ;
    ; CMP #$00FF // Update gun
    ; BNE {+}
    ; STZ Ship.Gun_X,X
    ; STZ Ship.Gun_Y,X
    ; BRL {+Done}
  ; {+} ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0008
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; PLX
    ; CLC
    ; ADC Ship.Y,X
    ; STA Ship.Gun_Y,X
    ;
    ; LDA Ship.Angle,X
    ; CLC
    ; ADC #$0008
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0008
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; PLX
    ; CLC
    ; ADC Ship.X,X
    ; STA Ship.Gun_X,X
    ;
    ; LDA Ship.Status,X // Weapon Logic
    ; CMP #$0000
    ; BNE {+}
    ; BRL {+Done}
  ; {+} ; LDA Ship.Timer,X
    ; BEQ {+}
    ; DEC Ship.Timer,X
    ; BRL {+Done}
    ;
  ; {+} ; LDA Ship.Burst,X
    ; BEQ {+}
    ; BRL {Bursting}
  ; {+} ; LDA JOY_WR,Y
    ; AND #$0020
    ; BEQ {+}
    ; LDA Ship.Charge,X
    ; BEQ {Shot}
    ; BRL {Burst}
  ; {+} ; LDA JOY_WR,Y
    ; AND #$0010
    ; BEQ {+Done}
    ;
    ; LDA JOY_WR,Y // Shot
    ; AND #$0010
    ; BEQ {+Done}
  ; {Shot} ; LDY #$FFF0
  ; {-} ; TYA
    ; CLC
    ; ADC #$0010
    ; TAY
    ; CMP #$0800
    ; BCS {+Done}
    ; LDA Bullet.Active,Y
    ; BNE {-}
    ; LDA #$FFFF
    ; STA Bullet.Active,Y
    ; LDA Ship.Polarity,X
    ; STA Bullet.Polarity,Y
    ;
    ; LDA Ship.Gun_X,X
    ; STA Bullet.X,Y
    ; LDA Ship.Gun_Y,X
    ; STA Bullet.Y,Y
    ;
    ; LDA Ship.Angle,X
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0003
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; CLC
    ; PLX
    ; ADC Ship.VY,X
    ; STA Bullet.VY,Y
    ;
    ; LDA Ship.Angle,X
    ; CLC
    ; ADC #$0008
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0003
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; PLX
    ; CLC
    ; ADC Ship.VX,X
    ; STA Bullet.VX,Y
    ; LDA #$0001
    ; STA Ship.Timer,X
  ; {+Done} ; BRL {+Done}
    ;
  ; {Burst} ; LDA #$0002 // Burst
    ; STA Ship.Burst,X
    ;
  ; {Bursting} ; LDA Ship.Angle,X
    ; CLC
    ; ADC Ship.Charge,X
    ; AND #$001F
    ; STA Max_Burst_Angle
    ; LDA Ship.Angle,X
    ; SEC
    ; SBC Ship.Charge,X
    ; DEC A
    ; AND #$001F
    ; STA Min_Burst_Angle
    ; INC A
    ; AND #$001F
    ; CMP Max_Burst_Angle
    ; BNE {+}
    ; LDA Min_Burst_Angle
    ; INC A
    ; AND #$001F
    ; STA Min_Burst_Angle
  ; {+} ;
    ;
    ; LDY #$FFF0
  ; {-} ; TYA
    ; CLC
    ; ADC #$0010
    ; TAY
    ; CMP #$0800
    ; BCS {++}
    ; LDA Bullet.Active,Y
    ; BNE {-}
    ; LDA #$FFFF
    ; STA Bullet.Active,Y
    ; LDA Ship.Polarity,X
    ; STA Bullet.Polarity,Y
    ;
    ; LDA Ship.Gun_X,X
    ; STA Bullet.X,Y
    ; LDA Ship.Gun_Y,X
    ; STA Bullet.Y,Y
    ;
    ; LDA Max_Burst_Angle
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0003
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; CLC
    ; PLX
    ; ADC Ship.VY,X
    ; STA Bullet.VY,Y
    ;
    ; LDA Max_Burst_Angle
    ; CLC
    ; ADC #$0008
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0003
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; PLX
    ; CLC
    ; ADC Ship.VX,X
    ; STA Bullet.VX,Y
    ;
    ; LDA Max_Burst_Angle
    ; DEC A
    ; AND #$001F
    ; STA Max_Burst_Angle
    ; CMP Min_Burst_Angle
    ; BNE {-}
    ;
  ; {++} ; LDA #$000C
    ; STA Ship.Timer,X
    ; DEC Ship.Burst,X
    ; BNE {+Done}
    ; STZ Ship.Charge,X
    ;
    ;
  ; {+Done} ;
    ;
    ; PLP
    ; RTS


    ; #Code w {Update_Ship.Death}
    ; PHP
    ; REP #$30
    ; TYX
    ;
    ; LDA #$0006 // Death Blossom
    ; CLC
    ; ADC Ship.Charge,X
    ; STA Death_Blossom_Count
    ; LDY #$FFF0
  ; {-} ; TYA
    ; CLC
    ; ADC #$0010
    ; TAY
    ; CMP #$0800
    ; BCS {++}
    ; LDA Bullet.Active,Y
    ; BNE {-}
    ;
    ; LDA #$FFFF
    ; STA Bullet.Active,Y
    ; LDA Ship.Polarity,X
    ; STA Bullet.Polarity,Y
    ;
    ; LDA Ship.X,X
    ; STA Bullet.X,Y
    ; LDA Ship.Y,X
    ; STA Bullet.Y,Y
    ;
    ; JSL Random_Number_Generator
    ; AND #$001F
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0001
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; CLC
    ; PLX
    ; ADC Ship.VY,X
    ; BNE {+}
    ; LDA Ship.VY,X
  ; {+} ; STA Bullet.VY,Y
    ;
    ; JSL Random_Number_Generator
    ; AND #$001F
    ; CLC
    ; ADC #$0008
    ; ASL A
    ; PHX
    ; TAX
    ; LDA Sinusoid,X
    ; STA Multiplicand_1
    ; LDA #$0001
    ; STA Multiplicand_2
    ; JSL Multiply
    ; LDA Product
    ; PLX
    ; CLC
    ; ADC Ship.VX,X
    ; BNE {+}
    ; LDA Ship.VX,X
  ; {+} ; STA Bullet.VX,Y
    ; DEC Death_Blossom_Count
    ; BNE {-}
  ; {++} ;
    ; STZ Ship.Render,X // Update ship
    ; STZ Ship.Charge,X
    ; STZ Ship.Burst,X
    ; JSL Random_Number_Generator
    ; STA Ship.X,X
    ; JSL Random_Number_Generator
    ; STA Ship.Y,X
    ; JSL Random_Number_Generator
    ; AND #$00FF
    ; CMP #$0080
    ; BCC {+}
    ; EOR #$FFFF
  ; {+} ; AND #$FFE0
    ; STA Ship.VX,X
    ; JSL Random_Number_Generator
    ; AND #$00FF
    ; CMP #$0080
    ; BCC {+}
    ; EOR #$FFFF
  ; {+} ; AND #$FFE0
    ; STA Ship.VY,X
    ; INC Ship.Status,X
    ; LDA #$0020
    ; STA Ship.Timer,X
    ;
    ; PLP
    ; RTS


    ; #Code w {Update_Ship.Dead}
    ; PHP
    ; REP #$30
    ; TYX
    ;
    ; DEC Ship.Timer,X
    ; BNE {+}
    ; STZ Ship.Status,X
    ; LDA #$0020
    ; STA Ship.Timer,X
    ;
  ; {+} ; PLP
    ; RTS


    ; #Code w {Update_Enemies}
    ; PHP
    ; REP #$30
    ;
    ; JSL Random_Number_Generator // Spawn Obstacle
    ; CMP #$FF00 // Spawn probablilty
    ; BCS {+}
    ; BRL {+Done}
    ;
  ; {+} ; LDX #$FFF0
  ; {-} ; TXA  // Find empty obstacle entry
    ; CLC
    ; ADC #$0010
    ; TAX
    ; CMP #$0200
    ; BCC {+}
    ; BRL {+Done}
  ; {+} ; LDA Obstacle.Active,X
    ; BNE {-}
    ; LDA #$FFFF
    ; STA Obstacle.Active,X
    ;
    ; JSL Random_Number_Generator
    ; ROR A
    ; BCS {Spawn_Y}
    ;
    ; JSL Random_Number_Generator // Spawn on X axis
    ; STA Obstacle.X,X
    ; JSL Random_Number_Generator
    ; ROR A
    ; BCS {+}
    ; AND #$007F
    ; BRA {++}
  ; {+} ; ORA #$FF80
  ; {++} ; STA Obstacle.VX,X
    ; JSL Random_Number_Generator
    ; ROR A
    ; BCS {Bottom}
    ;
    ; LDA #$0100 // Top
    ; STA Obstacle.Y,X
    ; JSL Random_Number_Generator
    ; AND #$007F
    ; STA Obstacle.VY,X
    ; BRA {+Done}
    ;
  ; {Bottom} ; LDA #$F800 // Bottom
    ; STA Obstacle.Y,X
    ; JSL Random_Number_Generator
    ; ORA #$FF80
    ; STA Obstacle.VY,X
    ; BRA {+Done}
    ;
  ; {Spawn_Y} ; JSL Random_Number_Generator // Spawn on Y axis
    ; STA Obstacle.Y,X
    ; JSL Random_Number_Generator
    ; ROR A
    ; BCS {+}
    ; AND #$007F
    ; BRA {++}
  ; {+} ; ORA #$FF80
  ; {++} ; STA Obstacle.VY,X
    ; JSL Random_Number_Generator
    ; ROR A
    ; BCS {Right}
    ;
    ; LDA #$0100 // Left
    ; STA Obstacle.X,X
    ; JSL Random_Number_Generator
    ; AND #$007F
    ; STA Obstacle.VX,X
    ; BRA {+Done}
    ;
  ; {Right} ; LDA #$F800 // Right
    ; STA Obstacle.X,X
    ; JSL Random_Number_Generator
    ; ORA #$FF80
    ; STA Obstacle.VX,X
    ; BRA {+Done}
  ; {+Done} ;
    ;
    ;
    ; LDX #$0000 // Update Obstacle
  ; {-} ; LDA Obstacle.Active,X
    ; BEQ {+Next}
    ; LDA Obstacle.VX,X
    ; BMI {+Minus}
    ; CLC
    ; ADC Obstacle.X,X
    ; BCC {+}
    ; STZ Obstacle.Active,X
    ; BRA {+Next}
  ; {+Minus} ; DEC A
    ; SEC
    ; ADC Obstacle.X,X
    ; BCS {+}
    ; STZ Obstacle.Active,X
    ; BRA {+Next}
  ; {+} ; STA Obstacle.X,X
    ;
    ; LDA Obstacle.VY,X
    ; BMI {+Minus}
    ; CLC
    ; ADC Obstacle.Y,X
    ; BCC {+}
    ; STZ Obstacle.Active,X
    ; BRA {+Next}
  ; {+Minus} ; DEC A
    ; SEC
    ; ADC Obstacle.Y,X
    ; BCS {+}
    ; STZ Obstacle.Active,X
    ; BRA {+Next}
  ; {+} ; STA Obstacle.Y,X
    ;
  ; {+Next} ; TXA
    ; CLC
    ; ADC #$0010
    ; CMP #$0200
    ; BEQ {+Done}
    ; TAX
    ; BRA {-}
    ;
  ; {+Done} ;
    ;
    ; PLP
    ; RTS

    ; #Code w {Update_Bullets}
    ; PHP
    ; REP #$30
    ;
    ; LDX #$0000
    ;
  ; {-} ; LDA Bullet.Active,X
    ; BEQ {+Next}
    ; LDA Bullet.VX,X
    ; BMI {+Minus}
    ; CLC
    ; ADC Bullet.X,X
    ; BCC {+}
    ; STZ Bullet.Active,X
    ; BRA {+Next}
  ; {+Minus} ; DEC A
    ; SEC
    ; ADC Bullet.X,X
    ; BCS {+}
    ; STZ Bullet.Active,X
    ; BRA {+Next}
  ; {+} ; STA Bullet.X,X
    ;
    ; LDA Bullet.VY,X
    ; BMI {+Minus}
    ; CLC
    ; ADC Bullet.Y,X
    ; BCC {+}
    ; STZ Bullet.Active,X
    ; BRA {+Next}
  ; {+Minus} ; DEC A
    ; SEC
    ; ADC Bullet.Y,X
    ; BCS {+}
    ; STZ Bullet.Active,X
    ; BRA {+Next}
  ; {+} ; STA Bullet.Y,X
    ;
  ; {+Next} ; TXA
    ; CLC
    ; ADC #$0010
    ; CMP #$0800
    ; BEQ {+Done}
    ; TAX
    ; BRA {-}
    ;
  ; {+Done} ; PLP
    ; RTS


    ; #Code w {Update_BG}
    ; PHP
    ; REP #$30
    ;
    ; LDX NMI_VRAM_Write_Table_OS
    ; LDY #$402A // Ship 1 Kills
    ; LDA Ship_1_Kills
    ; AND #$00FF
    ; LSR A
    ; LSR A
    ; LSR A
    ; LSR A
    ; ORA #$2400
    ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INY
    ; INX
    ; INX
    ; INX
    ; INX
    ; LDA Ship_1_Kills
    ; AND #$000F
    ; ORA #$2400
    ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INX
    ; INX
    ; INX
    ; INX
    ;
    ; LDY #$4034 // Ship 2 Kills
    ; LDA Ship_2_Kills
    ; AND #$00FF
    ; LSR A
    ; LSR A
    ; LSR A
    ; LSR A
    ; ORA #$2400
    ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INY
    ; INX
    ; INX
    ; INX
    ; INX
    ; LDA Ship_2_Kills
    ; AND #$000F
    ; ORA #$2400
    ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INX
    ; INX
    ; INX
    ; INX
    ;
    ; LDA Ship_1_Charge // Ship 1 Charge Gauge
    ; LDY #$4025
  ; {-} ; CPY #$4029
    ; BEQ {++}
    ; SEC
    ; SBC #$0004
    ; BCC {+}
    ; PHA
    ; LDA Ship_1_Polarity
    ; BNE {Blue}
    ; LDA #$242A
    ; BRA {Red}
  ; {Blue} ; LDA #$282A
  ; {Red} ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INY
    ; INX
    ; INX
    ; INX
    ; INX
    ; PLA
    ; BRA {-}
    ;
  ; {+} ; ADC #$202A
    ; PHA
    ; LDA Ship_1_Polarity
    ; BNE {Blue}
    ; PLA
    ; ORA #$0400
    ; BRA {Red}
  ; {Blue} ; PLA
    ; ORA #$0800
  ; {Red} ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INY
    ; INX
    ; INX
    ; INX
    ; INX
    ;
  ; {-} ; CPY #$4029
    ; BEQ {++}
    ; LDA #$2426
    ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; INY
    ; INX
    ; INX
    ; INX
    ; INX
    ; BRA {-}
  ; {++} ;
    ; LDA Ship_2_Charge // Ship 2 Charge Gauge
    ; LDY #$403A
  ; {-} ; CPY #$4036
    ; BEQ {++}
    ; SEC
    ; SBC #$0004
    ; BCC {+}
    ; PHA
    ; LDA Ship_2_Polarity
    ; BNE {Blue}
    ; LDA #$642A
    ; BRA {Red}
  ; {Blue} ; LDA #$682A
  ; {Red} ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; DEY
    ; INX
    ; INX
    ; INX
    ; INX
    ; PLA
    ; BRA {-}
    ;
  ; {+} ; ADC #$602A
    ; PHA
    ; LDA Ship_2_Polarity
    ; BNE {Blue}
    ; PLA
    ; ORA #$0400
    ; BRA {Red}
  ; {Blue} ; PLA
    ; ORA #$0800
  ; {Red} ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; DEY
    ; INX
    ; INX
    ; INX
    ; INX
    ;
  ; {-} ; CPY #$4036
    ; BEQ {++}
    ; LDA #$6426
    ; STA NMI_VRAM_Write.Data,X
    ; TYA
    ; STA NMI_VRAM_Write.Addr,X
    ; DEY
    ; INX
    ; INX
    ; INX
    ; INX
    ; BRA {-}
  ; {++} ;
    ; STX NMI_VRAM_Write_Table_OS
    ;
    ; CLC  // BG2 Star Map
    ; LDA Ship_1_VX
    ; ADC Ship_2_VX
    ; CLC
    ; BPL {+}
    ; SEC
  ; {+} ; ROR A
    ; CLC
    ; ADC BG2.X
    ; STA BG2.X
    ; XBA
    ; AND #$00FF
    ; STA BG2HOFS_WR
    ;
    ; CLC
    ; LDA Ship_1_VY
    ; ADC Ship_2_VY
    ; CLC
    ; BPL {+}
    ; SEC
  ; {+} ; ROR A
    ; CLC
    ; ADC BG2.Y
    ; STA BG2.Y
    ; XBA
    ; AND #$00FF
    ; STA BG2VOFS_WR
    ;
    ; PLP
    ; RTS


    ; #Code w {Update_CGRAM}
    ; PHP
    ; REP #$30
    ;
    ; LDA Main_Program_Count // Stars
    ; AND #$0002
    ; BNE {+}
    ; LDA #$0842
    ; STA $0382
    ; BRA {++}
  ; {+} ; LDA #$2108
    ; STA $0382
  ; {++} ;
    ;
    ; LDA Main_Program_Count // Charge Gauge
    ; AND #$0002
    ; BNE {+}
    ;
    ; LDA #$001C
    ; STA $035C
    ; LDA #$41BC
    ; STA $035E
    ; LDA #$7000
    ; STA $037C
    ; LDA #$71B0
    ; STA $037E
    ; BRA {++}
    ;
  ; {+} ; LDA #$000C
    ; STA $035C
    ; LDA #$0018
    ; STA $035E
    ; LDA #$3000
    ; STA $037C
    ; LDA #$6000
    ; STA $037E
  ; {++} ;
    ;
    ; PLP
    ; RTS


    ; #Code w {Draw_Frame}
    ; PHP
    ; REP #$20
    ; SEP #$10
    ; JSL Ready_OAM
    ; STZ Draw_Sprite_Char_OS
    ;
    ; LDA Ship_1_Render // Ship 1
    ; BEQ {+Skip}
    ; LDX #$80
    ; STX Draw_Sprite_Data_Bank
    ;
    ; LDA #Ship_Sprite
    ; STA Draw_Sprite_Data_OS
    ; LDX Ship_1_X.h
    ; STX Draw_Sprite_X
    ; LDX Ship_1_Y.h
    ; STX Draw_Sprite_Y
    ; LDA Ship_1_Polarity
    ; BNE {Blue}
    ; LDX #$20
    ; BRA {+}
  ; {Blue} ; LDX #$22
    ;
  ; {+} ; STX Draw_Sprite_OBJ_P_Override
    ; JSL Draw_Sprite
    ;
    ; LDX #$80
    ; STX Draw_Sprite_Data_Bank
    ; LDA #Gun_Sprite_1
    ; STA Draw_Sprite_Data_OS
    ; LDX Ship_1_Gun_X.h
    ; STX Draw_Sprite_X
    ; LDX Ship_1_Gun_Y.h
    ; STX Draw_Sprite_Y
    ; LDX #$00
    ; STX Draw_Sprite_OBJ_P_Override
    ; JSL Draw_Sprite


  ; {+Skip} ; LDA Ship_2_Render // Ship 2
    ; BEQ {+Skip}
    ; LDX #$80
    ; STX Draw_Sprite_Data_Bank
    ; LDA #Ship_Sprite
    ; STA Draw_Sprite_Data_OS
    ; LDX Ship_2_X.h
    ; STX Draw_Sprite_X
    ; LDX Ship_2_Y.h
    ; STX Draw_Sprite_Y
    ; LDA Ship_2_Polarity
    ; BNE {Blue}
    ; LDX #$00
    ; BRA {+}
  ; {Blue} ; LDX #$02
    ;
  ; {+} ; STX Draw_Sprite_OBJ_P_Override
    ; JSL Draw_Sprite
    ;
    ;
    ; LDX #$80
    ; STX Draw_Sprite_Data_Bank
    ; LDA #Gun_Sprite_2
    ; STA Draw_Sprite_Data_OS
    ; LDX Ship_2_Gun_X.h
    ; STX Draw_Sprite_X
    ; LDX Ship_2_Gun_Y.h
    ; STX Draw_Sprite_Y
    ; LDX #$00
    ; STX Draw_Sprite_OBJ_P_Override
    ; JSL Draw_Sprite
    ;
  ; {+Skip} ;
    ; LDX #$80 // Bullets
    ; STX Draw_Sprite_Data_Bank
    ; LDA #Shot_Sprite
    ; STA Draw_Sprite_Data_OS
    ;
    ; REP #$10
    ; LDX #$0000
  ; {-} ; SEP #$20
    ; LDA Bullet.Active,X
    ; BEQ {+Next}
    ;
    ; LDA Bullet.X.h,X
    ; STA Draw_Sprite_X
    ; LDA Bullet.Y.h,X
    ; STA Draw_Sprite_Y
    ; LDA Bullet.Polarity,X
    ; BNE {Blue}
    ; LDA #$20
    ; BRA {+}
  ; {Blue} ; LDA #$22
  ; {+} ; STA Draw_Sprite_OBJ_P_Override
    ; PHX
    ; JSL Draw_Sprite
    ; PLX
  ; {+Next} ; REP #$20
    ; TXA
    ; CLC
    ; ADC #$0010
    ; TAX
    ; CMP #$0800
    ; BCC {-}

    ; LDA #Obstacle_Sprite // Obstacles
    ; STA Draw_Sprite_Data_OS
    ;
    ; REP #$10
    ; LDX #$0000
  ; {-} ; SEP #$20
    ; LDA Obstacle.Active,X
    ; BEQ {+Next}
    ;
    ; LDA Obstacle.X.h,X
    ; STA Draw_Sprite_X
    ; LDA Obstacle.Y.h,X
    ; STA Draw_Sprite_Y
    ; STZ Draw_Sprite_OBJ_P_Override
    ; PHX
    ; JSL Draw_Sprite
    ; PLX
  ; {+Next} ; REP #$20
    ; TXA
    ; CLC
    ; ADC #$0010
    ; TAX
    ; CMP #$0200
    ; BCC {-}
    ;
    ;
    ; JSL Hide_Unused_OAM
    ; PLP
    ; RTS

    ; #Data w Ship_Sprite  { $00 , $00 $00 $2040 $00 }
    ; #Data w Gun_Sprite_1 { $00 , $00 $00 $2041 $00 }
    ; #Data w Gun_Sprite_2 { $00 , $00 $00 $2042 $00 }
    ; #Data w Shot_Sprite  { $00 , $00 $00 $2043 $00 }
    ; #Data w Obstacle_Sprite
    { $03
     $00 $00 $2444 $00
     $08 $00 $6444 $00
     $00 $08 $A444 $00
     $08 $08 $E444 $00
    }





    ; # General Functions =================


    ; #Code l {Multiply}        // 16*16=16
    ; PHP
    ; REP #$30
    ; LDA #$0000
  ; {-} ; LDX Multiplicand_1
    ; BEQ {+Return}
    ; LSR Multiplicand_1
    ; BCC {+}
    ; CLC
    ; ADC Multiplicand_2
  ; {+} ; ASL Multiplicand_2
    ; BRA {-}
  ; {+Return} ; STA Product
    ; PLP
    ; RTL

    ; #Code l {Divide}          // 16/16=16
    ; PHP
    ; REP #$30
    ; STZ Quotient
    ; LDA Divisor
    ; LDX Dividend
    ; LDY #$0001
  ; {-} ; ASL A
    ; BCS {+}
    ; INY
    ; CPY #$0011
    ; BNE {-}
  ; {+} ; ROR A
  ; {-} ; PHA
    ; TXA
    ; SEC
    ; SBC $01,S
    ; BCC {+}
    ; TAX
  ; {+} ; ROL Quotient
    ; PLA
    ; LSR A
    ; DEY
    ; BNE {-}
    ; LDA Quotient
    ; STX Remainder
    ; PLP
    ; RTL

    ; #Data l Sinusoid
    { $0000
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

    ; #Code l {Immediate_DMA}
    ; PHP
    ; PHB
    ; SEP #$20
    ; LDA $05,S
    ; PHA
    ; PLB
    ; REP #$20
    ; LDA $03,S
    ; INC A
    ; TAX
    ; LDA $0000,X
    ; STA DMAP0_R
    ; LDA $0002,X
    ; STA ABADD0_R.l
    ; LDA $0004,X
    ; STA ABADD0_R.b
    ; SEP #$20
    ; LDA $0006,X
    ; STA DMAARG0_R.h
    ; LDA #$01
    ; STA MDMAEN_R
    ; REP #$20
    ; TXA
    ; CLC
    ; ADC #$0006
    ; STA $03,S
    ; PLB
    ; PLP
    ; RTL

    ; #Code l {Ready_OAM}
    ; PHP
    ; PHB
    ; PEA $7E00
    ; PLB
    ; PLB
    ; REP #$30
    ; STZ OAM_OS
    ; STZ OAM_II_byte_OS // and bit OS
    ; LDX #$001E
  ; {-} ; STZ OAM_II_WR,X
    ; DEX
    ; DEX
    ; BPL {-}
    ; PLB
    ; PLP
    ; RTL

    ; #Code l {Hide_Unused_OAM}
    ; PHP
    ; REP #$20
    ; LDA OAM_OS
    ; CMP #$0200
    ; BMI {+}
    ; PLP
    ; RTL
  ; {+} ; LSR A
    ; STA $00
    ; LSR A
    ; ADC $00
    ; STA $00
    ; CLC
    ; PER $000C
    ; PLA
    ; ADC $00
    ; STA $00
    ; SEP #$20
    ; LDA #$F0
    ; JMP ($0000)
    ; STA $0101
    ; STA $0105
    ; STA $0109
    ; STA $010D
    ; STA $0111
    ; STA $0115
    ; STA $0119
    ; STA $011D
    ; STA $0121
    ; STA $0125
    ; STA $0129
    ; STA $012D
    ; STA $0131
    ; STA $0135
    ; STA $0139
    ; STA $013D
    ; STA $0141
    ; STA $0145
    ; STA $0149
    ; STA $014D
    ; STA $0151
    ; STA $0155
    ; STA $0159
    ; STA $015D
    ; STA $0161
    ; STA $0165
    ; STA $0169
    ; STA $016D
    ; STA $0171
    ; STA $0175
    ; STA $0179
    ; STA $017D
    ; STA $0181
    ; STA $0185
    ; STA $0189
    ; STA $018D
    ; STA $0191
    ; STA $0195
    ; STA $0199
    ; STA $019D
    ; STA $01A1
    ; STA $01A5
    ; STA $01A9
    ; STA $01AD
    ; STA $01B1
    ; STA $01B5
    ; STA $01B9
    ; STA $01BD
    ; STA $01C1
    ; STA $01C5
    ; STA $01C9
    ; STA $01CD
    ; STA $01D1
    ; STA $01D5
    ; STA $01D9
    ; STA $01DD
    ; STA $01E1
    ; STA $01E5
    ; STA $01E9
    ; STA $01ED
    ; STA $01F1
    ; STA $01F5
    ; STA $01F9
    ; STA $01FD
    ; STA $0201
    ; STA $0205
    ; STA $0209
    ; STA $020D
    ; STA $0211
    ; STA $0215
    ; STA $0219
    ; STA $021D
    ; STA $0221
    ; STA $0225
    ; STA $0229
    ; STA $022D
    ; STA $0231
    ; STA $0235
    ; STA $0239
    ; STA $023D
    ; STA $0241
    ; STA $0245
    ; STA $0249
    ; STA $024D
    ; STA $0251
    ; STA $0255
    ; STA $0259
    ; STA $025D
    ; STA $0261
    ; STA $0265
    ; STA $0269
    ; STA $026D
    ; STA $0271
    ; STA $0275
    ; STA $0279
    ; STA $027D
    ; STA $0281
    ; STA $0285
    ; STA $0289
    ; STA $028D
    ; STA $0291
    ; STA $0295
    ; STA $0299
    ; STA $029D
    ; STA $02A1
    ; STA $02A5
    ; STA $02A9
    ; STA $02AD
    ; STA $02B1
    ; STA $02B5
    ; STA $02B9
    ; STA $02BD
    ; STA $02C1
    ; STA $02C5
    ; STA $02C9
    ; STA $02CD
    ; STA $02D1
    ; STA $02D5
    ; STA $02D9
    ; STA $02DD
    ; STA $02E1
    ; STA $02E5
    ; STA $02E9
    ; STA $02ED
    ; STA $02F1
    ; STA $02F5
    ; STA $02F9
    ; STA $02FD
    ; PLP
    ; RTL

    ; #Code l {Draw_Sprite}
    ; PHP
    ; REP #$10
    ; LDY OAM_OS
    ; CPY #$0200 // OAM Overflow
    ; BCC {+}
    ; PLP
    ; RTL
  ; {+} ; PHB
    ; SEP #$20
    ; LDA Draw_Sprite_Data_Bank
    ; PHA
    ; PLB
    ; LDX Draw_Sprite_Data_OS
    ; LDA $0000,X // OBJ Count
    ; BRA {+}
  ; {--} ; CPY #$0200 // OAM Overflow
    ; BCC {++}
    ; BRL {+Return}
  ; {++} ; INX
    ; INX
    ; INX
    ; INX
  ; {+} ; INX
    ; STA Draw_Sprite_OBJ_Count
    ; LDA $0000,X // OBJ X Position
    ; PHX
    ; CLC
    ; ADC Draw_Sprite_X
    ; STA OAM_WR_X,Y
    ; LDA $0004,X // OBJ OAM II
    ; AND #$03
    ; BCC {+}
    ; EOR #$01
  ; {+} ; STY OAM_OS
    ; SEP #$10
    ; LDY OAM_II_bit_OS
  ; {-} ; BEQ {+}
    ; ASL A
    ; ASL A
    ; DEY
    ; DEY
    ; BRA {-}
  ; {+} ; LDY OAM_II_byte_OS
    ; ORA OAM_II_WR,Y
    ; STA OAM_II_WR,Y
    ; LDY OAM_II_bit_OS
    ; INY
    ; INY
    ; CPY #$08
    ; BCC {+}
    ; LDY #$00
    ; INC OAM_II_byte_OS
  ; {+} ; STY OAM_II_bit_OS
    ; REP #$10
    ; LDY OAM_OS
    ; PLX
    ; LDA $0001,X // OBJ Y Position
    ; CLC
    ; ADC Draw_Sprite_Y
    ; STA OAM_WR_Y,Y
    ; REP #$20
    ; LDA $0002,X // OBJ Character/Settings
    ; AND #$01FF
    ; CLC
    ; ADC Draw_Sprite_Char_OS
    ; AND #$01FF
    ; SEP #$20
    ; STA OAM_WR_C,Y
    ; XBA
    ; EOR $0003,X
    ; PHA
    ; LDA Draw_Sprite_OBJ_P_Override
    ; BEQ {+}
    ; PLA
    ; AND #$C1
    ; EOR Draw_Sprite_OBJ_P_Override
    ; BRA {++}
  ; {+} ; PLA
  ; {++} ; STA OAM_WR_P,Y // Draw Sprite OBJ P
    ; INY
    ; INY
    ; INY
    ; INY
    ; LDA Draw_Sprite_OBJ_Count
    ; DEC A
    ; BMI {+Return}
    ; BRL {--}
  ; {+Return} ; STY OAM_OS
    ; PLB
    ; PLP
    ; RTL


    ; #Code l {Find_Angle}
    ; PHP
    ; REP #$30
    ;
    ; STX Find_Angle_X
    ; STY Find_Angle_Y
    ;
    ; STZ Find_Angle_X_Sign
    ; TXA
    ; BPL {+}
    ; LDA #$FFFF
    ; STA Find_Angle_X_Sign
    ; EOR Find_Angle_X
    ; INC A
  ; {+} ; STA Find_Angle_X
    ;
    ; STZ Find_Angle_Y_Sign
    ; LDA Find_Angle_Y
    ; BPL {+}
    ; LDA #$FFFF
    ; STA Find_Angle_Y_Sign
    ; EOR Find_Angle_Y
    ; INC A
  ; {+} ; STA Find_Angle_Y
    ;
  ; {-} ; CMP #$0008
    ; BCC {+}
    ; LSR Find_Angle_X
    ; LSR A
    ; BRA {-}
  ; {+} ; STA Find_Angle_Y
    ;
    ; LDA Find_Angle_X
  ; {-} ; CMP #$0008
    ; BCC {+}
    ; LSR Find_Angle_Y
    ; LSR A
    ; BRA {-}
  ; {+} ; STA Find_Angle_X
    ;
    ; LDA Find_Angle_Y
    ; ASL A
    ; ASL A
    ; ASL A
    ; ADC Find_Angle_X
    ; TAX
    ; LDA #$0000
    ; SEP #$20
    ; LDA Angle_Array,X
    ; REP #$20
    ;
    ; LDX Find_Angle_X_Sign
    ; BPL {+}
    ; LDX Find_Angle_Y_Sign
    ; BPL {++}
    ; CLC
    ; ADC #$0010
    ; BRA {+Return}
  ; {++} ; EOR #$FFFF
    ; INC A
    ; CLC
    ; ADC #$0010
    ; BRA {+Return}
  ;{+}  ; LDX Find_Angle_Y_Sign
    ; BPL {+Return}
    ; EOR #$FFFF
    ; INC A
    ; CLC
    ; ADC #$0020
    ; AND #$001F
    ;
  ; {+Return} ; PLP
    ; RTL

    ; #Code l {Random_Number_Generator}
    ; PHP
    ; REP #$20
    ; LDA Random_Number
    ; SEP #$20
    ; STA M7A_R
    ; XBA
    ; STA M7A_R
    ; LDA #$D3
    ; STA M7B_R
    ; REP #$20
    ; LDA .MPY_R
    ; INC A
    ; XBA
    ; STA Random_Number
    ; PLP
    ; RTL

    ; #Data w Angle_Array
    { $FF $00 $00 $00 $00 $00 $00 $00
     $08 $04 $02 $02 $01 $01 $01 $01
     $08 $06 $04 $03 $02 $02 $02 $01
     $08 $06 $05 $04 $03 $03 $02 $02
     $08 $07 $06 $05 $04 $03 $03 $03
     $08 $07 $06 $05 $05 $04 $04 $03
     $08 $07 $06 $06 $05 $04 $04 $04
     $08 $07 $07 $06 $05 $05 $04 $04
    }




    ; #Data l Char_Data    {#char.dat}
    ; #Data l Frame_BG_Map {#frame_bg_map.dat}
    ; #Data l Star_BG_Map  {#star_bg_map.dat}
    ; #Data l Color_Data   {#color.dat}



    ; #Data $00:FFB0 ROM_Header
     {$52 $3A $50 $68 $6F $65 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
      $52 $3A $50 $68 $6F $65 $6E $69 $78 $20 $20 $20 $20 $20 $20 $20
      $20 $20 $20 $20 $20 $30 $00 $09 $00 $01 $33 $00 $00 $00 $00 $00 }

    ; #Data $00:FFE0 Vector_Table
     {$0000 $0000 $8000 $8000 $8000 $8007 $0000 $8000
      $0000 $0000 $8000 $0000 $8000 $8000 $8000 $8000}
