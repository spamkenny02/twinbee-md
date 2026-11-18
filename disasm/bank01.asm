; Detana!! TwinBee (PCE) - banque $01, vue en $C000-$DFFF
; 5006 octets de code (2755 exécutés en émulation)
; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique

L01_C000:
  C000  A9 12                 LDA   #$12                         ;[x]
  C002  20 52 E3              JSR   L00_E352                     ;[x]
  C005  20 90 E7              JSR   L00_E790                     ;[x]
  C008  23 00                 ST2   #$00                         ;[x]
  C00A  20 8D E7              JSR   L00_E78D                     ;[x]
  C00D  13 00                 ST1   #$00                         ;[x]
  C00F  23 10                 ST2   #$10                         ;[x]
  C011  20 85 E7              JSR   L00_E785                     ;[x]
  C014  A9 3C                 LDA   #$3C                         ;[x]
  C016  85 17                 STA   <$17                         ;[x]
  C018  A9 6D                 LDA   #$6D                         ;[x]
  C01A  85 15                 STA   <$15                         ;[x]
  C01C  E6 28                 INC   <$28                         ;[x]
  C01E  A5 28                 LDA   <$28                         ;[x]
  C020  29 03                 AND   #$03                         ;[x]
  C022  0A                    ASL   A                            ;[x]
  C023  A8                    TAY                                ;[x]
  C024  B9 6A C1              LDA   $C16A,Y                      ;[x]
  C027  85 12                 STA   <$12                         ;[x]
  C029  B9 6B C1              LDA   $C16B,Y                      ;[x]
  C02C  85 13                 STA   <$13                         ;[x]
  C02E  C2                    CLY                                ;[x]
L01_C02F:
  C02F  B1 12                 LDA   (<$12),Y                     ;[x]
  C031  AA                    TAX                                ;[x]
  C032  C8                    INY                                ;[x]
  C033  84 B3                 STY   <$B3                         ;[x]
  C035  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  C038  F0 08                 BEQ   L01_C042                     ;[x]
  C03A  86 B2                 STX   <$B2                         ;[x]
  C03C  44 27                 BSR   L01_C065                     ;[x]
  C03E  30 22                 BMI   L01_C062                     ;[x]
  C040  A6 B2                 LDX   <$B2                         ;[x]
L01_C042:
  C042  A4 B3                 LDY   <$B3                         ;[x]
  C044  E8                    INX                                ;[x]
  C045  C6 15                 DEC   <$15                         ;[x]
  C047  D0 E6                 BNE   L01_C02F                     ;[x]
  C049  A5 17                 LDA   <$17                         ;[x]
  C04B  18                    CLC                                ;[x]
  C04C  69 03                 ADC   #$03                         ;[x]
  C04E  AA                    TAX                                ;[x]
L01_C04F:
  C04F  13 00                 ST1   #$00                         ;[x]
  C051  23 00                 ST2   #$00                         ;[x]
  C053  13 00                 ST1   #$00                         ;[x]
  C055  23 00                 ST2   #$00                         ;[x]
  C057  13 00                 ST1   #$00                         ;[x]
  C059  23 00                 ST2   #$00                         ;[x]
  C05B  13 00                 ST1   #$00                         ;[x]
  C05D  23 00                 ST2   #$00                         ;[x]
  C05F  CA                    DEX                                ;[x]
  C060  10 ED                 BPL   L01_C04F                     ;[x]
L01_C062:
  C062  4C 65 E3              JMP   L00_E365                     ;[x]

L01_C065:
  C065  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  C068  18                    CLC                                ;[x]
  C069  69 40                 ADC   #$40                         ;[x]
  C06B  85 08                 STA   <$08                         ;[x]
  C06D  BD 21 2C              LDA   $2C21,X                      ;[x]
  C070  69 00                 ADC   #$00                         ;[x]
  C072  85 09                 STA   <$09                         ;[x]
  C074  BD 47 2B              LDA   $2B47,X                      ;[x]
  C077  18                    CLC                                ;[x]
  C078  69 20                 ADC   #$20                         ;[x]
  C07A  85 0A                 STA   <$0A                         ;[x]
  C07C  BD DA 2A              LDA   $2ADA,X                      ;[x]
  C07F  69 00                 ADC   #$00                         ;[x]
  C081  85 0B                 STA   <$0B                         ;[x]
  C083  BD 42 2E              LDA   $2E42,X                      ;[x]
  C086  85 0E                 STA   <$0E                         ;[x]
  C088  29 0F                 AND   #$0F                         ;[x]
  C08A  85 0F                 STA   <$0F                         ;[x]
  C08C  BD 00 2A              LDA   $2A00,X                      ;[x]
  C08F  0A                    ASL   A                            ;[x]
  C090  A8                    TAY                                ;[x]
  C091  B9 4C C1              LDA   $C14C,Y                      ;[x]
  C094  85 00                 STA   <$00                         ;[x]
  C096  B9 4D C1              LDA   $C14D,Y                      ;[x]
  C099  85 01                 STA   <$01                         ;[x]
  C09B  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  C09E  0A                    ASL   A                            ;[x]
  C09F  A8                    TAY                                ;[x]
  C0A0  B1 00                 LDA   (<$00),Y                     ;[x]
  C0A2  85 10                 STA   <$10                         ;[x]
  C0A4  C8                    INY                                ;[x]
  C0A5  B1 00                 LDA   (<$00),Y                     ;[x]
  C0A7  85 11                 STA   <$11                         ;[x]
  C0A9  B2 10                 LDA   (<$10)                       ;[x]
  C0AB  85 16                 STA   <$16                         ;[x]
  C0AD  E6 10                 INC   <$10                         ;[x]
  C0AF  D0 02                 BNE   L01_C0B3                     ;[x]
  C0B1  E6 11                 INC   <$11                         ;[x]
L01_C0B3:
  C0B3  C2                    CLY                                ;[x]
  C0B4  B1 10                 LDA   (<$10),Y                     ;[x]
  C0B6  85 00                 STA   <$00                         ;[x]
  C0B8  C8                    INY                                ;[x]
  C0B9  64 06                 STZ   <$06                         ;[x]
  C0BB  B1 10                 LDA   (<$10),Y                     ;[x]
  C0BD  10 02                 BPL   L01_C0C1                     ;[x]
  C0BF  C6 06                 DEC   <$06                         ;[x]
L01_C0C1:
  C0C1  18                    CLC                                ;[x]
  C0C2  65 08                 ADC   <$08                         ;[x]
  C0C4  85 07                 STA   <$07                         ;[x]
  C0C6  A5 06                 LDA   <$06                         ;[x]
  C0C8  65 09                 ADC   <$09                         ;[x]
  C0CA  85 06                 STA   <$06                         ;[x]
  C0CC  F0 08                 BEQ   L01_C0D6                     ;[x]
  C0CE  30 69                 BMI   L01_C139                     ;[x]
  C0D0  A5 07                 LDA   <$07                         ;[x]
  C0D2  C9 30                 CMP   #$30                         ;[x]
  C0D4  B0 63                 BCS   L01_C139                     ;[x]
L01_C0D6:
  C0D6  C8                    INY                                ;[x]
  C0D7  64 04                 STZ   <$04                         ;[x]
  C0D9  B1 10                 LDA   (<$10),Y                     ;[x]
  C0DB  10 02                 BPL   L01_C0DF                     ;[x]
  C0DD  C6 04                 DEC   <$04                         ;[x]
L01_C0DF:
  C0DF  18                    CLC                                ;[x]
  C0E0  65 0A                 ADC   <$0A                         ;[x]
  C0E2  85 05                 STA   <$05                         ;[x]
  C0E4  A5 04                 LDA   <$04                         ;[x]
  C0E6  65 0B                 ADC   <$0B                         ;[x]
  C0E8  85 04                 STA   <$04                         ;[x]
  C0EA  F0 08                 BEQ   L01_C0F4                     ;[x]
  C0EC  30 4B                 BMI   L01_C139                     ;[x]
  C0EE  A5 05                 LDA   <$05                         ;[x]
  C0F0  C9 20                 CMP   #$20                         ;[x]
  C0F2  B0 45                 BCS   L01_C139                     ;[x]
L01_C0F4:
  C0F4  C8                    INY                                ;[x]
  C0F5  B1 10                 LDA   (<$10),Y                     ;[x]
  C0F7  85 03                 STA   <$03                         ;[x]
  C0F9  C8                    INY                                ;[x]
  C0FA  B1 10                 LDA   (<$10),Y                     ;[x]
  C0FC  29 70                 AND   #$70                         ;[x]
  C0FE  4A                    LSR   A                            ;[x]
  C0FF  4A                    LSR   A                            ;[x]
  C100  4A                    LSR   A                            ;[x]
  C101  4A                    LSR   A                            ;[x]
  C102  85 02                 STA   <$02                         ;[x]
  C104  A5 0E                 LDA   <$0E                         ;[x]
  C106  0A                    ASL   A                            ;[x]
  C107  B0 0B                 BCS   L01_C114                     ;[x]
  C109  10 11                 BPL   L01_C11C                     ;[x]
  C10B  B1 10                 LDA   (<$10),Y                     ;[x]
  C10D  18                    CLC                                ;[x]
  C10E  65 0F                 ADC   <$0F                         ;[x]
  C110  29 8F                 AND   #$8F                         ;[x]
  C112  80 0C                 BRA   L01_C120                     ;[x]

L01_C114:
  C114  B1 10                 LDA   (<$10),Y                     ;[x]
  C116  29 80                 AND   #$80                         ;[x]
  C118  05 0F                 ORA   <$0F                         ;[x]
  C11A  80 04                 BRA   L01_C120                     ;[x]

L01_C11C:
  C11C  B1 10                 LDA   (<$10),Y                     ;[x]
  C11E  29 8F                 AND   #$8F                         ;[x]
L01_C120:
  C120  85 01                 STA   <$01                         ;[x]
  C122  C8                    INY                                ;[x]
  C123  A0 07                 LDY   #$07                         ;[x]
L01_C125:
  C125  B9 00 20              LDA   $2000,Y                      ;[x]
  C128  8D 02 00              STA   VDC_DATA_L                   ;[x]
  C12B  88                    DEY                                ;[x]
  C12C  B9 00 20              LDA   $2000,Y                      ;[x]
  C12F  8D 03 00              STA   VDC_DATA_H                   ;[x]
  C132  88                    DEY                                ;[x]
  C133  10 F0                 BPL   L01_C125                     ;[x]
  C135  C6 17                 DEC   <$17                         ;[x]
  C137  30 12                 BMI   L01_C14B                     ;[x]
L01_C139:
  C139  A9 05                 LDA   #$05                         ;[x]
  C13B  18                    CLC                                ;[x]
  C13C  65 10                 ADC   <$10                         ;[x]
  C13E  85 10                 STA   <$10                         ;[x]
  C140  90 02                 BCC   L01_C144                     ;[x]
  C142  E6 11                 INC   <$11                         ;[x]
L01_C144:
  C144  C6 16                 DEC   <$16                         ;[x]
  C146  F0 03                 BEQ   L01_C14B                     ;[x]
  C148  4C B3 C0              JMP   L01_C0B3                     ;[x]

L01_C14B:
  C14B  60                    RTS                                ;[x]

  C14C  .db $92,$57,$05,$5E,$92,$60,$96,$5C,$28,$66,$C8,$67,$A0,$6B,$88,$6C
  C15C  .db $AD,$70,$93,$71,$00,$40,$0C,$73,$D6,$74,$4E,$77,$FA,$40,$72,$C1
  C16C  .db $E0,$C1,$4D,$C2,$BA,$C2,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09
  C17C  .db $0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$13,$14,$15,$16,$17,$18
  C18C  .db $19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27,$28
  C19C  .db $29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38
  C1AC  .db $39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48
  C1BC  .db $49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58
  C1CC  .db $59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61,$62,$63,$64,$65,$66,$67,$68
  C1DC  .db $69,$6A,$6B,$6C,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B
  C1EC  .db $0C,$0D,$0E,$0F,$10,$11,$12,$13,$26,$27,$28,$29,$2A,$2B,$2C,$2D
  C1FC  .db $2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D
  C20C  .db $3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D
  C21C  .db $4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D
  C22C  .db $5E,$5F,$14,$15,$16,$17,$60,$18,$61,$19,$62,$1A,$63,$1B,$64,$1C
  C23C  .db $65,$1D,$66,$1E,$67,$1F,$68,$20,$69,$21,$6A,$22,$6B,$23,$6C,$24
  C24C  .db $25,$00,$01,$02,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31
  C25C  .db $32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41
  C26C  .db $42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51
  C27C  .db $52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$61
  C28C  .db $62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$03,$04,$05,$06,$07
  C29C  .db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17
  C2AC  .db $18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$00,$01
  C2BC  .db $02,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34
  C2CC  .db $35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44
  C2DC  .db $45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$03
  C2EC  .db $04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13
  C2FC  .db $54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$14,$15,$16,$17
  C30C  .db $60,$18,$61,$19,$62,$1A,$63,$1B,$64,$1C,$65,$1D,$66,$1E,$67,$1F
  C31C  .db $68,$20,$69,$21,$6A,$22,$6B,$23,$6C,$24,$25
L01_C327:
  C327  A5 84                 LDA   <$84                         ;[x]
  C329  F0 19                 BEQ   L01_C344                     ;[x]
  C32B  A5 3B                 LDA   <$3B                         ;[ ]
  C32D  D0 15                 BNE   L01_C344                     ;[ ]
  C32F  AD 89 2F              LDA   $2F89                        ;[ ]
  C332  C9 06                 CMP   #$06                         ;[ ]
  C334  90 07                 BCC   L01_C33D                     ;[ ]
  C336  AD 8A 2F              LDA   $2F8A                        ;[ ]
  C339  C9 06                 CMP   #$06                         ;[ ]
  C33B  B0 07                 BCS   L01_C344                     ;[ ]
L01_C33D:
  C33D  20 99 E7              JSR   L00_E799                     ;[ ]
  C340  A5 85                 LDA   <$85                         ;[ ]
  C342  F0 01                 BEQ   L01_C345                     ;[ ]
L01_C344:
  C344  60                    RTS                                ;[x]

L01_C345:
  C345  AD A6 3D              LDA   $3DA6                        ;[ ]
  C348  F0 05                 BEQ   L01_C34F                     ;[ ]
  C34A  CE A6 3D              DEC   $3DA6                        ;[ ]
  C34D  80 39                 BRA   L01_C388                     ;[ ]

L01_C34F:
  C34F  A9 06                 LDA   #$06                         ;[ ]
  C351  8D A6 3D              STA   $3DA6                        ;[ ]
  C354  AD AE 3D              LDA   $3DAE                        ;[ ]
  C357  1A                    INC   A                            ;[ ]
  C358  C9 10                 CMP   #$10                         ;[ ]
  C35A  90 01                 BCC   L01_C35D                     ;[ ]
  C35C  62                    CLA                                ;[ ]
L01_C35D:
  C35D  8D AE 3D              STA   $3DAE                        ;[ ]
  C360  0A                    ASL   A                            ;[ ]
  C361  A8                    TAY                                ;[ ]
  C362  20 8D E7              JSR   L00_E78D                     ;[ ]
  C365  13 60                 ST1   #$60                         ;[ ]
  C367  23 3F                 ST2   #$3F                         ;[ ]
  C369  20 19 C4              JSR   L01_C419                     ;[ ]
  C36C  20 2B C4              JSR   L01_C42B                     ;[ ]
  C36F  20 3D C4              JSR   L01_C43D                     ;[ ]
  C372  20 4F C4              JSR   L01_C44F                     ;[ ]
  C375  20 8D E7              JSR   L00_E78D                     ;[ ]
  C378  13 A0                 ST1   #$A0                         ;[ ]
  C37A  23 3F                 ST2   #$3F                         ;[ ]
  C37C  20 61 C4              JSR   L01_C461                     ;[ ]
  C37F  20 73 C4              JSR   L01_C473                     ;[ ]
  C382  20 85 C4              JSR   L01_C485                     ;[ ]
  C385  20 97 C4              JSR   L01_C497                     ;[ ]
L01_C388:
  C388  AD A7 3D              LDA   $3DA7                        ;[ ]
  C38B  F0 05                 BEQ   L01_C392                     ;[ ]
  C38D  CE A7 3D              DEC   $3DA7                        ;[ ]
  C390  80 39                 BRA   L01_C3CB                     ;[ ]

L01_C392:
  C392  A9 04                 LDA   #$04                         ;[ ]
  C394  8D A7 3D              STA   $3DA7                        ;[ ]
  C397  AD AF 3D              LDA   $3DAF                        ;[ ]
  C39A  1A                    INC   A                            ;[ ]
  C39B  C9 10                 CMP   #$10                         ;[ ]
  C39D  90 01                 BCC   L01_C3A0                     ;[ ]
  C39F  62                    CLA                                ;[ ]
L01_C3A0:
  C3A0  8D AF 3D              STA   $3DAF                        ;[ ]
  C3A3  0A                    ASL   A                            ;[ ]
  C3A4  A8                    TAY                                ;[ ]
  C3A5  20 8D E7              JSR   L00_E78D                     ;[ ]
  C3A8  13 E0                 ST1   #$E0                         ;[ ]
  C3AA  23 3F                 ST2   #$3F                         ;[ ]
  C3AC  20 19 C4              JSR   L01_C419                     ;[ ]
  C3AF  20 2B C4              JSR   L01_C42B                     ;[ ]
  C3B2  20 3D C4              JSR   L01_C43D                     ;[ ]
  C3B5  20 4F C4              JSR   L01_C44F                     ;[ ]
  C3B8  20 8D E7              JSR   L00_E78D                     ;[ ]
  C3BB  13 20                 ST1   #$20                         ;[ ]
  C3BD  23 40                 ST2   #$40                         ;[ ]
  C3BF  20 61 C4              JSR   L01_C461                     ;[ ]
  C3C2  20 73 C4              JSR   L01_C473                     ;[ ]
  C3C5  20 85 C4              JSR   L01_C485                     ;[ ]
  C3C8  20 97 C4              JSR   L01_C497                     ;[ ]
L01_C3CB:
  C3CB  AD A8 3D              LDA   $3DA8                        ;[ ]
  C3CE  F0 04                 BEQ   L01_C3D4                     ;[ ]
  C3D0  CE A8 3D              DEC   $3DA8                        ;[ ]
  C3D3  60                    RTS                                ;[ ]

L01_C3D4:
  C3D4  A9 03                 LDA   #$03                         ;[ ]
  C3D6  8D A8 3D              STA   $3DA8                        ;[ ]
  C3D9  AD B0 3D              LDA   $3DB0                        ;[ ]
  C3DC  1A                    INC   A                            ;[ ]
  C3DD  C9 08                 CMP   #$08                         ;[ ]
  C3DF  90 01                 BCC   L01_C3E2                     ;[ ]
  C3E1  62                    CLA                                ;[ ]
L01_C3E2:
  C3E2  8D B0 3D              STA   $3DB0                        ;[ ]
  C3E5  0A                    ASL   A                            ;[ ]
  C3E6  A8                    TAY                                ;[ ]
  C3E7  20 8D E7              JSR   L00_E78D                     ;[ ]
  C3EA  13 60                 ST1   #$60                         ;[ ]
  C3EC  23 40                 ST2   #$40                         ;[ ]
  C3EE  20 89 E7              JSR   L00_E789                     ;[ ]
  C3F1  B9 BE C5              LDA   $C5BE,Y                      ;[ ]
  C3F4  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C3F7  B9 BF C5              LDA   $C5BF,Y                      ;[ ]
  C3FA  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C3FD  20 A9 C4              JSR   L01_C4A9                     ;[ ]
  C400  20 8D E7              JSR   L00_E78D                     ;[ ]
  C403  13 70                 ST1   #$70                         ;[ ]
  C405  23 40                 ST2   #$40                         ;[ ]
  C407  20 89 E7              JSR   L00_E789                     ;[ ]
  C40A  B9 CE C5              LDA   $C5CE,Y                      ;[ ]
  C40D  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C410  B9 CF C5              LDA   $C5CF,Y                      ;[ ]
  C413  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C416  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C419:
  C419  20 89 E7              JSR   L00_E789                     ;[ ]
  C41C  B9 BE C4              LDA   $C4BE,Y                      ;[ ]
  C41F  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C422  B9 BF C4              LDA   $C4BF,Y                      ;[ ]
  C425  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C428  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C42B:
  C42B  20 89 E7              JSR   L00_E789                     ;[ ]
  C42E  B9 DE C4              LDA   $C4DE,Y                      ;[ ]
  C431  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C434  B9 DF C4              LDA   $C4DF,Y                      ;[ ]
  C437  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C43A  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C43D:
  C43D  20 89 E7              JSR   L00_E789                     ;[ ]
  C440  B9 FE C4              LDA   $C4FE,Y                      ;[ ]
  C443  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C446  B9 FF C4              LDA   $C4FF,Y                      ;[ ]
  C449  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C44C  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C44F:
  C44F  20 89 E7              JSR   L00_E789                     ;[ ]
  C452  B9 1E C5              LDA   $C51E,Y                      ;[ ]
  C455  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C458  B9 1F C5              LDA   $C51F,Y                      ;[ ]
  C45B  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C45E  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C461:
  C461  20 89 E7              JSR   L00_E789                     ;[ ]
  C464  B9 3E C5              LDA   $C53E,Y                      ;[ ]
  C467  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C46A  B9 3F C5              LDA   $C53F,Y                      ;[ ]
  C46D  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C470  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C473:
  C473  20 89 E7              JSR   L00_E789                     ;[ ]
  C476  B9 5E C5              LDA   $C55E,Y                      ;[ ]
  C479  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C47C  B9 5F C5              LDA   $C55F,Y                      ;[ ]
  C47F  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C482  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C485:
  C485  20 89 E7              JSR   L00_E789                     ;[ ]
  C488  B9 7E C5              LDA   $C57E,Y                      ;[ ]
  C48B  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C48E  B9 7F C5              LDA   $C57F,Y                      ;[ ]
  C491  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C494  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C497:
  C497  20 89 E7              JSR   L00_E789                     ;[ ]
  C49A  B9 9E C5              LDA   $C59E,Y                      ;[ ]
  C49D  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C4A0  B9 9F C5              LDA   $C59F,Y                      ;[ ]
  C4A3  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C4A6  4C A9 C4              JMP   L01_C4A9                     ;[ ]

L01_C4A9:
  C4A9  20 85 E7              JSR   L00_E785                     ;[ ]
  C4AC  A2 10                 LDX   #$10                         ;[ ]
L01_C4AE:
  C4AE  AD 02 00              LDA   VDC_DATA_L                   ;[ ]
  C4B1  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  C4B4  AD 03 00              LDA   VDC_DATA_H                   ;[ ]
  C4B7  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  C4BA  CA                    DEX                                ;[ ]
  C4BB  D0 F1                 BNE   L01_C4AE                     ;[ ]
  C4BD  60                    RTS                                ;[ ]

  C4BE  .db $D0,$2B,$90,$2B,$50,$2B,$10,$2B,$D0,$2A,$90,$2A,$50,$2A,$10,$2A
  C4CE  .db $B0,$2B,$70,$2B,$30,$2B,$F0,$2A,$B0,$2A,$70,$2A,$30,$2A,$F0,$29
  C4DE  .db $C0,$2B,$80,$2B,$40,$2B,$00,$2B,$C0,$2A,$80,$2A,$40,$2A,$00,$2A
  C4EE  .db $A0,$2B,$60,$2B,$20,$2B,$E0,$2A,$A0,$2A,$60,$2A,$20,$2A,$E0,$29
  C4FE  .db $B0,$2B,$70,$2B,$30,$2B,$F0,$2A,$B0,$2A,$70,$2A,$30,$2A,$F0,$29
  C50E  .db $D0,$2B,$90,$2B,$50,$2B,$10,$2B,$D0,$2A,$90,$2A,$50,$2A,$10,$2A
  C51E  .db $A0,$2B,$60,$2B,$20,$2B,$E0,$2A,$A0,$2A,$60,$2A,$20,$2A,$E0,$29
  C52E  .db $C0,$2B,$80,$2B,$40,$2B,$00,$2B,$C0,$2A,$80,$2A,$40,$2A,$00,$2A
  C53E  .db $50,$1A,$10,$1A,$D0,$19,$90,$19,$50,$19,$10,$19,$D0,$18,$90,$18
  C54E  .db $30,$1A,$F0,$19,$B0,$19,$70,$19,$30,$19,$F0,$18,$B0,$18,$70,$18
  C55E  .db $60,$1A,$20,$1A,$E0,$19,$A0,$19,$60,$19,$20,$19,$E0,$18,$A0,$18
  C56E  .db $40,$1A,$00,$1A,$C0,$19,$80,$19,$40,$19,$00,$19,$C0,$18,$80,$18
  C57E  .db $30,$1A,$F0,$19,$B0,$19,$70,$19,$30,$19,$F0,$18,$B0,$18,$70,$18
  C58E  .db $50,$1A,$10,$1A,$D0,$19,$90,$19,$50,$19,$10,$19,$D0,$18,$90,$18
  C59E  .db $40,$1A,$00,$1A,$C0,$19,$80,$19,$40,$19,$00,$19,$C0,$18,$80,$18
  C5AE  .db $60,$1A,$20,$1A,$E0,$19,$A0,$19,$60,$19,$20,$19,$E0,$18,$A0,$18
  C5BE  .db $50,$2C,$40,$2C,$30,$2C,$20,$2C,$10,$2C,$00,$2C,$F0,$2B,$E0,$2B
  C5CE  .db $E0,$1A,$D0,$1A,$C0,$1A,$B0,$1A,$A0,$1A,$90,$1A,$80,$1A,$70,$1A
L01_C5DE:
  C5DE  64 B8                 STZ   <$B8                         ;[x]
  C5E0  64 09                 STZ   <$09                         ;[x]
  C5E2  64 08                 STZ   <$08                         ;[x]
  C5E4  A5 86                 LDA   <$86                         ;[x]
  C5E6  D0 02                 BNE   L01_C5EA                     ;[x]
  C5E8  80 08                 BRA   L01_C5F2                     ;[x]

L01_C5EA:
  C5EA  0F 86 05              BBR0  <$86,L01_C5F2                ;[x]
  C5ED  1F 86 02              BBR1  <$86,L01_C5F2                ;[x]
  C5F0  44 01                 BSR   L01_C5F3                     ;[ ]
L01_C5F2:
  C5F2  60                    RTS                                ;[x]

L01_C5F3:
  C5F3  AD 8E 2C              LDA   $2C8E                        ;[ ]
  C5F6  38                    SEC                                ;[ ]
  C5F7  ED 8F 2C              SBC   $2C8F                        ;[ ]
  C5FA  B0 03                 BCS   L01_C5FF                     ;[ ]
  C5FC  49 FF                 EOR   #$FF                         ;[ ]
  C5FE  1A                    INC   A                            ;[ ]
L01_C5FF:
  C5FF  A8                    TAY                                ;[ ]
  C600  C0 10                 CPY   #$10                         ;[ ]
  C602  B0 0C                 BCS   L01_C610                     ;[ ]
  C604  C0 06                 CPY   #$06                         ;[ ]
  C606  90 02                 BCC   L01_C60A                     ;[ ]
  C608  E6 09                 INC   <$09                         ;[ ]
L01_C60A:
  C60A  C0 0C                 CPY   #$0C                         ;[ ]
  C60C  B0 02                 BCS   L01_C610                     ;[ ]
  C60E  E6 08                 INC   <$08                         ;[ ]
L01_C610:
  C610  AD 47 2B              LDA   $2B47                        ;[ ]
  C613  38                    SEC                                ;[ ]
  C614  ED 48 2B              SBC   $2B48                        ;[ ]
  C617  B0 03                 BCS   L01_C61C                     ;[ ]
  C619  49 FF                 EOR   #$FF                         ;[ ]
  C61B  1A                    INC   A                            ;[ ]
L01_C61C:
  C61C  A8                    TAY                                ;[ ]
  C61D  C0 24                 CPY   #$24                         ;[ ]
  C61F  B0 24                 BCS   L01_C645                     ;[ ]
  C621  E6 08                 INC   <$08                         ;[ ]
  C623  C0 08                 CPY   #$08                         ;[ ]
  C625  B0 02                 BCS   L01_C629                     ;[ ]
  C627  E6 09                 INC   <$09                         ;[ ]
L01_C629:
  C629  A5 08                 LDA   <$08                         ;[ ]
  C62B  C9 02                 CMP   #$02                         ;[ ]
  C62D  90 06                 BCC   L01_C635                     ;[ ]
  C62F  A5 B8                 LDA   <$B8                         ;[ ]
  C631  09 80                 ORA   #$80                         ;[ ]
  C633  85 B8                 STA   <$B8                         ;[ ]
L01_C635:
  C635  A5 09                 LDA   <$09                         ;[ ]
  C637  C9 02                 CMP   #$02                         ;[ ]
  C639  90 0A                 BCC   L01_C645                     ;[ ]
  C63B  A5 72                 LDA   <$72                         ;[ ]
  C63D  05 73                 ORA   <$73                         ;[ ]
  C63F  29 50                 AND   #$50                         ;[ ]
  C641  F0 02                 BEQ   L01_C645                     ;[ ]
  C643  44 01                 BSR   L01_C646                     ;[ ]
L01_C645:
  C645  60                    RTS                                ;[ ]

L01_C646:
  C646  A2 04                 LDX   #$04                         ;[ ]
  C648  62                    CLA                                ;[ ]
L01_C649:
  C649  1D 29 2F              ORA   $2F29,X                      ;[ ]
  C64C  CA                    DEX                                ;[ ]
  C64D  10 FA                 BPL   L01_C649                     ;[ ]
  C64F  29 FF                 AND   #$FF                         ;[ ]
  C651  F0 01                 BEQ   L01_C654                     ;[ ]
  C653  60                    RTS                                ;[ ]

L01_C654:
  C654  64 02                 STZ   <$02                         ;[ ]
  C656  AD FB 2C              LDA   $2CFB                        ;[ ]
  C659  18                    CLC                                ;[ ]
  C65A  6D FC 2C              ADC   $2CFC                        ;[ ]
  C65D  AD 8E 2C              LDA   $2C8E                        ;[ ]
  C660  6D 8F 2C              ADC   $2C8F                        ;[ ]
  C663  85 00                 STA   <$00                         ;[ ]
  C665  90 02                 BCC   L01_C669                     ;[ ]
  C667  E6 02                 INC   <$02                         ;[ ]
L01_C669:
  C669  A5 00                 LDA   <$00                         ;[ ]
  C66B  46 02                 LSR   <$02                         ;[ ]
  C66D  6A                    ROR   A                            ;[ ]
  C66E  85 10                 STA   <$10                         ;[ ]
  C670  64 02                 STZ   <$02                         ;[ ]
  C672  AD B4 2B              LDA   $2BB4                        ;[ ]
  C675  18                    CLC                                ;[ ]
  C676  6D B5 2B              ADC   $2BB5                        ;[ ]
  C679  AD 47 2B              LDA   $2B47                        ;[ ]
  C67C  6D 48 2B              ADC   $2B48                        ;[ ]
  C67F  85 00                 STA   <$00                         ;[ ]
  C681  90 02                 BCC   L01_C685                     ;[ ]
  C683  E6 02                 INC   <$02                         ;[ ]
L01_C685:
  C685  A5 00                 LDA   <$00                         ;[ ]
  C687  46 02                 LSR   <$02                         ;[ ]
  C689  6A                    ROR   A                            ;[ ]
  C68A  85 11                 STA   <$11                         ;[ ]
  C68C  A5 C5                 LDA   <$C5                         ;[ ]
  C68E  1A                    INC   A                            ;[ ]
  C68F  D0 01                 BNE   L01_C692                     ;[ ]
  C691  1A                    INC   A                            ;[ ]
L01_C692:
  C692  85 C5                 STA   <$C5                         ;[ ]
  C694  A2 04                 LDX   #$04                         ;[ ]
  C696  A0 1B                 LDY   #$1B                         ;[ ]
L01_C698:
  C698  A9 02                 LDA   #$02                         ;[ ]
  C69A  9D 29 2F              STA   $2F29,X                      ;[ ]
  C69D  9E 0D 2A              STZ   $2A0D,X                      ;[ ]
  C6A0  98                    TYA                                ;[ ]
  C6A1  9D 7A 2A              STA   $2A7A,X                      ;[ ]
  C6A4  88                    DEY                                ;[ ]
  C6A5  A5 10                 LDA   <$10                         ;[ ]
  C6A7  9D 9B 2C              STA   $2C9B,X                      ;[ ]
  C6AA  A5 11                 LDA   <$11                         ;[ ]
  C6AC  9D 54 2B              STA   $2B54,X                      ;[ ]
  C6AF  9E C1 2B              STZ   $2BC1,X                      ;[ ]
  C6B2  9E C1 2B              STZ   $2BC1,X                      ;[ ]
  C6B5  BD E8 C6              LDA   $C6E8,X                      ;[ ]
  C6B8  9D DD 30              STA   $30DD,X                      ;[ ]
  C6BB  BD E3 C6              LDA   $C6E3,X                      ;[ ]
  C6BE  9D 70 30              STA   $3070,X                      ;[ ]
  C6C1  BD F2 C6              LDA   $C6F2,X                      ;[ ]
  C6C4  9D B7 31              STA   $31B7,X                      ;[ ]
  C6C7  BD ED C6              LDA   $C6ED,X                      ;[ ]
  C6CA  9D 4A 31              STA   $314A,X                      ;[ ]
  C6CD  A9 08                 LDA   #$08                         ;[ ]
  C6CF  9D 6B 33              STA   $336B,X                      ;[ ]
  C6D2  9D D8 33              STA   $33D8,X                      ;[ ]
  C6D5  A5 C5                 LDA   <$C5                         ;[ ]
  C6D7  9D 1D 35              STA   $351D,X                      ;[ ]
  C6DA  CA                    DEX                                ;[ ]
  C6DB  10 BB                 BPL   L01_C698                     ;[ ]
  C6DD  A9 02                 LDA   #$02                         ;[ ]
  C6DF  20 FC E3              JSR   L00_E3FC                     ;[ ]
  C6E2  60                    RTS                                ;[ ]

  C6E3  .db $FB,$FD,$00,$02,$05,$80,$40,$00,$C0,$80,$FC,$FA,$FA,$FA,$FC,$00
  C6F3  .db $A0,$00,$A0,$00
L01_C6F7:
  C6F7  A5 86                 LDA   <$86                         ;[x]
  C6F9  D0 02                 BNE   L01_C6FD                     ;[x]
  C6FB  80 16                 BRA   L01_C713                     ;[x]

L01_C6FD:
  C6FD  0F 86 13              BBR0  <$86,L01_C713                ;[x]
  C700  1F 86 10              BBR1  <$86,L01_C713                ;[x]
  C703  AD 89 2F              LDA   $2F89                        ;[ ]
  C706  C9 03                 CMP   #$03                         ;[ ]
  C708  B0 09                 BCS   L01_C713                     ;[ ]
  C70A  AD 8A 2F              LDA   $2F8A                        ;[ ]
  C70D  C9 03                 CMP   #$03                         ;[ ]
  C70F  B0 02                 BCS   L01_C713                     ;[ ]
  C711  44 01                 BSR   L01_C714                     ;[ ]
L01_C713:
  C713  60                    RTS                                ;[x]

L01_C714:
  C714  A5 B9                 LDA   <$B9                         ;[ ]
  C716  05 BA                 ORA   <$BA                         ;[ ]
  C718  85 0E                 STA   <$0E                         ;[ ]
  C71A  AD 8E 2C              LDA   $2C8E                        ;[ ]
  C71D  85 11                 STA   <$11                         ;[ ]
  C71F  AD 47 2B              LDA   $2B47                        ;[ ]
  C722  85 10                 STA   <$10                         ;[ ]
  C724  AD 8F 2C              LDA   $2C8F                        ;[ ]
  C727  85 13                 STA   <$13                         ;[ ]
  C729  AD 48 2B              LDA   $2B48                        ;[ ]
  C72C  85 12                 STA   <$12                         ;[ ]
L01_C72E:
  C72E  64 08                 STZ   <$08                         ;[ ]
  C730  64 09                 STZ   <$09                         ;[ ]
  C732  A5 11                 LDA   <$11                         ;[ ]
  C734  38                    SEC                                ;[ ]
  C735  E5 13                 SBC   <$13                         ;[ ]
  C737  F0 0F                 BEQ   L01_C748                     ;[ ]
  C739  B0 07                 BCS   L01_C742                     ;[ ]
  C73B  C6 08                 DEC   <$08                         ;[ ]
  C73D  49 FF                 EOR   #$FF                         ;[ ]
  C73F  1A                    INC   A                            ;[ ]
  C740  80 02                 BRA   L01_C744                     ;[ ]

L01_C742:
  C742  E6 08                 INC   <$08                         ;[ ]
L01_C744:
  C744  C9 10                 CMP   #$10                         ;[ ]
  C746  B0 16                 BCS   L01_C75E                     ;[ ]
L01_C748:
  C748  A5 10                 LDA   <$10                         ;[ ]
  C74A  38                    SEC                                ;[ ]
  C74B  E5 12                 SBC   <$12                         ;[ ]
  C74D  F0 24                 BEQ   L01_C773                     ;[ ]
  C74F  B0 07                 BCS   L01_C758                     ;[ ]
  C751  C6 09                 DEC   <$09                         ;[ ]
  C753  49 FF                 EOR   #$FF                         ;[ ]
  C755  1A                    INC   A                            ;[ ]
  C756  80 02                 BRA   L01_C75A                     ;[ ]

L01_C758:
  C758  E6 09                 INC   <$09                         ;[ ]
L01_C75A:
  C75A  C9 10                 CMP   #$10                         ;[ ]
  C75C  90 15                 BCC   L01_C773                     ;[ ]
L01_C75E:
  C75E  A5 10                 LDA   <$10                         ;[ ]
  C760  8D 47 2B              STA   $2B47                        ;[ ]
  C763  A5 11                 LDA   <$11                         ;[ ]
  C765  8D 8E 2C              STA   $2C8E                        ;[ ]
  C768  A5 12                 LDA   <$12                         ;[ ]
  C76A  8D 48 2B              STA   $2B48                        ;[ ]
  C76D  A5 13                 LDA   <$13                         ;[ ]
  C76F  8D 8F 2C              STA   $2C8F                        ;[ ]
  C772  60                    RTS                                ;[ ]

L01_C773:
  C773  A5 08                 LDA   <$08                         ;[ ]
  C775  05 09                 ORA   <$09                         ;[ ]
  C777  F0 70                 BEQ   L01_C7E9                     ;[ ]
  C779  A5 0E                 LDA   <$0E                         ;[ ]
  C77B  29 0C                 AND   #$0C                         ;[ ]
  C77D  F0 20                 BEQ   L01_C79F                     ;[ ]
  C77F  A5 08                 LDA   <$08                         ;[ ]
  C781  F0 1C                 BEQ   L01_C79F                     ;[ ]
  C783  30 0E                 BMI   L01_C793                     ;[ ]
  C785  A5 13                 LDA   <$13                         ;[ ]
  C787  44 40                 BSR   L01_C7C9                     ;[ ]
  C789  85 13                 STA   <$13                         ;[ ]
  C78B  A5 11                 LDA   <$11                         ;[ ]
  C78D  44 42                 BSR   L01_C7D1                     ;[ ]
  C78F  85 11                 STA   <$11                         ;[ ]
  C791  80 0C                 BRA   L01_C79F                     ;[ ]

L01_C793:
  C793  A5 11                 LDA   <$11                         ;[ ]
  C795  44 32                 BSR   L01_C7C9                     ;[ ]
  C797  85 11                 STA   <$11                         ;[ ]
  C799  A5 13                 LDA   <$13                         ;[ ]
  C79B  44 34                 BSR   L01_C7D1                     ;[ ]
  C79D  85 13                 STA   <$13                         ;[ ]
L01_C79F:
  C79F  A5 0E                 LDA   <$0E                         ;[ ]
  C7A1  29 03                 AND   #$03                         ;[ ]
  C7A3  F0 89                 BEQ   L01_C72E                     ;[ ]
  C7A5  A5 09                 LDA   <$09                         ;[ ]
  C7A7  F0 85                 BEQ   L01_C72E                     ;[ ]
  C7A9  30 0F                 BMI   L01_C7BA                     ;[ ]
  C7AB  A5 10                 LDA   <$10                         ;[ ]
  C7AD  44 2A                 BSR   L01_C7D9                     ;[ ]
  C7AF  85 10                 STA   <$10                         ;[ ]
  C7B1  A5 12                 LDA   <$12                         ;[ ]
  C7B3  44 2C                 BSR   L01_C7E1                     ;[ ]
  C7B5  85 12                 STA   <$12                         ;[ ]
  C7B7  4C 2E C7              JMP   L01_C72E                     ;[ ]

L01_C7BA:
  C7BA  A5 12                 LDA   <$12                         ;[ ]
  C7BC  44 1B                 BSR   L01_C7D9                     ;[ ]
  C7BE  85 12                 STA   <$12                         ;[ ]
  C7C0  A5 10                 LDA   <$10                         ;[ ]
  C7C2  44 1D                 BSR   L01_C7E1                     ;[ ]
  C7C4  85 10                 STA   <$10                         ;[ ]
  C7C6  4C 2E C7              JMP   L01_C72E                     ;[ ]

L01_C7C9:
  C7C9  3A                    DEC   A                            ;[ ]
  C7CA  C9 18                 CMP   #$18                         ;[ ]
  C7CC  B0 02                 BCS   L01_C7D0                     ;[ ]
  C7CE  A9 18                 LDA   #$18                         ;[ ]
L01_C7D0:
  C7D0  60                    RTS                                ;[ ]

L01_C7D1:
  C7D1  1A                    INC   A                            ;[ ]
  C7D2  C9 C6                 CMP   #$C6                         ;[ ]
  C7D4  90 02                 BCC   L01_C7D8                     ;[ ]
  C7D6  A9 C6                 LDA   #$C6                         ;[ ]
L01_C7D8:
  C7D8  60                    RTS                                ;[ ]

L01_C7D9:
  C7D9  1A                    INC   A                            ;[ ]
  C7DA  C9 E1                 CMP   #$E1                         ;[ ]
  C7DC  90 02                 BCC   L01_C7E0                     ;[ ]
  C7DE  A9 E1                 LDA   #$E1                         ;[ ]
L01_C7E0:
  C7E0  60                    RTS                                ;[ ]

L01_C7E1:
  C7E1  3A                    DEC   A                            ;[ ]
  C7E2  C9 10                 CMP   #$10                         ;[ ]
  C7E4  B0 02                 BCS   L01_C7E8                     ;[ ]
  C7E6  A9 10                 LDA   #$10                         ;[ ]
L01_C7E8:
  C7E8  60                    RTS                                ;[ ]

L01_C7E9:
  C7E9  A9 01                 LDA   #$01                         ;[ ]
  C7EB  85 B9                 STA   <$B9                         ;[ ]
  C7ED  85 BA                 STA   <$BA                         ;[ ]
  C7EF  A5 10                 LDA   <$10                         ;[ ]
  C7F1  44 EE                 BSR   L01_C7E1                     ;[ ]
  C7F3  85 10                 STA   <$10                         ;[ ]
  C7F5  A5 12                 LDA   <$12                         ;[ ]
  C7F7  44 E0                 BSR   L01_C7D9                     ;[ ]
  C7F9  85 12                 STA   <$12                         ;[ ]
  C7FB  4C 2E C7              JMP   L01_C72E                     ;[ ]

  C7FE  A2 05                 LDX   #$05                         ;[x]
L01_C800:
  C800  B5 17                 LDA   <$17,X                       ;[x]
  C802  95 71                 STA   <$71,X                       ;[x]
  C804  B5 21                 LDA   <$21,X                       ;[x]
  C806  95 76                 STA   <$76,X                       ;[x]
  C808  CA                    DEX                                ;[x]
  C809  D0 F5                 BNE   L01_C800                     ;[x]
  C80B  80 00                 BRA   L01_C80D                     ;[x]

L01_C80D:
  C80D  20 F7 C6              JSR   L01_C6F7                     ;[x]
  C810  A2 01                 LDX   #$01                         ;[x]
L01_C812:
  C812  BD 0D 38              LDA   $380D,X                      ;[x]
  C815  F0 04                 BEQ   L01_C81B                     ;[x]
  C817  3A                    DEC   A                            ;[x]
  C818  9D 0D 38              STA   $380D,X                      ;[x]
L01_C81B:
  C81B  BD 7A 38              LDA   $387A,X                      ;[x]
  C81E  F0 06                 BEQ   L01_C826                     ;[x]
  C820  3A                    DEC   A                            ;[x]
  C821  9D 7A 38              STA   $387A,X                      ;[x]
  C824  D0 03                 BNE   L01_C829                     ;[x]
L01_C826:
  C826  9E E7 38              STZ   $38E7,X                      ;[x]
L01_C829:
  C829  20 51 C8              JSR   L01_C851                     ;[x]
  C82C  CA                    DEX                                ;[x]
  C82D  10 E3                 BPL   L01_C812                     ;[x]
  C82F  20 DE C5              JSR   L01_C5DE                     ;[x]
  C832  A2 00                 LDX   #$00                         ;[x]
  C834  0F 86 09              BBR0  <$86,L01_C840                ;[x]
  C837  20 34 CA              JSR   L01_CA34                     ;[x]
  C83A  20 47 D0              JSR   L01_D047                     ;[x]
  C83D  20 B5 CF              JSR   L01_CFB5                     ;[x]
L01_C840:
  C840  E8                    INX                                ;[x]
  C841  1F 86 09              BBR1  <$86,L01_C84D                ;[x]
  C844  20 34 CA              JSR   L01_CA34                     ;[ ]
  C847  20 47 D0              JSR   L01_D047                     ;[ ]
  C84A  20 B5 CF              JSR   L01_CFB5                     ;[ ]
L01_C84D:
  C84D  20 AA D6              JSR   L01_D6AA                     ;[x]
  C850  60                    RTS                                ;[x]

L01_C851:
  C851  64 08                 STZ   <$08                         ;[x]
  C853  64 09                 STZ   <$09                         ;[x]
  C855  64 0A                 STZ   <$0A                         ;[x]
  C857  BD 89 2F              LDA   $2F89,X                      ;[x]
  C85A  20 A2 E7              JSR   L00_E7A2                     ;[x]
  C85D  6D C8 3A              ADC   $3AC8                        ;[ ]
  C860  C9 50                 CMP   #$50                         ;[ ]
  C862  C9 0F                 CMP   #$0F                         ;[ ]
  C864  D4                    CSH                                ;[ ]
  C865  C6 D4                 DEC   <$D4                         ;[ ]
  C867  02                    SXY                                ;[ ]
  C868  D5 68                 CMP   <$68,X                       ;[ ]
  C86A  D5 FF                 CMP   <$FF,X                       ;[ ]
  C86C  D5 BD                 CMP   <$BD,X                       ;[ ]
  C86E  31 C9                 AND   (<$C9),Y                     ;[ ]
  C870  9D 47 2B              STA   $2B47,X                      ;[x]
  C873  9E 21 2C              STZ   $2C21,X                      ;[x]
  C876  BD 34 C9              LDA   $C934,X                      ;[x]
  C879  9D 8E 2C              STA   $2C8E,X                      ;[x]
  C87C  9E DA 2A              STZ   $2ADA,X                      ;[x]
  C87F  9E B4 2B              STZ   $2BB4,X                      ;[x]
  C882  9E FB 2C              STZ   $2CFB,X                      ;[x]
  C885  74 B9                 STZ   <$B9,X                       ;[x]
  C887  9E 00 2A              STZ   $2A00,X                      ;[x]
  C88A  8A                    TXA                                ;[x]
  C88B  09 80                 ORA   #$80                         ;[x]
  C88D  9D 42 2E              STA   $2E42,X                      ;[x]
  C890  74 C6                 STZ   <$C6,X                       ;[x]
  C892  74 C8                 STZ   <$C8,X                       ;[x]
  C894  74 CA                 STZ   <$CA,X                       ;[x]
  C896  74 CC                 STZ   <$CC,X                       ;[x]
  C898  9E 2E 3A              STZ   $3A2E,X                      ;[x]
  C89B  BD EA 3E              LDA   $3EEA,X                      ;[x]
  C89E  9D 54 39              STA   $3954,X                      ;[x]
  C8A1  BD E0 3E              LDA   $3EE0,X                      ;[x]
  C8A4  9D 38 34              STA   $3438,X                      ;[x]
  C8A7  85 0A                 STA   <$0A                         ;[x]
  C8A9  10 09                 BPL   L01_C8B4                     ;[x]
  C8AB  20 20 B2              JSR   $B220                        ;[ ]
  C8AE  BD E8 3E              LDA   $3EE8,X                      ;[ ]
  C8B1  9D AE 34              STA   $34AE,X                      ;[ ]
L01_C8B4:
  C8B4  0F 0A 03              BBR0  <$0A,L01_C8BA                ;[x]
  C8B7  20 22 B1              JSR   $B122                        ;[ ]
L01_C8BA:
  C8BA  1F 0A 03              BBR1  <$0A,L01_C8C0                ;[x]
  C8BD  20 97 B1              JSR   $B197                        ;[ ]
L01_C8C0:
  C8C0  4F 0A 1A              BBR4  <$0A,L01_C8DD                ;[x]
  C8C3  A5 A0                 LDA   <$A0                         ;[ ]
  C8C5  09 10                 ORA   #$10                         ;[ ]
  C8C7  85 A0                 STA   <$A0                         ;[ ]
  C8C9  A9 04                 LDA   #$04                         ;[ ]
  C8CB  8D 8B 2F              STA   $2F8B                        ;[ ]
  C8CE  A9 07                 LDA   #$07                         ;[ ]
  C8D0  8D 6F 2A              STA   $2A6F                        ;[ ]
  C8D3  AD E5 3E              LDA   $3EE5                        ;[ ]
  C8D6  8D 1E 2F              STA   $2F1E                        ;[ ]
  C8D9  8A                    TXA                                ;[ ]
  C8DA  8D 14 35              STA   $3514                        ;[ ]
L01_C8DD:
  C8DD  9E 9B 2F              STZ   $2F9B,X                      ;[x]
  C8E0  9E 7F 2A              STZ   $2A7F,X                      ;[x]
  C8E3  62                    CLA                                ;[x]
  C8E4  1D 9D 3F              ORA   $3F9D,X                      ;[x]
  C8E7  95 A9                 STA   <$A9,X                       ;[x]
  C8E9  9E C1 39              STZ   $39C1,X                      ;[x]
  C8EC  9E A5 34              STZ   $34A5,X                      ;[x]
  C8EF  9E 7A 38              STZ   $387A,X                      ;[x]
  C8F2  9E E7 38              STZ   $38E7,X                      ;[x]
  C8F5  A9 C0                 LDA   #$C0                         ;[x]
  C8F7  9D 0D 38              STA   $380D,X                      ;[x]
  C8FA  A5 86                 LDA   <$86                         ;[x]
  C8FC  1D 1B C9              ORA   $C91B,X                      ;[x]
  C8FF  85 86                 STA   <$86                         ;[x]
  C901  FE 89 2F              INC   $2F89,X                      ;[x]
  C904  A9 01                 LDA   #$01                         ;[x]
  C906  95 A6                 STA   <$A6,X                       ;[x]
  C908  A9 30                 LDA   #$30                         ;[x]
  C90A  9D 59 36              STA   $3659,X                      ;[x]
  C90D  A9 31                 LDA   #$31                         ;[x]
  C90F  20 FC E3              JSR   L00_E3FC                     ;[x]
  C912  A9 08                 LDA   #$08                         ;[x]
  C914  20 FC E3              JSR   L00_E3FC                     ;[x]
  C917  20 D8 FE              JSR   L00_FED8                     ;[x]
  C91A  60                    RTS                                ;[x]

  C91B  .db $01,$02,$80,$00,$00,$01,$80,$01,$00,$02,$80,$02,$00,$03,$80,$03
  C92B  .db $00,$04,$80,$04,$00,$05,$40,$A0,$70,$FF,$FF,$FF,$01,$02,$07
L01_C93A:
  C93A  A9 08                 LDA   #$08                         ;[x]
  C93C  95 B9                 STA   <$B9,X                       ;[x]
  C93E  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  C941  38                    SEC                                ;[x]
  C942  E9 02                 SBC   #$02                         ;[x]
  C944  9D 8E 2C              STA   $2C8E,X                      ;[x]
  C947  DE 59 36              DEC   $3659,X                      ;[x]
  C94A  D0 03                 BNE   L01_C94F                     ;[x]
  C94C  FE 89 2F              INC   $2F89,X                      ;[x]
L01_C94F:
  C94F  60                    RTS                                ;[x]

  C950  BD 2E 3A              LDA   $3A2E,X                      ;[x]
  C953  F0 10                 BEQ   L01_C965                     ;[x]
  C955  3A                    DEC   A                            ;[x]
  C956  9D 2E 3A              STA   $3A2E,X                      ;[x]
  C959  BD 54 39              LDA   $3954,X                      ;[x]
  C95C  38                    SEC                                ;[x]
  C95D  E9 04                 SBC   #$04                         ;[x]
  C95F  B0 01                 BCS   L01_C962                     ;[x]
  C961  62                    CLA                                ;[ ]
L01_C962:
  C962  A8                    TAY                                ;[x]
  C963  80 03                 BRA   L01_C968                     ;[x]

L01_C965:
  C965  BC 54 39              LDY   $3954,X                      ;[x]
L01_C968:
  C968  B9 1D C9              LDA   $C91D,Y                      ;[x]
  C96B  85 16                 STA   <$16                         ;[x]
  C96D  85 14                 STA   <$14                         ;[x]
  C96F  B9 1E C9              LDA   $C91E,Y                      ;[x]
  C972  85 15                 STA   <$15                         ;[x]
  C974  85 13                 STA   <$13                         ;[x]
  C976  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  C979  95 BD                 STA   <$BD,X                       ;[x]
  C97B  BD FB 2C              LDA   $2CFB,X                      ;[x]
  C97E  95 C1                 STA   <$C1,X                       ;[x]
  C980  BD 47 2B              LDA   $2B47,X                      ;[x]
  C983  95 BB                 STA   <$BB,X                       ;[x]
  C985  BD B4 2B              LDA   $2BB4,X                      ;[x]
  C988  95 BF                 STA   <$BF,X                       ;[x]
  C98A  74 B9                 STZ   <$B9,X                       ;[x]
  C98C  BD 38 34              LDA   $3438,X                      ;[x]
  C98F  85 0A                 STA   <$0A                         ;[x]
  C991  A9 01                 LDA   #$01                         ;[x]
  C993  9D 12 35              STA   $3512,X                      ;[x]
  C996  B5 77                 LDA   <$77,X                       ;[x]
  C998  85 09                 STA   <$09                         ;[x]
  C99A  B5 72                 LDA   <$72,X                       ;[x]
  C99C  85 08                 STA   <$08                         ;[x]
  C99E  29 A0                 AND   #$A0                         ;[x]
  C9A0  F0 4D                 BEQ   L01_C9EF                     ;[x]
  C9A2  9E 12 35              STZ   $3512,X                      ;[x]
  C9A5  29 20                 AND   #$20                         ;[x]
  C9A7  D0 20                 BNE   L01_C9C9                     ;[x]
  C9A9  B5 B9                 LDA   <$B9,X                       ;[x]
  C9AB  09 02                 ORA   #$02                         ;[x]
  C9AD  95 B9                 STA   <$B9,X                       ;[x]
  C9AF  A9 01                 LDA   #$01                         ;[x]
  C9B1  95 CA                 STA   <$CA,X                       ;[x]
  C9B3  BD B4 2B              LDA   $2BB4,X                      ;[x]
  C9B6  38                    SEC                                ;[x]
  C9B7  E5 16                 SBC   <$16                         ;[x]
  C9B9  9D B4 2B              STA   $2BB4,X                      ;[x]
  C9BC  BD 47 2B              LDA   $2B47,X                      ;[x]
  C9BF  E5 15                 SBC   <$15                         ;[x]
  C9C1  C9 10                 CMP   #$10                         ;[x]
  C9C3  B0 22                 BCS   L01_C9E7                     ;[x]
  C9C5  A9 10                 LDA   #$10                         ;[x]
  C9C7  80 1E                 BRA   L01_C9E7                     ;[x]

L01_C9C9:
  C9C9  B5 B9                 LDA   <$B9,X                       ;[x]
  C9CB  09 01                 ORA   #$01                         ;[x]
  C9CD  95 B9                 STA   <$B9,X                       ;[x]
  C9CF  A9 02                 LDA   #$02                         ;[x]
  C9D1  95 CA                 STA   <$CA,X                       ;[x]
  C9D3  BD B4 2B              LDA   $2BB4,X                      ;[x]
  C9D6  18                    CLC                                ;[x]
  C9D7  65 16                 ADC   <$16                         ;[x]
  C9D9  9D B4 2B              STA   $2BB4,X                      ;[x]
  C9DC  BD 47 2B              LDA   $2B47,X                      ;[x]
  C9DF  65 15                 ADC   <$15                         ;[x]
  C9E1  C9 E1                 CMP   #$E1                         ;[x]
  C9E3  90 02                 BCC   L01_C9E7                     ;[x]
  C9E5  A9 E1                 LDA   #$E1                         ;[x]
L01_C9E7:
  C9E7  9D 47 2B              STA   $2B47,X                      ;[x]
  C9EA  CF 0A 02              BBS4  <$0A,L01_C9EF                ;[x]
  C9ED  80 02                 BRA   L01_C9F1                     ;[x]

L01_C9EF:
  C9EF  74 CA                 STZ   <$CA,X                       ;[x]
L01_C9F1:
  C9F1  EF 08 1F              BBS6  <$08,L01_CA13                ;[x]
  C9F4  4F 08 3C              BBR4  <$08,L01_CA33                ;[x]
  C9F7  B5 B9                 LDA   <$B9,X                       ;[x]
  C9F9  09 08                 ORA   #$08                         ;[x]
  C9FB  95 B9                 STA   <$B9,X                       ;[x]
  C9FD  BD FB 2C              LDA   $2CFB,X                      ;[x]
  CA00  38                    SEC                                ;[x]
  CA01  E5 14                 SBC   <$14                         ;[x]
  CA03  9D FB 2C              STA   $2CFB,X                      ;[x]
  CA06  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CA09  E5 13                 SBC   <$13                         ;[x]
  CA0B  C9 18                 CMP   #$18                         ;[x]
  CA0D  B0 1E                 BCS   L01_CA2D                     ;[x]
  CA0F  A9 18                 LDA   #$18                         ;[x]
  CA11  80 1A                 BRA   L01_CA2D                     ;[x]

L01_CA13:
  CA13  B5 B9                 LDA   <$B9,X                       ;[x]
  CA15  09 04                 ORA   #$04                         ;[x]
  CA17  95 B9                 STA   <$B9,X                       ;[x]
  CA19  BD FB 2C              LDA   $2CFB,X                      ;[x]
  CA1C  18                    CLC                                ;[x]
  CA1D  65 14                 ADC   <$14                         ;[x]
  CA1F  9D FB 2C              STA   $2CFB,X                      ;[x]
  CA22  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CA25  65 13                 ADC   <$13                         ;[x]
  CA27  C9 C6                 CMP   #$C6                         ;[x]
  CA29  90 02                 BCC   L01_CA2D                     ;[x]
  CA2B  A9 C6                 LDA   #$C6                         ;[x]
L01_CA2D:
  CA2D  9D 8E 2C              STA   $2C8E,X                      ;[x]
  CA30  9E 12 35              STZ   $3512,X                      ;[x]
L01_CA33:
  CA33  60                    RTS                                ;[x]

L01_CA34:
  CA34  BD 89 2F              LDA   $2F89,X                      ;[x]
  CA37  C9 02                 CMP   #$02                         ;[x]
  CA39  F0 01                 BEQ   L01_CA3C                     ;[x]
  CA3B  60                    RTS                                ;[x]

L01_CA3C:
  CA3C  BD 38 34              LDA   $3438,X                      ;[x]
  CA3F  85 0A                 STA   <$0A                         ;[x]
  CA41  B5 77                 LDA   <$77,X                       ;[x]
  CA43  85 09                 STA   <$09                         ;[x]
  CA45  B5 72                 LDA   <$72,X                       ;[x]
  CA47  85 08                 STA   <$08                         ;[x]
  CA49  B5 A6                 LDA   <$A6,X                       ;[x]
  CA4B  D0 0E                 BNE   L01_CA5B                     ;[x]
  CA4D  A5 09                 LDA   <$09                         ;[x]
  CA4F  29 02                 AND   #$02                         ;[x]
  CA51  F0 05                 BEQ   L01_CA58                     ;[x]
  CA53  F6 A6                 INC   <$A6,X                       ;[x]
  CA55  4C 22 CB              JMP   L01_CB22                     ;[x]

L01_CA58:
  CA58  4C 54 CD              JMP   L01_CD54                     ;[x]

L01_CA5B:
  CA5B  A5 08                 LDA   <$08                         ;[x]
  CA5D  29 02                 AND   #$02                         ;[x]
  CA5F  F0 03                 BEQ   L01_CA64                     ;[x]
  CA61  4C 72 CA              JMP   L01_CA72                     ;[x]

L01_CA64:
  CA64  B5 A6                 LDA   <$A6,X                       ;[x]
  CA66  C9 0C                 CMP   #$0C                         ;[x]
  CA68  90 03                 BCC   L01_CA6D                     ;[x]
  CA6A  4C 94 CA              JMP   L01_CA94                     ;[x]

L01_CA6D:
  CA6D  74 A6                 STZ   <$A6,X                       ;[x]
  CA6F  4C 54 CD              JMP   L01_CD54                     ;[x]

L01_CA72:
  CA72  BD 27 2F              LDA   $2F27,X                      ;[x]
  CA75  F0 03                 BEQ   L01_CA7A                     ;[x]
  CA77  4C 22 CB              JMP   L01_CB22                     ;[ ]

L01_CA7A:
  CA7A  20 F1 CA              JSR   L01_CAF1                     ;[x]
  CA7D  B5 A6                 LDA   <$A6,X                       ;[x]
  CA7F  C9 0C                 CMP   #$0C                         ;[x]
  CA81  D0 07                 BNE   L01_CA8A                     ;[x]
  CA83  48                    PHA                                ;[x]
  CA84  A9 21                 LDA   #$21                         ;[x]
  CA86  20 FC E3              JSR   L00_E3FC                     ;[x]
  CA89  68                    PLA                                ;[x]
L01_CA8A:
  CA8A  C9 28                 CMP   #$28                         ;[x]
  CA8C  B0 03                 BCS   L01_CA91                     ;[x]
  CA8E  1A                    INC   A                            ;[x]
  CA8F  95 A6                 STA   <$A6,X                       ;[x]
L01_CA91:
  CA91  4C 22 CB              JMP   L01_CB22                     ;[x]

L01_CA94:
  CA94  C9 28                 CMP   #$28                         ;[x]
  CA96  90 0F                 BCC   L01_CAA7                     ;[x]
  CA98  A5 B8                 LDA   <$B8                         ;[x]
  CA9A  30 07                 BMI   L01_CAA3                     ;[x]
  CA9C  CF 0A 04              BBS4  <$0A,L01_CAA3                ;[x]
  CA9F  A9 02                 LDA   #$02                         ;[x]
  CAA1  80 06                 BRA   L01_CAA9                     ;[x]

L01_CAA3:
  CAA3  A9 03                 LDA   #$03                         ;[ ]
  CAA5  80 02                 BRA   L01_CAA9                     ;[ ]

L01_CAA7:
  CAA7  A9 01                 LDA   #$01                         ;[x]
L01_CAA9:
  CAA9  A8                    TAY                                ;[x]
  CAAA  9D 27 2F              STA   $2F27,X                      ;[x]
  CAAD  18                    CLC                                ;[x]
  CAAE  69 13                 ADC   #$13                         ;[x]
  CAB0  9D 78 2A              STA   $2A78,X                      ;[x]
  CAB3  74 A6                 STZ   <$A6,X                       ;[x]
  CAB5  B9 EA CA              LDA   $CAEA,Y                      ;[x]
  CAB8  9D 69 33              STA   $3369,X                      ;[x]
  CABB  B9 ED CA              LDA   $CAED,Y                      ;[x]
  CABE  9D D6 33              STA   $33D6,X                      ;[x]
  CAC1  BD 47 2B              LDA   $2B47,X                      ;[x]
  CAC4  9D 52 2B              STA   $2B52,X                      ;[x]
  CAC7  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CACA  18                    CLC                                ;[x]
  CACB  69 10                 ADC   #$10                         ;[x]
  CACD  9D 99 2C              STA   $2C99,X                      ;[x]
  CAD0  9E 2C 2C              STZ   $2C2C,X                      ;[x]
  CAD3  A9 40                 LDA   #$40                         ;[x]
  CAD5  9D 4D 2E              STA   $2E4D,X                      ;[x]
  CAD8  A5 C5                 LDA   <$C5                         ;[x]
  CADA  1A                    INC   A                            ;[x]
  CADB  D0 01                 BNE   L01_CADE                     ;[x]
  CADD  1A                    INC   A                            ;[ ]
L01_CADE:
  CADE  9D 1D 35              STA   $351D,X                      ;[x]
  CAE1  85 C5                 STA   <$C5                         ;[x]
  CAE3  A9 24                 LDA   #$24                         ;[x]
  CAE5  20 FC E3              JSR   L00_E3FC                     ;[x]
  CAE8  4C 54 CD              JMP   L01_CD54                     ;[x]

  CAEB  .db $0F,$1C,$24,$14,$34,$34
L01_CAF1:
  CAF1  B5 A6                 LDA   <$A6,X                       ;[x]
  CAF3  C9 0C                 CMP   #$0C                         ;[x]
  CAF5  90 26                 BCC   L01_CB1D                     ;[x]
  CAF7  A5 83                 LDA   <$83                         ;[x]
  CAF9  29 18                 AND   #$18                         ;[x]
  CAFB  4A                    LSR   A                            ;[x]
  CAFC  4A                    LSR   A                            ;[x]
  CAFD  4A                    LSR   A                            ;[x]
  CAFE  A8                    TAY                                ;[x]
  CAFF  B9 1E CB              LDA   $CB1E,Y                      ;[x]
  CB02  9D 78 2A              STA   $2A78,X                      ;[x]
  CB05  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CB08  38                    SEC                                ;[x]
  CB09  E9 10                 SBC   #$10                         ;[x]
  CB0B  9D 99 2C              STA   $2C99,X                      ;[x]
  CB0E  9E 2C 2C              STZ   $2C2C,X                      ;[x]
  CB11  BD 47 2B              LDA   $2B47,X                      ;[x]
  CB14  9D 52 2B              STA   $2B52,X                      ;[x]
  CB17  9E E5 2A              STZ   $2AE5,X                      ;[x]
  CB1A  9E 4D 2E              STZ   $2E4D,X                      ;[x]
L01_CB1D:
  CB1D  60                    RTS                                ;[x]

  CB1E  .db $00,$5B,$5A,$59
L01_CB22:
  CB22  BD A0 37              LDA   $37A0,X                      ;[x]
  CB25  F0 06                 BEQ   L01_CB2D                     ;[x]
  CB27  DE A0 37              DEC   $37A0,X                      ;[x]
  CB2A  4C 54 CD              JMP   L01_CD54                     ;[x]

L01_CB2D:
  CB2D  9F 09 03              BBS1  <$09,L01_CB33                ;[x]
  CB30  4C 54 CD              JMP   L01_CD54                     ;[x]

L01_CB33:
  CB33  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CB36  85 10                 STA   <$10                         ;[x]
  CB38  BD 47 2B              LDA   $2B47,X                      ;[x]
  CB3B  85 11                 STA   <$11                         ;[x]
  CB3D  BD 9D 2F              LDA   $2F9D,X                      ;[x]
  CB40  1D A1 2F              ORA   $2FA1,X                      ;[x]
  CB43  1D A5 2F              ORA   $2FA5,X                      ;[x]
  CB46  D0 03                 BNE   L01_CB4B                     ;[x]
  CB48  4C 5C CB              JMP   L01_CB5C                     ;[x]

L01_CB4B:
  CB4B  BD 9F 2F              LDA   $2F9F,X                      ;[x]
  CB4E  1D A3 2F              ORA   $2FA3,X                      ;[x]
  CB51  1D A7 2F              ORA   $2FA7,X                      ;[x]
  CB54  D0 03                 BNE   L01_CB59                     ;[x]
  CB56  4C 1E CC              JMP   L01_CC1E                     ;[x]

L01_CB59:
  CB59  4C DD CC              JMP   L01_CCDD                     ;[ ]

L01_CB5C:
  CB5C  A9 04                 LDA   #$04                         ;[x]
  CB5E  9D A0 37              STA   $37A0,X                      ;[x]
  CB61  FE 9D 2F              INC   $2F9D,X                      ;[x]
  CB64  A5 10                 LDA   <$10                         ;[x]
  CB66  9D A2 2C              STA   $2CA2,X                      ;[x]
  CB69  A5 11                 LDA   <$11                         ;[x]
  CB6B  9D 5B 2B              STA   $2B5B,X                      ;[x]
  CB6E  CF 0A 17              BBS4  <$0A,L01_CB88                ;[x]
  CB71  7F B8 25              BBR7  <$B8,L01_CB99                ;[x]
  CB74  BF 0A 11              BBS3  <$0A,L01_CB88                ;[ ]
  CB77  A9 1E                 LDA   #$1E                         ;[ ]
  CB79  9D 81 2A              STA   $2A81,X                      ;[ ]
  CB7C  A9 20                 LDA   #$20                         ;[ ]
  CB7E  9D 72 33              STA   $3372,X                      ;[ ]
  CB81  A9 14                 LDA   #$14                         ;[ ]
  CB83  9D DF 33              STA   $33DF,X                      ;[ ]
  CB86  80 35                 BRA   L01_CBBD                     ;[ ]

L01_CB88:
  CB88  A9 1D                 LDA   #$1D                         ;[ ]
  CB8A  9D 81 2A              STA   $2A81,X                      ;[ ]
  CB8D  A9 10                 LDA   #$10                         ;[ ]
  CB8F  9D 72 33              STA   $3372,X                      ;[ ]
  CB92  A9 14                 LDA   #$14                         ;[ ]
  CB94  9D DF 33              STA   $33DF,X                      ;[ ]
  CB97  80 24                 BRA   L01_CBBD                     ;[ ]

L01_CB99:
  CB99  BF 0A 12              BBS3  <$0A,L01_CBAE                ;[x]
  CB9C  2F 0A 0F              BBR2  <$0A,L01_CBAE                ;[x]
  CB9F  A9 1C                 LDA   #$1C                         ;[ ]
  CBA1  9D 81 2A              STA   $2A81,X                      ;[ ]
  CBA4  A9 0C                 LDA   #$0C                         ;[ ]
  CBA6  9D 72 33              STA   $3372,X                      ;[ ]
  CBA9  9D DF 33              STA   $33DF,X                      ;[ ]
  CBAC  80 0F                 BRA   L01_CBBD                     ;[ ]

L01_CBAE:
  CBAE  A9 0E                 LDA   #$0E                         ;[x]
  CBB0  9D 81 2A              STA   $2A81,X                      ;[x]
  CBB3  A9 08                 LDA   #$08                         ;[x]
  CBB5  9D 72 33              STA   $3372,X                      ;[x]
  CBB8  A9 10                 LDA   #$10                         ;[x]
  CBBA  9D DF 33              STA   $33DF,X                      ;[x]
L01_CBBD:
  CBBD  3F 0A 56              BBR3  <$0A,L01_CC16                ;[x]
  CBC0  A5 11                 LDA   <$11                         ;[ ]
  CBC2  9D 5F 2B              STA   $2B5F,X                      ;[ ]
  CBC5  9D 63 2B              STA   $2B63,X                      ;[ ]
  CBC8  A5 10                 LDA   <$10                         ;[ ]
  CBCA  9D A6 2C              STA   $2CA6,X                      ;[ ]
  CBCD  9D AA 2C              STA   $2CAA,X                      ;[ ]
  CBD0  A9 FC                 LDA   #$FC                         ;[ ]
  CBD2  9D 55 31              STA   $3155,X                      ;[ ]
  CBD5  A9 04                 LDA   #$04                         ;[ ]
  CBD7  9D 59 31              STA   $3159,X                      ;[ ]
  CBDA  FE A1 2F              INC   $2FA1,X                      ;[ ]
  CBDD  FE A5 2F              INC   $2FA5,X                      ;[ ]
  CBE0  CF 0A 03              BBS4  <$0A,L01_CBE6                ;[ ]
  CBE3  7F B8 19              BBR7  <$B8,L01_CBFF                ;[ ]
L01_CBE6:
  CBE6  A9 1F                 LDA   #$1F                         ;[ ]
  CBE8  9D 85 2A              STA   $2A85,X                      ;[ ]
  CBEB  1A                    INC   A                            ;[ ]
  CBEC  9D 89 2A              STA   $2A89,X                      ;[ ]
  CBEF  A9 0A                 LDA   #$0A                         ;[ ]
  CBF1  9D 76 33              STA   $3376,X                      ;[ ]
  CBF4  9D 7A 33              STA   $337A,X                      ;[ ]
  CBF7  9D E3 33              STA   $33E3,X                      ;[ ]
  CBFA  9D E7 33              STA   $33E7,X                      ;[ ]
  CBFD  80 17                 BRA   L01_CC16                     ;[ ]

L01_CBFF:
  CBFF  A9 0F                 LDA   #$0F                         ;[ ]
  CC01  9D 85 2A              STA   $2A85,X                      ;[ ]
  CC04  1A                    INC   A                            ;[ ]
  CC05  9D 89 2A              STA   $2A89,X                      ;[ ]
  CC08  A9 0A                 LDA   #$0A                         ;[ ]
  CC0A  9D 76 33              STA   $3376,X                      ;[ ]
  CC0D  9D 7A 33              STA   $337A,X                      ;[ ]
  CC10  9D E3 33              STA   $33E3,X                      ;[ ]
  CC13  9D E7 33              STA   $33E7,X                      ;[ ]
L01_CC16:
  CC16  A9 17                 LDA   #$17                         ;[x]
  CC18  20 FC E3              JSR   L00_E3FC                     ;[x]
  CC1B  4C DD CC              JMP   L01_CCDD                     ;[x]

L01_CC1E:
  CC1E  A9 04                 LDA   #$04                         ;[x]
  CC20  9D A0 37              STA   $37A0,X                      ;[x]
  CC23  FE 9F 2F              INC   $2F9F,X                      ;[x]
  CC26  A5 10                 LDA   <$10                         ;[x]
  CC28  9D A4 2C              STA   $2CA4,X                      ;[x]
  CC2B  A5 11                 LDA   <$11                         ;[x]
  CC2D  9D 5D 2B              STA   $2B5D,X                      ;[x]
  CC30  CF 0A 17              BBS4  <$0A,L01_CC4A                ;[x]
  CC33  7F B8 25              BBR7  <$B8,L01_CC5B                ;[x]
  CC36  BF 0A 11              BBS3  <$0A,L01_CC4A                ;[ ]
  CC39  A9 1E                 LDA   #$1E                         ;[ ]
  CC3B  9D 83 2A              STA   $2A83,X                      ;[ ]
  CC3E  A9 20                 LDA   #$20                         ;[ ]
  CC40  9D 74 33              STA   $3374,X                      ;[ ]
  CC43  A9 14                 LDA   #$14                         ;[ ]
  CC45  9D E1 33              STA   $33E1,X                      ;[ ]
  CC48  80 35                 BRA   L01_CC7F                     ;[ ]

L01_CC4A:
  CC4A  A9 1D                 LDA   #$1D                         ;[ ]
  CC4C  9D 83 2A              STA   $2A83,X                      ;[ ]
  CC4F  A9 10                 LDA   #$10                         ;[ ]
  CC51  9D 74 33              STA   $3374,X                      ;[ ]
  CC54  A9 14                 LDA   #$14                         ;[ ]
  CC56  9D E1 33              STA   $33E1,X                      ;[ ]
  CC59  80 24                 BRA   L01_CC7F                     ;[ ]

L01_CC5B:
  CC5B  BF 0A 12              BBS3  <$0A,L01_CC70                ;[x]
  CC5E  2F 0A 0F              BBR2  <$0A,L01_CC70                ;[x]
  CC61  A9 1C                 LDA   #$1C                         ;[ ]
  CC63  9D 83 2A              STA   $2A83,X                      ;[ ]
  CC66  A9 0C                 LDA   #$0C                         ;[ ]
  CC68  9D 74 33              STA   $3374,X                      ;[ ]
  CC6B  9D E1 33              STA   $33E1,X                      ;[ ]
  CC6E  80 0F                 BRA   L01_CC7F                     ;[ ]

L01_CC70:
  CC70  A9 0E                 LDA   #$0E                         ;[x]
  CC72  9D 83 2A              STA   $2A83,X                      ;[x]
  CC75  A9 08                 LDA   #$08                         ;[x]
  CC77  9D 74 33              STA   $3374,X                      ;[x]
  CC7A  A9 10                 LDA   #$10                         ;[x]
  CC7C  9D E1 33              STA   $33E1,X                      ;[x]
L01_CC7F:
  CC7F  3F 0A 56              BBR3  <$0A,L01_CCD8                ;[x]
  CC82  A5 11                 LDA   <$11                         ;[ ]
  CC84  9D 61 2B              STA   $2B61,X                      ;[ ]
  CC87  9D 65 2B              STA   $2B65,X                      ;[ ]
  CC8A  A5 10                 LDA   <$10                         ;[ ]
  CC8C  9D A8 2C              STA   $2CA8,X                      ;[ ]
  CC8F  9D AC 2C              STA   $2CAC,X                      ;[ ]
  CC92  A9 FC                 LDA   #$FC                         ;[ ]
  CC94  9D 57 31              STA   $3157,X                      ;[ ]
  CC97  A9 04                 LDA   #$04                         ;[ ]
  CC99  9D 5B 31              STA   $315B,X                      ;[ ]
  CC9C  FE A3 2F              INC   $2FA3,X                      ;[ ]
  CC9F  FE A7 2F              INC   $2FA7,X                      ;[ ]
  CCA2  CF 0A 03              BBS4  <$0A,L01_CCA8                ;[ ]
  CCA5  7F B8 19              BBR7  <$B8,L01_CCC1                ;[ ]
L01_CCA8:
  CCA8  A9 1F                 LDA   #$1F                         ;[ ]
  CCAA  9D 87 2A              STA   $2A87,X                      ;[ ]
  CCAD  1A                    INC   A                            ;[ ]
  CCAE  9D 8B 2A              STA   $2A8B,X                      ;[ ]
  CCB1  A9 0A                 LDA   #$0A                         ;[ ]
  CCB3  9D 78 33              STA   $3378,X                      ;[ ]
  CCB6  9D 7C 33              STA   $337C,X                      ;[ ]
  CCB9  9D E5 33              STA   $33E5,X                      ;[ ]
  CCBC  9D E9 33              STA   $33E9,X                      ;[ ]
  CCBF  80 17                 BRA   L01_CCD8                     ;[ ]

L01_CCC1:
  CCC1  A9 0F                 LDA   #$0F                         ;[ ]
  CCC3  9D 87 2A              STA   $2A87,X                      ;[ ]
  CCC6  1A                    INC   A                            ;[ ]
  CCC7  9D 8B 2A              STA   $2A8B,X                      ;[ ]
  CCCA  A9 0A                 LDA   #$0A                         ;[ ]
  CCCC  9D 78 33              STA   $3378,X                      ;[ ]
  CCCF  9D 7C 33              STA   $337C,X                      ;[ ]
  CCD2  9D E5 33              STA   $33E5,X                      ;[ ]
  CCD5  9D E9 33              STA   $33E9,X                      ;[ ]
L01_CCD8:
  CCD8  A9 17                 LDA   #$17                         ;[x]
  CCDA  20 FC E3              JSR   L00_E3FC                     ;[x]
L01_CCDD:
  CCDD  0F 0A 74              BBR0  <$0A,L01_CD54                ;[x]
  CCE0  A0 03                 LDY   #$03                         ;[ ]
  CCE2  02                    SXY                                ;[ ]
L01_CCE3:
  CCE3  BD A8 2F              LDA   $2FA8,X                      ;[ ]
  CCE6  D0 33                 BNE   L01_CD1B                     ;[ ]
  CCE8  BD 49 2B              LDA   $2B49,X                      ;[ ]
  CCEB  9D 66 2B              STA   $2B66,X                      ;[ ]
  CCEE  BD 90 2C              LDA   $2C90,X                      ;[ ]
  CCF1  9D AD 2C              STA   $2CAD,X                      ;[ ]
  CCF4  FE A8 2F              INC   $2FA8,X                      ;[ ]
  CCF7  2F 0A 0F              BBR2  <$0A,L01_CD09                ;[ ]
  CCFA  A9 1C                 LDA   #$1C                         ;[ ]
  CCFC  9D 8C 2A              STA   $2A8C,X                      ;[ ]
  CCFF  A9 0C                 LDA   #$0C                         ;[ ]
  CD01  9D 7D 33              STA   $337D,X                      ;[ ]
  CD04  9D EA 33              STA   $33EA,X                      ;[ ]
  CD07  80 0F                 BRA   L01_CD18                     ;[ ]

L01_CD09:
  CD09  A9 0E                 LDA   #$0E                         ;[ ]
  CD0B  9D 8C 2A              STA   $2A8C,X                      ;[ ]
  CD0E  A9 08                 LDA   #$08                         ;[ ]
  CD10  9D 7D 33              STA   $337D,X                      ;[ ]
  CD13  A9 10                 LDA   #$10                         ;[ ]
  CD15  9D EA 33              STA   $33EA,X                      ;[ ]
L01_CD18:
  CD18  4C 50 CD              JMP   L01_CD50                     ;[ ]

L01_CD1B:
  CD1B  BD AB 2F              LDA   $2FAB,X                      ;[ ]
  CD1E  D0 30                 BNE   L01_CD50                     ;[ ]
  CD20  BD 49 2B              LDA   $2B49,X                      ;[ ]
  CD23  9D 69 2B              STA   $2B69,X                      ;[ ]
  CD26  BD 90 2C              LDA   $2C90,X                      ;[ ]
  CD29  9D B0 2C              STA   $2CB0,X                      ;[ ]
  CD2C  FE AB 2F              INC   $2FAB,X                      ;[ ]
  CD2F  2F 0A 0F              BBR2  <$0A,L01_CD41                ;[ ]
  CD32  A9 1C                 LDA   #$1C                         ;[ ]
  CD34  9D 8F 2A              STA   $2A8F,X                      ;[ ]
  CD37  A9 0C                 LDA   #$0C                         ;[ ]
  CD39  9D 80 33              STA   $3380,X                      ;[ ]
  CD3C  9D ED 33              STA   $33ED,X                      ;[ ]
  CD3F  80 0F                 BRA   L01_CD50                     ;[ ]

L01_CD41:
  CD41  A9 0E                 LDA   #$0E                         ;[ ]
  CD43  9D 8F 2A              STA   $2A8F,X                      ;[ ]
  CD46  A9 08                 LDA   #$08                         ;[ ]
  CD48  9D 80 33              STA   $3380,X                      ;[ ]
  CD4B  A9 10                 LDA   #$10                         ;[ ]
  CD4D  9D ED 33              STA   $33ED,X                      ;[ ]
L01_CD50:
  CD50  CA                    DEX                                ;[ ]
  CD51  D0 90                 BNE   L01_CCE3                     ;[ ]
  CD53  02                    SXY                                ;[ ]
L01_CD54:
  CD54  BD A5 34              LDA   $34A5,X                      ;[x]
  CD57  29 03                 AND   #$03                         ;[x]
  CD59  C9 03                 CMP   #$03                         ;[x]
  CD5B  F0 03                 BEQ   L01_CD60                     ;[x]
  CD5D  8F 09 03              BBS0  <$09,L01_CD63                ;[x]
L01_CD60:
  CD60  4C 30 CF              JMP   L01_CF30                     ;[x]

L01_CD63:
  CD63  BD 84 32              LDA   $3284,X                      ;[x]
  CD66  29 01                 AND   #$01                         ;[x]
  CD68  F0 03                 BEQ   L01_CD6D                     ;[x]
  CD6A  4C 50 CE              JMP   L01_CE50                     ;[x]

L01_CD6D:
  CD6D  BD A5 34              LDA   $34A5,X                      ;[x]
  CD70  29 01                 AND   #$01                         ;[x]
  CD72  F0 03                 BEQ   L01_CD77                     ;[x]
  CD74  4C 50 CE              JMP   L01_CE50                     ;[x]

L01_CD77:
  CD77  BD 42 2F              LDA   $2F42,X                      ;[x]
  CD7A  D0 07                 BNE   L01_CD83                     ;[x]
  CD7C  BD B4 2F              LDA   $2FB4,X                      ;[x]
  CD7F  C9 01                 CMP   #$01                         ;[x]
  CD81  D0 03                 BNE   L01_CD86                     ;[x]
L01_CD83:
  CD83  4C 30 CF              JMP   L01_CF30                     ;[x]

L01_CD86:
  CD86  A9 06                 LDA   #$06                         ;[x]
  CD88  95 CC                 STA   <$CC,X                       ;[x]
  CD8A  20 33 CF              JSR   L01_CF33                     ;[x]
  CD8D  9D 8E 2D              STA   $2D8E,X                      ;[x]
  CD90  C9 00                 CMP   #$00                         ;[x]
  CD92  F0 21                 BEQ   L01_CDB5                     ;[x]
  CD94  3A                    DEC   A                            ;[x]
  CD95  A8                    TAY                                ;[x]
  CD96  A9 01                 LDA   #$01                         ;[x]
  CD98  99 C8 2D              STA   $2DC8,Y                      ;[x]
  CD9B  B9 EE 2C              LDA   $2CEE,Y                      ;[x]
  CD9E  9D 7A 39              STA   $397A,X                      ;[x]
  CDA1  18                    CLC                                ;[x]
  CDA2  69 30                 ADC   #$30                         ;[x]
  CDA4  9D C6 37              STA   $37C6,X                      ;[x]
  CDA7  B9 A7 2B              LDA   $2BA7,Y                      ;[x]
  CDAA  9D E7 39              STA   $39E7,X                      ;[x]
  CDAD  38                    SEC                                ;[x]
  CDAE  E9 0C                 SBC   #$0C                         ;[x]
  CDB0  9D A0 38              STA   $38A0,X                      ;[x]
  CDB3  80 18                 BRA   L01_CDCD                     ;[x]

L01_CDB5:
  CDB5  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CDB8  9D C6 37              STA   $37C6,X                      ;[x]
  CDBB  38                    SEC                                ;[x]
  CDBC  E9 30                 SBC   #$30                         ;[x]
  CDBE  9D 7A 39              STA   $397A,X                      ;[x]
  CDC1  BD 47 2B              LDA   $2B47,X                      ;[x]
  CDC4  9D E7 39              STA   $39E7,X                      ;[x]
  CDC7  38                    SEC                                ;[x]
  CDC8  E9 0C                 SBC   #$0C                         ;[x]
  CDCA  9D A0 38              STA   $38A0,X                      ;[x]
L01_CDCD:
  CDCD  BD 31 CF              LDA   $CF31,X                      ;[x]
  CDD0  9D 12 36              STA   $3612,X                      ;[x]
  CDD3  FE 84 32              INC   $3284,X                      ;[x]
  CDD6  A9 18                 LDA   #$18                         ;[x]
  CDD8  20 FC E3              JSR   L00_E3FC                     ;[x]
  CDDB  A9 01                 LDA   #$01                         ;[x]
  CDDD  9D 42 2F              STA   $2F42,X                      ;[x]
  CDE0  9D AF 2F              STA   $2FAF,X                      ;[x]
  CDE3  A9 08                 LDA   #$08                         ;[x]
  CDE5  9D 7F 36              STA   $367F,X                      ;[x]
  CDE8  8F 0A 03              BBS0  <$0A,L01_CDEE                ;[x]
  CDEB  4C 30 CF              JMP   L01_CF30                     ;[x]

L01_CDEE:
  CDEE  A0 03                 LDY   #$03                         ;[ ]
L01_CDF0:
  CDF0  A9 08                 LDA   #$08                         ;[ ]
  CDF2  99 80 36              STA   $3680,Y                      ;[ ]
  CDF5  A9 01                 LDA   #$01                         ;[ ]
  CDF7  99 B0 2F              STA   $2FB0,Y                      ;[ ]
  CDFA  20 74 CF              JSR   L01_CF74                     ;[ ]
  CDFD  99 8F 2D              STA   $2D8F,Y                      ;[ ]
  CE00  C9 00                 CMP   #$00                         ;[ ]
  CE02  F0 23                 BEQ   L01_CE27                     ;[ ]
  CE04  3A                    DEC   A                            ;[ ]
  CE05  DA                    PHX                                ;[ ]
  CE06  AA                    TAX                                ;[ ]
  CE07  A9 01                 LDA   #$01                         ;[ ]
  CE09  9D C8 2D              STA   $2DC8,X                      ;[ ]
  CE0C  BD EE 2C              LDA   $2CEE,X                      ;[ ]
  CE0F  99 7B 39              STA   $397B,Y                      ;[ ]
  CE12  18                    CLC                                ;[ ]
  CE13  69 30                 ADC   #$30                         ;[ ]
  CE15  99 C7 37              STA   $37C7,Y                      ;[ ]
  CE18  BD A7 2B              LDA   $2BA7,X                      ;[ ]
  CE1B  99 E8 39              STA   $39E8,Y                      ;[ ]
  CE1E  38                    SEC                                ;[ ]
  CE1F  E9 0C                 SBC   #$0C                         ;[ ]
  CE21  99 A1 38              STA   $38A1,Y                      ;[ ]
  CE24  FA                    PLX                                ;[ ]
  CE25  80 18                 BRA   L01_CE3F                     ;[ ]

L01_CE27:
  CE27  B9 90 2C              LDA   $2C90,Y                      ;[ ]
  CE2A  99 C7 37              STA   $37C7,Y                      ;[ ]
  CE2D  38                    SEC                                ;[ ]
  CE2E  E9 30                 SBC   #$30                         ;[ ]
  CE30  99 7B 39              STA   $397B,Y                      ;[ ]
  CE33  B9 49 2B              LDA   $2B49,Y                      ;[ ]
  CE36  99 E8 39              STA   $39E8,Y                      ;[ ]
  CE39  38                    SEC                                ;[ ]
  CE3A  E9 0C                 SBC   #$0C                         ;[ ]
  CE3C  99 A1 38              STA   $38A1,Y                      ;[ ]
L01_CE3F:
  CE3F  BD 31 CF              LDA   $CF31,X                      ;[ ]
  CE42  99 13 36              STA   $3613,Y                      ;[ ]
  CE45  A9 01                 LDA   #$01                         ;[ ]
  CE47  99 43 2F              STA   $2F43,Y                      ;[ ]
  CE4A  88                    DEY                                ;[ ]
  CE4B  D0 A3                 BNE   L01_CDF0                     ;[ ]
  CE4D  4C 30 CF              JMP   L01_CF30                     ;[ ]

L01_CE50:
  CE50  BD A5 34              LDA   $34A5,X                      ;[x]
  CE53  29 02                 AND   #$02                         ;[x]
  CE55  F0 03                 BEQ   L01_CE5A                     ;[x]
  CE57  4C 6D CD              JMP   L01_CD6D                     ;[x]

L01_CE5A:
  CE5A  BD 47 2F              LDA   $2F47,X                      ;[x]
  CE5D  D0 07                 BNE   L01_CE66                     ;[x]
  CE5F  BD AF 2F              LDA   $2FAF,X                      ;[x]
  CE62  C9 01                 CMP   #$01                         ;[x]
  CE64  D0 03                 BNE   L01_CE69                     ;[x]
L01_CE66:
  CE66  4C 30 CF              JMP   L01_CF30                     ;[x]

L01_CE69:
  CE69  A9 03                 LDA   #$03                         ;[x]
  CE6B  95 CC                 STA   <$CC,X                       ;[x]
  CE6D  20 33 CF              JSR   L01_CF33                     ;[x]
  CE70  9D 93 2D              STA   $2D93,X                      ;[x]
  CE73  C9 00                 CMP   #$00                         ;[x]
  CE75  F0 21                 BEQ   L01_CE98                     ;[x]
  CE77  3A                    DEC   A                            ;[x]
  CE78  A8                    TAY                                ;[x]
  CE79  A9 01                 LDA   #$01                         ;[x]
  CE7B  99 C8 2D              STA   $2DC8,Y                      ;[x]
  CE7E  B9 EE 2C              LDA   $2CEE,Y                      ;[x]
  CE81  9D 7F 39              STA   $397F,X                      ;[x]
  CE84  18                    CLC                                ;[x]
  CE85  69 30                 ADC   #$30                         ;[x]
  CE87  9D CB 37              STA   $37CB,X                      ;[x]
  CE8A  B9 A7 2B              LDA   $2BA7,Y                      ;[x]
  CE8D  9D EC 39              STA   $39EC,X                      ;[x]
  CE90  18                    CLC                                ;[x]
  CE91  69 0C                 ADC   #$0C                         ;[x]
  CE93  9D A5 38              STA   $38A5,X                      ;[x]
  CE96  80 18                 BRA   L01_CEB0                     ;[x]

L01_CE98:
  CE98  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CE9B  9D CB 37              STA   $37CB,X                      ;[x]
  CE9E  38                    SEC                                ;[x]
  CE9F  E9 30                 SBC   #$30                         ;[x]
  CEA1  9D 7F 39              STA   $397F,X                      ;[x]
  CEA4  BD 47 2B              LDA   $2B47,X                      ;[x]
  CEA7  9D EC 39              STA   $39EC,X                      ;[x]
  CEAA  18                    CLC                                ;[x]
  CEAB  69 0C                 ADC   #$0C                         ;[x]
  CEAD  9D A5 38              STA   $38A5,X                      ;[x]
L01_CEB0:
  CEB0  BD 31 CF              LDA   $CF31,X                      ;[x]
  CEB3  9D 17 36              STA   $3617,X                      ;[x]
  CEB6  FE 84 32              INC   $3284,X                      ;[x]
  CEB9  A9 18                 LDA   #$18                         ;[x]
  CEBB  20 FC E3              JSR   L00_E3FC                     ;[x]
  CEBE  A9 01                 LDA   #$01                         ;[x]
  CEC0  9D 47 2F              STA   $2F47,X                      ;[x]
  CEC3  9D B4 2F              STA   $2FB4,X                      ;[x]
  CEC6  A9 08                 LDA   #$08                         ;[x]
  CEC8  9D 84 36              STA   $3684,X                      ;[x]
  CECB  8F 0A 03              BBS0  <$0A,L01_CED1                ;[x]
  CECE  4C 30 CF              JMP   L01_CF30                     ;[x]

L01_CED1:
  CED1  A0 03                 LDY   #$03                         ;[ ]
L01_CED3:
  CED3  A9 08                 LDA   #$08                         ;[ ]
  CED5  99 85 36              STA   $3685,Y                      ;[ ]
  CED8  A9 01                 LDA   #$01                         ;[ ]
  CEDA  99 B5 2F              STA   $2FB5,Y                      ;[ ]
  CEDD  20 74 CF              JSR   L01_CF74                     ;[ ]
  CEE0  99 94 2D              STA   $2D94,Y                      ;[ ]
  CEE3  C9 00                 CMP   #$00                         ;[ ]
  CEE5  F0 23                 BEQ   L01_CF0A                     ;[ ]
  CEE7  3A                    DEC   A                            ;[ ]
  CEE8  DA                    PHX                                ;[ ]
  CEE9  AA                    TAX                                ;[ ]
  CEEA  A9 01                 LDA   #$01                         ;[ ]
  CEEC  9D C8 2D              STA   $2DC8,X                      ;[ ]
  CEEF  BD EE 2C              LDA   $2CEE,X                      ;[ ]
  CEF2  99 80 39              STA   $3980,Y                      ;[ ]
  CEF5  18                    CLC                                ;[ ]
  CEF6  69 30                 ADC   #$30                         ;[ ]
  CEF8  99 CC 37              STA   $37CC,Y                      ;[ ]
  CEFB  BD A7 2B              LDA   $2BA7,X                      ;[ ]
  CEFE  99 ED 39              STA   $39ED,Y                      ;[ ]
  CF01  18                    CLC                                ;[ ]
  CF02  69 0C                 ADC   #$0C                         ;[ ]
  CF04  99 A6 38              STA   $38A6,Y                      ;[ ]
  CF07  FA                    PLX                                ;[ ]
  CF08  80 18                 BRA   L01_CF22                     ;[ ]

L01_CF0A:
  CF0A  B9 90 2C              LDA   $2C90,Y                      ;[ ]
  CF0D  99 CC 37              STA   $37CC,Y                      ;[ ]
  CF10  38                    SEC                                ;[ ]
  CF11  E9 30                 SBC   #$30                         ;[ ]
  CF13  99 80 39              STA   $3980,Y                      ;[ ]
  CF16  B9 49 2B              LDA   $2B49,Y                      ;[ ]
  CF19  99 ED 39              STA   $39ED,Y                      ;[ ]
  CF1C  18                    CLC                                ;[ ]
  CF1D  69 0C                 ADC   #$0C                         ;[ ]
  CF1F  99 A6 38              STA   $38A6,Y                      ;[ ]
L01_CF22:
  CF22  BD 31 CF              LDA   $CF31,X                      ;[ ]
  CF25  99 18 36              STA   $3618,Y                      ;[ ]
  CF28  A9 01                 LDA   #$01                         ;[ ]
  CF2A  99 48 2F              STA   $2F48,Y                      ;[ ]
  CF2D  88                    DEY                                ;[ ]
  CF2E  D0 A3                 BNE   L01_CED3                     ;[ ]
L01_CF30:
  CF30  60                    RTS                                ;[x]

  CF31  .db $0B,$0C
L01_CF33:
  CF33  5A                    PHY                                ;[x]
  CF34  C2                    CLY                                ;[x]
L01_CF35:
  CF35  B9 C8 2D              LDA   $2DC8,Y                      ;[x]
  CF38  D0 11                 BNE   L01_CF4B                     ;[x]
  CF3A  B9 3A 2B              LDA   $2B3A,Y                      ;[x]
  CF3D  D0 0C                 BNE   L01_CF4B                     ;[x]
  CF3F  B9 81 2C              LDA   $2C81,Y                      ;[x]
  CF42  D0 07                 BNE   L01_CF4B                     ;[x]
  CF44  B9 51 33              LDA   $3351,Y                      ;[x]
  CF47  C9 81                 CMP   #$81                         ;[x]
  CF49  F0 08                 BEQ   L01_CF53                     ;[x]
L01_CF4B:
  CF4B  C8                    INY                                ;[x]
  CF4C  C0 08                 CPY   #$08                         ;[x]
  CF4E  90 E5                 BCC   L01_CF35                     ;[x]
  CF50  62                    CLA                                ;[x]
  CF51  7A                    PLY                                ;[x]
  CF52  60                    RTS                                ;[x]

L01_CF53:
  CF53  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  CF56  38                    SEC                                ;[x]
  CF57  F9 EE 2C              SBC   $2CEE,Y                      ;[x]
  CF5A  90 EF                 BCC   L01_CF4B                     ;[x]
  CF5C  C9 68                 CMP   #$68                         ;[x]
  CF5E  B0 EB                 BCS   L01_CF4B                     ;[x]
  CF60  BD 47 2B              LDA   $2B47,X                      ;[x]
  CF63  38                    SEC                                ;[x]
  CF64  F9 A7 2B              SBC   $2BA7,Y                      ;[x]
  CF67  B0 03                 BCS   L01_CF6C                     ;[x]
  CF69  49 FF                 EOR   #$FF                         ;[x]
  CF6B  1A                    INC   A                            ;[x]
L01_CF6C:
  CF6C  C9 20                 CMP   #$20                         ;[x]
  CF6E  B0 DB                 BCS   L01_CF4B                     ;[x]
  CF70  98                    TYA                                ;[x]
  CF71  1A                    INC   A                            ;[x]
  CF72  7A                    PLY                                ;[x]
  CF73  60                    RTS                                ;[x]

L01_CF74:
  CF74  DA                    PHX                                ;[ ]
  CF75  82                    CLX                                ;[ ]
L01_CF76:
  CF76  BD C8 2D              LDA   $2DC8,X                      ;[ ]
  CF79  D0 11                 BNE   L01_CF8C                     ;[ ]
  CF7B  BD 3A 2B              LDA   $2B3A,X                      ;[ ]
  CF7E  D0 0C                 BNE   L01_CF8C                     ;[ ]
  CF80  BD 81 2C              LDA   $2C81,X                      ;[ ]
  CF83  D0 07                 BNE   L01_CF8C                     ;[ ]
  CF85  BD 51 33              LDA   $3351,X                      ;[ ]
  CF88  C9 81                 CMP   #$81                         ;[ ]
  CF8A  F0 08                 BEQ   L01_CF94                     ;[ ]
L01_CF8C:
  CF8C  E8                    INX                                ;[ ]
  CF8D  E0 08                 CPX   #$08                         ;[ ]
  CF8F  90 E5                 BCC   L01_CF76                     ;[ ]
  CF91  62                    CLA                                ;[ ]
  CF92  FA                    PLX                                ;[ ]
  CF93  60                    RTS                                ;[ ]

L01_CF94:
  CF94  B9 90 2C              LDA   $2C90,Y                      ;[ ]
  CF97  38                    SEC                                ;[ ]
  CF98  FD EE 2C              SBC   $2CEE,X                      ;[ ]
  CF9B  90 EF                 BCC   L01_CF8C                     ;[ ]
  CF9D  C9 68                 CMP   #$68                         ;[ ]
  CF9F  B0 EB                 BCS   L01_CF8C                     ;[ ]
  CFA1  B9 49 2B              LDA   $2B49,Y                      ;[ ]
  CFA4  38                    SEC                                ;[ ]
  CFA5  FD A7 2B              SBC   $2BA7,X                      ;[ ]
  CFA8  B0 03                 BCS   L01_CFAD                     ;[ ]
  CFAA  49 FF                 EOR   #$FF                         ;[ ]
  CFAC  1A                    INC   A                            ;[ ]
L01_CFAD:
  CFAD  C9 20                 CMP   #$20                         ;[ ]
  CFAF  B0 DB                 BCS   L01_CF8C                     ;[ ]
  CFB1  8A                    TXA                                ;[ ]
  CFB2  1A                    INC   A                            ;[ ]
  CFB3  FA                    PLX                                ;[ ]
  CFB4  60                    RTS                                ;[ ]

L01_CFB5:
  CFB5  BD 9B 2F              LDA   $2F9B,X                      ;[x]
  CFB8  C9 03                 CMP   #$03                         ;[x]
  CFBA  F0 69                 BEQ   L01_D025                     ;[x]
  CFBC  BD 7A 38              LDA   $387A,X                      ;[x]
  CFBF  F0 0A                 BEQ   L01_CFCB                     ;[x]
  CFC1  A5 83                 LDA   <$83                         ;[x]
  CFC3  29 04                 AND   #$04                         ;[x]
  CFC5  F0 04                 BEQ   L01_CFCB                     ;[x]
  CFC7  B5 C8                 LDA   <$C8,X                       ;[x]
  CFC9  80 02                 BRA   L01_CFCD                     ;[x]

L01_CFCB:
  CFCB  B5 C6                 LDA   <$C6,X                       ;[x]
L01_CFCD:
  CFCD  18                    CLC                                ;[x]
  CFCE  75 CA                 ADC   <$CA,X                       ;[x]
  CFD0  75 CC                 ADC   <$CC,X                       ;[x]
  CFD2  A8                    TAY                                ;[x]
  CFD3  B9 F5 CF              LDA   $CFF5,Y                      ;[x]
  CFD6  9D 6D 2A              STA   $2A6D,X                      ;[x]
  CFD9  BD 0D 38              LDA   $380D,X                      ;[x]
  CFDC  F0 09                 BEQ   L01_CFE7                     ;[x]
  CFDE  A5 83                 LDA   <$83                         ;[x]
  CFE0  29 04                 AND   #$04                         ;[x]
  CFE2  D0 03                 BNE   L01_CFE7                     ;[x]
  CFE4  9E 6D 2A              STZ   $2A6D,X                      ;[x]
L01_CFE7:
  CFE7  BD 38 34              LDA   $3438,X                      ;[x]
  CFEA  29 01                 AND   #$01                         ;[x]
  CFEC  F0 06                 BEQ   L01_CFF4                     ;[x]
  CFEE  B9 0D D0              LDA   $D00D,Y                      ;[ ]
  CFF1  8D EF 35              STA   $35EF                        ;[ ]
L01_CFF4:
  CFF4  60                    RTS                                ;[x]

  CFF5  .db $01,$02,$03,$04,$05,$06,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F
  D005  .db $30,$31,$35,$36,$37,$32,$33,$34,$01,$01,$01,$03,$03,$03,$02,$02
  D015  .db $02,$06,$06,$06,$08,$08,$08,$04,$04,$04,$07,$07,$07,$05,$05,$05
L01_D025:
  D025  9E 42 2E              STZ   $2E42,X                      ;[ ]
  D028  62                    CLA                                ;[ ]
  D029  18                    CLC                                ;[ ]
  D02A  75 CA                 ADC   <$CA,X                       ;[ ]
  D02C  48                    PHA                                ;[ ]
  D02D  18                    CLC                                ;[ ]
  D02E  7D 45 D0              ADC   $D045,X                      ;[ ]
  D031  A8                    TAY                                ;[ ]
  D032  B9 3F D0              LDA   $D03F,Y                      ;[ ]
  D035  9D 6D 2A              STA   $2A6D,X                      ;[ ]
  D038  68                    PLA                                ;[ ]
  D039  18                    CLC                                ;[ ]
  D03A  69 12                 ADC   #$12                         ;[ ]
  D03C  A8                    TAY                                ;[ ]
  D03D  80 A8                 BRA   L01_CFE7                     ;[ ]

  D03F  .db $52,$53,$54,$55,$56,$57,$00,$03
L01_D047:
  D047  BD 38 34              LDA   $3438,X                      ;[x]
  D04A  85 0A                 STA   <$0A                         ;[x]
  D04C  8F 0A 03              BBS0  <$0A,L01_D052                ;[x]
  D04F  4C 89 D0              JMP   L01_D089                     ;[x]

L01_D052:
  D052  A0 17                 LDY   #$17                         ;[ ]
L01_D054:
  D054  B9 5F 3C              LDA   $3C5F,Y                      ;[ ]
  D057  99 60 3C              STA   $3C60,Y                      ;[ ]
  D05A  B9 8F 3C              LDA   $3C8F,Y                      ;[ ]
  D05D  99 90 3C              STA   $3C90,Y                      ;[ ]
  D060  88                    DEY                                ;[ ]
  D061  D0 F1                 BNE   L01_D054                     ;[ ]
  D063  A0 17                 LDY   #$17                         ;[ ]
  D065  DA                    PHX                                ;[ ]
  D066  A2 03                 LDX   #$03                         ;[ ]
L01_D068:
  D068  B9 90 3C              LDA   $3C90,Y                      ;[ ]
  D06B  9D 90 2C              STA   $2C90,X                      ;[ ]
  D06E  B9 60 3C              LDA   $3C60,Y                      ;[ ]
  D071  9D 49 2B              STA   $2B49,X                      ;[ ]
  D074  98                    TYA                                ;[ ]
  D075  38                    SEC                                ;[ ]
  D076  E9 08                 SBC   #$08                         ;[ ]
  D078  A8                    TAY                                ;[ ]
  D079  CA                    DEX                                ;[ ]
  D07A  D0 EC                 BNE   L01_D068                     ;[ ]
  D07C  FA                    PLX                                ;[ ]
  D07D  BD 47 2B              LDA   $2B47,X                      ;[ ]
  D080  8D 60 3C              STA   $3C60                        ;[ ]
  D083  BD 8E 2C              LDA   $2C8E,X                      ;[ ]
  D086  8D 90 3C              STA   $3C90                        ;[ ]
L01_D089:
  D089  9F 0A 03              BBS1  <$0A,L01_D08F                ;[x]
  D08C  4C C6 D0              JMP   L01_D0C6                     ;[x]

L01_D08F:
  D08F  A0 17                 LDY   #$17                         ;[ ]
L01_D091:
  D091  B9 BF 3C              LDA   $3CBF,Y                      ;[ ]
  D094  99 C0 3C              STA   $3CC0,Y                      ;[ ]
  D097  B9 EF 3C              LDA   $3CEF,Y                      ;[ ]
  D09A  99 F0 3C              STA   $3CF0,Y                      ;[ ]
  D09D  88                    DEY                                ;[ ]
  D09E  D0 F1                 BNE   L01_D091                     ;[ ]
  D0A0  A0 17                 LDY   #$17                         ;[ ]
  D0A2  DA                    PHX                                ;[ ]
  D0A3  A2 03                 LDX   #$03                         ;[ ]
L01_D0A5:
  D0A5  B9 F0 3C              LDA   $3CF0,Y                      ;[ ]
  D0A8  9D 93 2C              STA   $2C93,X                      ;[ ]
  D0AB  B9 C0 3C              LDA   $3CC0,Y                      ;[ ]
  D0AE  9D 4C 2B              STA   $2B4C,X                      ;[ ]
  D0B1  98                    TYA                                ;[ ]
  D0B2  38                    SEC                                ;[ ]
  D0B3  E9 08                 SBC   #$08                         ;[ ]
  D0B5  A8                    TAY                                ;[ ]
  D0B6  CA                    DEX                                ;[ ]
  D0B7  D0 EC                 BNE   L01_D0A5                     ;[ ]
  D0B9  FA                    PLX                                ;[ ]
  D0BA  BD 47 2B              LDA   $2B47,X                      ;[ ]
  D0BD  8D C0 3C              STA   $3CC0                        ;[ ]
  D0C0  BD 8E 2C              LDA   $2C8E,X                      ;[ ]
  D0C3  8D F0 3C              STA   $3CF0                        ;[ ]
L01_D0C6:
  D0C6  60                    RTS                                ;[x]

  D0C7  A2 12                 LDX   #$12                         ;[x]
L01_D0C9:
  D0C9  BD 9C 2F              LDA   $2F9C,X                      ;[x]
  D0CC  F0 34                 BEQ   L01_D102                     ;[x]
  D0CE  3A                    DEC   A                            ;[x]
  D0CF  F0 05                 BEQ   L01_D0D6                     ;[x]
  D0D1  3A                    DEC   A                            ;[x]
  D0D2  F0 3A                 BEQ   L01_D10E                     ;[x]
  D0D4  80 30                 BRA   L01_D106                     ;[x]

L01_D0D6:
  D0D6  BD 50 31              LDA   $3150,X                      ;[x]
  D0D9  F0 1A                 BEQ   L01_D0F5                     ;[x]
  D0DB  30 08                 BMI   L01_D0E5                     ;[ ]
  D0DD  18                    CLC                                ;[ ]
  D0DE  7D 5A 2B              ADC   $2B5A,X                      ;[ ]
  D0E1  B0 1A                 BCS   L01_D0FD                     ;[ ]
  D0E3  80 0D                 BRA   L01_D0F2                     ;[ ]

L01_D0E5:
  D0E5  49 FF                 EOR   #$FF                         ;[ ]
  D0E7  1A                    INC   A                            ;[ ]
  D0E8  85 17                 STA   <$17                         ;[ ]
  D0EA  BD 5A 2B              LDA   $2B5A,X                      ;[ ]
  D0ED  38                    SEC                                ;[ ]
  D0EE  E5 17                 SBC   <$17                         ;[ ]
  D0F0  90 0B                 BCC   L01_D0FD                     ;[ ]
L01_D0F2:
  D0F2  9D 5A 2B              STA   $2B5A,X                      ;[ ]
L01_D0F5:
  D0F5  BD A1 2C              LDA   $2CA1,X                      ;[x]
  D0F8  38                    SEC                                ;[x]
  D0F9  E9 06                 SBC   #$06                         ;[x]
  D0FB  B0 02                 BCS   L01_D0FF                     ;[x]
L01_D0FD:
  D0FD  80 07                 BRA   L01_D106                     ;[x]

L01_D0FF:
  D0FF  9D A1 2C              STA   $2CA1,X                      ;[x]
L01_D102:
  D102  CA                    DEX                                ;[x]
  D103  D0 C4                 BNE   L01_D0C9                     ;[x]
  D105  60                    RTS                                ;[x]

L01_D106:
  D106  9E 80 2A              STZ   $2A80,X                      ;[x]
  D109  9E 9C 2F              STZ   $2F9C,X                      ;[x]
  D10C  80 F4                 BRA   L01_D102                     ;[x]

L01_D10E:
  D10E  A9 13                 LDA   #$13                         ;[x]
  D110  9D 80 2A              STA   $2A80,X                      ;[x]
  D113  FE 9C 2F              INC   $2F9C,X                      ;[x]
  D116  80 EA                 BRA   L01_D102                     ;[x]

  D118  A2 04                 LDX   #$04                         ;[x]
L01_D11A:
  D11A  BD AF 2F              LDA   $2FAF,X                      ;[x]
  D11D  F0 54                 BEQ   L01_D173                     ;[x]
  D11F  3A                    DEC   A                            ;[x]
  D120  F0 05                 BEQ   L01_D127                     ;[x]
  D122  3A                    DEC   A                            ;[x]
  D123  F0 14                 BEQ   L01_D139                     ;[x]
  D125  80 4C                 BRA   L01_D173                     ;[ ]

L01_D127:
  D127  DE 7F 36              DEC   $367F,X                      ;[x]
  D12A  D0 0A                 BNE   L01_D136                     ;[x]
  D12C  FE AF 2F              INC   $2FAF,X                      ;[x]
  D12F  A9 10                 LDA   #$10                         ;[x]
  D131  9D 7F 36              STA   $367F,X                      ;[x]
  D134  74 CC                 STZ   <$CC,X                       ;[x]
L01_D136:
  D136  4C 73 D1              JMP   L01_D173                     ;[x]

L01_D139:
  D139  BD C6 37              LDA   $37C6,X                      ;[x]
  D13C  38                    SEC                                ;[x]
  D13D  E9 03                 SBC   #$03                         ;[x]
  D13F  18                    CLC                                ;[x]
  D140  6D 77 3B              ADC   $3B77                        ;[x]
  D143  9D C6 37              STA   $37C6,X                      ;[x]
  D146  BC 7F 36              LDY   $367F,X                      ;[x]
  D149  BD A0 38              LDA   $38A0,X                      ;[x]
  D14C  18                    CLC                                ;[x]
  D14D  79 D6 D1              ADC   $D1D6,Y                      ;[x]
  D150  38                    SEC                                ;[x]
  D151  ED 6F 3B              SBC   $3B6F                        ;[x]
  D154  9D A0 38              STA   $38A0,X                      ;[x]
  D157  BD 7A 39              LDA   $397A,X                      ;[x]
  D15A  18                    CLC                                ;[x]
  D15B  6D 77 3B              ADC   $3B77                        ;[x]
  D15E  9D 7A 39              STA   $397A,X                      ;[x]
  D161  BD E7 39              LDA   $39E7,X                      ;[x]
  D164  38                    SEC                                ;[x]
  D165  ED 6F 3B              SBC   $3B6F                        ;[x]
  D168  9D E7 39              STA   $39E7,X                      ;[x]
  D16B  DE 7F 36              DEC   $367F,X                      ;[x]
  D16E  D0 03                 BNE   L01_D173                     ;[x]
  D170  FE AF 2F              INC   $2FAF,X                      ;[x]
L01_D173:
  D173  BD B4 2F              LDA   $2FB4,X                      ;[x]
  D176  F0 57                 BEQ   L01_D1CF                     ;[x]
  D178  3A                    DEC   A                            ;[x]
  D179  F0 05                 BEQ   L01_D180                     ;[x]
  D17B  3A                    DEC   A                            ;[x]
  D17C  F0 14                 BEQ   L01_D192                     ;[x]
  D17E  80 4C                 BRA   L01_D1CC                     ;[x]

L01_D180:
  D180  DE 84 36              DEC   $3684,X                      ;[x]
  D183  D0 0A                 BNE   L01_D18F                     ;[x]
  D185  FE B4 2F              INC   $2FB4,X                      ;[x]
  D188  A9 10                 LDA   #$10                         ;[x]
  D18A  9D 84 36              STA   $3684,X                      ;[x]
  D18D  74 CC                 STZ   <$CC,X                       ;[x]
L01_D18F:
  D18F  4C CF D1              JMP   L01_D1CF                     ;[x]

L01_D192:
  D192  BD CB 37              LDA   $37CB,X                      ;[x]
  D195  38                    SEC                                ;[x]
  D196  E9 03                 SBC   #$03                         ;[x]
  D198  18                    CLC                                ;[x]
  D199  6D 77 3B              ADC   $3B77                        ;[x]
  D19C  9D CB 37              STA   $37CB,X                      ;[x]
  D19F  BC 84 36              LDY   $3684,X                      ;[x]
  D1A2  BD A5 38              LDA   $38A5,X                      ;[x]
  D1A5  38                    SEC                                ;[x]
  D1A6  F9 D6 D1              SBC   $D1D6,Y                      ;[x]
  D1A9  38                    SEC                                ;[x]
  D1AA  ED 6F 3B              SBC   $3B6F                        ;[x]
  D1AD  9D A5 38              STA   $38A5,X                      ;[x]
  D1B0  BD 7F 39              LDA   $397F,X                      ;[x]
  D1B3  18                    CLC                                ;[x]
  D1B4  6D 77 3B              ADC   $3B77                        ;[x]
  D1B7  9D 7F 39              STA   $397F,X                      ;[x]
  D1BA  BD EC 39              LDA   $39EC,X                      ;[x]
  D1BD  38                    SEC                                ;[x]
  D1BE  ED 6F 3B              SBC   $3B6F                        ;[x]
  D1C1  9D EC 39              STA   $39EC,X                      ;[x]
  D1C4  DE 84 36              DEC   $3684,X                      ;[x]
  D1C7  D0 03                 BNE   L01_D1CC                     ;[x]
  D1C9  FE B4 2F              INC   $2FB4,X                      ;[x]
L01_D1CC:
  D1CC  4C CF D1              JMP   L01_D1CF                     ;[x]

L01_D1CF:
  D1CF  CA                    DEX                                ;[x]
  D1D0  30 03                 BMI   L01_D1D5                     ;[x]
  D1D2  4C 1A D1              JMP   L01_D11A                     ;[x]

L01_D1D5:
  D1D5  60                    RTS                                ;[x]

  D1D6  .db $00,$02,$01,$02,$01,$02,$01,$02,$01,$00,$00,$00,$00,$00,$00,$00
  D1E6  .db $00
L01_D1E7:
  D1E7  A2 0A                 LDX   #$0A                         ;[x]
L01_D1E9:
  D1E9  BD 41 2F              LDA   $2F41,X                      ;[x]
  D1EC  D0 05                 BNE   L01_D1F3                     ;[x]
  D1EE  9E 92 2A              STZ   $2A92,X                      ;[x]
  D1F1  80 2E                 BRA   L01_D221                     ;[x]

L01_D1F3:
  D1F3  0F 32 17              BBR0  <$32,L01_D20D                ;[x]
  D1F6  BD C5 37              LDA   $37C5,X                      ;[x]
  D1F9  9D B3 2C              STA   $2CB3,X                      ;[x]
  D1FC  BD 9F 38              LDA   $389F,X                      ;[x]
  D1FF  9D 6C 2B              STA   $2B6C,X                      ;[x]
  D202  9E 25 2A              STZ   $2A25,X                      ;[x]
  D205  BD 11 36              LDA   $3611,X                      ;[x]
  D208  9D 92 2A              STA   $2A92,X                      ;[x]
  D20B  80 14                 BRA   L01_D221                     ;[x]

L01_D20D:
  D20D  BD 79 39              LDA   $3979,X                      ;[x]
  D210  9D B3 2C              STA   $2CB3,X                      ;[x]
  D213  BD E6 39              LDA   $39E6,X                      ;[x]
  D216  9D 6C 2B              STA   $2B6C,X                      ;[x]
  D219  9E 25 2A              STZ   $2A25,X                      ;[x]
  D21C  A9 0D                 LDA   #$0D                         ;[x]
  D21E  9D 92 2A              STA   $2A92,X                      ;[x]
L01_D221:
  D221  CA                    DEX                                ;[x]
  D222  D0 C5                 BNE   L01_D1E9                     ;[x]
  D224  60                    RTS                                ;[x]

  D225  A2 01                 LDX   #$01                         ;[x]
L01_D227:
  D227  BD 27 2F              LDA   $2F27,X                      ;[x]
  D22A  A8                    TAY                                ;[x]
  D22B  F0 2A                 BEQ   L01_D257                     ;[x]
  D22D  A5 83                 LDA   <$83                         ;[x]
  D22F  29 08                 AND   #$08                         ;[x]
  D231  D0 09                 BNE   L01_D23C                     ;[x]
  D233  BD 4D 2E              LDA   $2E4D,X                      ;[x]
  D236  1A                    INC   A                            ;[x]
  D237  29 C1                 AND   #$C1                         ;[x]
  D239  9D 4D 2E              STA   $2E4D,X                      ;[x]
L01_D23C:
  D23C  BD 99 2C              LDA   $2C99,X                      ;[x]
  D23F  38                    SEC                                ;[x]
  D240  E9 06                 SBC   #$06                         ;[x]
  D242  9D 99 2C              STA   $2C99,X                      ;[x]
  D245  85 00                 STA   <$00                         ;[x]
  D247  B0 03                 BCS   L01_D24C                     ;[x]
  D249  DE 2C 2C              DEC   $2C2C,X                      ;[x]
L01_D24C:
  D24C  BD 2C 2C              LDA   $2C2C,X                      ;[x]
  D24F  85 01                 STA   <$01                         ;[x]
  D251  C0 01                 CPY   #$01                         ;[x]
  D253  F0 06                 BEQ   L01_D25B                     ;[x]
  D255  80 11                 BRA   L01_D268                     ;[x]

L01_D257:
  D257  CA                    DEX                                ;[x]
  D258  10 CD                 BPL   L01_D227                     ;[x]
  D25A  60                    RTS                                ;[x]

L01_D25B:
  D25B  A9 10                 LDA   #$10                         ;[x]
  D25D  18                    CLC                                ;[x]
  D25E  65 00                 ADC   <$00                         ;[x]
  D260  85 00                 STA   <$00                         ;[x]
  D262  90 0F                 BCC   L01_D273                     ;[x]
  D264  E6 01                 INC   <$01                         ;[x]
  D266  80 0B                 BRA   L01_D273                     ;[x]

L01_D268:
  D268  A9 20                 LDA   #$20                         ;[x]
  D26A  18                    CLC                                ;[x]
  D26B  65 00                 ADC   <$00                         ;[x]
  D26D  85 00                 STA   <$00                         ;[x]
  D26F  90 02                 BCC   L01_D273                     ;[x]
  D271  E6 01                 INC   <$01                         ;[x]
L01_D273:
  D273  A5 01                 LDA   <$01                         ;[x]
  D275  C9 FF                 CMP   #$FF                         ;[x]
  D277  90 DE                 BCC   L01_D257                     ;[x]
  D279  9E 27 2F              STZ   $2F27,X                      ;[x]
  D27C  9E 78 2A              STZ   $2A78,X                      ;[x]
  D27F  80 D6                 BRA   L01_D257                     ;[x]

  D281  20 99 E7              JSR   L00_E799                     ;[x]
  D284  8F 32 04              BBS0  <$32,L01_D28B                ;[x]
  D287  A2 00                 LDX   #$00                         ;[x]
  D289  80 02                 BRA   L01_D28D                     ;[x]

L01_D28B:
  D28B  A2 01                 LDX   #$01                         ;[x]
L01_D28D:
  D28D  BD 89 2F              LDA   $2F89,X                      ;[x]
  D290  C9 06                 CMP   #$06                         ;[x]
  D292  90 03                 BCC   L01_D297                     ;[x]
  D294  4C 3F D3              JMP   L01_D33F                     ;[x]

L01_D297:
  D297  B5 A6                 LDA   <$A6,X                       ;[x]
  D299  4A                    LSR   A                            ;[x]
  D29A  85 00                 STA   <$00                         ;[x]
  D29C  4A                    LSR   A                            ;[x]
  D29D  4A                    LSR   A                            ;[x]
  D29E  85 01                 STA   <$01                         ;[x]
  D2A0  20 8D E7              JSR   L00_E78D                     ;[x]
  D2A3  BD 34 D3              LDA   $D334,X                      ;[x]
  D2A6  18                    CLC                                ;[x]
  D2A7  6D C8 3D              ADC   $3DC8                        ;[x]
  D2AA  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D2AD  62                    CLA                                ;[x]
  D2AE  6D C9 3D              ADC   $3DC9                        ;[x]
  D2B1  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D2B4  20 85 E7              JSR   L00_E785                     ;[x]
  D2B7  A9 37                 LDA   #$37                         ;[x]
  D2B9  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D2BC  A4 01                 LDY   <$01                         ;[x]
  D2BE  C0 05                 CPY   #$05                         ;[x]
  D2C0  D0 0E                 BNE   L01_D2D0                     ;[x]
  D2C2  9F 32 0B              BBS1  <$32,L01_D2D0                ;[x]
  D2C5  A9 11                 LDA   #$11                         ;[x]
  D2C7  85 03                 STA   <$03                         ;[x]
  D2C9  85 02                 STA   <$02                         ;[x]
  D2CB  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D2CE  80 45                 BRA   L01_D315                     ;[x]

L01_D2D0:
  D2D0  BD 36 D3              LDA   $D336,X                      ;[x]
  D2D3  85 02                 STA   <$02                         ;[x]
  D2D5  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D2D8  A9 01                 LDA   #$01                         ;[x]
  D2DA  85 03                 STA   <$03                         ;[x]
  D2DC  A4 01                 LDY   <$01                         ;[x]
  D2DE  F0 0D                 BEQ   L01_D2ED                     ;[x]
L01_D2E0:
  D2E0  A9 3C                 LDA   #$3C                         ;[x]
  D2E2  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D2E5  A5 02                 LDA   <$02                         ;[x]
  D2E7  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D2EA  88                    DEY                                ;[x]
  D2EB  D0 F3                 BNE   L01_D2E0                     ;[x]
L01_D2ED:
  D2ED  A5 00                 LDA   <$00                         ;[x]
  D2EF  C9 14                 CMP   #$14                         ;[x]
  D2F1  F0 2F                 BEQ   L01_D322                     ;[x]
  D2F3  29 03                 AND   #$03                         ;[x]
  D2F5  A8                    TAY                                ;[x]
  D2F6  B9 38 D3              LDA   $D338,Y                      ;[x]
  D2F9  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D2FC  A5 02                 LDA   <$02                         ;[x]
  D2FE  C0 00                 CPY   #$00                         ;[x]
  D300  F0 04                 BEQ   L01_D306                     ;[x]
  D302  A5 02                 LDA   <$02                         ;[x]
  D304  80 02                 BRA   L01_D308                     ;[x]

L01_D306:
  D306  A5 03                 LDA   <$03                         ;[x]
L01_D308:
  D308  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D30B  A9 04                 LDA   #$04                         ;[x]
  D30D  38                    SEC                                ;[x]
  D30E  E5 01                 SBC   <$01                         ;[x]
  D310  F0 10                 BEQ   L01_D322                     ;[x]
  D312  30 0E                 BMI   L01_D322                     ;[x]
  D314  A8                    TAY                                ;[x]
L01_D315:
  D315  A9 38                 LDA   #$38                         ;[x]
  D317  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D31A  A5 03                 LDA   <$03                         ;[x]
  D31C  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D31F  88                    DEY                                ;[x]
  D320  D0 F3                 BNE   L01_D315                     ;[x]
L01_D322:
  D322  C2                    CLY                                ;[x]
L01_D323:
  D323  B9 3C D3              LDA   $D33C,Y                      ;[x]
  D326  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D329  A5 02                 LDA   <$02                         ;[x]
  D32B  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D32E  C8                    INY                                ;[x]
  D32F  C0 03                 CPY   #$03                         ;[x]
  D331  90 F0                 BCC   L01_D323                     ;[x]
  D333  60                    RTS                                ;[x]

  D334  .db $07,$16,$01,$11,$38,$39,$3A,$3B,$3D,$3E,$3E
L01_D33F:
  D33F  48                    PHA                                ;[x]
  D340  20 8D E7              JSR   L00_E78D                     ;[x]
  D343  BD AD D3              LDA   $D3AD,X                      ;[x]
  D346  18                    CLC                                ;[x]
  D347  6D C8 3D              ADC   $3DC8                        ;[x]
  D34A  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D34D  62                    CLA                                ;[x]
  D34E  6D C9 3D              ADC   $3DC9                        ;[x]
  D351  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D354  20 85 E7              JSR   L00_E785                     ;[x]
  D357  68                    PLA                                ;[x]
  D358  E0 00                 CPX   #$00                         ;[x]
  D35A  F0 05                 BEQ   L01_D361                     ;[x]
  D35C  AC 3A 3F              LDY   $3F3A                        ;[x]
  D35F  F0 3A                 BEQ   L01_D39B                     ;[x]
L01_D361:
  D361  C9 06                 CMP   #$06                         ;[x]
  D363  D0 24                 BNE   L01_D389                     ;[x]
  D365  C2                    CLY                                ;[x]
L01_D366:
  D366  B9 AF D3              LDA   $D3AF,Y                      ;[x]
  D369  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D36C  A9 01                 LDA   #$01                         ;[x]
  D36E  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D371  C8                    INY                                ;[x]
  D372  C0 09                 CPY   #$09                         ;[x]
  D374  90 F0                 BCC   L01_D366                     ;[x]
  D376  BD 59 36              LDA   $3659,X                      ;[x]
  D379  18                    CLC                                ;[x]
  D37A  69 11                 ADC   #$11                         ;[x]
  D37C  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D37F  A9 01                 LDA   #$01                         ;[x]
  D381  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D384  13 3E                 ST1   #$3E                         ;[x]
  D386  23 01                 ST2   #$01                         ;[x]
  D388  60                    RTS                                ;[x]

L01_D389:
  D389  C2                    CLY                                ;[ ]
L01_D38A:
  D38A  B9 B8 D3              LDA   $D3B8,Y                      ;[ ]
  D38D  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  D390  A9 01                 LDA   #$01                         ;[ ]
  D392  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  D395  C8                    INY                                ;[ ]
  D396  C0 0B                 CPY   #$0B                         ;[ ]
  D398  90 F0                 BCC   L01_D38A                     ;[ ]
  D39A  60                    RTS                                ;[ ]

L01_D39B:
  D39B  C2                    CLY                                ;[x]
L01_D39C:
  D39C  B9 C3 D3              LDA   $D3C3,Y                      ;[x]
  D39F  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D3A2  A9 01                 LDA   #$01                         ;[x]
  D3A4  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D3A7  C8                    INY                                ;[x]
  D3A8  C0 0B                 CPY   #$0B                         ;[x]
  D3AA  90 F0                 BCC   L01_D39C                     ;[x]
  D3AC  60                    RTS                                ;[x]

  D3AD  .db $04,$13,$1D,$29,$28,$2E,$23,$28,$2F,$1F,$3E,$21,$1B,$27,$1F,$3E
  D3BD  .db $29,$30,$1F,$2C,$3E,$3E,$2A,$2C,$1F,$2D,$2D,$3E,$2C,$2F,$28,$3E
  D3CD  .db $3E
L01_D3CE:
  D3CE  A2 04                 LDX   #$04                         ;[x]
L01_D3D0:
  D3D0  BD 29 2F              LDA   $2F29,X                      ;[x]
  D3D3  F0 2E                 BEQ   L01_D403                     ;[x]
  D3D5  BD 08 2D              LDA   $2D08,X                      ;[ ]
  D3D8  18                    CLC                                ;[ ]
  D3D9  7D B7 31              ADC   $31B7,X                      ;[ ]
  D3DC  9D 08 2D              STA   $2D08,X                      ;[ ]
  D3DF  BD 9B 2C              LDA   $2C9B,X                      ;[ ]
  D3E2  7D 4A 31              ADC   $314A,X                      ;[ ]
  D3E5  C9 F8                 CMP   #$F8                         ;[ ]
  D3E7  B0 1E                 BCS   L01_D407                     ;[ ]
  D3E9  9D 9B 2C              STA   $2C9B,X                      ;[ ]
  D3EC  BD C1 2B              LDA   $2BC1,X                      ;[ ]
  D3EF  18                    CLC                                ;[ ]
  D3F0  7D DD 30              ADC   $30DD,X                      ;[ ]
  D3F3  9D C1 2B              STA   $2BC1,X                      ;[ ]
  D3F6  BD 54 2B              LDA   $2B54,X                      ;[ ]
  D3F9  7D 70 30              ADC   $3070,X                      ;[ ]
  D3FC  C9 F8                 CMP   #$F8                         ;[ ]
  D3FE  B0 07                 BCS   L01_D407                     ;[ ]
  D400  9D 54 2B              STA   $2B54,X                      ;[ ]
L01_D403:
  D403  CA                    DEX                                ;[x]
  D404  10 CA                 BPL   L01_D3D0                     ;[x]
  D406  60                    RTS                                ;[x]

L01_D407:
  D407  9E 29 2F              STZ   $2F29,X                      ;[ ]
  D40A  9E 7A 2A              STZ   $2A7A,X                      ;[ ]
  D40D  80 F4                 BRA   L01_D403                     ;[ ]

  D40F  BD 38 34              LDA   $3438,X                      ;[x]
  D412  85 0A                 STA   <$0A                         ;[x]
  D414  10 0C                 BPL   L01_D422                     ;[x]
  D416  9E 25 2F              STZ   $2F25,X                      ;[ ]
  D419  9E AE 34              STZ   $34AE,X                      ;[ ]
  D41C  9E F5 35              STZ   $35F5,X                      ;[ ]
  D41F  9E 76 2A              STZ   $2A76,X                      ;[ ]
L01_D422:
  D422  0F 0A 12              BBR0  <$0A,L01_D437                ;[x]
  D425  A5 A0                 LDA   <$A0                         ;[ ]
  D427  29 FE                 AND   #$FE                         ;[ ]
  D429  85 A0                 STA   <$A0                         ;[ ]
  D42B  62                    CLA                                ;[ ]
  D42C  A0 02                 LDY   #$02                         ;[ ]
L01_D42E:
  D42E  99 1F 2F              STA   $2F1F,Y                      ;[ ]
  D431  99 70 2A              STA   $2A70,Y                      ;[ ]
  D434  88                    DEY                                ;[ ]
  D435  10 F7                 BPL   L01_D42E                     ;[ ]
L01_D437:
  D437  1F 0A 12              BBR1  <$0A,L01_D44C                ;[x]
  D43A  A5 A0                 LDA   <$A0                         ;[ ]
  D43C  29 FD                 AND   #$FD                         ;[ ]
  D43E  85 A0                 STA   <$A0                         ;[ ]
  D440  62                    CLA                                ;[ ]
  D441  A0 02                 LDY   #$02                         ;[ ]
L01_D443:
  D443  99 22 2F              STA   $2F22,Y                      ;[ ]
  D446  99 73 2A              STA   $2A73,Y                      ;[ ]
  D449  88                    DEY                                ;[ ]
  D44A  10 F7                 BPL   L01_D443                     ;[ ]
L01_D44C:
  D44C  4F 0A 28              BBR4  <$0A,L01_D477                ;[x]
  D44F  A9 03                 LDA   #$03                         ;[ ]
  D451  8D 8B 2F              STA   $2F8B                        ;[ ]
  D454  AD 90 2C              LDA   $2C90                        ;[ ]
  D457  18                    CLC                                ;[ ]
  D458  69 10                 ADC   #$10                         ;[ ]
  D45A  8D AC 31              STA   $31AC                        ;[ ]
  D45D  AD 23 2C              LDA   $2C23                        ;[ ]
  D460  8D 3F 31              STA   $313F                        ;[ ]
  D463  AD 49 2B              LDA   $2B49                        ;[ ]
  D466  8D D2 30              STA   $30D2                        ;[ ]
  D469  AD DC 2A              LDA   $2ADC                        ;[ ]
  D46C  8D 65 30              STA   $3065                        ;[ ]
  D46F  9C C8 36              STZ   $36C8                        ;[ ]
  D472  A9 07                 LDA   #$07                         ;[ ]
  D474  8D 6F 2A              STA   $2A6F                        ;[ ]
L01_D477:
  D477  BD 9B 2F              LDA   $2F9B,X                      ;[x]
  D47A  F0 07                 BEQ   L01_D483                     ;[x]
  D47C  A9 04                 LDA   #$04                         ;[x]
  D47E  9D 9B 2F              STA   $2F9B,X                      ;[x]
  D481  74 A9                 STZ   <$A9,X                       ;[x]
L01_D483:
  D483  9E 38 34              STZ   $3438,X                      ;[x]
  D486  9E E0 3E              STZ   $3EE0,X                      ;[x]
  D489  9E 42 2E              STZ   $2E42,X                      ;[x]
  D48C  9E 7A 38              STZ   $387A,X                      ;[x]
  D48F  9E E7 38              STZ   $38E7,X                      ;[x]
  D492  9E C1 39              STZ   $39C1,X                      ;[x]
  D495  74 A6                 STZ   <$A6,X                       ;[x]
  D497  BD 27 2F              LDA   $2F27,X                      ;[x]
  D49A  D0 03                 BNE   L01_D49F                     ;[x]
  D49C  9E 78 2A              STZ   $2A78,X                      ;[x]
L01_D49F:
  D49F  A9 04                 LDA   #$04                         ;[x]
  D4A1  9D EA 3E              STA   $3EEA,X                      ;[x]
  D4A4  9D 54 39              STA   $3954,X                      ;[x]
  D4A7  A5 86                 LDA   <$86                         ;[x]
  D4A9  3D C4 D4              AND   $D4C4,X                      ;[x]
  D4AC  85 86                 STA   <$86                         ;[x]
  D4AE  A9 45                 LDA   #$45                         ;[x]
  D4B0  9D 6D 2A              STA   $2A6D,X                      ;[x]
  D4B3  A9 06                 LDA   #$06                         ;[x]
  D4B5  9D 59 36              STA   $3659,X                      ;[x]
  D4B8  A9 2F                 LDA   #$2F                         ;[x]
  D4BA  20 FC E3              JSR   L00_E3FC                     ;[x]
  D4BD  20 D8 FE              JSR   L00_FED8                     ;[x]
  D4C0  FE 89 2F              INC   $2F89,X                      ;[x]
  D4C3  60                    RTS                                ;[x]

  D4C4  .db $FE,$FD
L01_D4C6:
  D4C6  DE 59 36              DEC   $3659,X                      ;[x]
  D4C9  D0 10                 BNE   L01_D4DB                     ;[x]
  D4CB  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  D4CE  1A                    INC   A                            ;[x]
  D4CF  9D 6D 2A              STA   $2A6D,X                      ;[x]
  D4D2  C9 49                 CMP   #$49                         ;[x]
  D4D4  B0 06                 BCS   L01_D4DC                     ;[x]
  D4D6  A9 06                 LDA   #$06                         ;[x]
  D4D8  9D 59 36              STA   $3659,X                      ;[x]
L01_D4DB:
  D4DB  60                    RTS                                ;[x]

L01_D4DC:
  D4DC  8A                    TXA                                ;[x]
  D4DD  09 80                 ORA   #$80                         ;[x]
  D4DF  9D 42 2E              STA   $2E42,X                      ;[x]
  D4E2  F8                    SED                                ;[x]
  D4E3  B5 87                 LDA   <$87,X                       ;[x]
  D4E5  38                    SEC                                ;[x]
  D4E6  E9 01                 SBC   #$01                         ;[x]
  D4E8  95 87                 STA   <$87,X                       ;[x]
  D4EA  D8                    CLD                                ;[x]
  D4EB  B0 04                 BCS   L01_D4F1                     ;[x]
  D4ED  A9 FF                 LDA   #$FF                         ;[x]
  D4EF  95 87                 STA   <$87,X                       ;[x]
L01_D4F1:
  D4F1  A9 33                 LDA   #$33                         ;[x]
  D4F3  9D C6 36              STA   $36C6,X                      ;[x]
  D4F6  BD 00 D5              LDA   $D500,X                      ;[x]
  D4F9  20 FC E3              JSR   L00_E3FC                     ;[x]
  D4FC  FE 89 2F              INC   $2F89,X                      ;[x]
  D4FF  60                    RTS                                ;[x]

  D500  .db $05,$06
L01_D502:
  D502  DE C6 36              DEC   $36C6,X                      ;[x]
  D505  A5 83                 LDA   <$83                         ;[x]
  D507  29 01                 AND   #$01                         ;[x]
  D509  D0 0D                 BNE   L01_D518                     ;[x]
  D50B  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  D50E  1A                    INC   A                            ;[x]
  D50F  C9 51                 CMP   #$51                         ;[x]
  D511  90 02                 BCC   L01_D515                     ;[x]
  D513  A9 49                 LDA   #$49                         ;[x]
L01_D515:
  D515  9D 6D 2A              STA   $2A6D,X                      ;[x]
L01_D518:
  D518  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  D51B  18                    CLC                                ;[x]
  D51C  69 03                 ADC   #$03                         ;[x]
  D51E  C9 F8                 CMP   #$F8                         ;[x]
  D520  B0 05                 BCS   L01_D527                     ;[x]
  D522  9D 8E 2C              STA   $2C8E,X                      ;[x]
  D525  80 B4                 BRA   L01_D4DB                     ;[x]

L01_D527:
  D527  BD C6 36              LDA   $36C6,X                      ;[x]
  D52A  10 AF                 BPL   L01_D4DB                     ;[x]
  D52C  A5 35                 LDA   <$35                         ;[x]
  D52E  D0 22                 BNE   L01_D552                     ;[x]
  D530  B5 87                 LDA   <$87,X                       ;[x]
  D532  C9 9A                 CMP   #$9A                         ;[x]
  D534  B0 04                 BCS   L01_D53A                     ;[x]
  D536  9E 89 2F              STZ   $2F89,X                      ;[x]
  D539  60                    RTS                                ;[x]

L01_D53A:
  D53A  BD 38 3F              LDA   $3F38,X                      ;[x]
  D53D  F0 20                 BEQ   L01_D55F                     ;[x]
  D53F  A9 06                 LDA   #$06                         ;[x]
  D541  9D 89 2F              STA   $2F89,X                      ;[x]
  D544  9D E6 3E              STA   $3EE6,X                      ;[x]
  D547  A9 3C                 LDA   #$3C                         ;[x]
  D549  9D C6 36              STA   $36C6,X                      ;[x]
  D54C  A9 09                 LDA   #$09                         ;[x]
  D54E  9D 59 36              STA   $3659,X                      ;[x]
  D551  60                    RTS                                ;[x]

L01_D552:
  D552  A9 07                 LDA   #$07                         ;[ ]
  D554  9D 89 2F              STA   $2F89,X                      ;[ ]
  D557  9D E6 3E              STA   $3EE6,X                      ;[ ]
  D55A  A9 01                 LDA   #$01                         ;[ ]
  D55C  85 37                 STA   <$37                         ;[ ]
  D55E  60                    RTS                                ;[ ]

L01_D55F:
  D55F  A9 07                 LDA   #$07                         ;[ ]
  D561  9D 89 2F              STA   $2F89,X                      ;[ ]
  D564  9D E6 3E              STA   $3EE6,X                      ;[ ]
  D567  60                    RTS                                ;[ ]

  D568  8A                    TXA                                ;[x]
  D569  F0 05                 BEQ   L01_D570                     ;[x]
  D56B  AD 3A 3F              LDA   $3F3A                        ;[x]
  D56E  F0 18                 BEQ   L01_D588                     ;[x]
L01_D570:
  D570  BD 38 3F              LDA   $3F38,X                      ;[x]
  D573  F0 EA                 BEQ   L01_D55F                     ;[x]
  D575  DE C6 36              DEC   $36C6,X                      ;[x]
  D578  D0 0E                 BNE   L01_D588                     ;[x]
  D57A  BD 59 36              LDA   $3659,X                      ;[x]
  D57D  3A                    DEC   A                            ;[x]
  D57E  30 73                 BMI   L01_D5F3                     ;[x]
  D580  9D 59 36              STA   $3659,X                      ;[x]
  D583  A9 3C                 LDA   #$3C                         ;[x]
  D585  9D C6 36              STA   $36C6,X                      ;[x]
L01_D588:
  D588  A5 77                 LDA   <$77                         ;[x]
  D58A  29 08                 AND   #$08                         ;[x]
  D58C  F0 05                 BEQ   L01_D593                     ;[x]
  D58E  8A                    TXA                                ;[ ]
  D58F  D0 61                 BNE   L01_D5F2                     ;[ ]
  D591  80 09                 BRA   L01_D59C                     ;[ ]

L01_D593:
  D593  A5 78                 LDA   <$78                         ;[x]
  D595  29 08                 AND   #$08                         ;[x]
  D597  F0 59                 BEQ   L01_D5F2                     ;[x]
  D599  8A                    TXA                                ;[ ]
  D59A  F0 56                 BEQ   L01_D5F2                     ;[ ]
L01_D59C:
  D59C  BD 1B C9              LDA   $C91B,X                      ;[ ]
  D59F  05 86                 ORA   <$86                         ;[ ]
  D5A1  85 86                 STA   <$86                         ;[ ]
  D5A3  9E 89 2F              STZ   $2F89,X                      ;[ ]
  D5A6  A9 C0                 LDA   #$C0                         ;[ ]
  D5A8  9D 0D 38              STA   $380D,X                      ;[ ]
  D5AB  AD 9B 3F              LDA   $3F9B                        ;[ ]
  D5AE  F8                    SED                                ;[ ]
  D5AF  38                    SEC                                ;[ ]
  D5B0  E9 01                 SBC   #$01                         ;[ ]
  D5B2  D8                    CLD                                ;[ ]
  D5B3  95 87                 STA   <$87,X                       ;[ ]
  D5B5  DE 38 3F              DEC   $3F38,X                      ;[ ]
  D5B8  8A                    TXA                                ;[ ]
  D5B9  F0 05                 BEQ   L01_D5C0                     ;[ ]
  D5BB  AD 3A 3F              LDA   $3F3A                        ;[ ]
  D5BE  F0 14                 BEQ   L01_D5D4                     ;[ ]
L01_D5C0:
  D5C0  A9 06                 LDA   #$06                         ;[ ]
  D5C2  9D EA 3E              STA   $3EEA,X                      ;[ ]
  D5C5  9D 54 39              STA   $3954,X                      ;[ ]
  D5C8  A9 88                 LDA   #$88                         ;[ ]
  D5CA  9D E0 3E              STA   $3EE0,X                      ;[ ]
  D5CD  A9 0A                 LDA   #$0A                         ;[ ]
  D5CF  9D E8 3E              STA   $3EE8,X                      ;[ ]
  D5D2  80 0D                 BRA   L01_D5E1                     ;[ ]

L01_D5D4:
  D5D4  A9 01                 LDA   #$01                         ;[ ]
  D5D6  8D 3A 3F              STA   $3F3A                        ;[ ]
  D5D9  A9 04                 LDA   #$04                         ;[ ]
  D5DB  9D EA 3E              STA   $3EEA,X                      ;[ ]
  D5DE  9D 54 39              STA   $3954,X                      ;[ ]
L01_D5E1:
  D5E1  8A                    TXA                                ;[ ]
  D5E2  0A                    ASL   A                            ;[ ]
  D5E3  0A                    ASL   A                            ;[ ]
  D5E4  A8                    TAY                                ;[ ]
  D5E5  62                    CLA                                ;[ ]
  D5E6  99 84 3F              STA   $3F84,Y                      ;[ ]
  D5E9  99 85 3F              STA   $3F85,Y                      ;[ ]
  D5EC  99 86 3F              STA   $3F86,Y                      ;[ ]
  D5EF  99 87 3F              STA   $3F87,Y                      ;[ ]
L01_D5F2:
  D5F2  60                    RTS                                ;[x]

L01_D5F3:
  D5F3  A9 07                 LDA   #$07                         ;[ ]
  D5F5  9D 89 2F              STA   $2F89,X                      ;[ ]
  D5F8  9D E6 3E              STA   $3EE6,X                      ;[ ]
  D5FB  9E 38 3F              STZ   $3F38,X                      ;[ ]
  D5FE  60                    RTS                                ;[ ]

  D5FF  .db $E0,$00,$D0,$1C,$AD,$3A,$3F,$F0,$75,$AD,$8A,$2F,$C9,$07,$F0,$6E
  D60F  .db $AD,$39,$3F,$F0,$69,$A5,$77,$29,$08,$F0,$63,$CE,$39,$3F,$80,$1F
  D61F  .db $A5,$35,$D0,$5A,$AD,$89,$2F,$C9,$07,$F0,$53,$AD,$38,$3F,$F0,$4E
  D62F  .db $A5,$77,$29,$08,$D0,$48,$A5,$78,$29,$08,$F0,$42,$CE,$38,$3F,$BD
  D63F  .db $1B,$C9,$05,$86,$85,$86,$9E,$89,$2F,$9E,$E6,$3E,$A9,$C0,$9D,$0D
  D64F  .db $38,$AD,$9B,$3F,$F8,$38,$E9,$01,$D8,$95,$87,$A9,$06,$9D,$EA,$3E
  D65F  .db $9D,$54,$39,$A9,$88,$9D,$E0,$3E,$A9,$0A,$9D,$E8,$3E,$8A,$0A,$0A
  D66F  .db $A8,$62,$99,$84,$3F,$99,$85,$3F,$99,$86,$3F,$99,$87,$3F,$60
L01_D67E:
  D67E  A2 01                 LDX   #$01                         ;[x]
L01_D680:
  D680  BD 89 2F              LDA   $2F89,X                      ;[x]
  D683  C9 02                 CMP   #$02                         ;[x]
  D685  D0 1F                 BNE   L01_D6A6                     ;[x]
  D687  BD 38 34              LDA   $3438,X                      ;[x]
  D68A  29 80                 AND   #$80                         ;[x]
  D68C  F0 18                 BEQ   L01_D6A6                     ;[x]
  D68E  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  D691  9D 97 2C              STA   $2C97,X                      ;[x]
  D694  BD 47 2B              LDA   $2B47,X                      ;[x]
  D697  9D 50 2B              STA   $2B50,X                      ;[x]
  D69A  BD 88 35              LDA   $3588,X                      ;[x]
  D69D  8F 32 01              BBS0  <$32,L01_D6A1                ;[x]
  D6A0  1A                    INC   A                            ;[x]
L01_D6A1:
  D6A1  9D 76 2A              STA   $2A76,X                      ;[x]
  D6A4  A9 00                 LDA   #$00                         ;[x]
L01_D6A6:
  D6A6  CA                    DEX                                ;[x]
  D6A7  10 D7                 BPL   L01_D680                     ;[x]
  D6A9  60                    RTS                                ;[x]

L01_D6AA:
  D6AA  A2 01                 LDX   #$01                         ;[x]
L01_D6AC:
  D6AC  BD 9B 2F              LDA   $2F9B,X                      ;[x]
  D6AF  F0 0B                 BEQ   L01_D6BC                     ;[x]
  D6B1  3A                    DEC   A                            ;[x]
  D6B2  F0 20                 BEQ   L01_D6D4                     ;[x]
  D6B4  3A                    DEC   A                            ;[x]
  D6B5  F0 2F                 BEQ   L01_D6E6                     ;[x]
  D6B7  3A                    DEC   A                            ;[x]
  D6B8  F0 34                 BEQ   L01_D6EE                     ;[x]
  D6BA  80 72                 BRA   L01_D72E                     ;[x]

L01_D6BC:
  D6BC  CA                    DEX                                ;[x]
  D6BD  10 ED                 BPL   L01_D6AC                     ;[x]
  D6BF  AD 9B 2F              LDA   $2F9B                        ;[x]
  D6C2  0D 9C 2F              ORA   $2F9C                        ;[x]
  D6C5  F0 0C                 BEQ   L01_D6D3                     ;[x]
  D6C7  AF 32 04              BBS2  <$32,L01_D6CE                ;[x]
  D6CA  A9 1B                 LDA   #$1B                         ;[x]
  D6CC  80 02                 BRA   L01_D6D0                     ;[x]

L01_D6CE:
  D6CE  A9 1C                 LDA   #$1C                         ;[x]
L01_D6D0:
  D6D0  20 D4 E8              JSR   L00_E8D4                     ;[x]
L01_D6D3:
  D6D3  60                    RTS                                ;[x]

L01_D6D4:
  D6D4  BD A0 2C              LDA   $2CA0,X                      ;[x]
  D6D7  18                    CLC                                ;[x]
  D6D8  69 01                 ADC   #$01                         ;[x]
  D6DA  9D A0 2C              STA   $2CA0,X                      ;[x]
  D6DD  C9 E0                 CMP   #$E0                         ;[x]
  D6DF  90 03                 BCC   L01_D6E4                     ;[x]
  D6E1  FE 9B 2F              INC   $2F9B,X                      ;[x]
L01_D6E4:
  D6E4  80 D6                 BRA   L01_D6BC                     ;[x]

L01_D6E6:
  D6E6  9E 7F 2A              STZ   $2A7F,X                      ;[x]
  D6E9  9E 9B 2F              STZ   $2F9B,X                      ;[x]
  D6EC  80 CE                 BRA   L01_D6BC                     ;[x]

L01_D6EE:
  D6EE  DE 6B 36              DEC   $366B,X                      ;[ ]
  D6F1  D0 C9                 BNE   L01_D6BC                     ;[ ]
  D6F3  A9 51                 LDA   #$51                         ;[ ]
  D6F5  9D 7F 2A              STA   $2A7F,X                      ;[ ]
  D6F8  BD 8E 2C              LDA   $2C8E,X                      ;[ ]
  D6FB  38                    SEC                                ;[ ]
  D6FC  E9 05                 SBC   #$05                         ;[ ]
  D6FE  9D A0 2C              STA   $2CA0,X                      ;[ ]
  D701  BD 47 2B              LDA   $2B47,X                      ;[ ]
  D704  9D 59 2B              STA   $2B59,X                      ;[ ]
  D707  74 A9                 STZ   <$A9,X                       ;[ ]
  D709  9E A5 34              STZ   $34A5,X                      ;[ ]
  D70C  9E 7A 38              STZ   $387A,X                      ;[ ]
  D70F  9E E7 38              STZ   $38E7,X                      ;[ ]
  D712  74 C6                 STZ   <$C6,X                       ;[ ]
  D714  74 C8                 STZ   <$C8,X                       ;[ ]
  D716  FE 9B 2F              INC   $2F9B,X                      ;[ ]
  D719  20 B5 CF              JSR   L01_CFB5                     ;[ ]
  D71C  8A                    TXA                                ;[ ]
  D71D  09 80                 ORA   #$80                         ;[ ]
  D71F  9D 42 2E              STA   $2E42,X                      ;[ ]
  D722  A9 03                 LDA   #$03                         ;[ ]
  D724  20 FC E3              JSR   L00_E3FC                     ;[ ]
  D727  A9 2D                 LDA   #$2D                         ;[ ]
  D729  20 FC E3              JSR   L00_E3FC                     ;[ ]
  D72C  80 8E                 BRA   L01_D6BC                     ;[ ]

L01_D72E:
  D72E  BD A0 2C              LDA   $2CA0,X                      ;[x]
  D731  38                    SEC                                ;[x]
  D732  E9 06                 SBC   #$06                         ;[x]
  D734  C9 E8                 CMP   #$E8                         ;[x]
  D736  B0 06                 BCS   L01_D73E                     ;[x]
  D738  9D A0 2C              STA   $2CA0,X                      ;[x]
  D73B  4C BC D6              JMP   L01_D6BC                     ;[x]

L01_D73E:
  D73E  9E 7F 2A              STZ   $2A7F,X                      ;[x]
  D741  9E 9B 2F              STZ   $2F9B,X                      ;[x]
  D744  A5 B1                 LDA   <$B1                         ;[x]
  D746  9D C1 39              STA   $39C1,X                      ;[x]
  D749  60                    RTS                                ;[x]

  D74A  A5 92                 LDA   <$92                         ;[x]
  D74C  C9 04                 CMP   #$04                         ;[x]
  D74E  F0 05                 BEQ   L01_D755                     ;[x]
  D750  C9 03                 CMP   #$03                         ;[x]
  D752  F0 44                 BEQ   L01_D798                     ;[x]
  D754  60                    RTS                                ;[x]

L01_D755:
  D755  AD D1 3D              LDA   $3DD1                        ;[ ]
  D758  D0 19                 BNE   L01_D773                     ;[ ]
  D75A  AD D3 3D              LDA   $3DD3                        ;[ ]
  D75D  1A                    INC   A                            ;[ ]
  D75E  C9 05                 CMP   #$05                         ;[ ]
  D760  90 01                 BCC   L01_D763                     ;[ ]
  D762  62                    CLA                                ;[ ]
L01_D763:
  D763  8D D3 3D              STA   $3DD3                        ;[ ]
  D766  18                    CLC                                ;[ ]
  D767  69 3C                 ADC   #$3C                         ;[ ]
  D769  A2 02                 LDX   #$02                         ;[ ]
  D76B  20 D5 E8              JSR   L00_E8D5                     ;[ ]
  D76E  A9 04                 LDA   #$04                         ;[ ]
  D770  8D D1 3D              STA   $3DD1                        ;[ ]
L01_D773:
  D773  CE D1 3D              DEC   $3DD1                        ;[ ]
  D776  AD D2 3D              LDA   $3DD2                        ;[ ]
  D779  D0 19                 BNE   L01_D794                     ;[ ]
  D77B  AC D4 3D              LDY   $3DD4                        ;[ ]
  D77E  C8                    INY                                ;[ ]
  D77F  C0 06                 CPY   #$06                         ;[ ]
  D781  90 01                 BCC   L01_D784                     ;[ ]
  D783  C2                    CLY                                ;[ ]
L01_D784:
  D784  8C D4 3D              STY   $3DD4                        ;[ ]
  D787  B9 BD D7              LDA   $D7BD,Y                      ;[ ]
  D78A  A2 03                 LDX   #$03                         ;[ ]
  D78C  20 D5 E8              JSR   L00_E8D5                     ;[ ]
  D78F  A9 08                 LDA   #$08                         ;[ ]
  D791  8D D2 3D              STA   $3DD2                        ;[ ]
L01_D794:
  D794  CE D2 3D              DEC   $3DD2                        ;[ ]
  D797  60                    RTS                                ;[ ]

L01_D798:
  D798  AD D1 3D              LDA   $3DD1                        ;[ ]
  D79B  D0 08                 BNE   L01_D7A5                     ;[ ]
  D79D  A9 18                 LDA   #$18                         ;[ ]
  D79F  8D D1 3D              STA   $3DD1                        ;[ ]
  D7A2  EE D3 3D              INC   $3DD3                        ;[ ]
L01_D7A5:
  D7A5  CE D1 3D              DEC   $3DD1                        ;[ ]
  D7A8  AD D3 3D              LDA   $3DD3                        ;[ ]
  D7AB  29 01                 AND   #$01                         ;[ ]
  D7AD  18                    CLC                                ;[ ]
  D7AE  69 48                 ADC   #$48                         ;[ ]
  D7B0  AC 81 26              LDY   $2681                        ;[ ]
  D7B3  F0 03                 BEQ   L01_D7B8                     ;[ ]
  D7B5  18                    CLC                                ;[ ]
  D7B6  69 02                 ADC   #$02                         ;[ ]
L01_D7B8:
  D7B8  A2 02                 LDX   #$02                         ;[ ]
  D7BA  4C D5 E8              JMP   L00_E8D5                     ;[ ]

  D7BD  .db $42,$43,$44,$46,$44,$43,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D7CD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D7DD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D7ED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D7FD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D80D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D81D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D82D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D83D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D84D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D85D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D86D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D87D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D88D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D89D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D8AD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D8BD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D8CD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D8DD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D8ED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D8FD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D90D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D91D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D92D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D93D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D94D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D95D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D96D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D97D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D98D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D99D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D9AD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D9BD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D9CD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D9DD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D9ED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  D9FD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA0D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA1D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA2D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA3D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA4D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA5D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA6D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA7D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA8D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DA9D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DAAD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DABD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DACD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DADD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DAED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DAFD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB0D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB1D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB2D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB3D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB4D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB5D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB6D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB7D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB8D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB9D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBAD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBBD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBCD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBDD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBFD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC0D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC1D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC2D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC3D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC4D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC5D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC6D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC7D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC8D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC9D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCAD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCBD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCCD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCDD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCFD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD0D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD1D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD2D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD3D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD4D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD5D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD6D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD7D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD8D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD9D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDAD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDBD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDCD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDDD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDFD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE0D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE1D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE2D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE3D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE4D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE5D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE6D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE7D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE8D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE9D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEAD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEBD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DECD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEDD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF0D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF1D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF2D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF3D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF4D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF5D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF6D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF7D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF8D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF9D  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFAD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFBD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFCD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFDD  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFED  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFFD  .db $FF,$FF,$FF
