; Detana!! TwinBee (PCE) - banque $00, vue en $E000-$FFFF
; 6075 octets de code (4882 exécutés en émulation)
; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique

L00_E000:
  E000  EA                    NOP                                ;[x]
  E001  D4                    CSH                                ;[x]
  E002  78                    SEI                                ;[x]
  E003  D8                    CLD                                ;[x]
  E004  A9 FF                 LDA   #$FF                         ;[x]
  E006  53 01                 TAM   #$01                         ;[x]
  E008  A9 F8                 LDA   #$F8                         ;[x]
  E00A  53 02                 TAM   #$02                         ;[x]
  E00C  A9 05                 LDA   #$05                         ;[x]
  E00E  53 04                 TAM   #$04                         ;[x]
  E010  A9 04                 LDA   #$04                         ;[x]
  E012  53 08                 TAM   #$08                         ;[x]
  E014  A9 03                 LDA   #$03                         ;[x]
  E016  53 10                 TAM   #$10                         ;[x]
  E018  A9 02                 LDA   #$02                         ;[x]
  E01A  53 20                 TAM   #$20                         ;[x]
  E01C  A9 01                 LDA   #$01                         ;[x]
  E01E  53 40                 TAM   #$40                         ;[x]
  E020  A9 00                 LDA   #$00                         ;[x]
  E022  53 80                 TAM   #$80                         ;[x]
  E024  F3 C6 FB 00 21 00 01  TAI   $FBC6,$2100,$0100            ;[x]
  E02B  F3 C6 FB 00 3E 00 02  TAI   $FBC6,$3E00,$0200            ;[x]
  E032  A9 01                 LDA   #$01                         ;[x]
  E034  8D 99 3F              STA   $3F99                        ;[x]
  E037  A9 03                 LDA   #$03                         ;[x]
  E039  8D 9A 3F              STA   $3F9A                        ;[x]
  E03C  A9 03                 LDA   #$03                         ;[x]
  E03E  8D 9B 3F              STA   $3F9B                        ;[x]
  E041  9C 9C 3F              STZ   $3F9C                        ;[x]
  E044  A9 05                 LDA   #$05                         ;[x]
  E046  8D 81 3F              STA   $3F81                        ;[x]
  E049  A9 73                 LDA   #$73                         ;[x]
  E04B  8D 82 3F              STA   $3F82                        ;[x]
  E04E  9C A0 3F              STZ   $3FA0                        ;[x]
L00_E051:
  E051  78                    SEI                                ;[x]
  E052  D8                    CLD                                ;[x]
  E053  9C 01 0C              STZ   TIMER_CTRL                   ;[x]
  E056  9C 02 14              STZ   IRQ_MASK                     ;[x]
  E059  9C 03 14              STZ   IRQ_STATUS                   ;[x]
  E05C  A2 FF                 LDX   #$FF                         ;[x]
  E05E  9A                    TXS                                ;[x]
  E05F  20 A0 E8              JSR   L00_E8A0                     ;[x]
  E062  A2 02                 LDX   #$02                         ;[x]
L00_E064:
  E064  BD 8E 3F              LDA   $3F8E,X                      ;[x]
  E067  9D B0 3F              STA   $3FB0,X                      ;[x]
  E06A  CA                    DEX                                ;[x]
  E06B  10 F7                 BPL   L00_E064                     ;[x]
  E06D  AD A0 3F              LDA   $3FA0                        ;[x]
  E070  29 EF                 AND   #$EF                         ;[x]
  E072  8D A0 3F              STA   $3FA0                        ;[x]
  E075  F3 C6 FB 00 20 80 1F  TAI   $FBC6,$2000,$1F80            ;[x]
  E07C  9C 02 04              STZ   VCE_ADDR_L                   ;[x]
  E07F  A9 01                 LDA   #$01                         ;[x]
  E081  8D 03 04              STA   VCE_ADDR_H                   ;[x]
  E084  9C 04 04              STZ   VCE_DATA_L                   ;[x]
  E087  9C 05 04              STZ   VCE_DATA_H                   ;[x]
  E08A  82                    CLX                                ;[x]
L00_E08B:
  E08B  BD CD E0              LDA   $E0CD,X                      ;[x]
  E08E  8D 00 00              STA   VDC_AR                       ;[x]
  E091  E8                    INX                                ;[x]
  E092  BD CD E0              LDA   $E0CD,X                      ;[x]
  E095  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E098  E8                    INX                                ;[x]
  E099  BD CD E0              LDA   $E0CD,X                      ;[x]
  E09C  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E09F  E8                    INX                                ;[x]
  E0A0  E0 24                 CPX   #$24                         ;[x]
  E0A2  90 E7                 BCC   L00_E08B                     ;[x]
  E0A4  A9 06                 LDA   #$06                         ;[x]
  E0A6  85 30                 STA   <$30                         ;[x]
  E0A8  20 74 E3              JSR   L00_E374                     ;[x]
  E0AB  62                    CLA                                ;[x]
  E0AC  8D 02 14              STA   IRQ_MASK                     ;[x]
  E0AF  A9 00                 LDA   #$00                         ;[x]
  E0B1  8D 00 0C              STA   TIMER_CNT                    ;[x]
  E0B4  9C 20 28              STZ   $2820                        ;[x]
  E0B7  9C 21 28              STZ   $2821                        ;[x]
  E0BA  A9 01                 LDA   #$01                         ;[x]
  E0BC  8D 01 0C              STA   TIMER_CTRL                   ;[x]
  E0BF  62                    CLA                                ;[x]
  E0C0  8D 22 28              STA   $2822                        ;[x]
  E0C3  9C 9D 3F              STZ   $3F9D                        ;[x]
  E0C6  9C 9E 3F              STZ   $3F9E                        ;[x]
  E0C9  58                    CLI                                ;[x]
L00_E0CA:
  E0CA  4C CA E0              JMP   L00_E0CA                     ;[x]

  E0CD  .db $05,$00,$00,$06,$00,$00,$07,$00,$00,$08,$00,$00,$09,$50,$00,$0A
  E0DD  .db $02,$02,$0B,$1F,$04,$0C,$02,$0F,$0D,$EF,$00,$0E,$04,$00,$0F,$10
  E0ED  .db $00,$13,$00,$10
L00_E0F1:
  E0F1  48                    PHA                                ;[x]
  E0F2  DA                    PHX                                ;[x]
  E0F3  5A                    PHY                                ;[x]
  E0F4  43 04                 TMA   #$04                         ;[x]
  E0F6  48                    PHA                                ;[x]
  E0F7  43 08                 TMA   #$08                         ;[x]
  E0F9  48                    PHA                                ;[x]
  E0FA  43 10                 TMA   #$10                         ;[x]
  E0FC  48                    PHA                                ;[x]
  E0FD  43 20                 TMA   #$20                         ;[x]
  E0FF  48                    PHA                                ;[x]
  E100  AD 40 3F              LDA   $3F40                        ;[x]
  E103  48                    PHA                                ;[x]
  E104  AD 00 00              LDA   VDC_AR                       ;[x]
  E107  85 3A                 STA   <$3A                         ;[x]
  E109  2F 3A 03              BBR2  <$3A,L00_E10F                ;[x]
  E10C  4C 69 E2              JMP   L00_E269                     ;[x]

L00_E10F:
  E10F  DF 3A 03              BBS5  <$3A,L00_E115                ;[x]
  E112  4C CA E1              JMP   L00_E1CA                     ;[ ]

L00_E115:
  E115  58                    CLI                                ;[x]
  E116  A5 33                 LDA   <$33                         ;[x]
  E118  F0 03                 BEQ   L00_E11D                     ;[x]
  E11A  4C DE E1              JMP   L00_E1DE                     ;[x]

L00_E11D:
  E11D  E6 33                 INC   <$33                         ;[x]
  E11F  A4 4C                 LDY   <$4C                         ;[x]
  E121  B9 C9 E4              LDA   $E4C9,Y                      ;[x]
  E124  8D 00 04              STA   VCE_CR                       ;[x]
  E127  98                    TYA                                ;[x]
  E128  0A                    ASL   A                            ;[x]
  E129  A8                    TAY                                ;[x]
  E12A  A9 0A                 LDA   #$0A                         ;[x]
  E12C  20 92 E7              JSR   L00_E792                     ;[x]
  E12F  B9 CE E4              LDA   $E4CE,Y                      ;[x]
  E132  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E135  B9 CF E4              LDA   $E4CF,Y                      ;[x]
  E138  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E13B  A9 0B                 LDA   #$0B                         ;[x]
  E13D  20 92 E7              JSR   L00_E792                     ;[x]
  E140  B9 D8 E4              LDA   $E4D8,Y                      ;[x]
  E143  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E146  B9 D9 E4              LDA   $E4D9,Y                      ;[x]
  E149  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E14C  20 F9 E1              JSR   L00_E1F9                     ;[x]
  E14F  A5 4A                 LDA   <$4A                         ;[x]
  E151  A6 39                 LDX   <$39                         ;[x]
  E153  F0 06                 BEQ   L00_E15B                     ;[x]
  E155  C6 39                 DEC   <$39                         ;[x]
  E157  F0 02                 BEQ   L00_E15B                     ;[x]
  E159  29 3F                 AND   #$3F                         ;[x]
L00_E15B:
  E15B  09 08                 ORA   #$08                         ;[x]
  E15D  A8                    TAY                                ;[x]
  E15E  20 90 E7              JSR   L00_E790                     ;[x]
  E161  8C 30 3F              STY   $3F30                        ;[x]
  E164  8C 02 00              STY   VDC_DATA_L                   ;[x]
  E167  AD B6 3D              LDA   $3DB6                        ;[x]
  E16A  8D BE 3D              STA   $3DBE                        ;[x]
  E16D  AD B8 3D              LDA   $3DB8                        ;[x]
  E170  8D C0 3D              STA   $3DC0                        ;[x]
  E173  AD BA 3D              LDA   $3DBA                        ;[x]
  E176  8D C2 3D              STA   $3DC2                        ;[x]
  E179  AD BC 3D              LDA   $3DBC                        ;[x]
  E17C  8D C4 3D              STA   $3DC4                        ;[x]
  E17F  82                    CLX                                ;[x]
  E180  20 99 E3              JSR   L00_E399                     ;[x]
  E183  20 1F E9              JSR   L00_E91F                     ;[x]
  E186  A9 01                 LDA   #$01                         ;[x]
  E188  20 3D F0              JSR   L00_F03D                     ;[x]
  E18B  20 27 C3              JSR   $C327                        ;[x]
  E18E  20 88 F0              JSR   L00_F088                     ;[x]
  E191  20 00 C0              JSR   $C000                        ;[x]
  E194  20 E9 E3              JSR   L00_E3E9                     ;[x]
  E197  20 1D E7              JSR   L00_E71D                     ;[x]
  E19A  20 62 E5              JSR   L00_E562                     ;[x]
  E19D  64 33                 STZ   <$33                         ;[x]
  E19F  64 34                 STZ   <$34                         ;[x]
  E1A1  AD 8C 3F              LDA   $3F8C                        ;[x]
  E1A4  F0 24                 BEQ   L00_E1CA                     ;[x]
  E1A6  A0 08                 LDY   #$08                         ;[ ]
  E1A8  A9 0A                 LDA   #$0A                         ;[ ]
  E1AA  20 92 E7              JSR   L00_E792                     ;[ ]
  E1AD  B9 CE E4              LDA   $E4CE,Y                      ;[ ]
  E1B0  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  E1B3  B9 CF E4              LDA   $E4CF,Y                      ;[ ]
  E1B6  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  E1B9  A9 0B                 LDA   #$0B                         ;[ ]
  E1BB  20 92 E7              JSR   L00_E792                     ;[ ]
  E1BE  B9 D8 E4              LDA   $E4D8,Y                      ;[ ]
  E1C1  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  E1C4  B9 D9 E4              LDA   $E4D9,Y                      ;[ ]
  E1C7  8D 03 00              STA   VDC_DATA_H                   ;[ ]
L00_E1CA:
  E1CA  68                    PLA                                ;[x]
  E1CB  20 92 E7              JSR   L00_E792                     ;[x]
  E1CE  68                    PLA                                ;[x]
  E1CF  53 20                 TAM   #$20                         ;[x]
  E1D1  68                    PLA                                ;[x]
  E1D2  53 10                 TAM   #$10                         ;[x]
  E1D4  68                    PLA                                ;[x]
  E1D5  53 08                 TAM   #$08                         ;[x]
  E1D7  68                    PLA                                ;[x]
  E1D8  53 04                 TAM   #$04                         ;[x]
  E1DA  7A                    PLY                                ;[x]
  E1DB  FA                    PLX                                ;[x]
  E1DC  68                    PLA                                ;[x]
  E1DD  40                    RTI                                ;[x]

L00_E1DE:
  E1DE  AD 2F 3F              LDA   $3F2F                        ;[x]
  E1E1  F0 00                 BEQ   L00_E1E3                     ;[x]
L00_E1E3:
  E1E3  20 90 E7              JSR   L00_E790                     ;[x]
  E1E6  AD 30 3F              LDA   $3F30                        ;[x]
  E1E9  09 08                 ORA   #$08                         ;[x]
  E1EB  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E1EE  44 09                 BSR   L00_E1F9                     ;[x]
  E1F0  82                    CLX                                ;[x]
  E1F1  20 99 E3              JSR   L00_E399                     ;[x]
  E1F4  20 E9 E3              JSR   L00_E3E9                     ;[x]
  E1F7  80 D1                 BRA   L00_E1CA                     ;[x]

L00_E1F9:
  E1F9  A5 4A                 LDA   <$4A                         ;[x]
  E1FB  29 FB                 AND   #$FB                         ;[x]
  E1FD  85 4A                 STA   <$4A                         ;[x]
  E1FF  A5 45                 LDA   <$45                         ;[x]
  E201  8D 2F 3F              STA   $3F2F                        ;[x]
  E204  F0 62                 BEQ   L00_E268                     ;[x]
  E206  64 44                 STZ   <$44                         ;[x]
  E208  AD C6 3D              LDA   $3DC6                        ;[x]
  E20B  8D C7 3D              STA   $3DC7                        ;[x]
  E20E  A5 89                 LDA   <$89                         ;[x]
  E210  85 8A                 STA   <$8A                         ;[x]
  E212  D0 37                 BNE   L00_E24B                     ;[x]
  E214  AD C7 3D              LDA   $3DC7                        ;[x]
  E217  D0 0F                 BNE   L00_E228                     ;[x]
  E219  A9 06                 LDA   #$06                         ;[x]
  E21B  20 92 E7              JSR   L00_E792                     ;[x]
  E21E  A9 41                 LDA   #$41                         ;[x]
  E220  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E223  9C 03 00              STZ   VDC_DATA_H                   ;[x]
  E226  80 3A                 BRA   L00_E262                     ;[x]

L00_E228:
  E228  AD B7 3D              LDA   $3DB7                        ;[x]
  E22B  8D BF 3D              STA   $3DBF                        ;[x]
  E22E  AD B9 3D              LDA   $3DB9                        ;[x]
  E231  8D C1 3D              STA   $3DC1                        ;[x]
  E234  A9 06                 LDA   #$06                         ;[x]
  E236  20 92 E7              JSR   L00_E792                     ;[x]
  E239  AD BB 3D              LDA   $3DBB                        ;[x]
  E23C  18                    CLC                                ;[x]
  E23D  69 40                 ADC   #$40                         ;[x]
  E23F  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E242  62                    CLA                                ;[x]
  E243  6D BD 3D              ADC   $3DBD                        ;[x]
  E246  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E249  80 17                 BRA   L00_E262                     ;[x]

L00_E24B:
  E24B  64 8B                 STZ   <$8B                         ;[ ]
  E24D  E6 8C                 INC   <$8C                         ;[ ]
  E24F  A5 8C                 LDA   <$8C                         ;[ ]
  E251  29 7F                 AND   #$7F                         ;[ ]
  E253  85 8D                 STA   <$8D                         ;[ ]
  E255  A9 06                 LDA   #$06                         ;[ ]
  E257  20 92 E7              JSR   L00_E792                     ;[ ]
  E25A  A9 40                 LDA   #$40                         ;[ ]
  E25C  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  E25F  9C 03 00              STZ   VDC_DATA_H                   ;[ ]
L00_E262:
  E262  A5 4A                 LDA   <$4A                         ;[x]
  E264  09 04                 ORA   #$04                         ;[x]
  E266  85 4A                 STA   <$4A                         ;[x]
L00_E268:
  E268  60                    RTS                                ;[x]

L00_E269:
  E269  AC 2F 3F              LDY   $3F2F                        ;[x]
  E26C  F0 60                 BEQ   L00_E2CE                     ;[x]
  E26E  AD C7 3D              LDA   $3DC7                        ;[x]
  E271  D0 03                 BNE   L00_E276                     ;[x]
  E273  4C 7E E2              JMP   L00_E27E                     ;[x]

L00_E276:
  E276  A2 01                 LDX   #$01                         ;[x]
  E278  20 99 E3              JSR   L00_E399                     ;[x]
  E27B  4C CE E2              JMP   L00_E2CE                     ;[x]

L00_E27E:
  E27E  A5 8A                 LDA   <$8A                         ;[x]
  E280  F0 50                 BEQ   L00_E2D2                     ;[x]
  E282  A5 9F                 LDA   <$9F                         ;[ ]
  E284  F0 0C                 BEQ   L00_E292                     ;[ ]
  E286  A5 8B                 LDA   <$8B                         ;[ ]
  E288  C5 8E                 CMP   <$8E                         ;[ ]
  E28A  B0 04                 BCS   L00_E290                     ;[ ]
L00_E28C:
  E28C  A9 08                 LDA   #$08                         ;[ ]
  E28E  80 0D                 BRA   L00_E29D                     ;[ ]

L00_E290:
  E290  F0 FA                 BEQ   L00_E28C                     ;[ ]
L00_E292:
  E292  A5 8D                 LDA   <$8D                         ;[ ]
  E294  1A                    INC   A                            ;[ ]
  E295  29 7F                 AND   #$7F                         ;[ ]
  E297  85 8D                 STA   <$8D                         ;[ ]
  E299  AA                    TAX                                ;[ ]
  E29A  BD E2 E4              LDA   $E4E2,X                      ;[ ]
L00_E29D:
  E29D  8D B7 3D              STA   $3DB7                        ;[ ]
  E2A0  A9 07                 LDA   #$07                         ;[ ]
  E2A2  20 92 E7              JSR   L00_E792                     ;[ ]
  E2A5  AD B7 3D              LDA   $3DB7                        ;[ ]
  E2A8  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  E2AB  9C 03 00              STZ   VDC_DATA_H                   ;[ ]
  E2AE  A5 8B                 LDA   <$8B                         ;[ ]
  E2B0  18                    CLC                                ;[ ]
  E2B1  69 08                 ADC   #$08                         ;[ ]
  E2B3  85 8B                 STA   <$8B                         ;[ ]
  E2B5  C9 D0                 CMP   #$D0                         ;[ ]
  E2B7  F0 02                 BEQ   L00_E2BB                     ;[ ]
  E2B9  B0 2F                 BCS   L00_E2EA                     ;[ ]
L00_E2BB:
  E2BB  82                    CLX                                ;[ ]
  E2BC  69 40                 ADC   #$40                         ;[ ]
  E2BE  90 01                 BCC   L00_E2C1                     ;[ ]
  E2C0  E8                    INX                                ;[ ]
L00_E2C1:
  E2C1  48                    PHA                                ;[ ]
  E2C2  A9 06                 LDA   #$06                         ;[ ]
  E2C4  20 92 E7              JSR   L00_E792                     ;[ ]
  E2C7  68                    PLA                                ;[ ]
  E2C8  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  E2CB  8E 03 00              STX   VDC_DATA_H                   ;[ ]
L00_E2CE:
  E2CE  58                    CLI                                ;[x]
  E2CF  4C CA E1              JMP   L00_E1CA                     ;[x]

L00_E2D2:
  E2D2  A5 44                 LDA   <$44                         ;[x]
  E2D4  D0 14                 BNE   L00_E2EA                     ;[x]
  E2D6  1A                    INC   A                            ;[x]
  E2D7  85 44                 STA   <$44                         ;[x]
  E2D9  A9 06                 LDA   #$06                         ;[x]
  E2DB  20 92 E7              JSR   L00_E792                     ;[x]
  E2DE  A9 10                 LDA   #$10                         ;[x]
  E2E0  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E2E3  A9 01                 LDA   #$01                         ;[x]
  E2E5  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E2E8  80 E4                 BRA   L00_E2CE                     ;[x]

L00_E2EA:
  E2EA  9F 44 42              BBS1  <$44,L00_E32F                ;[x]
  E2ED  AD CF 3D              LDA   $3DCF                        ;[x]
  E2F0  8D B6 3D              STA   $3DB6                        ;[x]
  E2F3  A9 07                 LDA   #$07                         ;[x]
  E2F5  20 92 E7              JSR   L00_E792                     ;[x]
  E2F8  13 00                 ST1   #$00                         ;[x]
  E2FA  23 01                 ST2   #$01                         ;[x]
  E2FC  A9 08                 LDA   #$08                         ;[x]
  E2FE  20 92 E7              JSR   L00_E792                     ;[x]
  E301  AD CA 3D              LDA   $3DCA                        ;[x]
  E304  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E307  AD CB 3D              LDA   $3DCB                        ;[x]
  E30A  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E30D  20 90 E7              JSR   L00_E790                     ;[x]
  E310  AD 30 3F              LDA   $3F30                        ;[x]
  E313  29 BF                 AND   #$BF                         ;[x]
  E315  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E318  A9 06                 LDA   #$06                         ;[x]
  E31A  20 92 E7              JSR   L00_E792                     ;[x]
  E31D  A9 28                 LDA   #$28                         ;[x]
  E31F  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E322  A9 01                 LDA   #$01                         ;[x]
  E324  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E327  A9 03                 LDA   #$03                         ;[x]
  E329  85 44                 STA   <$44                         ;[x]
  E32B  58                    CLI                                ;[x]
  E32C  4C CA E1              JMP   L00_E1CA                     ;[x]

L00_E32F:
  E32F  A9 07                 LDA   #$07                         ;[x]
  E331  20 92 E7              JSR   L00_E792                     ;[x]
  E334  13 00                 ST1   #$00                         ;[x]
  E336  23 01                 ST2   #$01                         ;[x]
  E338  A9 08                 LDA   #$08                         ;[x]
  E33A  20 92 E7              JSR   L00_E792                     ;[x]
  E33D  AD CA 3D              LDA   $3DCA                        ;[x]
  E340  18                    CLC                                ;[x]
  E341  69 10                 ADC   #$10                         ;[x]
  E343  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E346  AD CB 3D              LDA   $3DCB                        ;[x]
  E349  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E34C  58                    CLI                                ;[x]
  E34D  4C CA E1              JMP   L00_E1CA                     ;[x]

L00_E350:
  E350  A9 02                 LDA   #$02                         ;[x]
L00_E352:
  E352  48                    PHA                                ;[x]
  E353  43 04                 TMA   #$04                         ;[x]
  E355  8D 00 3F              STA   $3F00                        ;[x]
  E358  68                    PLA                                ;[x]
L00_E359:
  E359  53 04                 TAM   #$04                         ;[x]
  E35B  1A                    INC   A                            ;[x]
  E35C  53 08                 TAM   #$08                         ;[x]
  E35E  1A                    INC   A                            ;[x]
  E35F  53 10                 TAM   #$10                         ;[x]
  E361  1A                    INC   A                            ;[x]
  E362  53 20                 TAM   #$20                         ;[x]
  E364  60                    RTS                                ;[x]

L00_E365:
  E365  AD 00 3F              LDA   $3F00                        ;[x]
  E368  53 04                 TAM   #$04                         ;[x]
  E36A  1A                    INC   A                            ;[x]
  E36B  53 08                 TAM   #$08                         ;[x]
  E36D  1A                    INC   A                            ;[x]
  E36E  53 10                 TAM   #$10                         ;[x]
  E370  1A                    INC   A                            ;[x]
  E371  53 20                 TAM   #$20                         ;[x]
  E373  60                    RTS                                ;[x]

L00_E374:
  E374  20 90 E7              JSR   L00_E790                     ;[x]
  E377  A9 C8                 LDA   #$C8                         ;[x]
  E379  85 4A                 STA   <$4A                         ;[x]
  E37B  29 0F                 AND   #$0F                         ;[x]
  E37D  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E380  62                    CLA                                ;[x]
  E381  85 4B                 STA   <$4B                         ;[x]
  E383  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E386  9C B6 3D              STZ   $3DB6                        ;[x]
  E389  9C B8 3D              STZ   $3DB8                        ;[x]
  E38C  9C BA 3D              STZ   $3DBA                        ;[x]
  E38F  9C BC 3D              STZ   $3DBC                        ;[x]
  E392  64 45                 STZ   <$45                         ;[x]
  E394  A9 04                 LDA   #$04                         ;[x]
  E396  85 39                 STA   <$39                         ;[x]
  E398  60                    RTS                                ;[x]

L00_E399:
  E399  A9 07                 LDA   #$07                         ;[x]
  E39B  20 92 E7              JSR   L00_E792                     ;[x]
  E39E  BD BE 3D              LDA   $3DBE,X                      ;[x]
  E3A1  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E3A4  BD C0 3D              LDA   $3DC0,X                      ;[x]
  E3A7  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E3AA  A9 08                 LDA   #$08                         ;[x]
  E3AC  20 92 E7              JSR   L00_E792                     ;[x]
  E3AF  BD C2 3D              LDA   $3DC2,X                      ;[x]
  E3B2  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E3B5  BD C4 3D              LDA   $3DC4,X                      ;[x]
  E3B8  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E3BB  60                    RTS                                ;[x]

L00_E3BC:
  E3BC  64 3A                 STZ   <$3A                         ;[x]
L00_E3BE:
  E3BE  5F 3A FD              BBR5  <$3A,L00_E3BE                ;[x]
  E3C1  20 90 E7              JSR   L00_E790                     ;[x]
  E3C4  A5 4A                 LDA   <$4A                         ;[x]
  E3C6  29 3F                 AND   #$3F                         ;[x]
  E3C8  8D 30 3F              STA   $3F30                        ;[x]
  E3CB  8D 02 00              STA   VDC_DATA_L                   ;[x]
  E3CE  60                    RTS                                ;[x]

  E3CF  .db $20,$90,$E7,$A5,$4A,$8D,$02,$00,$A5,$4B,$8D,$03,$00,$60
L00_E3DD:
  E3DD  DA                    PHX                                ;[x]
  E3DE  20 50 E3              JSR   L00_E350                     ;[x]
  E3E1  20 B2 4A              JSR   $4AB2                        ;[x]
  E3E4  20 65 E3              JSR   L00_E365                     ;[x]
  E3E7  FA                    PLX                                ;[x]
  E3E8  60                    RTS                                ;[x]

L00_E3E9:
  E3E9  A5 34                 LDA   <$34                         ;[x]
  E3EB  D0 0E                 BNE   L00_E3FB                     ;[x]
  E3ED  A9 80                 LDA   #$80                         ;[x]
  E3EF  85 34                 STA   <$34                         ;[x]
  E3F1  A9 02                 LDA   #$02                         ;[x]
  E3F3  20 59 E3              JSR   L00_E359                     ;[x]
  E3F6  20 65 40              JSR   $4065                        ;[x]
  E3F9  64 34                 STZ   <$34                         ;[x]
L00_E3FB:
  E3FB  60                    RTS                                ;[x]

L00_E3FC:
  E3FC  24 34                 BIT   <$34                         ;[x]
  E3FE  30 23                 BMI   L00_E423                     ;[x]
  E400  48                    PHA                                ;[x]
  E401  A9 80                 LDA   #$80                         ;[x]
  E403  85 34                 STA   <$34                         ;[x]
  E405  43 04                 TMA   #$04                         ;[x]
  E407  8D 08 3F              STA   $3F08                        ;[x]
  E40A  A9 02                 LDA   #$02                         ;[x]
  E40C  20 59 E3              JSR   L00_E359                     ;[x]
  E40F  68                    PLA                                ;[x]
  E410  20 EE 4A              JSR   $4AEE                        ;[x]
  E413  AD 08 3F              LDA   $3F08                        ;[x]
  E416  53 04                 TAM   #$04                         ;[x]
  E418  1A                    INC   A                            ;[x]
  E419  53 08                 TAM   #$08                         ;[x]
  E41B  1A                    INC   A                            ;[x]
  E41C  53 10                 TAM   #$10                         ;[x]
  E41E  1A                    INC   A                            ;[x]
  E41F  53 20                 TAM   #$20                         ;[x]
  E421  64 34                 STZ   <$34                         ;[x]
L00_E423:
  E423  60                    RTS                                ;[x]

  E424  48                    PHA                                ;[x]
  E425  08                    PHP                                ;[x]
  E426  5A                    PHY                                ;[x]
  E427  43 04                 TMA   #$04                         ;[x]
  E429  48                    PHA                                ;[x]
  E42A  43 08                 TMA   #$08                         ;[x]
  E42C  48                    PHA                                ;[x]
  E42D  43 10                 TMA   #$10                         ;[x]
  E42F  48                    PHA                                ;[x]
  E430  43 20                 TMA   #$20                         ;[x]
  E432  48                    PHA                                ;[x]
  E433  43 40                 TMA   #$40                         ;[x]
  E435  48                    PHA                                ;[x]
  E436  A9 06                 LDA   #$06                         ;[x]
  E438  53 04                 TAM   #$04                         ;[x]
  E43A  1A                    INC   A                            ;[x]
  E43B  53 08                 TAM   #$08                         ;[x]
  E43D  1A                    INC   A                            ;[x]
  E43E  53 10                 TAM   #$10                         ;[x]
  E440  1A                    INC   A                            ;[x]
  E441  53 20                 TAM   #$20                         ;[x]
  E443  1A                    INC   A                            ;[x]
  E444  53 40                 TAM   #$40                         ;[x]
  E446  AD 12 28              LDA   $2812                        ;[x]
  E449  C9 00                 CMP   #$00                         ;[x]
  E44B  D0 66                 BNE   L00_E4B3                     ;[x]
  E44D  EE 22 28              INC   $2822                        ;[x]
  E450  AD 22 28              LDA   $2822                        ;[x]
  E453  C9 03                 CMP   #$03                         ;[x]
  E455  90 28                 BCC   L00_E47F                     ;[x]
  E457  9C 22 28              STZ   $2822                        ;[x]
  E45A  AD 20 28              LDA   $2820                        ;[x]
  E45D  F0 20                 BEQ   L00_E47F                     ;[x]
  E45F  C2                    CLY                                ;[x]
  E460  B1 5A                 LDA   (<$5A),Y                     ;[x]
  E462  A0 04                 LDY   #$04                         ;[x]
  E464  8C 00 08              STY   PSG_CH                       ;[x]
  E467  C9 FF                 CMP   #$FF                         ;[x]
  E469  F0 0D                 BEQ   L00_E478                     ;[x]
  E46B  4A                    LSR   A                            ;[x]
  E46C  4A                    LSR   A                            ;[x]
  E46D  8D 06 08              STA   PSG_WAVE                     ;[x]
  E470  E6 5A                 INC   <$5A                         ;[x]
  E472  D0 0B                 BNE   L00_E47F                     ;[x]
  E474  E6 5B                 INC   <$5B                         ;[x]
  E476  80 07                 BRA   L00_E47F                     ;[x]

L00_E478:
  E478  62                    CLA                                ;[x]
  E479  8D 20 28              STA   $2820                        ;[x]
  E47C  8D 05 08              STA   PSG_PAN                      ;[x]
L00_E47F:
  E47F  AD 21 28              LDA   $2821                        ;[x]
  E482  F0 24                 BEQ   L00_E4A8                     ;[x]
  E484  C2                    CLY                                ;[x]
  E485  B1 5C                 LDA   (<$5C),Y                     ;[x]
  E487  A0 00                 LDY   #$00                         ;[x]
  E489  8C 00 08              STY   PSG_CH                       ;[x]
  E48C  C9 FF                 CMP   #$FF                         ;[x]
  E48E  F0 0B                 BEQ   L00_E49B                     ;[x]
  E490  8D 06 08              STA   PSG_WAVE                     ;[x]
  E493  E6 5C                 INC   <$5C                         ;[x]
  E495  D0 11                 BNE   L00_E4A8                     ;[x]
  E497  E6 5D                 INC   <$5D                         ;[x]
  E499  80 0D                 BRA   L00_E4A8                     ;[x]

L00_E49B:
  E49B  62                    CLA                                ;[x]
  E49C  8D 1C 27              STA   $271C                        ;[x]
  E49F  8D 21 28              STA   $2821                        ;[x]
  E4A2  8D 04 08              STA   PSG_CTRL                     ;[x]
  E4A5  8D 05 08              STA   PSG_PAN                      ;[x]
L00_E4A8:
  E4A8  AC 11 28              LDY   $2811                        ;[x]
  E4AB  C0 06                 CPY   #$06                         ;[x]
  E4AD  D0 01                 BNE   L00_E4B0                     ;[x]
  E4AF  88                    DEY                                ;[x]
L00_E4B0:
  E4B0  8C 00 08              STY   PSG_CH                       ;[x]
L00_E4B3:
  E4B3  68                    PLA                                ;[x]
  E4B4  53 40                 TAM   #$40                         ;[x]
  E4B6  68                    PLA                                ;[x]
  E4B7  53 20                 TAM   #$20                         ;[x]
  E4B9  68                    PLA                                ;[x]
  E4BA  53 10                 TAM   #$10                         ;[x]
  E4BC  68                    PLA                                ;[x]
  E4BD  53 08                 TAM   #$08                         ;[x]
  E4BF  68                    PLA                                ;[x]
  E4C0  53 04                 TAM   #$04                         ;[x]
  E4C2  7A                    PLY                                ;[x]
  E4C3  28                    PLP                                ;[x]
  E4C4  68                    PLA                                ;[x]
  E4C5  8D 03 14              STA   IRQ_STATUS                   ;[x]
  E4C8  40                    RTI                                ;[x]

  E4C9  .db $00,$01,$00,$01,$00,$02,$02,$03,$03,$02,$03,$03,$0A,$02,$03,$1F
  E4D9  .db $04,$2B,$06,$1D,$05,$1D,$0A,$1E,$04,$08,$09,$09,$0A,$0A,$0A,$0B
  E4E9  .db $0B,$0B,$0C,$0C,$0C,$0D,$0D,$0D,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F
  E4F9  .db $0F,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
  E509  .db $0F,$0F,$0F,$0F,$0F,$0E,$0E,$0E,$0E,$0D,$0D,$0D,$0C,$0C,$0C,$0B
  E519  .db $0B,$0B,$0A,$0A,$0A,$09,$09,$08,$08,$08,$07,$07,$06,$06,$06,$05
  E529  .db $05,$05,$04,$04,$04,$03,$03,$03,$02,$02,$02,$02,$01,$01,$01,$01
  E539  .db $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  E549  .db $01,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05
  E559  .db $05,$05,$06,$06,$06,$07,$07,$08,$08
L00_E562:
  E562  E6 32                 INC   <$32                         ;[x]
  E564  A5 30                 LDA   <$30                         ;[x]
  E566  20 A2 E7              JSR   L00_E7A2                     ;[x]
  E569  .db $7B,$E5,$84,$E5,$AC,$E5,$39,$E6,$6A,$E6,$8B,$E6,$A3,$E6,$C3,$E6
  E579  .db $DD,$E6
L00_E57B:
  E57B  A9 01                 LDA   #$01                         ;[x]
  E57D  85 35                 STA   <$35                         ;[x]
  E57F  64 27                 STZ   <$27                         ;[x]
  E581  4C 0B E7              JMP   L00_E70B                     ;[x]

  E584  64 4C                 STZ   <$4C                         ;[x]
  E586  64 3B                 STZ   <$3B                         ;[x]
  E588  20 69 FA              JSR   L00_FA69                     ;[x]
  E58B  20 00 C0              JSR   $C000                        ;[x]
  E58E  20 55 FA              JSR   L00_FA55                     ;[x]
  E591  AD A0 3F              LDA   $3FA0                        ;[x]
  E594  29 10                 AND   #$10                         ;[x]
  E596  F0 05                 BEQ   L00_E59D                     ;[x]
  E598  A9 07                 LDA   #$07                         ;[ ]
  E59A  4C 0E E7              JMP   L00_E70E                     ;[ ]

L00_E59D:
  E59D  A5 37                 LDA   <$37                         ;[x]
  E59F  D0 01                 BNE   L00_E5A2                     ;[x]
  E5A1  60                    RTS                                ;[x]

L00_E5A2:
  E5A2  30 03                 BMI   L00_E5A7                     ;[x]
  E5A4  4C 0B E7              JMP   L00_E70B                     ;[ ]

L00_E5A7:
  E5A7  A9 03                 LDA   #$03                         ;[x]
  E5A9  4C 0E E7              JMP   L00_E70E                     ;[x]

  E5AC  .db $A5,$22,$29,$0C,$F0,$26,$F3,$C6,$FB,$B6,$3D,$40,$00,$AD,$B4,$3F
  E5BC  .db $85,$83,$AD,$B3,$3F,$85,$32,$AD,$B5,$3F,$8D,$80,$26,$A2,$02,$BD
  E5CC  .db $B0,$3F,$9D,$8E,$3F,$CA,$10,$F7,$62,$4C,$0E,$E7,$A6,$31,$D0,$35
  E5DC  .db $20,$D1,$E7,$A5,$83,$8D,$B4,$3F,$A5,$32,$8D,$B3,$3F,$AD,$80,$26
  E5EC  .db $8D,$B5,$3F,$64,$83,$64,$32,$9C,$3B,$3F,$9C,$3D,$3F,$A9,$01,$85
  E5FC  .db $35,$A2,$02,$BD,$8E,$3F,$9D,$B0,$3F,$CA,$10,$F7,$20,$61,$FB,$20
  E60C  .db $74,$E3,$4C,$15,$E7,$20,$9C,$F5,$A5,$37,$D0,$01,$60,$AD,$B4,$3F
  E61C  .db $85,$83,$AD,$B3,$3F,$85,$32,$AD,$B5,$3F,$8D,$80,$26,$A2,$02,$BD
  E62C  .db $B0,$3F,$9D,$8E,$3F,$CA,$10,$F7,$A9,$08,$4C,$0E,$E7
L00_E639:
  E639  A6 31                 LDX   <$31                         ;[x]
  E63B  D0 12                 BNE   L00_E64F                     ;[x]
  E63D  A9 11                 LDA   #$11                         ;[x]
  E63F  20 FC E3              JSR   L00_E3FC                     ;[x]
  E642  64 35                 STZ   <$35                         ;[x]
  E644  A9 03                 LDA   #$03                         ;[x]
  E646  85 27                 STA   <$27                         ;[x]
  E648  A9 50                 LDA   #$50                         ;[x]
  E64A  85 72                 STA   <$72                         ;[x]
  E64C  4C 15 E7              JMP   L00_E715                     ;[x]

L00_E64F:
  E64F  C6 72                 DEC   <$72                         ;[x]
  E651  F0 11                 BEQ   L00_E664                     ;[x]
  E653  A5 72                 LDA   <$72                         ;[x]
  E655  29 08                 AND   #$08                         ;[x]
  E657  0A                    ASL   A                            ;[x]
  E658  0A                    ASL   A                            ;[x]
  E659  0A                    ASL   A                            ;[x]
  E65A  0A                    ASL   A                            ;[x]
  E65B  AE 24 3F              LDX   $3F24                        ;[x]
  E65E  1D 67 E6              ORA   $E667,X                      ;[x]
  E661  4C 2B EE              JMP   L00_EE2B                     ;[x]

L00_E664:
  E664  4C 0B E7              JMP   L00_E70B                     ;[x]

  E667  .db $08,$09,$0A
L00_E66A:
  E66A  64 4C                 STZ   <$4C                         ;[x]
  E66C  64 3B                 STZ   <$3B                         ;[x]
  E66E  AD 24 3F              LDA   $3F24                        ;[x]
  E671  C9 02                 CMP   #$02                         ;[x]
  E673  F0 0E                 BEQ   L00_E683                     ;[x]
  E675  20 69 FA              JSR   L00_FA69                     ;[x]
  E678  20 82 C8              JSR   $C882                        ;[x]
  E67B  20 55 FA              JSR   L00_FA55                     ;[x]
  E67E  A5 37                 LDA   <$37                         ;[x]
  E680  D0 01                 BNE   L00_E683                     ;[x]
  E682  60                    RTS                                ;[x]

L00_E683:
  E683  20 D8 E7              JSR   L00_E7D8                     ;[x]
  E686  64 3F                 STZ   <$3F                         ;[x]
  E688  4C 0B E7              JMP   L00_E70B                     ;[x]

  E68B  20 A1 F5              JSR   L00_F5A1                     ;[x]
  E68E  20 AF EC              JSR   L00_ECAF                     ;[x]
  E691  A5 37                 LDA   <$37                         ;[x]
  E693  D0 01                 BNE   L00_E696                     ;[x]
  E695  60                    RTS                                ;[x]

L00_E696:
  E696  AD 24 3F              LDA   $3F24                        ;[ ]
  E699  C9 02                 CMP   #$02                         ;[ ]
  E69B  90 03                 BCC   L00_E6A0                     ;[ ]
  E69D  9C 24 3F              STZ   $3F24                        ;[ ]
L00_E6A0:
  E6A0  4C 0B E7              JMP   L00_E70B                     ;[ ]

  E6A3  64 4C                 STZ   <$4C                         ;[x]
  E6A5  A9 14                 LDA   #$14                         ;[x]
  E6A7  20 3D F0              JSR   L00_F03D                     ;[x]
  E6AA  20 2A C6              JSR   $C62A                        ;[x]
  E6AD  20 46 F0              JSR   L00_F046                     ;[x]
  E6B0  A5 37                 LDA   <$37                         ;[x]
  E6B2  D0 01                 BNE   L00_E6B5                     ;[x]
  E6B4  60                    RTS                                ;[x]

L00_E6B5:
  E6B5  A9 02                 LDA   #$02                         ;[x]
  E6B7  85 39                 STA   <$39                         ;[x]
  E6B9  8D A6 3F              STA   $3FA6                        ;[x]
  E6BC  62                    CLA                                ;[x]
  E6BD  8D C6 3D              STA   $3DC6                        ;[x]
  E6C0  4C 0E E7              JMP   L00_E70E                     ;[x]

  E6C3  .db $20,$69,$FA,$20,$09,$D1,$20,$55,$FA,$A5,$37,$D0,$01,$60,$AD,$A0
  E6D3  .db $3F,$29,$2F,$8D,$A0,$3F,$62,$4C,$0E,$E7,$A5,$22,$29,$0C,$F0,$0E
  E6E3  .db $F3,$C6,$FB,$B6,$3D,$40,$00,$20,$DD,$E3,$62,$4C,$0E,$E7,$20,$69
  E6F3  .db $FA,$20,$FD,$D1,$20,$55,$FA,$A5,$37,$D0,$01,$60,$F3,$C6,$FB,$B6
  E703  .db $3D,$40,$00,$A9,$06,$4C,$0E,$E7
L00_E70B:
  E70B  A5 30                 LDA   <$30                         ;[x]
  E70D  1A                    INC   A                            ;[x]
L00_E70E:
  E70E  85 30                 STA   <$30                         ;[x]
  E710  64 37                 STZ   <$37                         ;[x]
  E712  62                    CLA                                ;[x]
  E713  80 03                 BRA   L00_E718                     ;[x]

L00_E715:
  E715  A5 31                 LDA   <$31                         ;[x]
  E717  1A                    INC   A                            ;[x]
L00_E718:
  E718  85 31                 STA   <$31                         ;[x]
  E71A  64 38                 STZ   <$38                         ;[x]
  E71C  60                    RTS                                ;[x]

L00_E71D:
  E71D  C2                    CLY                                ;[x]
  E71E  A9 01                 LDA   #$01                         ;[x]
  E720  8D 00 10              STA   JOYPAD                       ;[x]
  E723  A9 03                 LDA   #$03                         ;[x]
  E725  8D 00 10              STA   JOYPAD                       ;[x]
L00_E728:
  E728  A9 01                 LDA   #$01                         ;[x]
  E72A  8D 00 10              STA   JOYPAD                       ;[x]
  E72D  48                    PHA                                ;[x]
  E72E  68                    PLA                                ;[x]
  E72F  EA                    NOP                                ;[x]
  E730  B9 18 20              LDA   $2018,Y                      ;[x]
  E733  99 1D 20              STA   $201D,Y                      ;[x]
  E736  AD 00 10              LDA   JOYPAD                       ;[x]
  E739  0A                    ASL   A                            ;[x]
  E73A  0A                    ASL   A                            ;[x]
  E73B  0A                    ASL   A                            ;[x]
  E73C  0A                    ASL   A                            ;[x]
  E73D  99 18 20              STA   $2018,Y                      ;[x]
  E740  9C 00 10              STZ   JOYPAD                       ;[x]
  E743  48                    PHA                                ;[x]
  E744  68                    PLA                                ;[x]
  E745  EA                    NOP                                ;[x]
  E746  AD 00 10              LDA   JOYPAD                       ;[x]
  E749  29 0F                 AND   #$0F                         ;[x]
  E74B  19 18 20              ORA   $2018,Y                      ;[x]
  E74E  49 FF                 EOR   #$FF                         ;[x]
  E750  99 18 20              STA   $2018,Y                      ;[x]
  E753  59 1D 20              EOR   $201D,Y                      ;[x]
  E756  39 18 20              AND   $2018,Y                      ;[x]
  E759  99 22 20              STA   $2022,Y                      ;[x]
  E75C  C8                    INY                                ;[x]
  E75D  C0 05                 CPY   #$05                         ;[x]
  E75F  90 C7                 BCC   L00_E728                     ;[x]
  E761  C2                    CLY                                ;[x]
L00_E762:
  E762  A5 27                 LDA   <$27                         ;[x]
  E764  39 80 E7              AND   $E780,Y                      ;[x]
  E767  F0 11                 BEQ   L00_E77A                     ;[x]
  E769  B9 22 20              LDA   $2022,Y                      ;[x]
  E76C  C9 04                 CMP   #$04                         ;[x]
  E76E  D0 0A                 BNE   L00_E77A                     ;[x]
  E770  B9 18 20              LDA   $2018,Y                      ;[ ]
  E773  C9 0C                 CMP   #$0C                         ;[ ]
  E775  D0 03                 BNE   L00_E77A                     ;[ ]
  E777  4C 51 E0              JMP   L00_E051                     ;[ ]

L00_E77A:
  E77A  C8                    INY                                ;[x]
  E77B  C0 05                 CPY   #$05                         ;[x]
  E77D  90 E3                 BCC   L00_E762                     ;[x]
  E77F  60                    RTS                                ;[x]

  E780  .db $01,$02,$04,$08,$10
L00_E785:
  E785  A9 02                 LDA   #$02                         ;[x]
  E787  80 09                 BRA   L00_E792                     ;[x]

L00_E789:
  E789  A9 01                 LDA   #$01                         ;[ ]
  E78B  80 05                 BRA   L00_E792                     ;[ ]

L00_E78D:
  E78D  62                    CLA                                ;[x]
  E78E  80 02                 BRA   L00_E792                     ;[x]

L00_E790:
  E790  A9 05                 LDA   #$05                         ;[x]
L00_E792:
  E792  8D 40 3F              STA   $3F40                        ;[x]
  E795  8D 00 00              STA   VDC_AR                       ;[x]
  E798  60                    RTS                                ;[x]

L00_E799:
  E799  62                    CLA                                ;[x]
  E79A  48                    PHA                                ;[x]
  E79B  44 F3                 BSR   L00_E790                     ;[x]
  E79D  68                    PLA                                ;[x]
  E79E  8D 03 00              STA   VDC_DATA_H                   ;[x]
  E7A1  60                    RTS                                ;[x]

L00_E7A2:
  E7A2  84 D9                 STY   <$D9                         ;[x]
  E7A4  0A                    ASL   A                            ;[x]
  E7A5  A8                    TAY                                ;[x]
  E7A6  68                    PLA                                ;[x]
  E7A7  85 D5                 STA   <$D5                         ;[x]
  E7A9  68                    PLA                                ;[x]
  E7AA  85 D6                 STA   <$D6                         ;[x]
  E7AC  C8                    INY                                ;[x]
  E7AD  B1 D5                 LDA   (<$D5),Y                     ;[x]
  E7AF  85 D7                 STA   <$D7                         ;[x]
  E7B1  C8                    INY                                ;[x]
  E7B2  B1 D5                 LDA   (<$D5),Y                     ;[x]
  E7B4  85 D8                 STA   <$D8                         ;[x]
  E7B6  A4 D9                 LDY   <$D9                         ;[x]
  E7B8  6C D7 20              JMP   ($20D7)                      ;[x]

L00_E7BB:
  E7BB  18                    CLC                                ;[x]
  E7BC  75 00                 ADC   <$00,X                       ;[x]
  E7BE  95 00                 STA   <$00,X                       ;[x]
  E7C0  90 02                 BCC   L00_E7C4                     ;[x]
  E7C2  F6 01                 INC   <$01,X                       ;[x]
L00_E7C4:
  E7C4  60                    RTS                                ;[x]

  E7C5  .db $49,$FF,$38,$75,$00,$95,$00,$B0,$F6,$D6,$01,$60
L00_E7D1:
  E7D1  F3 C6 FB 70 20 10 00  TAI   $FBC6,$2070,$0010            ;[x]
L00_E7D8:
  E7D8  F3 C6 FB 80 20 50 00  TAI   $FBC6,$2080,$0050            ;[x]
  E7DF  F3 C6 FB E0 3E 20 00  TAI   $FBC6,$3EE0,$0020            ;[x]
L00_E7E6:
  E7E6  F3 C6 FB 00 2A B6 13  TAI   $FBC6,$2A00,$13B6            ;[x]
  E7ED  60                    RTS                                ;[x]

L00_E7EE:
  E7EE  48                    PHA                                ;[x]
  E7EF  A5 35                 LDA   <$35                         ;[x]
  E7F1  F0 02                 BEQ   L00_E7F5                     ;[x]
  E7F3  68                    PLA                                ;[ ]
  E7F4  60                    RTS                                ;[ ]

L00_E7F5:
  E7F5  68                    PLA                                ;[x]
  E7F6  8E 92 3F              STX   $3F92                        ;[x]
  E7F9  8C 93 3F              STY   $3F93                        ;[x]
  E7FC  0A                    ASL   A                            ;[x]
  E7FD  0A                    ASL   A                            ;[x]
  E7FE  AA                    TAX                                ;[x]
  E7FF  C2                    CLY                                ;[x]
L00_E800:
  E800  BD 77 E8              LDA   $E877,X                      ;[x]
  E803  99 94 3F              STA   $3F94,Y                      ;[x]
  E806  E8                    INX                                ;[x]
  E807  C8                    INY                                ;[x]
  E808  C0 04                 CPY   #$04                         ;[x]
  E80A  90 F4                 BCC   L00_E800                     ;[x]
  E80C  AD 91 3F              LDA   $3F91                        ;[x]
  E80F  F0 05                 BEQ   L00_E816                     ;[x]
  E811  3A                    DEC   A                            ;[ ]
  E812  F0 08                 BEQ   L00_E81C                     ;[ ]
  E814  80 0C                 BRA   L00_E822                     ;[ ]

L00_E816:
  E816  A2 07                 LDX   #$07                         ;[x]
  E818  44 17                 BSR   L00_E831                     ;[x]
  E81A  80 0E                 BRA   L00_E82A                     ;[x]

L00_E81C:
  E81C  A2 0B                 LDX   #$0B                         ;[ ]
  E81E  44 11                 BSR   L00_E831                     ;[ ]
  E820  80 08                 BRA   L00_E82A                     ;[ ]

L00_E822:
  E822  A2 07                 LDX   #$07                         ;[ ]
  E824  44 0B                 BSR   L00_E831                     ;[ ]
  E826  A2 0B                 LDX   #$0B                         ;[ ]
  E828  44 07                 BSR   L00_E831                     ;[ ]
L00_E82A:
  E82A  AE 92 3F              LDX   $3F92                        ;[x]
  E82D  AC 93 3F              LDY   $3F93                        ;[x]
  E830  60                    RTS                                ;[x]

L00_E831:
  E831  8E 98 3F              STX   $3F98                        ;[x]
  E834  F8                    SED                                ;[x]
  E835  18                    CLC                                ;[x]
  E836  A0 03                 LDY   #$03                         ;[x]
L00_E838:
  E838  B9 94 3F              LDA   $3F94,Y                      ;[x]
  E83B  7D 80 3F              ADC   $3F80,X                      ;[x]
  E83E  9D 80 3F              STA   $3F80,X                      ;[x]
  E841  CA                    DEX                                ;[x]
  E842  88                    DEY                                ;[x]
  E843  10 F3                 BPL   L00_E838                     ;[x]
  E845  D8                    CLD                                ;[x]
  E846  90 0F                 BCC   L00_E857                     ;[x]
  E848  DA                    PHX                                ;[ ]
  E849  5A                    PHY                                ;[ ]
  E84A  A0 04                 LDY   #$04                         ;[ ]
  E84C  A9 99                 LDA   #$99                         ;[ ]
L00_E84E:
  E84E  E8                    INX                                ;[ ]
  E84F  9D 80 3F              STA   $3F80,X                      ;[ ]
  E852  88                    DEY                                ;[ ]
  E853  D0 F9                 BNE   L00_E84E                     ;[ ]
  E855  7A                    PLY                                ;[ ]
  E856  FA                    PLX                                ;[ ]
L00_E857:
  E857  C8                    INY                                ;[x]
  E858  E8                    INX                                ;[x]
  E859  B9 80 3F              LDA   $3F80,Y                      ;[x]
  E85C  DD 80 3F              CMP   $3F80,X                      ;[x]
  E85F  90 06                 BCC   L00_E867                     ;[x]
  E861  D0 13                 BNE   L00_E876                     ;[x]
  E863  C0 03                 CPY   #$03                         ;[x]
  E865  90 F0                 BCC   L00_E857                     ;[x]
L00_E867:
  E867  AE 98 3F              LDX   $3F98                        ;[x]
  E86A  A0 03                 LDY   #$03                         ;[x]
L00_E86C:
  E86C  BD 80 3F              LDA   $3F80,X                      ;[x]
  E86F  99 80 3F              STA   $3F80,Y                      ;[x]
  E872  CA                    DEX                                ;[x]
  E873  88                    DEY                                ;[x]
  E874  10 F6                 BPL   L00_E86C                     ;[x]
L00_E876:
  E876  60                    RTS                                ;[x]

  E877  .db $00,$00,$00,$50,$00,$00,$01,$00,$00,$00,$02,$00,$00,$00,$10,$00
  E887  .db $00,$00,$05,$00,$00,$00,$25,$00,$00,$00,$50,$00,$00,$01,$00,$00
  E897  .db $00,$02,$00,$00,$00,$03,$00,$00,$60
L00_E8A0:
  E8A0  A5 00                 LDA   <$00                         ;[x]
  E8A2  8D 8F 3F              STA   $3F8F                        ;[x]
  E8A5  49 FF                 EOR   #$FF                         ;[x]
  E8A7  8D 90 3F              STA   $3F90                        ;[x]
  E8AA  60                    RTS                                ;[x]

L00_E8AB:
  E8AB  AD 90 3F              LDA   $3F90                        ;[x]
  E8AE  29 6F                 AND   #$6F                         ;[x]
  E8B0  4D 8F 3F              EOR   $3F8F                        ;[x]
  E8B3  8D 8E 3F              STA   $3F8E                        ;[x]
  E8B6  4A                    LSR   A                            ;[x]
  E8B7  4A                    LSR   A                            ;[x]
  E8B8  4A                    LSR   A                            ;[x]
  E8B9  4A                    LSR   A                            ;[x]
  E8BA  4D 8E 3F              EOR   $3F8E                        ;[x]
  E8BD  8D 8E 3F              STA   $3F8E                        ;[x]
  E8C0  4A                    LSR   A                            ;[x]
  E8C1  4A                    LSR   A                            ;[x]
  E8C2  4D 8E 3F              EOR   $3F8E                        ;[x]
  E8C5  8D 8E 3F              STA   $3F8E                        ;[x]
  E8C8  4A                    LSR   A                            ;[x]
  E8C9  4D 8E 3F              EOR   $3F8E                        ;[x]
  E8CC  4A                    LSR   A                            ;[x]
  E8CD  6E 90 3F              ROR   $3F90                        ;[x]
  E8D0  6E 8F 3F              ROR   $3F8F                        ;[x]
  E8D3  60                    RTS                                ;[x]

L00_E8D4:
  E8D4  82                    CLX                                ;[x]
L00_E8D5:
  E8D5  C9 80                 CMP   #$80                         ;[x]
  E8D7  B0 11                 BCS   L00_E8EA                     ;[x]
  E8D9  0A                    ASL   A                            ;[x]
  E8DA  A8                    TAY                                ;[x]
  E8DB  44 29                 BSR   L00_E906                     ;[x]
  E8DD  B9 1D EB              LDA   $EB1D,Y                      ;[x]
  E8E0  9D 08 3B              STA   $3B08,X                      ;[x]
  E8E3  B9 1E EB              LDA   $EB1E,Y                      ;[x]
  E8E6  9D 10 3B              STA   $3B10,X                      ;[x]
  E8E9  60                    RTS                                ;[x]

L00_E8EA:
  E8EA  38                    SEC                                ;[x]
  E8EB  E9 80                 SBC   #$80                         ;[x]
  E8ED  0A                    ASL   A                            ;[x]
  E8EE  A8                    TAY                                ;[x]
  E8EF  44 15                 BSR   L00_E906                     ;[x]
  E8F1  B9 1D EC              LDA   $EC1D,Y                      ;[x]
  E8F4  9D 08 3B              STA   $3B08,X                      ;[x]
  E8F7  B9 1E EC              LDA   $EC1E,Y                      ;[x]
  E8FA  9D 10 3B              STA   $3B10,X                      ;[x]
  E8FD  60                    RTS                                ;[x]

  E8FE  .db $F3,$C6,$FB,$08,$3B,$40,$00,$60
L00_E906:
  E906  9E 08 3B              STZ   $3B08,X                      ;[x]
  E909  9E 10 3B              STZ   $3B10,X                      ;[x]
  E90C  9E 18 3B              STZ   $3B18,X                      ;[x]
  E90F  9E 20 3B              STZ   $3B20,X                      ;[x]
  E912  9E 28 3B              STZ   $3B28,X                      ;[x]
  E915  9E 30 3B              STZ   $3B30,X                      ;[x]
  E918  9E 38 3B              STZ   $3B38,X                      ;[x]
  E91B  9E 40 3B              STZ   $3B40,X                      ;[x]
  E91E  60                    RTS                                ;[x]

L00_E91F:
  E91F  A9 10                 LDA   #$10                         ;[x]
  E921  20 52 E3              JSR   L00_E352                     ;[x]
  E924  A2 07                 LDX   #$07                         ;[x]
L00_E926:
  E926  BD 08 3B              LDA   $3B08,X                      ;[x]
  E929  F0 06                 BEQ   L00_E931                     ;[x]
  E92B  86 B2                 STX   <$B2                         ;[x]
  E92D  44 08                 BSR   L00_E937                     ;[x]
  E92F  A6 B2                 LDX   <$B2                         ;[x]
L00_E931:
  E931  CA                    DEX                                ;[x]
  E932  10 F2                 BPL   L00_E926                     ;[x]
  E934  4C 65 E3              JMP   L00_E365                     ;[x]

L00_E937:
  E937  3A                    DEC   A                            ;[x]
  E938  F0 06                 BEQ   L00_E940                     ;[x]
  E93A  3A                    DEC   A                            ;[x]
  E93B  F0 64                 BEQ   L00_E9A1                     ;[x]
  E93D  4C 33 EA              JMP   L00_EA33                     ;[ ]

L00_E940:
  E940  BD 28 3B              LDA   $3B28,X                      ;[x]
  E943  F0 04                 BEQ   L00_E949                     ;[x]
  E945  DE 28 3B              DEC   $3B28,X                      ;[ ]
  E948  60                    RTS                                ;[ ]

L00_E949:
  E949  BD 10 3B              LDA   $3B10,X                      ;[x]
  E94C  30 0E                 BMI   L00_E95C                     ;[x]
  E94E  0A                    ASL   A                            ;[x]
  E94F  A8                    TAY                                ;[x]
  E950  B9 D7 74              LDA   $74D7,Y                      ;[x]
  E953  85 00                 STA   <$00                         ;[x]
  E955  B9 D8 74              LDA   $74D8,Y                      ;[x]
  E958  85 01                 STA   <$01                         ;[x]
  E95A  80 11                 BRA   L00_E96D                     ;[x]

L00_E95C:
  E95C  38                    SEC                                ;[x]
  E95D  E9 80                 SBC   #$80                         ;[x]
  E95F  0A                    ASL   A                            ;[x]
  E960  A8                    TAY                                ;[x]
  E961  B9 D7 75              LDA   $75D7,Y                      ;[x]
  E964  85 00                 STA   <$00                         ;[x]
  E966  B9 D8 75              LDA   $75D8,Y                      ;[x]
  E969  85 01                 STA   <$01                         ;[x]
  E96B  80 00                 BRA   L00_E96D                     ;[x]

L00_E96D:
  E96D  C2                    CLY                                ;[x]
  E96E  B1 00                 LDA   (<$00),Y                     ;[x]
  E970  9D 28 3B              STA   $3B28,X                      ;[x]
L00_E973:
  E973  BD 18 3B              LDA   $3B18,X                      ;[x]
  E976  0A                    ASL   A                            ;[x]
  E977  0A                    ASL   A                            ;[x]
  E978  1A                    INC   A                            ;[x]
  E979  1A                    INC   A                            ;[x]
  E97A  A8                    TAY                                ;[x]
  E97B  B1 00                 LDA   (<$00),Y                     ;[x]
  E97D  C9 FF                 CMP   #$FF                         ;[x]
  E97F  F0 08                 BEQ   L00_E989                     ;[x]
  E981  20 DD EA              JSR   L00_EADD                     ;[x]
  E984  FE 18 3B              INC   $3B18,X                      ;[x]
  E987  80 B7                 BRA   L00_E940                     ;[x]

L00_E989:
  E989  FE 20 3B              INC   $3B20,X                      ;[x]
  E98C  9E 18 3B              STZ   $3B18,X                      ;[x]
  E98F  A0 01                 LDY   #$01                         ;[x]
  E991  B1 00                 LDA   (<$00),Y                     ;[x]
  E993  30 DE                 BMI   L00_E973                     ;[x]
  E995  29 7F                 AND   #$7F                         ;[x]
  E997  DD 20 3B              CMP   $3B20,X                      ;[x]
  E99A  B0 D7                 BCS   L00_E973                     ;[x]
  E99C  4C 06 E9              JMP   L00_E906                     ;[x]

  E99F  .db $D7,$74
L00_E9A1:
  E9A1  BD 28 3B              LDA   $3B28,X                      ;[x]
  E9A4  F0 04                 BEQ   L00_E9AA                     ;[x]
  E9A6  DE 28 3B              DEC   $3B28,X                      ;[x]
  E9A9  60                    RTS                                ;[x]

L00_E9AA:
  E9AA  FE 20 3B              INC   $3B20,X                      ;[x]
  E9AD  BD 20 3B              LDA   $3B20,X                      ;[x]
  E9B0  C9 08                 CMP   #$08                         ;[x]
  E9B2  90 03                 BCC   L00_E9B7                     ;[x]
  E9B4  4C 06 E9              JMP   L00_E906                     ;[x]

L00_E9B7:
  E9B7  BD 10 3B              LDA   $3B10,X                      ;[x]
  E9BA  0A                    ASL   A                            ;[x]
  E9BB  A8                    TAY                                ;[x]
  E9BC  B9 63 7B              LDA   $7B63,Y                      ;[x]
  E9BF  85 00                 STA   <$00                         ;[x]
  E9C1  B9 64 7B              LDA   $7B64,Y                      ;[x]
  E9C4  85 01                 STA   <$01                         ;[x]
  E9C6  C2                    CLY                                ;[x]
  E9C7  B1 00                 LDA   (<$00),Y                     ;[x]
  E9C9  9D 28 3B              STA   $3B28,X                      ;[x]
  E9CC  C8                    INY                                ;[x]
L00_E9CD:
  E9CD  B1 00                 LDA   (<$00),Y                     ;[x]
  E9CF  C9 FF                 CMP   #$FF                         ;[x]
  E9D1  D0 01                 BNE   L00_E9D4                     ;[x]
  E9D3  60                    RTS                                ;[x]

L00_E9D4:
  E9D4  85 08                 STA   <$08                         ;[x]
  E9D6  8D 02 04              STA   VCE_ADDR_L                   ;[x]
  E9D9  C8                    INY                                ;[x]
  E9DA  B1 00                 LDA   (<$00),Y                     ;[x]
  E9DC  85 09                 STA   <$09                         ;[x]
  E9DE  8D 03 04              STA   VCE_ADDR_H                   ;[x]
  E9E1  C8                    INY                                ;[x]
  E9E2  F3 04 04 48 3B 20 00  TAI   $0404,$3B48,$0020            ;[x]
  E9E9  82                    CLX                                ;[x]
L00_E9EA:
  E9EA  BD 48 3B              LDA   $3B48,X                      ;[x]
  E9ED  29 07                 AND   #$07                         ;[x]
  E9EF  F0 01                 BEQ   L00_E9F2                     ;[x]
  E9F1  3A                    DEC   A                            ;[x]
L00_E9F2:
  E9F2  85 02                 STA   <$02                         ;[x]
  E9F4  BD 48 3B              LDA   $3B48,X                      ;[x]
  E9F7  29 38                 AND   #$38                         ;[x]
  E9F9  F0 03                 BEQ   L00_E9FE                     ;[x]
  E9FB  38                    SEC                                ;[x]
  E9FC  E9 08                 SBC   #$08                         ;[x]
L00_E9FE:
  E9FE  05 02                 ORA   <$02                         ;[x]
  EA00  85 02                 STA   <$02                         ;[x]
  EA02  BD 48 3B              LDA   $3B48,X                      ;[x]
  EA05  5E 49 3B              LSR   $3B49,X                      ;[x]
  EA08  6A                    ROR   A                            ;[x]
  EA09  29 E0                 AND   #$E0                         ;[x]
  EA0B  F0 03                 BEQ   L00_EA10                     ;[x]
  EA0D  38                    SEC                                ;[x]
  EA0E  E9 20                 SBC   #$20                         ;[x]
L00_EA10:
  EA10  0A                    ASL   A                            ;[x]
  EA11  3E 49 3B              ROL   $3B49,X                      ;[x]
  EA14  05 02                 ORA   <$02                         ;[x]
  EA16  9D 48 3B              STA   $3B48,X                      ;[x]
  EA19  E8                    INX                                ;[x]
  EA1A  E8                    INX                                ;[x]
  EA1B  E0 20                 CPX   #$20                         ;[x]
  EA1D  90 CB                 BCC   L00_E9EA                     ;[x]
  EA1F  A5 08                 LDA   <$08                         ;[x]
  EA21  8D 02 04              STA   VCE_ADDR_L                   ;[x]
  EA24  A5 09                 LDA   <$09                         ;[x]
  EA26  8D 03 04              STA   VCE_ADDR_H                   ;[x]
  EA29  E3 48 3B 04 04 20 00  TIA   $3B48,$0404,$0020            ;[x]
  EA30  4C CD E9              JMP   L00_E9CD                     ;[x]

L00_EA33:
  EA33  BD 28 3B              LDA   $3B28,X                      ;[ ]
  EA36  F0 04                 BEQ   L00_EA3C                     ;[ ]
  EA38  DE 28 3B              DEC   $3B28,X                      ;[ ]
  EA3B  60                    RTS                                ;[ ]

L00_EA3C:
  EA3C  FE 20 3B              INC   $3B20,X                      ;[ ]
  EA3F  38                    SEC                                ;[ ]
  EA40  A9 07                 LDA   #$07                         ;[ ]
  EA42  FD 20 3B              SBC   $3B20,X                      ;[ ]
  EA45  B0 03                 BCS   L00_EA4A                     ;[ ]
  EA47  4C 06 E9              JMP   L00_E906                     ;[ ]

L00_EA4A:
  EA4A  85 08                 STA   <$08                         ;[ ]
  EA4C  0A                    ASL   A                            ;[ ]
  EA4D  0A                    ASL   A                            ;[ ]
  EA4E  0A                    ASL   A                            ;[ ]
  EA4F  85 09                 STA   <$09                         ;[ ]
  EA51  0A                    ASL   A                            ;[ ]
  EA52  0A                    ASL   A                            ;[ ]
  EA53  85 0A                 STA   <$0A                         ;[ ]
  EA55  BD 10 3B              LDA   $3B10,X                      ;[ ]
  EA58  0A                    ASL   A                            ;[ ]
  EA59  A8                    TAY                                ;[ ]
  EA5A  B9 95 7B              LDA   $7B95,Y                      ;[ ]
  EA5D  85 00                 STA   <$00                         ;[ ]
  EA5F  B9 96 7B              LDA   $7B96,Y                      ;[ ]
  EA62  85 01                 STA   <$01                         ;[ ]
  EA64  C2                    CLY                                ;[ ]
  EA65  B1 00                 LDA   (<$00),Y                     ;[ ]
  EA67  9D 28 3B              STA   $3B28,X                      ;[ ]
  EA6A  C8                    INY                                ;[ ]
L00_EA6B:
  EA6B  B1 00                 LDA   (<$00),Y                     ;[ ]
  EA6D  C9 FF                 CMP   #$FF                         ;[ ]
  EA6F  D0 01                 BNE   L00_EA72                     ;[ ]
  EA71  60                    RTS                                ;[ ]

L00_EA72:
  EA72  8D 02 04              STA   VCE_ADDR_L                   ;[ ]
  EA75  C8                    INY                                ;[ ]
  EA76  B1 00                 LDA   (<$00),Y                     ;[ ]
  EA78  8D 03 04              STA   VCE_ADDR_H                   ;[ ]
  EA7B  C8                    INY                                ;[ ]
  EA7C  B1 00                 LDA   (<$00),Y                     ;[ ]
  EA7E  85 02                 STA   <$02                         ;[ ]
  EA80  C8                    INY                                ;[ ]
  EA81  B1 00                 LDA   (<$00),Y                     ;[ ]
  EA83  85 03                 STA   <$03                         ;[ ]
  EA85  C8                    INY                                ;[ ]
  EA86  84 B3                 STY   <$B3                         ;[ ]
  EA88  B2 02                 LDA   (<$02)                       ;[ ]
  EA8A  85 05                 STA   <$05                         ;[ ]
L00_EA8C:
  EA8C  A0 01                 LDY   #$01                         ;[ ]
  EA8E  B1 02                 LDA   (<$02),Y                     ;[ ]
  EA90  85 04                 STA   <$04                         ;[ ]
L00_EA92:
  EA92  C8                    INY                                ;[ ]
  EA93  B1 02                 LDA   (<$02),Y                     ;[ ]
  EA95  29 07                 AND   #$07                         ;[ ]
  EA97  38                    SEC                                ;[ ]
  EA98  E5 08                 SBC   <$08                         ;[ ]
  EA9A  B0 01                 BCS   L00_EA9D                     ;[ ]
  EA9C  62                    CLA                                ;[ ]
L00_EA9D:
  EA9D  85 0B                 STA   <$0B                         ;[ ]
  EA9F  B1 02                 LDA   (<$02),Y                     ;[ ]
  EAA1  29 38                 AND   #$38                         ;[ ]
  EAA3  38                    SEC                                ;[ ]
  EAA4  E5 09                 SBC   <$09                         ;[ ]
  EAA6  B0 01                 BCS   L00_EAA9                     ;[ ]
  EAA8  62                    CLA                                ;[ ]
L00_EAA9:
  EAA9  05 0B                 ORA   <$0B                         ;[ ]
  EAAB  85 0B                 STA   <$0B                         ;[ ]
  EAAD  B1 02                 LDA   (<$02),Y                     ;[ ]
  EAAF  06 04                 ASL   <$04                         ;[ ]
  EAB1  6A                    ROR   A                            ;[ ]
  EAB2  29 E0                 AND   #$E0                         ;[ ]
  EAB4  38                    SEC                                ;[ ]
  EAB5  E5 0A                 SBC   <$0A                         ;[ ]
  EAB7  B0 01                 BCS   L00_EABA                     ;[ ]
  EAB9  62                    CLA                                ;[ ]
L00_EABA:
  EABA  0A                    ASL   A                            ;[ ]
  EABB  05 0B                 ORA   <$0B                         ;[ ]
  EABD  8D 04 04              STA   VCE_DATA_L                   ;[ ]
  EAC0  62                    CLA                                ;[ ]
  EAC1  2A                    ROL   A                            ;[ ]
  EAC2  8D 05 04              STA   VCE_DATA_H                   ;[ ]
  EAC5  C0 09                 CPY   #$09                         ;[ ]
  EAC7  90 C9                 BCC   L00_EA92                     ;[ ]
  EAC9  A5 02                 LDA   <$02                         ;[ ]
  EACB  18                    CLC                                ;[ ]
  EACC  69 09                 ADC   #$09                         ;[ ]
  EACE  85 02                 STA   <$02                         ;[ ]
  EAD0  90 02                 BCC   L00_EAD4                     ;[ ]
  EAD2  E6 03                 INC   <$03                         ;[ ]
L00_EAD4:
  EAD4  C6 05                 DEC   <$05                         ;[ ]
  EAD6  10 B4                 BPL   L00_EA8C                     ;[ ]
  EAD8  A4 B3                 LDY   <$B3                         ;[ ]
  EADA  4C 6B EA              JMP   L00_EA6B                     ;[ ]

L00_EADD:
  EADD  B1 00                 LDA   (<$00),Y                     ;[x]
  EADF  8D 02 04              STA   VCE_ADDR_L                   ;[x]
  EAE2  C8                    INY                                ;[x]
  EAE3  B1 00                 LDA   (<$00),Y                     ;[x]
  EAE5  8D 03 04              STA   VCE_ADDR_H                   ;[x]
  EAE8  C8                    INY                                ;[x]
  EAE9  B1 00                 LDA   (<$00),Y                     ;[x]
  EAEB  85 02                 STA   <$02                         ;[x]
  EAED  C8                    INY                                ;[x]
  EAEE  B1 00                 LDA   (<$00),Y                     ;[x]
  EAF0  85 03                 STA   <$03                         ;[x]
  EAF2  B2 02                 LDA   (<$02)                       ;[x]
  EAF4  85 05                 STA   <$05                         ;[x]
L00_EAF6:
  EAF6  A0 01                 LDY   #$01                         ;[x]
  EAF8  B1 02                 LDA   (<$02),Y                     ;[x]
  EAFA  85 04                 STA   <$04                         ;[x]
L00_EAFC:
  EAFC  C8                    INY                                ;[x]
  EAFD  B1 02                 LDA   (<$02),Y                     ;[x]
  EAFF  8D 04 04              STA   VCE_DATA_L                   ;[x]
  EB02  62                    CLA                                ;[x]
  EB03  06 04                 ASL   <$04                         ;[x]
  EB05  2A                    ROL   A                            ;[x]
  EB06  8D 05 04              STA   VCE_DATA_H                   ;[x]
  EB09  C0 09                 CPY   #$09                         ;[x]
  EB0B  90 EF                 BCC   L00_EAFC                     ;[x]
  EB0D  18                    CLC                                ;[x]
  EB0E  A5 02                 LDA   <$02                         ;[x]
  EB10  69 09                 ADC   #$09                         ;[x]
  EB12  85 02                 STA   <$02                         ;[x]
  EB14  90 02                 BCC   L00_EB18                     ;[x]
  EB16  E6 03                 INC   <$03                         ;[x]
L00_EB18:
  EB18  C6 05                 DEC   <$05                         ;[x]
  EB1A  10 DA                 BPL   L00_EAF6                     ;[x]
  EB1C  60                    RTS                                ;[x]

  EB1D  .db $01,$00,$01,$01,$01,$02,$02,$00,$01,$03,$01,$04,$01,$05,$01,$09
  EB2D  .db $01,$0A,$01,$0B,$01,$06,$01,$07,$01,$08,$01,$0C,$01,$0D,$01,$0E
  EB3D  .db $01,$0F,$01,$10,$01,$13,$01,$12,$01,$11,$02,$01,$01,$14,$01,$15
  EB4D  .db $01,$16,$01,$17,$01,$18,$01,$19,$01,$1A,$01,$1B,$01,$1C,$01,$1D
  EB5D  .db $01,$1E,$01,$1F,$01,$20,$01,$21,$01,$22,$01,$23,$01,$24,$01,$25
  EB6D  .db $01,$26,$01,$27,$01,$28,$01,$29,$01,$2A,$01,$2B,$01,$2C,$01,$2D
  EB7D  .db $01,$2E,$01,$2F,$01,$30,$02,$02,$01,$31,$01,$32,$01,$33,$01,$34
  EB8D  .db $01,$35,$01,$36,$01,$37,$01,$38,$01,$39,$01,$3A,$01,$3B,$01,$3C
  EB9D  .db $01,$3D,$01,$3E,$01,$3F,$01,$40,$01,$41,$01,$42,$01,$43,$01,$44
  EBAD  .db $01,$45,$01,$46,$01,$47,$01,$48,$01,$49,$01,$4A,$01,$4B,$01,$4C
  EBBD  .db $01,$4D,$01,$4E,$01,$4F,$01,$50,$01,$51,$01,$52,$01,$53,$01,$54
  EBCD  .db $01,$55,$01,$56,$01,$57,$01,$58,$02,$03,$02,$04,$01,$59,$01,$5A
  EBDD  .db $01,$5B,$01,$5C,$01,$5D,$01,$5E,$01,$5F,$01,$60,$01,$61,$01,$62
  EBED  .db $01,$63,$01,$64,$03,$00,$01,$65,$01,$66,$01,$67,$01,$68,$01,$69
  EBFD  .db $01,$6A,$01,$71,$01,$73,$01,$6B,$01,$6C,$01,$6D,$01,$6E,$01,$6F
  EC0D  .db $01,$70,$01,$72,$01,$74,$01,$75,$01,$76,$01,$77,$01,$78,$01,$79
  EC1D  .db $01,$7A,$01,$7B,$01,$7C,$01,$7D,$01,$7E,$01,$7F,$01,$80,$01,$81
  EC2D  .db $01,$82,$01,$83,$01,$84,$01,$85,$01,$86,$01,$87,$01,$88,$01,$89
  EC3D  .db $01,$8A
L00_EC3F:
  EC3F  20 E6 E7              JSR   L00_E7E6                     ;[x]
L00_EC42:
  EC42  20 BC E3              JSR   L00_E3BC                     ;[x]
  EC45  A9 04                 LDA   #$04                         ;[x]
  EC47  85 39                 STA   <$39                         ;[x]
  EC49  64 45                 STZ   <$45                         ;[x]
  EC4B  64 4C                 STZ   <$4C                         ;[x]
  EC4D  9C B6 3D              STZ   $3DB6                        ;[x]
  EC50  9C B8 3D              STZ   $3DB8                        ;[x]
  EC53  9C BA 3D              STZ   $3DBA                        ;[x]
  EC56  9C BC 3D              STZ   $3DBC                        ;[x]
  EC59  20 99 E7              JSR   L00_E799                     ;[x]
  EC5C  20 8D E7              JSR   L00_E78D                     ;[x]
  EC5F  13 00                 ST1   #$00                         ;[x]
  EC61  23 00                 ST2   #$00                         ;[x]
  EC63  20 85 E7              JSR   L00_E785                     ;[x]
  EC66  82                    CLX                                ;[x]
  EC67  A0 0F                 LDY   #$0F                         ;[x]
L00_EC69:
  EC69  13 10                 ST1   #$10                         ;[x]
  EC6B  23 01                 ST2   #$01                         ;[x]
  EC6D  E8                    INX                                ;[x]
  EC6E  D0 F9                 BNE   L00_EC69                     ;[x]
  EC70  88                    DEY                                ;[x]
  EC71  10 F6                 BPL   L00_EC69                     ;[x]
  EC73  60                    RTS                                ;[x]

L00_EC74:
  EC74  48                    PHA                                ;[x]
  EC75  A0 03                 LDY   #$03                         ;[x]
  EC77  AD C8 3D              LDA   $3DC8                        ;[x]
  EC7A  85 00                 STA   <$00                         ;[x]
  EC7C  AD C9 3D              LDA   $3DC9                        ;[x]
  EC7F  85 01                 STA   <$01                         ;[x]
L00_EC81:
  EC81  20 8D E7              JSR   L00_E78D                     ;[x]
  EC84  A5 00                 LDA   <$00                         ;[x]
  EC86  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EC89  A5 01                 LDA   <$01                         ;[x]
  EC8B  8D 03 00              STA   VDC_DATA_H                   ;[x]
  EC8E  A2 20                 LDX   #$20                         ;[x]
  EC90  20 85 E7              JSR   L00_E785                     ;[x]
L00_EC93:
  EC93  68                    PLA                                ;[x]
  EC94  48                    PHA                                ;[x]
  EC95  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EC98  23 01                 ST2   #$01                         ;[x]
  EC9A  CA                    DEX                                ;[x]
  EC9B  D0 F6                 BNE   L00_EC93                     ;[x]
  EC9D  88                    DEY                                ;[x]
  EC9E  F0 0D                 BEQ   L00_ECAD                     ;[x]
  ECA0  A5 00                 LDA   <$00                         ;[x]
  ECA2  18                    CLC                                ;[x]
  ECA3  69 40                 ADC   #$40                         ;[x]
  ECA5  85 00                 STA   <$00                         ;[x]
  ECA7  90 D8                 BCC   L00_EC81                     ;[x]
  ECA9  E6 01                 INC   <$01                         ;[ ]
  ECAB  80 D4                 BRA   L00_EC81                     ;[ ]

L00_ECAD:
  ECAD  68                    PLA                                ;[x]
  ECAE  60                    RTS                                ;[x]

L00_ECAF:
  ECAF  A5 95                 LDA   <$95                         ;[x]
  ECB1  D0 01                 BNE   L00_ECB4                     ;[x]
  ECB3  60                    RTS                                ;[x]

L00_ECB4:
  ECB4  20 99 E7              JSR   L00_E799                     ;[x]
  ECB7  AD C8 3D              LDA   $3DC8                        ;[x]
  ECBA  85 17                 STA   <$17                         ;[x]
  ECBC  AD C9 3D              LDA   $3DC9                        ;[x]
  ECBF  85 16                 STA   <$16                         ;[x]
  ECC1  A5 96                 LDA   <$96                         ;[x]
  ECC3  1A                    INC   A                            ;[x]
  ECC4  C9 04                 CMP   #$04                         ;[x]
  ECC6  90 01                 BCC   L00_ECC9                     ;[x]
  ECC8  62                    CLA                                ;[x]
L00_ECC9:
  ECC9  85 96                 STA   <$96                         ;[x]
  ECCB  F0 43                 BEQ   L00_ED10                     ;[x]
  ECCD  3A                    DEC   A                            ;[x]
  ECCE  F0 06                 BEQ   L00_ECD6                     ;[x]
  ECD0  3A                    DEC   A                            ;[x]
  ECD1  F0 76                 BEQ   L00_ED49                     ;[x]
  ECD3  4C 5C ED              JMP   L00_ED5C                     ;[x]

L00_ECD6:
  ECD6  20 8D E7              JSR   L00_E78D                     ;[x]
  ECD9  A5 17                 LDA   <$17                         ;[x]
  ECDB  18                    CLC                                ;[x]
  ECDC  69 10                 ADC   #$10                         ;[x]
  ECDE  8D 02 00              STA   VDC_DATA_L                   ;[x]
  ECE1  62                    CLA                                ;[x]
  ECE2  65 16                 ADC   <$16                         ;[x]
  ECE4  8D 03 00              STA   VDC_DATA_H                   ;[x]
  ECE7  20 85 E7              JSR   L00_E785                     ;[x]
  ECEA  13 13                 ST1   #$13                         ;[x]
  ECEC  23 01                 ST2   #$01                         ;[x]
  ECEE  13 2A                 ST1   #$2A                         ;[x]
  ECF0  23 01                 ST2   #$01                         ;[x]
  ECF2  13 3E                 ST1   #$3E                         ;[x]
  ECF4  23 01                 ST2   #$01                         ;[x]
  ECF6  AD 8A 2F              LDA   $2F8A                        ;[x]
  ECF9  C9 06                 CMP   #$06                         ;[x]
  ECFB  B0 12                 BCS   L00_ED0F                     ;[x]
  ECFD  13 3F                 ST1   #$3F                         ;[ ]
  ECFF  23 11                 ST2   #$11                         ;[ ]
  ED01  A9 01                 LDA   #$01                         ;[ ]
  ED03  85 10                 STA   <$10                         ;[ ]
  ED05  A5 88                 LDA   <$88                         ;[ ]
  ED07  C9 9A                 CMP   #$9A                         ;[ ]
  ED09  90 01                 BCC   L00_ED0C                     ;[ ]
  ED0B  62                    CLA                                ;[ ]
L00_ED0C:
  ED0C  4C AC ED              JMP   L00_EDAC                     ;[ ]

L00_ED0F:
  ED0F  60                    RTS                                ;[x]

L00_ED10:
  ED10  20 8D E7              JSR   L00_E78D                     ;[x]
  ED13  A5 17                 LDA   <$17                         ;[x]
  ED15  18                    CLC                                ;[x]
  ED16  69 01                 ADC   #$01                         ;[x]
  ED18  8D 02 00              STA   VDC_DATA_L                   ;[x]
  ED1B  62                    CLA                                ;[x]
  ED1C  65 16                 ADC   <$16                         ;[x]
  ED1E  8D 03 00              STA   VDC_DATA_H                   ;[x]
  ED21  20 85 E7              JSR   L00_E785                     ;[x]
  ED24  13 12                 ST1   #$12                         ;[x]
  ED26  23 01                 ST2   #$01                         ;[x]
  ED28  13 2A                 ST1   #$2A                         ;[x]
  ED2A  23 01                 ST2   #$01                         ;[x]
  ED2C  13 3E                 ST1   #$3E                         ;[x]
  ED2E  23 01                 ST2   #$01                         ;[x]
  ED30  AD 89 2F              LDA   $2F89                        ;[x]
  ED33  C9 06                 CMP   #$06                         ;[x]
  ED35  B0 D8                 BCS   L00_ED0F                     ;[x]
  ED37  13 3F                 ST1   #$3F                         ;[x]
  ED39  23 01                 ST2   #$01                         ;[x]
  ED3B  A9 01                 LDA   #$01                         ;[x]
  ED3D  85 10                 STA   <$10                         ;[x]
  ED3F  A5 87                 LDA   <$87                         ;[x]
  ED41  C9 9A                 CMP   #$9A                         ;[x]
  ED43  90 01                 BCC   L00_ED46                     ;[x]
  ED45  62                    CLA                                ;[x]
L00_ED46:
  ED46  4C AC ED              JMP   L00_EDAC                     ;[x]

L00_ED49:
  ED49  A2 84                 LDX   #$84                         ;[x]
  ED4B  A0 45                 LDY   #$45                         ;[x]
  ED4D  AD 89 2F              LDA   $2F89                        ;[x]
  ED50  C9 06                 CMP   #$06                         ;[x]
  ED52  D0 06                 BNE   L00_ED5A                     ;[x]
  ED54  AD 38 3F              LDA   $3F38                        ;[x]
  ED57  4C E4 ED              JMP   L00_EDE4                     ;[x]

L00_ED5A:
  ED5A  80 11                 BRA   L00_ED6D                     ;[x]

L00_ED5C:
  ED5C  A2 88                 LDX   #$88                         ;[x]
  ED5E  A0 54                 LDY   #$54                         ;[x]
  ED60  AD 8A 2F              LDA   $2F8A                        ;[x]
  ED63  C9 06                 CMP   #$06                         ;[x]
  ED65  D0 06                 BNE   L00_ED6D                     ;[x]
  ED67  AD 39 3F              LDA   $3F39                        ;[x]
  ED6A  4C E4 ED              JMP   L00_EDE4                     ;[x]

L00_ED6D:
  ED6D  20 8D E7              JSR   L00_E78D                     ;[x]
  ED70  98                    TYA                                ;[x]
  ED71  18                    CLC                                ;[x]
  ED72  65 17                 ADC   <$17                         ;[x]
  ED74  8D 02 00              STA   VDC_DATA_L                   ;[x]
  ED77  62                    CLA                                ;[x]
  ED78  65 16                 ADC   <$16                         ;[x]
  ED7A  8D 03 00              STA   VDC_DATA_H                   ;[x]
  ED7D  86 12                 STX   <$12                         ;[x]
  ED7F  A2 3F                 LDX   #$3F                         ;[x]
  ED81  86 13                 STX   <$13                         ;[x]
  ED83  64 10                 STZ   <$10                         ;[x]
  ED85  20 85 E7              JSR   L00_E785                     ;[x]
  ED88  C2                    CLY                                ;[x]
  ED89  44 1E                 BSR   L00_EDA9                     ;[x]
  ED8B  44 1C                 BSR   L00_EDA9                     ;[x]
  ED8D  44 1A                 BSR   L00_EDA9                     ;[x]
  ED8F  44 16                 BSR   L00_EDA7                     ;[x]
  ED91  60                    RTS                                ;[x]

  ED92  .db $48,$20,$8D,$E7,$98,$18,$65,$17,$8D,$02,$00,$62,$65,$16,$8D,$03
  EDA2  .db $00,$68,$4C,$31,$EE
L00_EDA7:
  EDA7  E6 10                 INC   <$10                         ;[x]
L00_EDA9:
  EDA9  B1 12                 LDA   (<$12),Y                     ;[x]
  EDAB  C8                    INY                                ;[x]
L00_EDAC:
  EDAC  85 00                 STA   <$00                         ;[x]
  EDAE  4A                    LSR   A                            ;[x]
  EDAF  4A                    LSR   A                            ;[x]
  EDB0  4A                    LSR   A                            ;[x]
  EDB1  4A                    LSR   A                            ;[x]
  EDB2  44 06                 BSR   L00_EDBA                     ;[x]
  EDB4  A5 00                 LDA   <$00                         ;[x]
  EDB6  29 0F                 AND   #$0F                         ;[x]
  EDB8  80 0C                 BRA   L00_EDC6                     ;[x]

L00_EDBA:
  EDBA  A6 10                 LDX   <$10                         ;[x]
  EDBC  E0 02                 CPX   #$02                         ;[x]
  EDBE  B0 10                 BCS   L00_EDD0                     ;[x]
  EDC0  C9 00                 CMP   #$00                         ;[x]
  EDC2  F0 15                 BEQ   L00_EDD9                     ;[x]
  EDC4  80 0A                 BRA   L00_EDD0                     ;[x]

L00_EDC6:
  EDC6  A6 10                 LDX   <$10                         ;[x]
  EDC8  E0 01                 CPX   #$01                         ;[x]
  EDCA  B0 04                 BCS   L00_EDD0                     ;[x]
  EDCC  C9 00                 CMP   #$00                         ;[x]
  EDCE  F0 09                 BEQ   L00_EDD9                     ;[x]
L00_EDD0:
  EDD0  A2 02                 LDX   #$02                         ;[x]
  EDD2  86 10                 STX   <$10                         ;[x]
  EDD4  18                    CLC                                ;[x]
  EDD5  69 11                 ADC   #$11                         ;[x]
  EDD7  80 02                 BRA   L00_EDDB                     ;[x]

L00_EDD9:
  EDD9  A9 3E                 LDA   #$3E                         ;[x]
L00_EDDB:
  EDDB  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EDDE  A9 01                 LDA   #$01                         ;[x]
  EDE0  8D 03 00              STA   VDC_DATA_H                   ;[x]
  EDE3  60                    RTS                                ;[x]

L00_EDE4:
  EDE4  48                    PHA                                ;[x]
  EDE5  20 8D E7              JSR   L00_E78D                     ;[x]
  EDE8  98                    TYA                                ;[x]
  EDE9  18                    CLC                                ;[x]
  EDEA  65 17                 ADC   <$17                         ;[x]
  EDEC  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EDEF  62                    CLA                                ;[x]
  EDF0  65 16                 ADC   <$16                         ;[x]
  EDF2  8D 03 00              STA   VDC_DATA_H                   ;[x]
  EDF5  20 85 E7              JSR   L00_E785                     ;[x]
  EDF8  C2                    CLY                                ;[x]
L00_EDF9:
  EDF9  B9 16 EE              LDA   $EE16,Y                      ;[x]
  EDFC  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EDFF  A9 01                 LDA   #$01                         ;[x]
  EE01  8D 03 00              STA   VDC_DATA_H                   ;[x]
  EE04  C8                    INY                                ;[x]
  EE05  C0 07                 CPY   #$07                         ;[x]
  EE07  90 F0                 BCC   L00_EDF9                     ;[x]
  EE09  68                    PLA                                ;[x]
  EE0A  18                    CLC                                ;[x]
  EE0B  69 11                 ADC   #$11                         ;[x]
  EE0D  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EE10  A9 01                 LDA   #$01                         ;[x]
  EE12  8D 03 00              STA   VDC_DATA_H                   ;[x]
  EE15  60                    RTS                                ;[x]

  EE16  .db $1D,$2C,$1F,$1E,$23,$2E,$3E,$64,$02,$84,$04,$80,$13,$84,$04,$A2
  EE26  .db $02,$86,$02,$80,$0B
L00_EE2B:
  EE2B  A2 02                 LDX   #$02                         ;[x]
  EE2D  86 02                 STX   <$02                         ;[x]
  EE2F  80 02                 BRA   L00_EE33                     ;[x]

  EE31  .db $64,$02
L00_EE33:
  EE33  C2                    CLY                                ;[x]
  EE34  84 04                 STY   <$04                         ;[x]
  EE36  85 03                 STA   <$03                         ;[x]
  EE38  0A                    ASL   A                            ;[x]
  EE39  AA                    TAX                                ;[x]
  EE3A  BD 91 EE              LDA   $EE91,X                      ;[x]
  EE3D  85 00                 STA   <$00                         ;[x]
  EE3F  BD 92 EE              LDA   $EE92,X                      ;[x]
  EE42  85 01                 STA   <$01                         ;[x]
  EE44  20 99 E7              JSR   L00_E799                     ;[x]
  EE47  C2                    CLY                                ;[x]
  EE48  A5 04                 LDA   <$04                         ;[x]
  EE4A  D0 04                 BNE   L00_EE50                     ;[x]
  EE4C  A2 01                 LDX   #$01                         ;[x]
  EE4E  86 04                 STX   <$04                         ;[x]
L00_EE50:
  EE50  A5 02                 LDA   <$02                         ;[x]
  EE52  F0 0F                 BEQ   L00_EE63                     ;[x]
L00_EE54:
  EE54  20 8D E7              JSR   L00_E78D                     ;[x]
  EE57  B1 00                 LDA   (<$00),Y                     ;[x]
  EE59  C8                    INY                                ;[x]
  EE5A  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EE5D  B1 00                 LDA   (<$00),Y                     ;[x]
  EE5F  C8                    INY                                ;[x]
  EE60  8D 03 00              STA   VDC_DATA_H                   ;[x]
L00_EE63:
  EE63  20 85 E7              JSR   L00_E785                     ;[x]
L00_EE66:
  EE66  A6 04                 LDX   <$04                         ;[x]
  EE68  B1 00                 LDA   (<$00),Y                     ;[x]
  EE6A  C8                    INY                                ;[x]
  EE6B  C9 FF                 CMP   #$FF                         ;[x]
  EE6D  F0 21                 BEQ   L00_EE90                     ;[x]
  EE6F  C9 FE                 CMP   #$FE                         ;[x]
  EE71  F0 E1                 BEQ   L00_EE54                     ;[x]
  EE73  C9 FD                 CMP   #$FD                         ;[x]
  EE75  F0 12                 BEQ   L00_EE89                     ;[x]
  EE77  7F 03 02              BBR7  <$03,L00_EE7C                ;[x]
  EE7A  A9 10                 LDA   #$10                         ;[x]
L00_EE7C:
  EE7C  8D 02 00              STA   VDC_DATA_L                   ;[x]
  EE7F  7F 03 02              BBR7  <$03,L00_EE84                ;[x]
  EE82  A2 01                 LDX   #$01                         ;[x]
L00_EE84:
  EE84  8E 03 00              STX   VDC_DATA_H                   ;[x]
  EE87  80 DD                 BRA   L00_EE66                     ;[x]

L00_EE89:
  EE89  B1 00                 LDA   (<$00),Y                     ;[x]
  EE8B  C8                    INY                                ;[x]
  EE8C  85 04                 STA   <$04                         ;[x]
  EE8E  80 D6                 BRA   L00_EE66                     ;[x]

L00_EE90:
  EE90  60                    RTS                                ;[x]

  EE91  .db $BD,$EE,$C9,$EE,$D5,$EE,$E1,$EE,$ED,$EE,$16,$EF,$24,$EF,$34,$EF
  EEA1  .db $42,$EF,$4F,$EF,$5D,$EF,$68,$EF,$99,$EF,$D6,$EF,$1C,$F0,$22,$F0
  EEB1  .db $22,$F0,$22,$F0,$22,$F0,$3D,$F0,$3D,$F0,$3D,$F0,$60,$00,$FD,$31
  EEC1  .db $96,$97,$FE,$E0,$00,$98,$99,$FF,$60,$00,$FD,$31,$9A,$9B,$FE,$E0
  EED1  .db $00,$9C,$9D,$FF,$60,$00,$FD,$31,$9E,$9F,$FE,$E0,$00,$A0,$A1,$FF
  EEE1  .db $60,$00,$FD,$31,$A2,$A3,$FE,$E0,$00,$A4,$A5,$FF,$4A,$06,$FD,$01
  EEF1  .db $37,$10,$12,$1A,$1A,$13,$10,$25,$29,$28,$1B,$27,$23,$FE,$86,$06
  EF01  .db $1B,$26,$26,$10,$2C,$23,$21,$22,$2E,$2D,$10,$2C,$1F,$2D,$1F,$2C
  EF11  .db $30,$1F,$1E,$35,$FF,$8B,$04,$FD,$01,$38,$FE,$0B,$05,$10,$FE,$8B
  EF21  .db $05,$10,$FF,$8B,$04,$FD,$01,$10,$FE,$0B,$05,$38,$FE,$8B,$05,$FD
  EF31  .db $01,$10,$FF,$8B,$04,$FD,$01,$10,$FE,$0B,$05,$10,$FE,$8B,$05,$38
  EF41  .db $FF,$8D,$04,$FD,$01,$12,$10,$2A,$26,$1B,$33,$1F,$2C,$FF,$0D,$05
  EF51  .db $FD,$01,$13,$10,$2A,$26,$1B,$33,$1F,$2C,$2D,$FF,$8D,$05,$FD,$01
  EF61  .db $29,$2A,$2E,$23,$29,$28,$FF,$49,$01,$FD,$01,$29,$2A,$2E,$23,$29
  EF71  .db $28,$10,$27,$29,$1E,$1F,$FE,$09,$02,$2C,$1B,$28,$25,$FE,$89,$02
  EF81  .db $1D,$2C,$1F,$1E,$23,$2E,$FE,$09,$03,$2A,$26,$1B,$33,$1F,$2C,$FE
  EF91  .db $89,$03,$2D,$29,$2F,$28,$1E,$FF,$4A,$01,$FD,$01,$30,$23,$2D,$2F
  EFA1  .db $1B,$26,$10,$2E,$1F,$2D,$2E,$FE,$0F,$02,$2D,$2E,$1B,$21,$1F,$12
  EFB1  .db $FE,$8F,$02,$2D,$2E,$1B,$21,$1F,$13,$FE,$0F,$03,$2D,$2E,$1B,$21
  EFC1  .db $1F,$14,$FE,$8F,$03,$2D,$2E,$1B,$21,$1F,$15,$FE,$0F,$04,$2D,$2E
  EFD1  .db $1B,$21,$1F,$16,$FF,$4A,$01,$FD,$01,$30,$23,$2D,$2F,$1B,$26,$10
  EFE1  .db $2E,$1F,$2D,$2E,$FE,$0F,$02,$2D,$2E,$1B,$21,$1F,$12,$FE,$8F,$02
  EFF1  .db $2D,$2E,$1B,$21,$1F,$13,$FE,$0F,$03,$2D,$2E,$1B,$21,$1F,$14,$FE
  F001  .db $8F,$03,$2D,$2E,$1B,$21,$1F,$15,$FE,$0F,$04,$2D,$2E,$1B,$21,$1F
  F011  .db $16,$FE,$8F,$04,$1F,$28,$1E,$23,$28,$21,$FF,$10,$10,$22,$23,$10
  F021  .db $FF,$50,$01,$FD,$01,$2D,$2E,$1B,$21,$1F,$10,$2D,$1F,$26,$1F,$1D
  F031  .db $2E,$FE,$94,$01,$2D,$2E,$1B,$21,$1F,$10,$12,$FF
L00_F03D:
  F03D  48                    PHA                                ;[x]
  F03E  43 40                 TMA   #$40                         ;[x]
  F040  85 DA                 STA   <$DA                         ;[x]
  F042  68                    PLA                                ;[x]
  F043  53 40                 TAM   #$40                         ;[x]
  F045  60                    RTS                                ;[x]

L00_F046:
  F046  A5 DA                 LDA   <$DA                         ;[x]
  F048  53 40                 TAM   #$40                         ;[x]
  F04A  60                    RTS                                ;[x]

L00_F04B:
  F04B  9E 88 3B              STZ   $3B88,X                      ;[x]
  F04E  9E 90 3B              STZ   $3B90,X                      ;[x]
  F051  9E 98 3B              STZ   $3B98,X                      ;[x]
  F054  9E A0 3B              STZ   $3BA0,X                      ;[x]
  F057  9E A8 3B              STZ   $3BA8,X                      ;[x]
  F05A  9E B0 3B              STZ   $3BB0,X                      ;[x]
  F05D  9E B8 3B              STZ   $3BB8,X                      ;[x]
  F060  9E C0 3B              STZ   $3BC0,X                      ;[x]
  F063  60                    RTS                                ;[x]

L00_F064:
  F064  82                    CLX                                ;[x]
L00_F065:
  F065  44 E4                 BSR   L00_F04B                     ;[x]
  F067  0A                    ASL   A                            ;[x]
  F068  A8                    TAY                                ;[x]
  F069  B9 24 F5              LDA   $F524,Y                      ;[x]
  F06C  9D 88 3B              STA   $3B88,X                      ;[x]
  F06F  B9 25 F5              LDA   $F525,Y                      ;[x]
  F072  9D 90 3B              STA   $3B90,X                      ;[x]
  F075  60                    RTS                                ;[x]

L00_F076:
  F076  C2                    CLY                                ;[ ]
  F077  02                    SXY                                ;[ ]
  F078  44 D1                 BSR   L00_F04B                     ;[ ]
  F07A  9D C0 3B              STA   $3BC0,X                      ;[ ]
  F07D  A9 02                 LDA   #$02                         ;[ ]
  F07F  9D 88 3B              STA   $3B88,X                      ;[ ]
  F082  98                    TYA                                ;[ ]
  F083  9D B0 3B              STA   $3BB0,X                      ;[ ]
  F086  AA                    TAX                                ;[ ]
  F087  60                    RTS                                ;[ ]

L00_F088:
  F088  A5 3B                 LDA   <$3B                         ;[x]
  F08A  D0 15                 BNE   L00_F0A1                     ;[x]
  F08C  A9 14                 LDA   #$14                         ;[x]
  F08E  20 3D F0              JSR   L00_F03D                     ;[x]
  F091  A2 07                 LDX   #$07                         ;[x]
L00_F093:
  F093  BD 88 3B              LDA   $3B88,X                      ;[x]
  F096  F0 06                 BEQ   L00_F09E                     ;[x]
  F098  86 B2                 STX   <$B2                         ;[x]
  F09A  44 08                 BSR   L00_F0A4                     ;[x]
  F09C  A6 B2                 LDX   <$B2                         ;[x]
L00_F09E:
  F09E  CA                    DEX                                ;[x]
  F09F  10 F2                 BPL   L00_F093                     ;[x]
L00_F0A1:
  F0A1  4C 46 F0              JMP   L00_F046                     ;[x]

L00_F0A4:
  F0A4  3A                    DEC   A                            ;[x]
  F0A5  F0 06                 BEQ   L00_F0AD                     ;[x]
  F0A7  3A                    DEC   A                            ;[x]
  F0A8  F0 57                 BEQ   L00_F101                     ;[x]
  F0AA  4C 23 F4              JMP   L00_F423                     ;[x]

L00_F0AD:
  F0AD  BD A8 3B              LDA   $3BA8,X                      ;[x]
  F0B0  F0 04                 BEQ   L00_F0B6                     ;[x]
  F0B2  DE A8 3B              DEC   $3BA8,X                      ;[ ]
  F0B5  60                    RTS                                ;[ ]

L00_F0B6:
  F0B6  BD 90 3B              LDA   $3B90,X                      ;[x]
  F0B9  0A                    ASL   A                            ;[x]
  F0BA  A8                    TAY                                ;[x]
  F0BB  B9 59 C1              LDA   $C159,Y                      ;[x]
  F0BE  85 00                 STA   <$00                         ;[x]
  F0C0  B9 5A C1              LDA   $C15A,Y                      ;[x]
  F0C3  85 01                 STA   <$01                         ;[x]
  F0C5  C2                    CLY                                ;[x]
  F0C6  B1 00                 LDA   (<$00),Y                     ;[x]
  F0C8  9D A8 3B              STA   $3BA8,X                      ;[x]
L00_F0CB:
  F0CB  BD 98 3B              LDA   $3B98,X                      ;[x]
  F0CE  0A                    ASL   A                            ;[x]
  F0CF  A8                    TAY                                ;[x]
  F0D0  C8                    INY                                ;[x]
  F0D1  C8                    INY                                ;[x]
  F0D2  B1 00                 LDA   (<$00),Y                     ;[x]
  F0D4  85 08                 STA   <$08                         ;[x]
  F0D6  C8                    INY                                ;[x]
  F0D7  B1 00                 LDA   (<$00),Y                     ;[x]
  F0D9  85 09                 STA   <$09                         ;[x]
  F0DB  25 08                 AND   <$08                         ;[x]
  F0DD  C9 FF                 CMP   #$FF                         ;[x]
  F0DF  F0 0A                 BEQ   L00_F0EB                     ;[x]
  F0E1  20 8B F1              JSR   L00_F18B                     ;[x]
  F0E4  A6 B2                 LDX   <$B2                         ;[x]
  F0E6  FE 98 3B              INC   $3B98,X                      ;[x]
  F0E9  80 C2                 BRA   L00_F0AD                     ;[x]

L00_F0EB:
  F0EB  FE A0 3B              INC   $3BA0,X                      ;[x]
  F0EE  9E 98 3B              STZ   $3B98,X                      ;[x]
  F0F1  A0 01                 LDY   #$01                         ;[x]
  F0F3  B1 00                 LDA   (<$00),Y                     ;[x]
  F0F5  30 D4                 BMI   L00_F0CB                     ;[x]
  F0F7  29 7F                 AND   #$7F                         ;[x]
  F0F9  DD A0 3B              CMP   $3BA0,X                      ;[x]
  F0FC  B0 CD                 BCS   L00_F0CB                     ;[x]
  F0FE  4C 4B F0              JMP   L00_F04B                     ;[x]

L00_F101:
  F101  BC B0 3B              LDY   $3BB0,X                      ;[ ]
  F104  B9 1C 2F              LDA   $2F1C,Y                      ;[ ]
  F107  D0 03                 BNE   L00_F10C                     ;[ ]
  F109  4C 4B F0              JMP   L00_F04B                     ;[ ]

L00_F10C:
  F10C  B9 EC 35              LDA   $35EC,Y                      ;[ ]
  F10F  DD B8 3B              CMP   $3BB8,X                      ;[ ]
  F112  D0 01                 BNE   L00_F115                     ;[ ]
  F114  60                    RTS                                ;[ ]

L00_F115:
  F115  9D B8 3B              STA   $3BB8,X                      ;[ ]
  F118  BD C0 3B              LDA   $3BC0,X                      ;[ ]
  F11B  0A                    ASL   A                            ;[ ]
  F11C  A8                    TAY                                ;[ ]
  F11D  B9 0D C2              LDA   $C20D,Y                      ;[ ]
  F120  85 08                 STA   <$08                         ;[ ]
  F122  B9 0E C2              LDA   $C20E,Y                      ;[ ]
  F125  85 09                 STA   <$09                         ;[ ]
  F127  BD B8 3B              LDA   $3BB8,X                      ;[ ]
  F12A  0A                    ASL   A                            ;[ ]
  F12B  A8                    TAY                                ;[ ]
  F12C  B1 08                 LDA   (<$08),Y                     ;[ ]
  F12E  85 00                 STA   <$00                         ;[ ]
  F130  C8                    INY                                ;[ ]
  F131  B1 08                 LDA   (<$08),Y                     ;[ ]
  F133  85 01                 STA   <$01                         ;[ ]
  F135  64 06                 STZ   <$06                         ;[ ]
  F137  C2                    CLY                                ;[ ]
  F138  B1 00                 LDA   (<$00),Y                     ;[ ]
  F13A  20 52 E3              JSR   L00_E352                     ;[ ]
  F13D  C8                    INY                                ;[ ]
  F13E  B1 00                 LDA   (<$00),Y                     ;[ ]
L00_F140:
  F140  85 06                 STA   <$06                         ;[ ]
  F142  C8                    INY                                ;[ ]
  F143  B1 00                 LDA   (<$00),Y                     ;[ ]
  F145  85 02                 STA   <$02                         ;[ ]
  F147  C8                    INY                                ;[ ]
  F148  B1 00                 LDA   (<$00),Y                     ;[ ]
  F14A  85 03                 STA   <$03                         ;[ ]
  F14C  20 8D E7              JSR   L00_E78D                     ;[ ]
  F14F  A5 02                 LDA   <$02                         ;[ ]
  F151  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  F154  A5 03                 LDA   <$03                         ;[ ]
  F156  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  F159  20 85 E7              JSR   L00_E785                     ;[ ]
  F15C  C8                    INY                                ;[ ]
  F15D  B1 00                 LDA   (<$00),Y                     ;[ ]
  F15F  85 04                 STA   <$04                         ;[ ]
  F161  C8                    INY                                ;[ ]
  F162  B1 00                 LDA   (<$00),Y                     ;[ ]
  F164  85 05                 STA   <$05                         ;[ ]
  F166  5A                    PHY                                ;[ ]
  F167  20 71 F4              JSR   L00_F471                     ;[ ]
  F16A  7A                    PLY                                ;[ ]
  F16B  C8                    INY                                ;[ ]
  F16C  B1 00                 LDA   (<$00),Y                     ;[ ]
  F16E  C9 FF                 CMP   #$FF                         ;[ ]
  F170  D0 CE                 BNE   L00_F140                     ;[ ]
  F172  60                    RTS                                ;[ ]

L00_F173:
  F173  48                    PHA                                ;[x]
  F174  A9 14                 LDA   #$14                         ;[x]
  F176  20 3D F0              JSR   L00_F03D                     ;[x]
  F179  68                    PLA                                ;[x]
  F17A  44 03                 BSR   L00_F17F                     ;[x]
  F17C  4C 46 F0              JMP   L00_F046                     ;[x]

L00_F17F:
  F17F  0A                    ASL   A                            ;[x]
  F180  A8                    TAY                                ;[x]
  F181  B9 9A F5              LDA   $F59A,Y                      ;[x]
  F184  85 08                 STA   <$08                         ;[x]
  F186  B9 9B F5              LDA   $F59B,Y                      ;[x]
  F189  85 09                 STA   <$09                         ;[x]
L00_F18B:
  F18B  C2                    CLY                                ;[x]
  F18C  B1 08                 LDA   (<$08),Y                     ;[x]
  F18E  C9 FF                 CMP   #$FF                         ;[x]
  F190  D0 01                 BNE   L00_F193                     ;[x]
  F192  60                    RTS                                ;[x]

L00_F193:
  F193  20 52 E3              JSR   L00_E352                     ;[x]
  F196  C8                    INY                                ;[x]
  F197  B1 08                 LDA   (<$08),Y                     ;[x]
  F199  85 11                 STA   <$11                         ;[x]
  F19B  C8                    INY                                ;[x]
  F19C  20 99 E7              JSR   L00_E799                     ;[x]
  F19F  20 8D E7              JSR   L00_E78D                     ;[x]
  F1A2  B1 08                 LDA   (<$08),Y                     ;[x]
  F1A4  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F1A7  C8                    INY                                ;[x]
  F1A8  B1 08                 LDA   (<$08),Y                     ;[x]
  F1AA  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F1AD  C8                    INY                                ;[x]
  F1AE  B1 08                 LDA   (<$08),Y                     ;[x]
  F1B0  85 00                 STA   <$00                         ;[x]
  F1B2  C8                    INY                                ;[x]
  F1B3  18                    CLC                                ;[x]
  F1B4  69 01                 ADC   #$01                         ;[x]
  F1B6  85 14                 STA   <$14                         ;[x]
  F1B8  B1 08                 LDA   (<$08),Y                     ;[x]
  F1BA  85 01                 STA   <$01                         ;[x]
  F1BC  69 00                 ADC   #$00                         ;[x]
  F1BE  85 15                 STA   <$15                         ;[x]
  F1C0  B2 00                 LDA   (<$00)                       ;[x]
  F1C2  85 16                 STA   <$16                         ;[x]
  F1C4  29 7F                 AND   #$7F                         ;[x]
  F1C6  1A                    INC   A                            ;[x]
  F1C7  18                    CLC                                ;[x]
  F1C8  65 00                 ADC   <$00                         ;[x]
  F1CA  85 12                 STA   <$12                         ;[x]
  F1CC  62                    CLA                                ;[x]
  F1CD  65 01                 ADC   <$01                         ;[x]
  F1CF  85 13                 STA   <$13                         ;[x]
  F1D1  64 D0                 STZ   <$D0                         ;[x]
  F1D3  20 85 E7              JSR   L00_E785                     ;[x]
L00_F1D6:
  F1D6  C2                    CLY                                ;[x]
  F1D7  B1 12                 LDA   (<$12),Y                     ;[x]
  F1D9  10 03                 BPL   L00_F1DE                     ;[x]
  F1DB  4C 86 F2              JMP   L00_F286                     ;[x]

L00_F1DE:
  F1DE  F0 42                 BEQ   L00_F222                     ;[x]
  F1E0  C9 01                 CMP   #$01                         ;[x]
  F1E2  F0 1C                 BEQ   L00_F200                     ;[x]
  F1E4  C9 02                 CMP   #$02                         ;[x]
  F1E6  D0 59                 BNE   L00_F241                     ;[x]
  F1E8  A0 03                 LDY   #$03                         ;[x]
  F1EA  20 24 F3              JSR   L00_F324                     ;[x]
L00_F1ED:
  F1ED  A5 02                 LDA   <$02                         ;[x]
  F1EF  20 32 F3              JSR   L00_F332                     ;[x]
  F1F2  A5 03                 LDA   <$03                         ;[x]
  F1F4  20 32 F3              JSR   L00_F332                     ;[x]
  F1F7  C6 01                 DEC   <$01                         ;[x]
  F1F9  D0 F2                 BNE   L00_F1ED                     ;[x]
  F1FB  A9 04                 LDA   #$04                         ;[x]
  F1FD  4C CE F2              JMP   L00_F2CE                     ;[x]

L00_F200:
  F200  A0 03                 LDY   #$03                         ;[x]
  F202  20 24 F3              JSR   L00_F324                     ;[x]
L00_F205:
  F205  A5 01                 LDA   <$01                         ;[x]
  F207  38                    SEC                                ;[x]
  F208  E9 01                 SBC   #$01                         ;[x]
  F20A  85 01                 STA   <$01                         ;[x]
  F20C  B0 0D                 BCS   L00_F21B                     ;[x]
  F20E  A5 02                 LDA   <$02                         ;[x]
  F210  E9 00                 SBC   #$00                         ;[x]
  F212  85 02                 STA   <$02                         ;[x]
  F214  B0 05                 BCS   L00_F21B                     ;[x]
  F216  A9 04                 LDA   #$04                         ;[x]
  F218  4C CE F2              JMP   L00_F2CE                     ;[x]

L00_F21B:
  F21B  A5 03                 LDA   <$03                         ;[x]
  F21D  20 32 F3              JSR   L00_F332                     ;[x]
  F220  80 E3                 BRA   L00_F205                     ;[x]

L00_F222:
  F222  A0 02                 LDY   #$02                         ;[x]
  F224  20 24 F3              JSR   L00_F324                     ;[x]
  F227  A9 03                 LDA   #$03                         ;[x]
  F229  20 2D F3              JSR   L00_F32D                     ;[x]
  F22C  C2                    CLY                                ;[x]
L00_F22D:
  F22D  A5 02                 LDA   <$02                         ;[x]
  F22F  20 32 F3              JSR   L00_F332                     ;[x]
  F232  B1 12                 LDA   (<$12),Y                     ;[x]
  F234  20 32 F3              JSR   L00_F332                     ;[x]
  F237  C8                    INY                                ;[x]
  F238  C4 01                 CPY   <$01                         ;[x]
  F23A  D0 F1                 BNE   L00_F22D                     ;[x]
  F23C  A5 01                 LDA   <$01                         ;[x]
  F23E  4C CE F2              JMP   L00_F2CE                     ;[x]

L00_F241:
  F241  C9 40                 CMP   #$40                         ;[x]
  F243  B0 16                 BCS   L00_F25B                     ;[x]
  F245  85 00                 STA   <$00                         ;[x]
  F247  A0 01                 LDY   #$01                         ;[x]
  F249  B1 12                 LDA   (<$12),Y                     ;[x]
  F24B  85 01                 STA   <$01                         ;[x]
  F24D  A4 00                 LDY   <$00                         ;[x]
L00_F24F:
  F24F  A5 01                 LDA   <$01                         ;[x]
  F251  20 32 F3              JSR   L00_F332                     ;[x]
  F254  88                    DEY                                ;[x]
  F255  D0 F8                 BNE   L00_F24F                     ;[x]
  F257  A9 02                 LDA   #$02                         ;[x]
  F259  80 73                 BRA   L00_F2CE                     ;[x]

L00_F25B:
  F25B  29 3F                 AND   #$3F                         ;[x]
  F25D  A8                    TAY                                ;[x]
L00_F25E:
  F25E  62                    CLA                                ;[x]
  F25F  20 32 F3              JSR   L00_F332                     ;[x]
  F262  88                    DEY                                ;[x]
  F263  D0 F9                 BNE   L00_F25E                     ;[x]
  F265  A9 01                 LDA   #$01                         ;[x]
  F267  80 65                 BRA   L00_F2CE                     ;[x]

  F269  .db $29,$3F,$85,$01,$A9,$01,$20,$2D,$F3,$C2,$A5,$02,$20,$32,$F3,$B1
  F279  .db $12,$20,$32,$F3,$C8,$C4,$01,$D0,$F1,$A5,$01,$80,$48
L00_F286:
  F286  C9 80                 CMP   #$80                         ;[x]
  F288  F0 50                 BEQ   L00_F2DA                     ;[x]
  F28A  C9 FE                 CMP   #$FE                         ;[x]
  F28C  F0 75                 BEQ   L00_F303                     ;[x]
  F28E  C9 FF                 CMP   #$FF                         ;[x]
  F290  D0 26                 BNE   L00_F2B8                     ;[x]
  F292  20 65 E3              JSR   L00_E365                     ;[x]
  F295  A5 08                 LDA   <$08                         ;[x]
  F297  18                    CLC                                ;[x]
  F298  69 06                 ADC   #$06                         ;[x]
  F29A  85 08                 STA   <$08                         ;[x]
  F29C  90 02                 BCC   L00_F2A0                     ;[x]
  F29E  E6 09                 INC   <$09                         ;[ ]
L00_F2A0:
  F2A0  4C 8B F1              JMP   L00_F18B                     ;[x]

L00_F2A3:
  F2A3  29 3F                 AND   #$3F                         ;[x]
  F2A5  85 00                 STA   <$00                         ;[x]
  F2A7  C2                    CLY                                ;[x]
L00_F2A8:
  F2A8  62                    CLA                                ;[x]
  F2A9  20 32 F3              JSR   L00_F332                     ;[x]
  F2AC  C8                    INY                                ;[x]
  F2AD  B1 12                 LDA   (<$12),Y                     ;[x]
  F2AF  20 32 F3              JSR   L00_F332                     ;[x]
  F2B2  C4 00                 CPY   <$00                         ;[x]
  F2B4  D0 F2                 BNE   L00_F2A8                     ;[x]
  F2B6  80 13                 BRA   L00_F2CB                     ;[x]

L00_F2B8:
  F2B8  29 7F                 AND   #$7F                         ;[x]
  F2BA  85 00                 STA   <$00                         ;[x]
  F2BC  C9 40                 CMP   #$40                         ;[x]
  F2BE  B0 E3                 BCS   L00_F2A3                     ;[x]
  F2C0  C2                    CLY                                ;[x]
L00_F2C1:
  F2C1  C8                    INY                                ;[x]
  F2C2  B1 12                 LDA   (<$12),Y                     ;[x]
  F2C4  20 32 F3              JSR   L00_F332                     ;[x]
  F2C7  C4 00                 CPY   <$00                         ;[x]
  F2C9  D0 F6                 BNE   L00_F2C1                     ;[x]
L00_F2CB:
  F2CB  A5 00                 LDA   <$00                         ;[x]
  F2CD  1A                    INC   A                            ;[x]
L00_F2CE:
  F2CE  18                    CLC                                ;[x]
  F2CF  65 12                 ADC   <$12                         ;[x]
  F2D1  85 12                 STA   <$12                         ;[x]
  F2D3  90 02                 BCC   L00_F2D7                     ;[x]
  F2D5  E6 13                 INC   <$13                         ;[x]
L00_F2D7:
  F2D7  4C D6 F1              JMP   L00_F1D6                     ;[x]

L00_F2DA:
  F2DA  A0 02                 LDY   #$02                         ;[x]
  F2DC  20 24 F3              JSR   L00_F324                     ;[x]
  F2DF  A9 03                 LDA   #$03                         ;[x]
  F2E1  20 2D F3              JSR   L00_F32D                     ;[x]
  F2E4  C2                    CLY                                ;[x]
L00_F2E5:
  F2E5  A5 01                 LDA   <$01                         ;[x]
  F2E7  38                    SEC                                ;[x]
  F2E8  E9 01                 SBC   #$01                         ;[x]
  F2EA  85 01                 STA   <$01                         ;[x]
  F2EC  B0 08                 BCS   L00_F2F6                     ;[x]
  F2EE  A5 02                 LDA   <$02                         ;[x]
  F2F0  E9 00                 SBC   #$00                         ;[x]
  F2F2  85 02                 STA   <$02                         ;[x]
  F2F4  90 E1                 BCC   L00_F2D7                     ;[x]
L00_F2F6:
  F2F6  B1 12                 LDA   (<$12),Y                     ;[x]
  F2F8  20 32 F3              JSR   L00_F332                     ;[x]
  F2FB  E6 12                 INC   <$12                         ;[x]
  F2FD  D0 E6                 BNE   L00_F2E5                     ;[x]
  F2FF  E6 13                 INC   <$13                         ;[x]
  F301  80 E2                 BRA   L00_F2E5                     ;[x]

L00_F303:
  F303  A0 05                 LDY   #$05                         ;[x]
  F305  20 24 F3              JSR   L00_F324                     ;[x]
L00_F308:
  F308  A5 02                 LDA   <$02                         ;[x]
  F30A  20 32 F3              JSR   L00_F332                     ;[x]
  F30D  A5 03                 LDA   <$03                         ;[x]
  F30F  20 32 F3              JSR   L00_F332                     ;[x]
  F312  A5 04                 LDA   <$04                         ;[x]
  F314  20 32 F3              JSR   L00_F332                     ;[x]
  F317  A5 05                 LDA   <$05                         ;[x]
  F319  20 32 F3              JSR   L00_F332                     ;[x]
  F31C  C6 01                 DEC   <$01                         ;[x]
  F31E  D0 E8                 BNE   L00_F308                     ;[x]
  F320  A9 06                 LDA   #$06                         ;[x]
  F322  80 AA                 BRA   L00_F2CE                     ;[x]

L00_F324:
  F324  B1 12                 LDA   (<$12),Y                     ;[x]
  F326  99 00 20              STA   $2000,Y                      ;[x]
  F329  88                    DEY                                ;[x]
  F32A  D0 F8                 BNE   L00_F324                     ;[x]
  F32C  60                    RTS                                ;[x]

L00_F32D:
  F32D  A2 12                 LDX   #$12                         ;[x]
  F32F  4C BB E7              JMP   L00_E7BB                     ;[x]

L00_F332:
  F332  FF 16 54              BBS7  <$16,L00_F389                ;[x]
  F335  A6 D0                 LDX   <$D0                         ;[x]
  F337  9D 08 3D              STA   $3D08,X                      ;[x]
  F33A  E6 D0                 INC   <$D0                         ;[x]
  F33C  E0 7F                 CPX   #$7F                         ;[x]
  F33E  90 48                 BCC   L00_F388                     ;[x]
  F340  64 D0                 STZ   <$D0                         ;[x]
  F342  A5 16                 LDA   <$16                         ;[x]
  F344  29 1F                 AND   #$1F                         ;[x]
  F346  F0 28                 BEQ   L00_F370                     ;[x]
  F348  84 B3                 STY   <$B3                         ;[ ]
  F34A  A2 1F                 LDX   #$1F                         ;[ ]
L00_F34C:
  F34C  A9 08                 LDA   #$08                         ;[ ]
  F34E  85 07                 STA   <$07                         ;[ ]
  F350  62                    CLA                                ;[ ]
L00_F351:
  F351  29 0F                 AND   #$0F                         ;[ ]
  F353  A8                    TAY                                ;[ ]
  F354  B1 14                 LDA   (<$14),Y                     ;[ ]
  F356  0A                    ASL   A                            ;[ ]
  F357  3E 68 3D              ROL   $3D68,X                      ;[ ]
  F35A  2A                    ROL   A                            ;[ ]
  F35B  3E 48 3D              ROL   $3D48,X                      ;[ ]
  F35E  2A                    ROL   A                            ;[ ]
  F35F  3E 28 3D              ROL   $3D28,X                      ;[ ]
  F362  2A                    ROL   A                            ;[ ]
  F363  3E 08 3D              ROL   $3D08,X                      ;[ ]
  F366  2A                    ROL   A                            ;[ ]
  F367  C6 07                 DEC   <$07                         ;[ ]
  F369  10 E6                 BPL   L00_F351                     ;[ ]
  F36B  CA                    DEX                                ;[ ]
  F36C  10 DE                 BPL   L00_F34C                     ;[ ]
  F36E  A4 B3                 LDY   <$B3                         ;[ ]
L00_F370:
  F370  DA                    PHX                                ;[x]
  F371  5A                    PHY                                ;[x]
  F372  A0 40                 LDY   #$40                         ;[x]
  F374  82                    CLX                                ;[x]
L00_F375:
  F375  BD 08 3D              LDA   $3D08,X                      ;[x]
  F378  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F37B  E8                    INX                                ;[x]
  F37C  BD 08 3D              LDA   $3D08,X                      ;[x]
  F37F  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F382  E8                    INX                                ;[x]
  F383  88                    DEY                                ;[x]
  F384  D0 EF                 BNE   L00_F375                     ;[x]
  F386  7A                    PLY                                ;[x]
  F387  FA                    PLX                                ;[x]
L00_F388:
  F388  60                    RTS                                ;[x]

L00_F389:
  F389  0F 11 1A              BBR0  <$11,L00_F3A6                ;[x]
  F38C  4A                    LSR   A                            ;[x]
  F38D  26 07                 ROL   <$07                         ;[x]
  F38F  4A                    LSR   A                            ;[x]
  F390  26 07                 ROL   <$07                         ;[x]
  F392  4A                    LSR   A                            ;[x]
  F393  26 07                 ROL   <$07                         ;[x]
  F395  4A                    LSR   A                            ;[x]
  F396  26 07                 ROL   <$07                         ;[x]
  F398  4A                    LSR   A                            ;[x]
  F399  26 07                 ROL   <$07                         ;[x]
  F39B  4A                    LSR   A                            ;[x]
  F39C  26 07                 ROL   <$07                         ;[x]
  F39E  4A                    LSR   A                            ;[x]
  F39F  26 07                 ROL   <$07                         ;[x]
  F3A1  4A                    LSR   A                            ;[x]
  F3A2  26 07                 ROL   <$07                         ;[x]
  F3A4  A5 07                 LDA   <$07                         ;[x]
L00_F3A6:
  F3A6  A6 D0                 LDX   <$D0                         ;[x]
  F3A8  9D 08 3D              STA   $3D08,X                      ;[x]
  F3AB  E6 D0                 INC   <$D0                         ;[x]
  F3AD  E0 1F                 CPX   #$1F                         ;[x]
  F3AF  90 4C                 BCC   L00_F3FD                     ;[x]
  F3B1  64 D0                 STZ   <$D0                         ;[x]
  F3B3  A5 16                 LDA   <$16                         ;[x]
  F3B5  29 1F                 AND   #$1F                         ;[x]
  F3B7  F0 29                 BEQ   L00_F3E2                     ;[x]
  F3B9  84 B3                 STY   <$B3                         ;[ ]
  F3BB  A2 0F                 LDX   #$0F                         ;[ ]
L00_F3BD:
  F3BD  A9 08                 LDA   #$08                         ;[ ]
  F3BF  85 07                 STA   <$07                         ;[ ]
  F3C1  62                    CLA                                ;[ ]
L00_F3C2:
  F3C2  29 0F                 AND   #$0F                         ;[ ]
  F3C4  A8                    TAY                                ;[ ]
  F3C5  B1 14                 LDA   (<$14),Y                     ;[ ]
  F3C7  0A                    ASL   A                            ;[ ]
  F3C8  3E 18 3D              ROL   $3D18,X                      ;[ ]
  F3CB  2A                    ROL   A                            ;[ ]
  F3CC  3E 17 3D              ROL   $3D17,X                      ;[ ]
  F3CF  2A                    ROL   A                            ;[ ]
  F3D0  3E 08 3D              ROL   $3D08,X                      ;[ ]
  F3D3  2A                    ROL   A                            ;[ ]
  F3D4  3E 07 3D              ROL   $3D07,X                      ;[ ]
  F3D7  2A                    ROL   A                            ;[ ]
  F3D8  C6 07                 DEC   <$07                         ;[ ]
  F3DA  10 E6                 BPL   L00_F3C2                     ;[ ]
  F3DC  CA                    DEX                                ;[ ]
  F3DD  CA                    DEX                                ;[ ]
  F3DE  10 DD                 BPL   L00_F3BD                     ;[ ]
  F3E0  A4 B3                 LDY   <$B3                         ;[ ]
L00_F3E2:
  F3E2  9F 11 19              BBS1  <$11,L00_F3FE                ;[x]
  F3E5  DA                    PHX                                ;[x]
  F3E6  5A                    PHY                                ;[x]
  F3E7  A0 10                 LDY   #$10                         ;[x]
  F3E9  82                    CLX                                ;[x]
L00_F3EA:
  F3EA  BD 08 3D              LDA   $3D08,X                      ;[x]
  F3ED  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F3F0  E8                    INX                                ;[x]
  F3F1  BD 08 3D              LDA   $3D08,X                      ;[x]
  F3F4  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F3F7  E8                    INX                                ;[x]
  F3F8  88                    DEY                                ;[x]
  F3F9  D0 EF                 BNE   L00_F3EA                     ;[x]
  F3FB  7A                    PLY                                ;[x]
  F3FC  FA                    PLX                                ;[x]
L00_F3FD:
  F3FD  60                    RTS                                ;[x]

L00_F3FE:
  F3FE  A2 0F                 LDX   #$0F                         ;[ ]
L00_F400:
  F400  BD 07 3D              LDA   $3D07,X                      ;[ ]
  F403  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  F406  BD 08 3D              LDA   $3D08,X                      ;[ ]
  F409  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  F40C  CA                    DEX                                ;[ ]
  F40D  CA                    DEX                                ;[ ]
  F40E  10 F0                 BPL   L00_F400                     ;[ ]
  F410  A2 0F                 LDX   #$0F                         ;[ ]
L00_F412:
  F412  BD 17 3D              LDA   $3D17,X                      ;[ ]
  F415  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  F418  BD 18 3D              LDA   $3D18,X                      ;[ ]
  F41B  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  F41E  CA                    DEX                                ;[ ]
  F41F  CA                    DEX                                ;[ ]
  F420  10 F0                 BPL   L00_F412                     ;[ ]
  F422  60                    RTS                                ;[ ]

L00_F423:
  F423  BD 90 3B              LDA   $3B90,X                      ;[x]
  F426  0A                    ASL   A                            ;[x]
  F427  A8                    TAY                                ;[x]
  F428  B9 00 C0              LDA   $C000,Y                      ;[x]
  F42B  85 00                 STA   <$00                         ;[x]
  F42D  B9 01 C0              LDA   $C001,Y                      ;[x]
  F430  85 01                 STA   <$01                         ;[x]
  F432  64 06                 STZ   <$06                         ;[x]
  F434  C2                    CLY                                ;[x]
  F435  B1 00                 LDA   (<$00),Y                     ;[x]
  F437  20 52 E3              JSR   L00_E352                     ;[x]
  F43A  C8                    INY                                ;[x]
  F43B  B1 00                 LDA   (<$00),Y                     ;[x]
L00_F43D:
  F43D  85 06                 STA   <$06                         ;[x]
  F43F  C8                    INY                                ;[x]
  F440  B1 00                 LDA   (<$00),Y                     ;[x]
  F442  85 02                 STA   <$02                         ;[x]
  F444  C8                    INY                                ;[x]
  F445  B1 00                 LDA   (<$00),Y                     ;[x]
  F447  85 03                 STA   <$03                         ;[x]
  F449  20 8D E7              JSR   L00_E78D                     ;[x]
  F44C  A5 02                 LDA   <$02                         ;[x]
  F44E  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F451  A5 03                 LDA   <$03                         ;[x]
  F453  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F456  20 85 E7              JSR   L00_E785                     ;[x]
  F459  C8                    INY                                ;[x]
  F45A  B1 00                 LDA   (<$00),Y                     ;[x]
  F45C  85 04                 STA   <$04                         ;[x]
  F45E  C8                    INY                                ;[x]
  F45F  B1 00                 LDA   (<$00),Y                     ;[x]
  F461  85 05                 STA   <$05                         ;[x]
  F463  5A                    PHY                                ;[x]
  F464  44 0B                 BSR   L00_F471                     ;[x]
  F466  7A                    PLY                                ;[x]
  F467  C8                    INY                                ;[x]
  F468  B1 00                 LDA   (<$00),Y                     ;[x]
  F46A  C9 FF                 CMP   #$FF                         ;[x]
  F46C  D0 CF                 BNE   L00_F43D                     ;[x]
  F46E  4C 4B F0              JMP   L00_F04B                     ;[x]

L00_F471:
  F471  C2                    CLY                                ;[x]
  F472  B1 04                 LDA   (<$04),Y                     ;[x]
  F474  D0 03                 BNE   L00_F479                     ;[x]
  F476  4C D0 F4              JMP   L00_F4D0                     ;[x]

L00_F479:
  F479  30 03                 BMI   L00_F47E                     ;[x]
  F47B  4C B3 F4              JMP   L00_F4B3                     ;[x]

L00_F47E:
  F47E  C9 FF                 CMP   #$FF                         ;[x]
  F480  D0 01                 BNE   L00_F483                     ;[x]
  F482  60                    RTS                                ;[x]

L00_F483:
  F483  C9 FE                 CMP   #$FE                         ;[x]
  F485  D0 03                 BNE   L00_F48A                     ;[x]
  F487  4C EC F4              JMP   L00_F4EC                     ;[x]

L00_F48A:
  F48A  C9 FD                 CMP   #$FD                         ;[x]
  F48C  D0 03                 BNE   L00_F491                     ;[x]
  F48E  4C 0B F5              JMP   L00_F50B                     ;[ ]

L00_F491:
  F491  29 7F                 AND   #$7F                         ;[x]
  F493  85 08                 STA   <$08                         ;[x]
L00_F495:
  F495  C8                    INY                                ;[x]
  F496  B1 04                 LDA   (<$04),Y                     ;[x]
  F498  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F49B  C8                    INY                                ;[x]
  F49C  B1 04                 LDA   (<$04),Y                     ;[x]
  F49E  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F4A1  C6 08                 DEC   <$08                         ;[x]
  F4A3  D0 F0                 BNE   L00_F495                     ;[x]
L00_F4A5:
  F4A5  C8                    INY                                ;[x]
  F4A6  98                    TYA                                ;[x]
  F4A7  18                    CLC                                ;[x]
  F4A8  65 04                 ADC   <$04                         ;[x]
  F4AA  85 04                 STA   <$04                         ;[x]
  F4AC  90 02                 BCC   L00_F4B0                     ;[x]
  F4AE  E6 05                 INC   <$05                         ;[x]
L00_F4B0:
  F4B0  4C 71 F4              JMP   L00_F471                     ;[x]

L00_F4B3:
  F4B3  C8                    INY                                ;[x]
  F4B4  85 08                 STA   <$08                         ;[x]
  F4B6  B1 04                 LDA   (<$04),Y                     ;[x]
  F4B8  85 09                 STA   <$09                         ;[x]
  F4BA  C8                    INY                                ;[x]
  F4BB  B1 04                 LDA   (<$04),Y                     ;[x]
  F4BD  85 0A                 STA   <$0A                         ;[x]
L00_F4BF:
  F4BF  A5 09                 LDA   <$09                         ;[x]
  F4C1  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F4C4  A5 0A                 LDA   <$0A                         ;[x]
  F4C6  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F4C9  C6 08                 DEC   <$08                         ;[x]
  F4CB  D0 F2                 BNE   L00_F4BF                     ;[x]
  F4CD  4C A5 F4              JMP   L00_F4A5                     ;[x]

L00_F4D0:
  F4D0  C8                    INY                                ;[x]
  F4D1  B1 04                 LDA   (<$04),Y                     ;[x]
  F4D3  85 08                 STA   <$08                         ;[x]
  F4D5  C8                    INY                                ;[x]
  F4D6  B1 04                 LDA   (<$04),Y                     ;[x]
  F4D8  85 09                 STA   <$09                         ;[x]
L00_F4DA:
  F4DA  C8                    INY                                ;[x]
  F4DB  B1 04                 LDA   (<$04),Y                     ;[x]
  F4DD  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F4E0  A5 09                 LDA   <$09                         ;[x]
  F4E2  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F4E5  C6 08                 DEC   <$08                         ;[x]
  F4E7  D0 F1                 BNE   L00_F4DA                     ;[x]
  F4E9  4C A5 F4              JMP   L00_F4A5                     ;[x]

L00_F4EC:
  F4EC  C8                    INY                                ;[x]
  F4ED  20 8D E7              JSR   L00_E78D                     ;[x]
  F4F0  B1 04                 LDA   (<$04),Y                     ;[x]
  F4F2  18                    CLC                                ;[x]
  F4F3  65 02                 ADC   <$02                         ;[x]
  F4F5  8D 02 00              STA   VDC_DATA_L                   ;[x]
  F4F8  C8                    INY                                ;[x]
  F4F9  B1 04                 LDA   (<$04),Y                     ;[x]
  F4FB  65 03                 ADC   <$03                         ;[x]
  F4FD  8F 06 02              BBS0  <$06,L00_F502                ;[x]
  F500  29 0F                 AND   #$0F                         ;[x]
L00_F502:
  F502  8D 03 00              STA   VDC_DATA_H                   ;[x]
  F505  20 85 E7              JSR   L00_E785                     ;[x]
  F508  4C A5 F4              JMP   L00_F4A5                     ;[x]

L00_F50B:
  F50B  C8                    INY                                ;[ ]
  F50C  20 8D E7              JSR   L00_E78D                     ;[ ]
  F50F  B1 04                 LDA   (<$04),Y                     ;[ ]
  F511  85 02                 STA   <$02                         ;[ ]
  F513  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  F516  C8                    INY                                ;[ ]
  F517  B1 04                 LDA   (<$04),Y                     ;[ ]
  F519  85 03                 STA   <$03                         ;[ ]
  F51B  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  F51E  20 85 E7              JSR   L00_E785                     ;[ ]
  F521  4C A5 F4              JMP   L00_F4A5                     ;[ ]

  F524  .db $01,$00,$01,$01,$01,$02,$01,$03,$01,$04,$01,$05,$01,$06,$01,$07
  F534  .db $01,$08,$03,$00,$03,$01,$03,$02,$03,$03,$03,$04,$03,$05,$03,$06
  F544  .db $03,$07,$03,$08,$03,$09,$03,$0A,$03,$0B,$03,$0C,$01,$08,$03,$0D
  F554  .db $03,$0E,$03,$0F,$03,$10,$01,$09,$01,$0A,$01,$0B,$01,$0C,$01,$0D
  F564  .db $03,$11,$03,$12,$03,$13,$03,$14,$03,$15,$03,$16,$03,$17,$03,$18
  F574  .db $03,$19,$03,$1A,$03,$1B,$03,$1C,$01,$0E,$03,$1D,$03,$1E,$03,$1F
  F584  .db $03,$20,$03,$21,$01,$0F,$03,$22,$01,$10,$03,$23,$03,$24,$01,$11
  F594  .db $01,$12,$01,$13,$03,$25,$21,$C2,$20,$73,$FA,$80,$11
L00_F5A1:
  F5A1  AD 24 3F              LDA   $3F24                        ;[x]
  F5A4  C9 02                 CMP   #$02                         ;[x]
  F5A6  90 0A                 BCC   L00_F5B2                     ;[x]
  F5A8  20 69 FA              JSR   L00_FA69                     ;[ ]
  F5AB  20 F3 C4              JSR   $C4F3                        ;[ ]
  F5AE  20 55 FA              JSR   L00_FA55                     ;[ ]
  F5B1  60                    RTS                                ;[ ]

L00_F5B2:
  F5B2  20 55 FA              JSR   L00_FA55                     ;[x]
  F5B5  20 1C F9              JSR   L00_F91C                     ;[x]
  F5B8  A5 3B                 LDA   <$3B                         ;[x]
  F5BA  F0 01                 BEQ   L00_F5BD                     ;[x]
  F5BC  60                    RTS                                ;[ ]

L00_F5BD:
  F5BD  E6 83                 INC   <$83                         ;[x]
  F5BF  A5 80                 LDA   <$80                         ;[x]
  F5C1  F0 3F                 BEQ   L00_F602                     ;[x]
  F5C3  3A                    DEC   A                            ;[x]
  F5C4  D0 03                 BNE   L00_F5C9                     ;[x]
  F5C6  4C 75 F6              JMP   L00_F675                     ;[x]

L00_F5C9:
  F5C9  3A                    DEC   A                            ;[x]
  F5CA  D0 03                 BNE   L00_F5CF                     ;[x]
  F5CC  4C 69 F6              JMP   L00_F669                     ;[x]

L00_F5CF:
  F5CF  3A                    DEC   A                            ;[x]
  F5D0  D0 03                 BNE   L00_F5D5                     ;[x]
  F5D2  4C 20 F8              JMP   L00_F820                     ;[x]

L00_F5D5:
  F5D5  3A                    DEC   A                            ;[x]
  F5D6  D0 03                 BNE   L00_F5DB                     ;[x]
  F5D8  4C 48 F8              JMP   L00_F848                     ;[ ]

L00_F5DB:
  F5DB  3A                    DEC   A                            ;[x]
  F5DC  D0 03                 BNE   L00_F5E1                     ;[x]
  F5DE  4C 29 F7              JMP   L00_F729                     ;[x]

L00_F5E1:
  F5E1  3A                    DEC   A                            ;[x]
  F5E2  D0 03                 BNE   L00_F5E7                     ;[x]
  F5E4  4C 8D F8              JMP   L00_F88D                     ;[x]

L00_F5E7:
  F5E7  3A                    DEC   A                            ;[x]
  F5E8  D0 03                 BNE   L00_F5ED                     ;[x]
  F5EA  4C AD F8              JMP   L00_F8AD                     ;[x]

L00_F5ED:
  F5ED  3A                    DEC   A                            ;[x]
  F5EE  D0 03                 BNE   L00_F5F3                     ;[x]
  F5F0  4C 98 F9              JMP   L00_F998                     ;[x]

L00_F5F3:
  F5F3  3A                    DEC   A                            ;[x]
  F5F4  D0 03                 BNE   L00_F5F9                     ;[x]
  F5F6  4C 15 FA              JMP   L00_FA15                     ;[x]

L00_F5F9:
  F5F9  3A                    DEC   A                            ;[x]
  F5FA  D0 03                 BNE   L00_F5FF                     ;[x]
  F5FC  4C 1C FA              JMP   L00_FA1C                     ;[x]

L00_F5FF:
  F5FF  4C 42 FA              JMP   L00_FA42                     ;[ ]

L00_F602:
  F602  20 D8 E7              JSR   L00_E7D8                     ;[x]
  F605  20 3F EC              JSR   L00_EC3F                     ;[x]
  F608  A5 35                 LDA   <$35                         ;[x]
  F60A  F0 23                 BEQ   L00_F62F                     ;[x]
  F60C  A4 3E                 LDY   <$3E                         ;[ ]
  F60E  C8                    INY                                ;[ ]
  F60F  C0 06                 CPY   #$06                         ;[ ]
  F611  90 01                 BCC   L00_F614                     ;[ ]
  F613  C2                    CLY                                ;[ ]
L00_F614:
  F614  84 3E                 STY   <$3E                         ;[ ]
  F616  B9 63 F6              LDA   $F663,Y                      ;[ ]
  F619  8D E2 3E              STA   $3EE2                        ;[ ]
  F61C  9C E4 3E              STZ   $3EE4                        ;[ ]
  F61F  9C 80 26              STZ   $2680                        ;[ ]
  F622  A9 01                 LDA   #$01                         ;[ ]
  F624  8D 8E 3F              STA   $3F8E                        ;[ ]
  F627  3A                    DEC   A                            ;[ ]
  F628  8D 8F 3F              STA   $3F8F                        ;[ ]
  F62B  3A                    DEC   A                            ;[ ]
  F62C  8D 90 3F              STA   $3F90                        ;[ ]
L00_F62F:
  F62F  A9 FF                 LDA   #$FF                         ;[x]
  F631  85 87                 STA   <$87                         ;[x]
  F633  85 88                 STA   <$88                         ;[x]
  F635  AD 9A 3F              LDA   $3F9A                        ;[x]
  F638  8D 39 3F              STA   $3F39                        ;[x]
  F63B  3A                    DEC   A                            ;[x]
  F63C  8D 38 3F              STA   $3F38                        ;[x]
  F63F  A5 35                 LDA   <$35                         ;[x]
  F641  D0 11                 BNE   L00_F654                     ;[x]
  F643  F3 C6 FB 84 3F 08 00  TAI   $FBC6,$3F84,$0008            ;[x]
  F64A  AD 24 3F              LDA   $3F24                        ;[x]
  F64D  D0 05                 BNE   L00_F654                     ;[x]
  F64F  9C 3A 3F              STZ   $3F3A                        ;[x]
  F652  80 06                 BRA   L00_F65A                     ;[x]

L00_F654:
  F654  CE 39 3F              DEC   $3F39                        ;[ ]
  F657  EE 3A 3F              INC   $3F3A                        ;[ ]
L00_F65A:
  F65A  64 9C                 STZ   <$9C                         ;[x]
  F65C  A9 02                 LDA   #$02                         ;[x]
  F65E  85 39                 STA   <$39                         ;[x]
  F660  4C 0E F9              JMP   L00_F90E                     ;[x]

  F663  .db $05,$00,$01,$02,$03,$04
L00_F669:
  F669  A5 35                 LDA   <$35                         ;[x]
  F66B  D0 03                 BNE   L00_F670                     ;[x]
  F66D  4C 0E F9              JMP   L00_F90E                     ;[x]

L00_F670:
  F670  A9 05                 LDA   #$05                         ;[ ]
  F672  4C 11 F9              JMP   L00_F911                     ;[ ]

L00_F675:
  F675  A5 35                 LDA   <$35                         ;[x]
  F677  F0 33                 BEQ   L00_F6AC                     ;[x]
  F679  9C E6 3E              STZ   $3EE6                        ;[ ]
  F67C  A4 3E                 LDY   <$3E                         ;[ ]
  F67E  B9 FF F6              LDA   $F6FF,Y                      ;[ ]
  F681  8D E7 3E              STA   $3EE7                        ;[ ]
  F684  B9 05 F7              LDA   $F705,Y                      ;[ ]
  F687  85 86                 STA   <$86                         ;[ ]
  F689  8D E3 3E              STA   $3EE3                        ;[ ]
  F68C  B9 0B F7              LDA   $F70B,Y                      ;[ ]
  F68F  8D EF 3E              STA   $3EEF                        ;[ ]
  F692  B9 11 F7              LDA   $F711,Y                      ;[ ]
  F695  8D E0 3E              STA   $3EE0                        ;[ ]
  F698  B9 17 F7              LDA   $F717,Y                      ;[ ]
  F69B  8D E1 3E              STA   $3EE1                        ;[ ]
  F69E  B9 1D F7              LDA   $F71D,Y                      ;[ ]
  F6A1  8D E8 3E              STA   $3EE8                        ;[ ]
  F6A4  B9 23 F7              LDA   $F723,Y                      ;[ ]
  F6A7  8D E9 3E              STA   $3EE9                        ;[ ]
  F6AA  80 2E                 BRA   L00_F6DA                     ;[ ]

L00_F6AC:
  F6AC  9C EF 3E              STZ   $3EEF                        ;[x]
  F6AF  9C E0 3E              STZ   $3EE0                        ;[x]
  F6B2  9C E1 3E              STZ   $3EE1                        ;[x]
  F6B5  9C E8 3E              STZ   $3EE8                        ;[x]
  F6B8  9C E9 3E              STZ   $3EE9                        ;[x]
  F6BB  9C E2 3E              STZ   $3EE2                        ;[x]
  F6BE  9C E4 3E              STZ   $3EE4                        ;[x]
  F6C1  AE 24 3F              LDX   $3F24                        ;[x]
  F6C4  BD FC F6              LDA   $F6FC,X                      ;[x]
  F6C7  85 86                 STA   <$86                         ;[x]
  F6C9  8D E3 3E              STA   $3EE3                        ;[x]
  F6CC  9C E6 3E              STZ   $3EE6                        ;[x]
  F6CF  9C E7 3E              STZ   $3EE7                        ;[x]
  F6D2  9F 86 05              BBS1  <$86,L00_F6DA                ;[x]
  F6D5  A9 06                 LDA   #$06                         ;[x]
  F6D7  8D E7 3E              STA   $3EE7                        ;[x]
L00_F6DA:
  F6DA  AD 9B 3F              LDA   $3F9B                        ;[x]
  F6DD  F8                    SED                                ;[x]
  F6DE  38                    SEC                                ;[x]
  F6DF  E9 01                 SBC   #$01                         ;[x]
  F6E1  D8                    CLD                                ;[x]
  F6E2  85 87                 STA   <$87                         ;[x]
  F6E4  1F 86 02              BBR1  <$86,L00_F6E9                ;[x]
  F6E7  85 88                 STA   <$88                         ;[ ]
L00_F6E9:
  F6E9  64 C6                 STZ   <$C6                         ;[x]
  F6EB  64 C7                 STZ   <$C7                         ;[x]
  F6ED  A9 04                 LDA   #$04                         ;[x]
  F6EF  8D EA 3E              STA   $3EEA                        ;[x]
  F6F2  8D EB 3E              STA   $3EEB                        ;[x]
  F6F5  A9 02                 LDA   #$02                         ;[x]
  F6F7  85 39                 STA   <$39                         ;[x]
  F6F9  4C 0E F9              JMP   L00_F90E                     ;[x]

  F6FC  .db $01,$03,$03,$00,$07,$00,$07,$00,$07,$03,$01,$03,$01,$03,$01,$13
  F70C  .db $00,$00,$00,$01,$02,$02,$00,$80,$00,$01,$02,$11,$00,$00,$00,$08
  F71C  .db $00,$00,$00,$0A,$00,$00,$00,$00,$00,$00,$00,$00,$00
L00_F729:
  F729  20 E6 E7              JSR   L00_E7E6                     ;[x]
  F72C  20 DD E3              JSR   L00_E3DD                     ;[x]
  F72F  20 3F EC              JSR   L00_EC3F                     ;[x]
  F732  AE E2 3E              LDX   $3EE2                        ;[x]
  F735  86 92                 STX   <$92                         ;[x]
  F737  AD E4 3E              LDA   $3EE4                        ;[x]
  F73A  85 9E                 STA   <$9E                         ;[x]
  F73C  AD E3 3E              LDA   $3EE3                        ;[x]
  F73F  85 86                 STA   <$86                         ;[x]
  F741  AD EF 3E              LDA   $3EEF                        ;[x]
  F744  85 A0                 STA   <$A0                         ;[x]
  F746  9C 81 26              STZ   $2681                        ;[x]
  F749  A5 35                 LDA   <$35                         ;[x]
  F74B  F0 04                 BEQ   L00_F751                     ;[x]
  F74D  A9 01                 LDA   #$01                         ;[ ]
  F74F  80 03                 BRA   L00_F754                     ;[ ]

L00_F751:
  F751  AD 99 3F              LDA   $3F99                        ;[x]
L00_F754:
  F754  85 B1                 STA   <$B1                         ;[x]
  F756  8A                    TXA                                ;[x]
  F757  0A                    ASL   A                            ;[x]
  F758  A8                    TAY                                ;[x]
  F759  B9 5C F9              LDA   $F95C,Y                      ;[x]
  F75C  85 97                 STA   <$97                         ;[x]
  F75E  B9 5D F9              LDA   $F95D,Y                      ;[x]
  F761  85 98                 STA   <$98                         ;[x]
  F763  DA                    PHX                                ;[x]
  F764  20 50 B2              JSR   L17_B250                     ;[x]
  F767  20 59 A7              JSR   L17_A759                     ;[x]
  F76A  FA                    PLX                                ;[x]
  F76B  AD EE 3E              LDA   $3EEE                        ;[x]
  F76E  85 C3                 STA   <$C3                         ;[x]
  F770  64 C4                 STZ   <$C4                         ;[x]
  F772  BD 92 F9              LDA   $F992,X                      ;[x]
  F775  85 85                 STA   <$85                         ;[x]
  F777  BD 74 F9              LDA   $F974,X                      ;[x]
  F77A  8D 70 3B              STA   $3B70                        ;[x]
  F77D  9C 7A 3B              STZ   $3B7A                        ;[x]
  F780  BD 7A F9              LDA   $F97A,X                      ;[x]
  F783  8D 74 3B              STA   $3B74                        ;[x]
  F786  BD 80 F9              LDA   $F980,X                      ;[x]
  F789  8D 75 3B              STA   $3B75                        ;[x]
  F78C  A9 01                 LDA   #$01                         ;[x]
  F78E  85 45                 STA   <$45                         ;[x]
  F790  BD 86 F9              LDA   $F986,X                      ;[x]
  F793  85 89                 STA   <$89                         ;[x]
  F795  64 8E                 STZ   <$8E                         ;[x]
  F797  64 9F                 STZ   <$9F                         ;[x]
  F799  9C D1 3D              STZ   $3DD1                        ;[x]
  F79C  9C D3 3D              STZ   $3DD3                        ;[x]
  F79F  E0 02                 CPX   #$02                         ;[x]
  F7A1  D0 16                 BNE   L00_F7B9                     ;[x]
  F7A3  A9 15                 LDA   #$15                         ;[ ]
  F7A5  8D 6D 3B              STA   $3B6D                        ;[ ]
  F7A8  9C 6C 3B              STZ   $3B6C                        ;[ ]
  F7AB  9C B6 3D              STZ   $3DB6                        ;[ ]
  F7AE  9C D0 3D              STZ   $3DD0                        ;[ ]
  F7B1  9C CF 3D              STZ   $3DCF                        ;[ ]
  F7B4  9C CE 3D              STZ   $3DCE                        ;[ ]
  F7B7  80 0E                 BRA   L00_F7C7                     ;[ ]

L00_F7B9:
  F7B9  9C 6D 3B              STZ   $3B6D                        ;[x]
  F7BC  9C 6C 3B              STZ   $3B6C                        ;[x]
  F7BF  A9 08                 LDA   #$08                         ;[x]
  F7C1  8D B6 3D              STA   $3DB6                        ;[x]
  F7C4  8D CF 3D              STA   $3DCF                        ;[x]
L00_F7C7:
  F7C7  64 B7                 STZ   <$B7                         ;[x]
  F7C9  A0 01                 LDY   #$01                         ;[x]
L00_F7CB:
  F7CB  B9 E6 3E              LDA   $3EE6,Y                      ;[x]
  F7CE  99 89 2F              STA   $2F89,Y                      ;[x]
  F7D1  B9 F2 3E              LDA   $3EF2,Y                      ;[x]
  F7D4  99 59 36              STA   $3659,Y                      ;[x]
  F7D7  B9 F4 3E              LDA   $3EF4,Y                      ;[x]
  F7DA  99 C6 36              STA   $36C6,Y                      ;[x]
  F7DD  88                    DEY                                ;[x]
  F7DE  10 EB                 BPL   L00_F7CB                     ;[x]
  F7E0  A9 09                 LDA   #$09                         ;[x]
  F7E2  20 92 E7              JSR   L00_E792                     ;[x]
  F7E5  13 30                 ST1   #$30                         ;[x]
  F7E7  AE E2 3E              LDX   $3EE2                        ;[x]
  F7EA  BD 68 F9              LDA   $F968,X                      ;[x]
  F7ED  20 D4 E8              JSR   L00_E8D4                     ;[x]
  F7F0  A2 07                 LDX   #$07                         ;[x]
  F7F2  AC E2 3E              LDY   $3EE2                        ;[x]
  F7F5  B9 6E F9              LDA   $F96E,Y                      ;[x]
  F7F8  20 65 F0              JSR   L00_F065                     ;[x]
  F7FB  A9 04                 LDA   #$04                         ;[x]
  F7FD  85 39                 STA   <$39                         ;[x]
  F7FF  20 C8 FB              JSR   L00_FBC8                     ;[x]
  F802  20 F9 FD              JSR   L00_FDF9                     ;[x]
  F805  A9 02                 LDA   #$02                         ;[x]
  F807  85 39                 STA   <$39                         ;[x]
  F809  A9 01                 LDA   #$01                         ;[x]
  F80B  85 95                 STA   <$95                         ;[x]
  F80D  64 9A                 STZ   <$9A                         ;[x]
  F80F  A9 03                 LDA   #$03                         ;[x]
  F811  85 39                 STA   <$39                         ;[x]
  F813  64 43                 STZ   <$43                         ;[x]
  F815  AD 9C 3F              LDA   $3F9C                        ;[x]
  F818  18                    CLC                                ;[x]
  F819  69 02                 ADC   #$02                         ;[x]
  F81B  85 4C                 STA   <$4C                         ;[x]
  F81D  4C 0E F9              JMP   L00_F90E                     ;[x]

L00_F820:
  F820  20 42 EC              JSR   L00_EC42                     ;[x]
  F823  AD 99 3F              LDA   $3F99                        ;[x]
  F826  C9 03                 CMP   #$03                         ;[x]
  F828  F0 07                 BEQ   L00_F831                     ;[x]
  F82A  AD A0 3F              LDA   $3FA0                        ;[x]
  F82D  29 08                 AND   #$08                         ;[x]
  F82F  D0 05                 BNE   L00_F836                     ;[x]
L00_F831:
  F831  A9 05                 LDA   #$05                         ;[x]
  F833  4C 11 F9              JMP   L00_F911                     ;[x]

L00_F836:
  F836  A9 34                 LDA   #$34                         ;[ ]
  F838  20 D4 E8              JSR   L00_E8D4                     ;[ ]
  F83B  A9 01                 LDA   #$01                         ;[ ]
  F83D  20 64 F0              JSR   L00_F064                     ;[ ]
  F840  A9 12                 LDA   #$12                         ;[ ]
  F842  20 2B EE              JSR   L00_EE2B                     ;[ ]
  F845  4C 0E F9              JMP   L00_F90E                     ;[ ]

L00_F848:
  F848  A5 22                 LDA   <$22                         ;[ ]
  F84A  D0 01                 BNE   L00_F84D                     ;[ ]
  F84C  60                    RTS                                ;[ ]

L00_F84D:
  F84D  8F 22 0A              BBS0  <$22,L00_F85A                ;[ ]
  F850  BF 22 07              BBS3  <$22,L00_F85A                ;[ ]
  F853  CF 22 07              BBS4  <$22,L00_F85D                ;[ ]
  F856  EF 22 12              BBS6  <$22,L00_F86B                ;[ ]
L00_F859:
  F859  60                    RTS                                ;[ ]

L00_F85A:
  F85A  4C 0E F9              JMP   L00_F90E                     ;[ ]

L00_F85D:
  F85D  AD E2 3E              LDA   $3EE2                        ;[ ]
  F860  C9 05                 CMP   #$05                         ;[ ]
  F862  B0 F5                 BCS   L00_F859                     ;[ ]
  F864  1A                    INC   A                            ;[ ]
  F865  8D E2 3E              STA   $3EE2                        ;[ ]
  F868  4C 74 F8              JMP   L00_F874                     ;[ ]

L00_F86B:
  F86B  AD E2 3E              LDA   $3EE2                        ;[ ]
  F86E  F0 E9                 BEQ   L00_F859                     ;[ ]
  F870  3A                    DEC   A                            ;[ ]
  F871  8D E2 3E              STA   $3EE2                        ;[ ]
L00_F874:
  F874  20 8D E7              JSR   L00_E78D                     ;[ ]
  F877  13 9A                 ST1   #$9A                         ;[ ]
  F879  23 01                 ST2   #$01                         ;[ ]
  F87B  20 85 E7              JSR   L00_E785                     ;[ ]
  F87E  A9 12                 LDA   #$12                         ;[ ]
  F880  18                    CLC                                ;[ ]
  F881  6D E2 3E              ADC   $3EE2                        ;[ ]
  F884  8D 02 00              STA   VDC_DATA_L                   ;[ ]
  F887  A9 01                 LDA   #$01                         ;[ ]
  F889  8D 03 00              STA   VDC_DATA_H                   ;[ ]
  F88C  60                    RTS                                ;[ ]

L00_F88D:
  F88D  A5 35                 LDA   <$35                         ;[x]
  F88F  D0 08                 BNE   L00_F899                     ;[x]
  F891  A4 92                 LDY   <$92                         ;[x]
  F893  B9 A7 F8              LDA   $F8A7,Y                      ;[x]
  F896  20 FC E3              JSR   L00_E3FC                     ;[x]
L00_F899:
  F899  A9 14                 LDA   #$14                         ;[x]
  F89B  20 3D F0              JSR   L00_F03D                     ;[x]
  F89E  20 EB C7              JSR   $C7EB                        ;[x]
  F8A1  20 46 F0              JSR   L00_F046                     ;[x]
  F8A4  4C 0E F9              JMP   L00_F90E                     ;[x]

  F8A7  .db $5B,$62,$67,$6C,$71,$7B
L00_F8AD:
  F8AD  64 3C                 STZ   <$3C                         ;[x]
  F8AF  20 FE C7              JSR   $C7FE                        ;[x]
  F8B2  AD 89 2F              LDA   $2F89                        ;[x]
  F8B5  C9 06                 CMP   #$06                         ;[x]
  F8B7  90 07                 BCC   L00_F8C0                     ;[x]
  F8B9  AD 8A 2F              LDA   $2F8A                        ;[x]
  F8BC  C9 06                 CMP   #$06                         ;[x]
  F8BE  B0 27                 BCS   L00_F8E7                     ;[x]
L00_F8C0:
  F8C0  20 3E B6              JSR   L17_B63E                     ;[x]
  F8C3  20 E7 D1              JSR   $D1E7                        ;[x]
  F8C6  20 C7 D0              JSR   $D0C7                        ;[x]
  F8C9  20 25 D2              JSR   $D225                        ;[x]
  F8CC  20 CE D3              JSR   $D3CE                        ;[x]
  F8CF  20 7E D6              JSR   $D67E                        ;[x]
  F8D2  20 1C FC              JSR   L00_FC1C                     ;[x]
  F8D5  20 18 D1              JSR   $D118                        ;[x]
  F8D8  20 5F FA              JSR   L00_FA5F                     ;[x]
  F8DB  20 82 4E              JSR   $4E82                        ;[x]
  F8DE  20 55 FA              JSR   L00_FA55                     ;[x]
  F8E1  20 8F A5              JSR   L17_A58F                     ;[x]
  F8E4  20 05 FE              JSR   L00_FE05                     ;[x]
L00_F8E7:
  F8E7  20 4A D7              JSR   $D74A                        ;[x]
  F8EA  20 81 D2              JSR   $D281                        ;[x]
  F8ED  AD 89 2F              LDA   $2F89                        ;[x]
  F8F0  C9 07                 CMP   #$07                         ;[x]
  F8F2  D0 19                 BNE   L00_F90D                     ;[x]
  F8F4  AD 3A 3F              LDA   $3F3A                        ;[ ]
  F8F7  D0 0A                 BNE   L00_F903                     ;[ ]
  F8F9  AD 8A 2F              LDA   $2F8A                        ;[ ]
  F8FC  C9 06                 CMP   #$06                         ;[ ]
  F8FE  90 0D                 BCC   L00_F90D                     ;[ ]
  F900  4C 0E F9              JMP   L00_F90E                     ;[ ]

L00_F903:
  F903  AD 8A 2F              LDA   $2F8A                        ;[ ]
  F906  C9 07                 CMP   #$07                         ;[ ]
  F908  D0 03                 BNE   L00_F90D                     ;[ ]
  F90A  4C 0E F9              JMP   L00_F90E                     ;[ ]

L00_F90D:
  F90D  60                    RTS                                ;[x]

L00_F90E:
  F90E  A5 80                 LDA   <$80                         ;[x]
  F910  1A                    INC   A                            ;[x]
L00_F911:
  F911  85 80                 STA   <$80                         ;[x]
  F913  A9 01                 LDA   #$01                         ;[x]
  F915  85 3C                 STA   <$3C                         ;[x]
  F917  64 81                 STZ   <$81                         ;[x]
  F919  64 82                 STZ   <$82                         ;[x]
  F91B  60                    RTS                                ;[x]

L00_F91C:
  F91C  A5 35                 LDA   <$35                         ;[x]
  F91E  05 3C                 ORA   <$3C                         ;[x]
  F920  05 39                 ORA   <$39                         ;[x]
  F922  D0 37                 BNE   L00_F95B                     ;[x]
  F924  A5 3B                 LDA   <$3B                         ;[x]
  F926  D0 16                 BNE   L00_F93E                     ;[x]
  F928  62                    CLA                                ;[x]
  F929  0F 86 02              BBR0  <$86,L00_F92E                ;[x]
  F92C  05 22                 ORA   <$22                         ;[x]
L00_F92E:
  F92E  1F 86 02              BBR1  <$86,L00_F933                ;[x]
  F931  05 23                 ORA   <$23                         ;[ ]
L00_F933:
  F933  29 08                 AND   #$08                         ;[x]
  F935  F0 24                 BEQ   L00_F95B                     ;[x]
  F937  E6 3B                 INC   <$3B                         ;[ ]
  F939  A9 3E                 LDA   #$3E                         ;[ ]
  F93B  4C FC E3              JMP   L00_E3FC                     ;[ ]

L00_F93E:
  F93E  20 E7 D1              JSR   $D1E7                        ;[ ]
  F941  20 7E D6              JSR   $D67E                        ;[ ]
  F944  20 4A D7              JSR   $D74A                        ;[ ]
  F947  20 81 D2              JSR   $D281                        ;[ ]
  F94A  62                    CLA                                ;[ ]
  F94B  0F 86 02              BBR0  <$86,L00_F950                ;[ ]
  F94E  05 22                 ORA   <$22                         ;[ ]
L00_F950:
  F950  1F 86 02              BBR1  <$86,L00_F955                ;[ ]
  F953  05 23                 ORA   <$23                         ;[ ]
L00_F955:
  F955  29 08                 AND   #$08                         ;[ ]
  F957  F0 02                 BEQ   L00_F95B                     ;[ ]
  F959  64 3B                 STZ   <$3B                         ;[ ]
L00_F95B:
  F95B  60                    RTS                                ;[x]

  F95C  .db $0E,$5E,$B2,$71,$40,$91,$CE,$9F,$BE,$B1,$F7,$D5,$05,$16,$17,$45
  F96C  .db $3B,$57,$02,$03,$04,$05,$06,$07,$18,$10,$14,$10,$0D,$0C,$02,$00
  F97C  .db $00,$00,$00,$00,$00,$55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$01
  F98C  .db $00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00
L00_F998:
  F998  64 95                 STZ   <$95                         ;[x]
  F99A  62                    CLA                                ;[x]
  F99B  AC 89 2F              LDY   $2F89                        ;[x]
  F99E  C0 06                 CPY   #$06                         ;[x]
  F9A0  90 11                 BCC   L00_F9B3                     ;[x]
  F9A2  AC 8A 2F              LDY   $2F8A                        ;[ ]
  F9A5  C0 06                 CPY   #$06                         ;[ ]
  F9A7  90 0A                 BCC   L00_F9B3                     ;[ ]
  F9A9  A9 80                 LDA   #$80                         ;[ ]
  F9AB  85 B0                 STA   <$B0                         ;[ ]
  F9AD  20 3F EC              JSR   L00_EC3F                     ;[ ]
  F9B0  4C 0E F9              JMP   L00_F90E                     ;[ ]

L00_F9B3:
  F9B3  64 B0                 STZ   <$B0                         ;[x]
  F9B5  A9 01                 LDA   #$01                         ;[x]
  F9B7  85 3C                 STA   <$3C                         ;[x]
  F9B9  A2 01                 LDX   #$01                         ;[x]
L00_F9BB:
  F9BB  BD 59 36              LDA   $3659,X                      ;[x]
  F9BE  9D F2 3E              STA   $3EF2,X                      ;[x]
  F9C1  BD C6 36              LDA   $36C6,X                      ;[x]
  F9C4  9D F4 3E              STA   $3EF4,X                      ;[x]
  F9C7  BD 38 34              LDA   $3438,X                      ;[x]
  F9CA  9D E0 3E              STA   $3EE0,X                      ;[x]
  F9CD  BD 89 2F              LDA   $2F89,X                      ;[x]
  F9D0  C9 03                 CMP   #$03                         ;[x]
  F9D2  B0 03                 BCS   L00_F9D7                     ;[x]
  F9D4  9E E6 3E              STZ   $3EE6,X                      ;[x]
L00_F9D7:
  F9D7  B5 87                 LDA   <$87,X                       ;[x]
  F9D9  9D F0 3E              STA   $3EF0,X                      ;[x]
  F9DC  BD AE 34              LDA   $34AE,X                      ;[x]
  F9DF  9D E8 3E              STA   $3EE8,X                      ;[x]
  F9E2  BD 54 39              LDA   $3954,X                      ;[x]
  F9E5  9D EA 3E              STA   $3EEA,X                      ;[x]
  F9E8  CA                    DEX                                ;[x]
  F9E9  10 D0                 BPL   L00_F9BB                     ;[x]
  F9EB  AD 1E 2F              LDA   $2F1E                        ;[x]
  F9EE  8D E5 3E              STA   $3EE5                        ;[x]
  F9F1  A5 92                 LDA   <$92                         ;[x]
  F9F3  1A                    INC   A                            ;[x]
  F9F4  C9 06                 CMP   #$06                         ;[x]
  F9F6  90 05                 BCC   L00_F9FD                     ;[x]
  F9F8  A9 01                 LDA   #$01                         ;[ ]
  F9FA  85 B0                 STA   <$B0                         ;[ ]
  F9FC  62                    CLA                                ;[ ]
L00_F9FD:
  F9FD  8D E2 3E              STA   $3EE2                        ;[x]
  FA00  A5 C3                 LDA   <$C3                         ;[x]
  FA02  8D EE 3E              STA   $3EEE                        ;[x]
  FA05  A5 86                 LDA   <$86                         ;[x]
  FA07  8D E3 3E              STA   $3EE3                        ;[x]
  FA0A  A5 A0                 LDA   <$A0                         ;[x]
  FA0C  8D EF 3E              STA   $3EEF                        ;[x]
  FA0F  20 3F EC              JSR   L00_EC3F                     ;[x]
  FA12  4C 0E F9              JMP   L00_F90E                     ;[x]

L00_FA15:
  FA15  64 3F                 STZ   <$3F                         ;[x]
  FA17  64 4C                 STZ   <$4C                         ;[x]
  FA19  4C 0E F9              JMP   L00_F90E                     ;[x]

L00_FA1C:
  FA1C  A5 B0                 LDA   <$B0                         ;[x]
  FA1E  30 1F                 BMI   L00_FA3F                     ;[x]
  FA20  20 69 FA              JSR   L00_FA69                     ;[x]
  FA23  A5 B0                 LDA   <$B0                         ;[x]
  FA25  D0 05                 BNE   L00_FA2C                     ;[x]
  FA27  20 2E D2              JSR   $D22E                        ;[x]
  FA2A  80 03                 BRA   L00_FA2F                     ;[x]

L00_FA2C:
  FA2C  20 78 CA              JSR   $CA78                        ;[ ]
L00_FA2F:
  FA2F  20 55 FA              JSR   L00_FA55                     ;[x]
  FA32  A5 82                 LDA   <$82                         ;[x]
  FA34  D0 01                 BNE   L00_FA37                     ;[x]
  FA36  60                    RTS                                ;[x]

L00_FA37:
  FA37  20 E6 E7              JSR   L00_E7E6                     ;[x]
  FA3A  A9 05                 LDA   #$05                         ;[x]
  FA3C  4C 11 F9              JMP   L00_F911                     ;[x]

L00_FA3F:
  FA3F  4C 0E F9              JMP   L00_F90E                     ;[ ]

L00_FA42:
  FA42  20 69 FA              JSR   L00_FA69                     ;[ ]
  FA45  20 C5 D9              JSR   $D9C5                        ;[ ]
  FA48  20 55 FA              JSR   L00_FA55                     ;[ ]
  FA4B  A5 82                 LDA   <$82                         ;[ ]
  FA4D  D0 01                 BNE   L00_FA50                     ;[ ]
  FA4F  60                    RTS                                ;[ ]

L00_FA50:
  FA50  A9 80                 LDA   #$80                         ;[ ]
  FA52  85 37                 STA   <$37                         ;[ ]
  FA54  60                    RTS                                ;[ ]

L00_FA55:
  FA55  A9 14                 LDA   #$14                         ;[x]
  FA57  20 52 E3              JSR   L00_E352                     ;[x]
  FA5A  A9 01                 LDA   #$01                         ;[x]
  FA5C  53 40                 TAM   #$40                         ;[x]
  FA5E  60                    RTS                                ;[x]

L00_FA5F:
  FA5F  A9 0B                 LDA   #$0B                         ;[x]
  FA61  20 52 E3              JSR   L00_E352                     ;[x]
  FA64  A9 0F                 LDA   #$0F                         ;[x]
  FA66  53 40                 TAM   #$40                         ;[x]
  FA68  60                    RTS                                ;[x]

L00_FA69:
  FA69  A9 14                 LDA   #$14                         ;[x]
  FA6B  20 52 E3              JSR   L00_E352                     ;[x]
  FA6E  A9 15                 LDA   #$15                         ;[x]
  FA70  53 40                 TAM   #$40                         ;[x]
  FA72  60                    RTS                                ;[x]

  FA73  .db $A9,$16,$20,$3D,$F0,$AD,$25,$3F,$85,$00,$AD,$26,$3F,$85,$01,$AD
  FA83  .db $27,$3F,$85,$02,$AD,$28,$3F,$85,$03,$A5,$7E,$D0,$15,$B2,$00,$D0
  FA93  .db $03,$4C,$38,$FB,$85,$7E,$82,$20,$3F,$FB,$B2,$00,$85,$7F,$82,$20
  FAA3  .db $3F,$FB,$A5,$7F,$85,$18,$A5,$7C,$D0,$16,$B2,$02,$D0,$03,$4C,$38
  FAB3  .db $FB,$85,$7C,$A2,$02,$20,$3F,$FB,$B2,$02,$85,$7D,$A2,$02,$44,$7C
  FAC3  .db $A5,$7D,$85,$22,$AD,$29,$3F,$85,$00,$AD,$2A,$3F,$85,$01,$AD,$2B
  FAD3  .db $3F,$85,$02,$AD,$2C,$3F,$85,$03,$AD,$3D,$3F,$D0,$12,$B2,$00,$F0
  FAE3  .db $54,$8D,$3D,$3F,$82,$44,$66,$B2,$00,$8D,$3E,$3F,$82,$44,$5E,$AD
  FAF3  .db $3E,$3F,$85,$19,$AD,$3B,$3F,$D0,$14,$B2,$02,$F0,$38,$8D,$3B,$3F
  FB03  .db $A2,$02,$44,$49,$B2,$02,$8D,$3C,$3F,$A2,$02,$44,$40,$AD,$3C,$3F
  FB13  .db $85,$23,$CF,$83,$11,$A2,$01,$B5,$22,$09,$01,$95,$22,$B5,$18,$09
  FB23  .db $01,$95,$18,$CA,$10,$F1,$C6,$7E,$C6,$7C,$CE,$3D,$3F,$CE,$3B,$3F
  FB33  .db $A5,$37,$D0,$01,$60,$A9,$01,$85,$37,$4C,$DD,$E3,$F6,$00,$D0,$02
  FB43  .db $F6,$01,$B5,$00,$9D,$25,$3F,$B5,$01,$9D,$26,$3F,$60,$F6,$00,$D0
  FB53  .db $02,$F6,$01,$B5,$00,$9D,$29,$3F,$B5,$01,$9D,$2A,$3F,$60,$A5,$3E
  FB63  .db $0A,$A8,$B9,$96,$FB,$8D,$25,$3F,$B9,$97,$FB,$8D,$26,$3F,$B9,$A2
  FB73  .db $FB,$8D,$27,$3F,$B9,$A3,$FB,$8D,$28,$3F,$B9,$AE,$FB,$8D,$29,$3F
  FB83  .db $B9,$AF,$FB,$8D,$2A,$3F,$B9,$BA,$FB,$8D,$2B,$3F,$B9,$BB,$FB,$8D
  FB93  .db $2C,$3F,$60,$00,$C0,$B2,$C3,$30,$C7,$FC,$C9,$A2,$CD,$EC,$D0,$F0
  FBA3  .db $C2,$70,$C6,$98,$C9,$50,$CC,$78,$D0,$06,$D3,$00,$C0,$CA,$D3,$30
  FBB3  .db $C7,$94,$D8,$A2,$CD,$88,$DC,$F0,$C2,$CA,$D7,$98,$C9,$56,$DB,$78
  FBC3  .db $D0,$80,$DE,$00,$00
L00_FBC8:
  FBC8  A9 09                 LDA   #$09                         ;[x]
  FBCA  20 92 E7              JSR   L00_E792                     ;[x]
  FBCD  13 50                 ST1   #$50                         ;[x]
  FBCF  64 B4                 STZ   <$B4                         ;[x]
  FBD1  64 B5                 STZ   <$B5                         ;[x]
  FBD3  64 B6                 STZ   <$B6                         ;[x]
  FBD5  9C 78 3B              STZ   $3B78                        ;[x]
  FBD8  9C 73 3B              STZ   $3B73                        ;[x]
  FBDB  9C 72 3B              STZ   $3B72                        ;[x]
  FBDE  9C 71 3B              STZ   $3B71                        ;[x]
  FBE1  AD 71 3B              LDA   $3B71                        ;[x]
  FBE4  8D BA 3D              STA   $3DBA                        ;[x]
  FBE7  AD 70 3B              LDA   $3B70                        ;[x]
  FBEA  18                    CLC                                ;[x]
  FBEB  69 01                 ADC   #$01                         ;[x]
  FBED  8D 70 3B              STA   $3B70                        ;[x]
  FBF0  29 01                 AND   #$01                         ;[x]
  FBF2  8D BC 3D              STA   $3DBC                        ;[x]
  FBF5  A9 20                 LDA   #$20                         ;[x]
  FBF7  85 17                 STA   <$17                         ;[x]
L00_FBF9:
  FBF9  20 09 FD              JSR   L00_FD09                     ;[x]
  FBFC  AD 71 3B              LDA   $3B71                        ;[x]
  FBFF  38                    SEC                                ;[x]
  FC00  E9 08                 SBC   #$08                         ;[x]
  FC02  8D 71 3B              STA   $3B71                        ;[x]
  FC05  8D BA 3D              STA   $3DBA                        ;[x]
  FC08  AD 70 3B              LDA   $3B70                        ;[x]
  FC0B  E9 00                 SBC   #$00                         ;[x]
  FC0D  8D 70 3B              STA   $3B70                        ;[x]
  FC10  29 01                 AND   #$01                         ;[x]
  FC12  8D BC 3D              STA   $3DBC                        ;[x]
  FC15  C6 17                 DEC   <$17                         ;[x]
  FC17  D0 E0                 BNE   L00_FBF9                     ;[x]
  FC19  4C 09 FD              JMP   L00_FD09                     ;[x]

L00_FC1C:
  FC1C  9C 6F 3B              STZ   $3B6F                        ;[x]
  FC1F  9C 77 3B              STZ   $3B77                        ;[x]
  FC22  AD 7A 3B              LDA   $3B7A                        ;[x]
  FC25  F0 03                 BEQ   L00_FC2A                     ;[x]
  FC27  4C 03 FD              JMP   L00_FD03                     ;[x]

L00_FC2A:
  FC2A  A5 92                 LDA   <$92                         ;[x]
  FC2C  C9 02                 CMP   #$02                         ;[x]
  FC2E  D0 4D                 BNE   L00_FC7D                     ;[x]
  FC30  AD D0 3D              LDA   $3DD0                        ;[ ]
  FC33  18                    CLC                                ;[ ]
  FC34  6D 6D 3B              ADC   $3B6D                        ;[ ]
  FC37  8D D0 3D              STA   $3DD0                        ;[ ]
  FC3A  AD CF 3D              LDA   $3DCF                        ;[ ]
  FC3D  85 00                 STA   <$00                         ;[ ]
  FC3F  6D 6C 3B              ADC   $3B6C                        ;[ ]
  FC42  8D CF 3D              STA   $3DCF                        ;[ ]
  FC45  38                    SEC                                ;[ ]
  FC46  E5 00                 SBC   <$00                         ;[ ]
  FC48  8D 6F 3B              STA   $3B6F                        ;[ ]
  FC4B  AD CE 3D              LDA   $3DCE                        ;[ ]
  FC4E  D0 18                 BNE   L00_FC68                     ;[ ]
  FC50  AD CF 3D              LDA   $3DCF                        ;[ ]
  FC53  C9 40                 CMP   #$40                         ;[ ]
  FC55  90 26                 BCC   L00_FC7D                     ;[ ]
  FC57  A9 01                 LDA   #$01                         ;[ ]
  FC59  8D CE 3D              STA   $3DCE                        ;[ ]
  FC5C  A9 FF                 LDA   #$FF                         ;[ ]
  FC5E  8D 6C 3B              STA   $3B6C                        ;[ ]
  FC61  A9 EB                 LDA   #$EB                         ;[ ]
  FC63  8D 6D 3B              STA   $3B6D                        ;[ ]
  FC66  80 15                 BRA   L00_FC7D                     ;[ ]

L00_FC68:
  FC68  AD CF 3D              LDA   $3DCF                        ;[ ]
  FC6B  D0 10                 BNE   L00_FC7D                     ;[ ]
  FC6D  AD D0 3D              LDA   $3DD0                        ;[ ]
  FC70  D0 0B                 BNE   L00_FC7D                     ;[ ]
  FC72  9C CE 3D              STZ   $3DCE                        ;[ ]
  FC75  9C 6C 3B              STZ   $3B6C                        ;[ ]
  FC78  A9 15                 LDA   #$15                         ;[ ]
  FC7A  8D 6D 3B              STA   $3B6D                        ;[ ]
L00_FC7D:
  FC7D  38                    SEC                                ;[x]
  FC7E  AD 72 3B              LDA   $3B72                        ;[x]
  FC81  ED 75 3B              SBC   $3B75                        ;[x]
  FC84  8D 72 3B              STA   $3B72                        ;[x]
  FC87  AD 71 3B              LDA   $3B71                        ;[x]
  FC8A  85 00                 STA   <$00                         ;[x]
  FC8C  ED 74 3B              SBC   $3B74                        ;[x]
  FC8F  8D 71 3B              STA   $3B71                        ;[x]
  FC92  AD 70 3B              LDA   $3B70                        ;[x]
  FC95  E9 00                 SBC   #$00                         ;[x]
  FC97  8D 70 3B              STA   $3B70                        ;[x]
  FC9A  A5 00                 LDA   <$00                         ;[x]
  FC9C  38                    SEC                                ;[x]
  FC9D  ED 71 3B              SBC   $3B71                        ;[x]
  FCA0  8D 77 3B              STA   $3B77                        ;[x]
  FCA3  18                    CLC                                ;[x]
  FCA4  65 B5                 ADC   <$B5                         ;[x]
  FCA6  85 B5                 STA   <$B5                         ;[x]
  FCA8  62                    CLA                                ;[x]
  FCA9  65 B4                 ADC   <$B4                         ;[x]
  FCAB  85 B4                 STA   <$B4                         ;[x]
  FCAD  AD BA 3D              LDA   $3DBA                        ;[x]
  FCB0  38                    SEC                                ;[x]
  FCB1  ED 77 3B              SBC   $3B77                        ;[x]
  FCB4  8D BA 3D              STA   $3DBA                        ;[x]
  FCB7  B0 00                 BCS   L00_FCB9                     ;[x]
L00_FCB9:
  FCB9  AD BC 3D              LDA   $3DBC                        ;[x]
  FCBC  E9 00                 SBC   #$00                         ;[x]
  FCBE  8D BC 3D              STA   $3DBC                        ;[x]
  FCC1  A5 92                 LDA   <$92                         ;[x]
  FCC3  C9 05                 CMP   #$05                         ;[x]
  FCC5  D0 19                 BNE   L00_FCE0                     ;[x]
  FCC7  AD 70 3B              LDA   $3B70                        ;[ ]
  FCCA  C9 05                 CMP   #$05                         ;[ ]
  FCCC  D0 12                 BNE   L00_FCE0                     ;[ ]
  FCCE  AD 71 3B              LDA   $3B71                        ;[ ]
  FCD1  F0 0B                 BEQ   L00_FCDE                     ;[ ]
  FCD3  49 FF                 EOR   #$FF                         ;[ ]
  FCD5  1A                    INC   A                            ;[ ]
  FCD6  85 8E                 STA   <$8E                         ;[ ]
  FCD8  A9 01                 LDA   #$01                         ;[ ]
  FCDA  85 9F                 STA   <$9F                         ;[ ]
  FCDC  80 02                 BRA   L00_FCE0                     ;[ ]

L00_FCDE:
  FCDE  64 89                 STZ   <$89                         ;[ ]
L00_FCE0:
  FCE0  AD 70 3B              LDA   $3B70                        ;[x]
  FCE3  0D 71 3B              ORA   $3B71                        ;[x]
  FCE6  D0 0D                 BNE   L00_FCF5                     ;[x]
  FCE8  A9 00                 LDA   #$00                         ;[ ]
  FCEA  8D 71 3B              STA   $3B71                        ;[ ]
  FCED  A9 02                 LDA   #$02                         ;[ ]
  FCEF  8D 70 3B              STA   $3B70                        ;[ ]
  FCF2  9C 72 3B              STZ   $3B72                        ;[ ]
L00_FCF5:
  FCF5  AD 78 3B              LDA   $3B78                        ;[x]
  FCF8  18                    CLC                                ;[x]
  FCF9  6D 77 3B              ADC   $3B77                        ;[x]
  FCFC  8D 78 3B              STA   $3B78                        ;[x]
  FCFF  C9 08                 CMP   #$08                         ;[x]
  FD01  B0 01                 BCS   L00_FD04                     ;[x]
L00_FD03:
  FD03  60                    RTS                                ;[x]

L00_FD04:
  FD04  E9 08                 SBC   #$08                         ;[x]
  FD06  8D 78 3B              STA   $3B78                        ;[x]
L00_FD09:
  FD09  20 90 E7              JSR   L00_E790                     ;[x]
  FD0C  A9 00                 LDA   #$00                         ;[x]
  FD0E  8D 03 00              STA   VDC_DATA_H                   ;[x]
  FD11  20 8D E7              JSR   L00_E78D                     ;[x]
  FD14  AD BA 3D              LDA   $3DBA                        ;[x]
  FD17  38                    SEC                                ;[x]
  FD18  E9 08                 SBC   #$08                         ;[x]
  FD1A  85 00                 STA   <$00                         ;[x]
  FD1C  AD BC 3D              LDA   $3DBC                        ;[x]
  FD1F  E9 00                 SBC   #$00                         ;[x]
  FD21  29 01                 AND   #$01                         ;[x]
  FD23  85 02                 STA   <$02                         ;[x]
  FD25  A5 00                 LDA   <$00                         ;[x]
  FD27  0A                    ASL   A                            ;[x]
  FD28  26 02                 ROL   <$02                         ;[x]
  FD2A  0A                    ASL   A                            ;[x]
  FD2B  26 02                 ROL   <$02                         ;[x]
  FD2D  0A                    ASL   A                            ;[x]
  FD2E  26 02                 ROL   <$02                         ;[x]
  FD30  8D 02 00              STA   VDC_DATA_L                   ;[x]
  FD33  A5 02                 LDA   <$02                         ;[x]
  FD35  8D 03 00              STA   VDC_DATA_H                   ;[x]
  FD38  AD 71 3B              LDA   $3B71                        ;[x]
  FD3B  38                    SEC                                ;[x]
  FD3C  E9 08                 SBC   #$08                         ;[x]
  FD3E  85 00                 STA   <$00                         ;[x]
  FD40  AD 70 3B              LDA   $3B70                        ;[x]
  FD43  E9 00                 SBC   #$00                         ;[x]
  FD45  85 01                 STA   <$01                         ;[x]
  FD47  A5 92                 LDA   <$92                         ;[x]
  FD49  AA                    TAX                                ;[x]
  FD4A  BD F3 FD              LDA   $FDF3,X                      ;[x]
  FD4D  20 52 E3              JSR   L00_E352                     ;[x]
  FD50  8A                    TXA                                ;[x]
  FD51  0A                    ASL   A                            ;[x]
  FD52  AA                    TAX                                ;[x]
  FD53  E0 04                 CPX   #$04                         ;[x]
  FD55  F0 19                 BEQ   L00_FD70                     ;[x]
  FD57  A5 01                 LDA   <$01                         ;[x]
  FD59  85 09                 STA   <$09                         ;[x]
  FD5B  62                    CLA                                ;[x]
  FD5C  46 09                 LSR   <$09                         ;[x]
  FD5E  6A                    ROR   A                            ;[x]
  FD5F  46 09                 LSR   <$09                         ;[x]
  FD61  6A                    ROR   A                            ;[x]
  FD62  85 08                 STA   <$08                         ;[x]
  FD64  A5 00                 LDA   <$00                         ;[x]
  FD66  29 E0                 AND   #$E0                         ;[x]
  FD68  4A                    LSR   A                            ;[x]
  FD69  4A                    LSR   A                            ;[x]
  FD6A  05 08                 ORA   <$08                         ;[x]
  FD6C  85 08                 STA   <$08                         ;[x]
  FD6E  80 0C                 BRA   L00_FD7C                     ;[x]

L00_FD70:
  FD70  A5 01                 LDA   <$01                         ;[ ]
  FD72  85 09                 STA   <$09                         ;[ ]
  FD74  A5 00                 LDA   <$00                         ;[ ]
  FD76  29 E0                 AND   #$E0                         ;[ ]
  FD78  18                    CLC                                ;[ ]
  FD79  46 09                 LSR   <$09                         ;[ ]
  FD7B  6A                    ROR   A                            ;[ ]
L00_FD7C:
  FD7C  18                    CLC                                ;[x]
  FD7D  7D DB FD              ADC   $FDDB,X                      ;[x]
  FD80  85 08                 STA   <$08                         ;[x]
  FD82  A5 09                 LDA   <$09                         ;[x]
  FD84  7D DC FD              ADC   $FDDC,X                      ;[x]
  FD87  85 09                 STA   <$09                         ;[x]
  FD89  20 85 E7              JSR   L00_E785                     ;[x]
  FD8C  A5 92                 LDA   <$92                         ;[x]
  FD8E  C9 02                 CMP   #$02                         ;[x]
  FD90  D0 06                 BNE   L00_FD98                     ;[x]
  FD92  A9 10                 LDA   #$10                         ;[ ]
  FD94  85 12                 STA   <$12                         ;[ ]
  FD96  80 04                 BRA   L00_FD9C                     ;[ ]

L00_FD98:
  FD98  A9 08                 LDA   #$08                         ;[x]
  FD9A  85 12                 STA   <$12                         ;[x]
L00_FD9C:
  FD9C  C2                    CLY                                ;[x]
L00_FD9D:
  FD9D  B1 08                 LDA   (<$08),Y                     ;[x]
  FD9F  85 11                 STA   <$11                         ;[x]
  FDA1  62                    CLA                                ;[x]
  FDA2  46 11                 LSR   <$11                         ;[x]
  FDA4  6A                    ROR   A                            ;[x]
  FDA5  46 11                 LSR   <$11                         ;[x]
  FDA7  6A                    ROR   A                            ;[x]
  FDA8  46 11                 LSR   <$11                         ;[x]
  FDAA  6A                    ROR   A                            ;[x]
  FDAB  85 10                 STA   <$10                         ;[x]
  FDAD  A5 00                 LDA   <$00                         ;[x]
  FDAF  29 18                 AND   #$18                         ;[x]
  FDB1  05 10                 ORA   <$10                         ;[x]
  FDB3  18                    CLC                                ;[x]
  FDB4  7D E7 FD              ADC   $FDE7,X                      ;[x]
  FDB7  85 10                 STA   <$10                         ;[x]
  FDB9  A5 11                 LDA   <$11                         ;[x]
  FDBB  7D E8 FD              ADC   $FDE8,X                      ;[x]
  FDBE  85 11                 STA   <$11                         ;[x]
  FDC0  5A                    PHY                                ;[x]
  FDC1  C2                    CLY                                ;[x]
L00_FDC2:
  FDC2  B1 10                 LDA   (<$10),Y                     ;[x]
  FDC4  8D 02 00              STA   VDC_DATA_L                   ;[x]
  FDC7  C8                    INY                                ;[x]
  FDC8  B1 10                 LDA   (<$10),Y                     ;[x]
  FDCA  8D 03 00              STA   VDC_DATA_H                   ;[x]
  FDCD  C8                    INY                                ;[x]
  FDCE  C0 08                 CPY   #$08                         ;[x]
  FDD0  90 F0                 BCC   L00_FDC2                     ;[x]
  FDD2  7A                    PLY                                ;[x]
  FDD3  C8                    INY                                ;[x]
  FDD4  C4 12                 CPY   <$12                         ;[x]
  FDD6  90 C5                 BCC   L00_FD9D                     ;[x]
  FDD8  4C 65 E3              JMP   L00_E365                     ;[x]

  FDDB  .db $BD,$9C,$FD,$A2,$3D,$A7,$CB,$90,$BD,$B7,$0B,$95,$BD,$4A,$3D,$62
  FDEB  .db $9D,$74,$8B,$5F,$9D,$80,$AB,$7B,$38,$38,$38,$3C,$38,$3C
L00_FDF9:
  FDF9  AD BA 3D              LDA   $3DBA                        ;[x]
  FDFC  0A                    ASL   A                            ;[x]
  FDFD  AD BC 3D              LDA   $3DBC                        ;[x]
  FE00  2A                    ROL   A                            ;[x]
  FE01  29 03                 AND   #$03                         ;[x]
  FE03  80 15                 BRA   L00_FE1A                     ;[x]

L00_FE05:
  FE05  AD BA 3D              LDA   $3DBA                        ;[x]
  FE08  0A                    ASL   A                            ;[x]
  FE09  AD BC 3D              LDA   $3DBC                        ;[x]
  FE0C  2A                    ROL   A                            ;[x]
  FE0D  29 03                 AND   #$03                         ;[x]
  FE0F  C5 94                 CMP   <$94                         ;[x]
  FE11  F0 3D                 BEQ   L00_FE50                     ;[x]
  FE13  48                    PHA                                ;[x]
  FE14  A9 10                 LDA   #$10                         ;[x]
  FE16  20 74 EC              JSR   L00_EC74                     ;[x]
  FE19  68                    PLA                                ;[x]
L00_FE1A:
  FE1A  85 94                 STA   <$94                         ;[x]
  FE1C  0A                    ASL   A                            ;[x]
  FE1D  A8                    TAY                                ;[x]
  FE1E  B9 51 FE              LDA   $FE51,Y                      ;[x]
  FE21  8D CA 3D              STA   $3DCA                        ;[x]
  FE24  B9 52 FE              LDA   $FE52,Y                      ;[x]
  FE27  8D CB 3D              STA   $3DCB                        ;[x]
  FE2A  B9 59 FE              LDA   $FE59,Y                      ;[x]
  FE2D  8D C8 3D              STA   $3DC8                        ;[x]
  FE30  B9 5A FE              LDA   $FE5A,Y                      ;[x]
  FE33  8D C9 3D              STA   $3DC9                        ;[x]
  FE36  A9 3E                 LDA   #$3E                         ;[x]
  FE38  20 74 EC              JSR   L00_EC74                     ;[x]
  FE3B  20 AF EC              JSR   L00_ECAF                     ;[x]
  FE3E  20 AF EC              JSR   L00_ECAF                     ;[x]
  FE41  20 AF EC              JSR   L00_ECAF                     ;[x]
  FE44  20 AF EC              JSR   L00_ECAF                     ;[x]
  FE47  82                    CLX                                ;[x]
  FE48  20 8D D2              JSR   $D28D                        ;[x]
  FE4B  A2 01                 LDX   #$01                         ;[x]
  FE4D  4C 8D D2              JMP   $D28D                        ;[x]

L00_FE50:
  FE50  60                    RTS                                ;[x]

  FE51  .db $BF,$01,$3F,$00,$BF,$00,$3F,$01,$20,$0E,$20,$02,$20,$06,$20,$0A
L00_FE61:
  FE61  84 05                 STY   <$05                         ;[x]
  FE63  44 4B                 BSR   L00_FEB0                     ;[x]
  FE65  80 04                 BRA   L00_FE6B                     ;[x]

L00_FE67:
  FE67  84 05                 STY   <$05                         ;[x]
  FE69  44 1F                 BSR   L00_FE8A                     ;[x]
L00_FE6B:
  FE6B  64 00                 STZ   <$00                         ;[x]
  FE6D  64 01                 STZ   <$01                         ;[x]
  FE6F  A0 08                 LDY   #$08                         ;[x]
L00_FE71:
  FE71  66 05                 ROR   <$05                         ;[x]
  FE73  90 0D                 BCC   L00_FE82                     ;[x]
  FE75  18                    CLC                                ;[x]
  FE76  A5 03                 LDA   <$03                         ;[x]
  FE78  65 00                 ADC   <$00                         ;[x]
  FE7A  85 00                 STA   <$00                         ;[x]
  FE7C  A5 04                 LDA   <$04                         ;[x]
  FE7E  65 01                 ADC   <$01                         ;[x]
  FE80  85 01                 STA   <$01                         ;[x]
L00_FE82:
  FE82  06 03                 ASL   <$03                         ;[x]
  FE84  26 04                 ROL   <$04                         ;[x]
  FE86  88                    DEY                                ;[x]
  FE87  D0 E8                 BNE   L00_FE71                     ;[x]
  FE89  60                    RTS                                ;[x]

L00_FE8A:
  FE8A  64 04                 STZ   <$04                         ;[x]
  FE8C  89 0F                 BIT   #$0F                         ;[x]
  FE8E  F0 1A                 BEQ   L00_FEAA                     ;[x]
  FE90  A8                    TAY                                ;[x]
  FE91  29 10                 AND   #$10                         ;[x]
  FE93  F0 04                 BEQ   L00_FE99                     ;[x]
  FE95  A9 FF                 LDA   #$FF                         ;[x]
  FE97  85 04                 STA   <$04                         ;[x]
L00_FE99:
  FE99  98                    TYA                                ;[x]
  FE9A  A0 B8                 LDY   #$B8                         ;[x]
  FE9C  84 00                 STY   <$00                         ;[x]
  FE9E  A0 FE                 LDY   #$FE                         ;[x]
  FEA0  84 01                 STY   <$01                         ;[x]
  FEA2  29 1F                 AND   #$1F                         ;[x]
  FEA4  A8                    TAY                                ;[x]
  FEA5  B1 00                 LDA   (<$00),Y                     ;[x]
  FEA7  85 03                 STA   <$03                         ;[x]
  FEA9  60                    RTS                                ;[x]

L00_FEAA:
  FEAA  62                    CLA                                ;[x]
  FEAB  85 02                 STA   <$02                         ;[x]
  FEAD  85 03                 STA   <$03                         ;[x]
  FEAF  60                    RTS                                ;[x]

L00_FEB0:
  FEB0  18                    CLC                                ;[x]
  FEB1  69 08                 ADC   #$08                         ;[x]
  FEB3  29 1F                 AND   #$1F                         ;[x]
  FEB5  4C 8A FE              JMP   L00_FE8A                     ;[x]

  FEB8  .db $00,$31,$60,$8C,$B3,$D3,$EB,$FA,$FF,$FA,$EB,$D3,$B3,$8C,$60,$31
  FEC8  .db $FF,$CF,$A0,$74,$4D,$2D,$15,$06,$01,$06,$15,$2D,$4D,$74,$A0,$CF
L00_FED8:
  FED8  DA                    PHX                                ;[x]
  FED9  5A                    PHY                                ;[x]
  FEDA  A5 B1                 LDA   <$B1                         ;[x]
  FEDC  0A                    ASL   A                            ;[x]
  FEDD  0A                    ASL   A                            ;[x]
  FEDE  0A                    ASL   A                            ;[x]
  FEDF  85 70                 STA   <$70                         ;[x]
  FEE1  A5 92                 LDA   <$92                         ;[x]
  FEE3  18                    CLC                                ;[x]
  FEE4  65 70                 ADC   <$70                         ;[x]
  FEE6  85 70                 STA   <$70                         ;[x]
  FEE8  A5 9E                 LDA   <$9E                         ;[x]
  FEEA  F0 07                 BEQ   L00_FEF3                     ;[x]
  FEEC  A5 70                 LDA   <$70                         ;[ ]
  FEEE  18                    CLC                                ;[ ]
  FEEF  69 10                 ADC   #$10                         ;[ ]
  FEF1  85 70                 STA   <$70                         ;[ ]
L00_FEF3:
  FEF3  A5 86                 LDA   <$86                         ;[x]
  FEF5  85 71                 STA   <$71                         ;[x]
  FEF7  82                    CLX                                ;[x]
L00_FEF8:
  FEF8  46 71                 LSR   <$71                         ;[x]
  FEFA  90 51                 BCC   L00_FF4D                     ;[x]
  FEFC  A9 08                 LDA   #$08                         ;[x]
  FEFE  18                    CLC                                ;[x]
  FEFF  65 70                 ADC   <$70                         ;[x]
  FF01  85 70                 STA   <$70                         ;[x]
  FF03  BD 38 34              LDA   $3438,X                      ;[x]
  FF06  89 04                 BIT   #$04                         ;[x]
  FF08  F0 02                 BEQ   L00_FF0C                     ;[x]
  FF0A  E6 70                 INC   <$70                         ;[ ]
L00_FF0C:
  FF0C  89 08                 BIT   #$08                         ;[x]
  FF0E  F0 04                 BEQ   L00_FF14                     ;[x]
  FF10  E6 70                 INC   <$70                         ;[ ]
  FF12  E6 70                 INC   <$70                         ;[ ]
L00_FF14:
  FF14  89 01                 BIT   #$01                         ;[x]
  FF16  F0 04                 BEQ   L00_FF1C                     ;[x]
  FF18  E6 70                 INC   <$70                         ;[ ]
  FF1A  E6 70                 INC   <$70                         ;[ ]
L00_FF1C:
  FF1C  89 10                 BIT   #$10                         ;[x]
  FF1E  F0 04                 BEQ   L00_FF24                     ;[x]
  FF20  E6 70                 INC   <$70                         ;[ ]
  FF22  E6 70                 INC   <$70                         ;[ ]
L00_FF24:
  FF24  89 02                 BIT   #$02                         ;[x]
  FF26  F0 07                 BEQ   L00_FF2F                     ;[x]
  FF28  A5 70                 LDA   <$70                         ;[ ]
  FF2A  18                    CLC                                ;[ ]
  FF2B  69 03                 ADC   #$03                         ;[ ]
  FF2D  85 70                 STA   <$70                         ;[ ]
L00_FF2F:
  FF2F  BD 38 34              LDA   $3438,X                      ;[x]
  FF32  89 80                 BIT   #$80                         ;[x]
  FF34  F0 07                 BEQ   L00_FF3D                     ;[x]
  FF36  A5 70                 LDA   <$70                         ;[x]
  FF38  18                    CLC                                ;[x]
  FF39  69 04                 ADC   #$04                         ;[x]
  FF3B  85 70                 STA   <$70                         ;[x]
L00_FF3D:
  FF3D  BD 54 39              LDA   $3954,X                      ;[x]
  FF40  4A                    LSR   A                            ;[x]
  FF41  38                    SEC                                ;[x]
  FF42  E9 02                 SBC   #$02                         ;[x]
  FF44  30 07                 BMI   L00_FF4D                     ;[x]
  FF46  1A                    INC   A                            ;[x]
  FF47  4A                    LSR   A                            ;[x]
  FF48  18                    CLC                                ;[x]
  FF49  65 70                 ADC   <$70                         ;[x]
  FF4B  85 70                 STA   <$70                         ;[x]
L00_FF4D:
  FF4D  E8                    INX                                ;[x]
  FF4E  E0 02                 CPX   #$02                         ;[x]
  FF50  D0 A6                 BNE   L00_FEF8                     ;[x]
  FF52  A5 70                 LDA   <$70                         ;[x]
  FF54  4A                    LSR   A                            ;[x]
  FF55  38                    SEC                                ;[x]
  FF56  E9 04                 SBC   #$04                         ;[x]
  FF58  10 01                 BPL   L00_FF5B                     ;[x]
  FF5A  62                    CLA                                ;[ ]
L00_FF5B:
  FF5B  85 8F                 STA   <$8F                         ;[x]
  FF5D  7A                    PLY                                ;[x]
  FF5E  FA                    PLX                                ;[x]
  FF5F  60                    RTS                                ;[x]

  FF60  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  FF70  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  FF80  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  FF90  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  FFA0  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  FFB0  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  FFC0  .db $44,$45,$54,$41,$4E,$41,$20,$54,$57,$49,$4E,$42,$45,$45,$20,$20
  FFD0  .db $20,$20,$20,$20,$20,$20,$00,$09,$00,$00,$A4,$00,$57,$29,$A8,$D6
  FFE0  .db $48,$43,$80,$48,$A9,$FC,$53,$80,$4C,$64,$F3,$68,$53,$80,$68,$40
  FFF0  .db $FF,$FF,$FF,$FF,$FF,$FF,$DD,$E1,$F1,$E0,$24,$E4,$DD,$E1,$00,$E0
