; Detana!! TwinBee (PCE) - banque $15, vue en $C000-$DFFF
; 2202 octets de code (1912 exécutés en émulation)
; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique

L15_C000:
  C000  A5 31                 LDA   <$31                         ;[x]
  C002  20 A2 E7              JSR   L00_E7A2                     ;[x]
  C005  15 C0                 ORA   <$C0,X                       ;[ ]
  C007  73 C0 97 C1 E7 C1 9F  TII   $97C0,$E7C1,$9FC1            ;[ ]
  C00E  C2                    CLY                                ;[ ]
  C00F  00                    BRK                                ;[ ]
  C010  .db $C3,$5A,$C3,$E1,$C3
L15_C015:
  C015  20 DD E3              JSR   L00_E3DD                     ;[x]
  C018  20 3F EC              JSR   L00_EC3F                     ;[x]
  C01B  A9 09                 LDA   #$09                         ;[x]
  C01D  20 92 E7              JSR   L00_E792                     ;[x]
  C020  13 50                 ST1   #$50                         ;[x]
  C022  A9 39                 LDA   #$39                         ;[x]
  C024  20 64 F0              JSR   L00_F064                     ;[x]
  C027  A2 01                 LDX   #$01                         ;[x]
  C029  A9 14                 LDA   #$14                         ;[x]
  C02B  20 65 F0              JSR   L00_F065                     ;[x]
  C02E  A9 04                 LDA   #$04                         ;[x]
  C030  20 D4 E8              JSR   L00_E8D4                     ;[x]
  C033  A9 53                 LDA   #$53                         ;[x]
  C035  20 FC E3              JSR   L00_E3FC                     ;[x]
  C038  A9 2A                 LDA   #$2A                         ;[x]
  C03A  85 74                 STA   <$74                         ;[x]
  C03C  A9 02                 LDA   #$02                         ;[x]
  C03E  85 75                 STA   <$75                         ;[x]
  C040  A9 01                 LDA   #$01                         ;[x]
  C042  8D 21 2C              STA   $2C21                        ;[x]
  C045  A9 10                 LDA   #$10                         ;[x]
  C047  8D 8E 2C              STA   $2C8E                        ;[x]
  C04A  A9 80                 LDA   #$80                         ;[x]
  C04C  8D 47 2B              STA   $2B47                        ;[x]
  C04F  9C DA 2A              STZ   $2ADA                        ;[x]
  C052  A9 07                 LDA   #$07                         ;[x]
  C054  8D 6D 2A              STA   $2A6D                        ;[x]
  C057  64 74                 STZ   <$74                         ;[x]
  C059  A9 80                 LDA   #$80                         ;[x]
  C05B  8D BA 3D              STA   $3DBA                        ;[x]
  C05E  A9 2F                 LDA   #$2F                         ;[x]
  C060  85 78                 STA   <$78                         ;[x]
  C062  A2 04                 LDX   #$04                         ;[x]
L15_C064:
  C064  9E A1 3F              STZ   $3FA1,X                      ;[x]
  C067  CA                    DEX                                ;[x]
  C068  10 FA                 BPL   L15_C064                     ;[x]
  C06A  20 6D CA              JSR   L15_CA6D                     ;[x]
  C06D  E6 31                 INC   <$31                         ;[x]
  C06F  9C A0 37              STZ   $37A0                        ;[x]
  C072  60                    RTS                                ;[x]

  C073  A5 22                 LDA   <$22                         ;[x]
  C075  29 0C                 AND   #$0C                         ;[x]
  C077  F0 07                 BEQ   L15_C080                     ;[x]
  C079  A9 06                 LDA   #$06                         ;[ ]
  C07B  85 31                 STA   <$31                         ;[ ]
  C07D  4C DD E3              JMP   L00_E3DD                     ;[ ]

L15_C080:
  C080  A5 32                 LDA   <$32                         ;[x]
  C082  29 03                 AND   #$03                         ;[x]
  C084  D0 0D                 BNE   L15_C093                     ;[x]
  C086  AD 6D 2A              LDA   $2A6D                        ;[x]
  C089  1A                    INC   A                            ;[x]
  C08A  C9 09                 CMP   #$09                         ;[x]
  C08C  90 02                 BCC   L15_C090                     ;[x]
  C08E  A9 01                 LDA   #$01                         ;[x]
L15_C090:
  C090  8D 6D 2A              STA   $2A6D                        ;[x]
L15_C093:
  C093  AD FB 2C              LDA   $2CFB                        ;[x]
  C096  38                    SEC                                ;[x]
  C097  E9 4E                 SBC   #$4E                         ;[x]
  C099  8D FB 2C              STA   $2CFB                        ;[x]
  C09C  AD 8E 2C              LDA   $2C8E                        ;[x]
  C09F  E9 00                 SBC   #$00                         ;[x]
  C0A1  8D 8E 2C              STA   $2C8E                        ;[x]
  C0A4  AD 21 2C              LDA   $2C21                        ;[x]
  C0A7  E9 00                 SBC   #$00                         ;[x]
  C0A9  8D 21 2C              STA   $2C21                        ;[x]
  C0AC  D0 23                 BNE   L15_C0D1                     ;[x]
  C0AE  AD 8E 2C              LDA   $2C8E                        ;[x]
  C0B1  C9 2D                 CMP   #$2D                         ;[x]
  C0B3  B0 1C                 BCS   L15_C0D1                     ;[x]
  C0B5  A9 0A                 LDA   #$0A                         ;[x]
  C0B7  85 72                 STA   <$72                         ;[x]
  C0B9  64 73                 STZ   <$73                         ;[x]
  C0BB  A9 09                 LDA   #$09                         ;[x]
  C0BD  8D 6D 2A              STA   $2A6D                        ;[x]
  C0C0  A9 58                 LDA   #$58                         ;[x]
  C0C2  8D BA 3D              STA   $3DBA                        ;[x]
  C0C5  A9 01                 LDA   #$01                         ;[x]
  C0C7  20 FC E3              JSR   L00_E3FC                     ;[x]
  C0CA  A9 38                 LDA   #$38                         ;[x]
  C0CC  20 FC E3              JSR   L00_E3FC                     ;[x]
  C0CF  E6 31                 INC   <$31                         ;[x]
L15_C0D1:
  C0D1  AD 8E 2C              LDA   $2C8E                        ;[x]
  C0D4  A4 74                 LDY   <$74                         ;[x]
  C0D6  C0 08                 CPY   #$08                         ;[x]
  C0D8  B0 0D                 BCS   L15_C0E7                     ;[x]
  C0DA  D9 86 C1              CMP   $C186,Y                      ;[x]
  C0DD  D0 08                 BNE   L15_C0E7                     ;[x]
  C0DF  E6 74                 INC   <$74                         ;[x]
  C0E1  B9 8F C1              LDA   $C18F,Y                      ;[x]
  C0E4  20 D4 E8              JSR   L00_E8D4                     ;[x]
L15_C0E7:
  C0E7  C6 75                 DEC   <$75                         ;[x]
  C0E9  D0 68                 BNE   L15_C153                     ;[x]
  C0EB  AD 8E 2C              LDA   $2C8E                        ;[x]
  C0EE  C9 20                 CMP   #$20                         ;[x]
  C0F0  90 13                 BCC   L15_C105                     ;[x]
  C0F2  C9 90                 CMP   #$90                         ;[x]
  C0F4  B0 0F                 BCS   L15_C105                     ;[x]
  C0F6  A2 0F                 LDX   #$0F                         ;[x]
  C0F8  20 AB E8              JSR   L00_E8AB                     ;[x]
  C0FB  AD 8F 3F              LDA   $3F8F                        ;[x]
  C0FE  29 03                 AND   #$03                         ;[x]
  C100  18                    CLC                                ;[x]
  C101  69 0C                 ADC   #$0C                         ;[x]
  C103  80 04                 BRA   L15_C109                     ;[x]

L15_C105:
  C105  A2 05                 LDX   #$05                         ;[x]
  C107  A9 10                 LDA   #$10                         ;[x]
L15_C109:
  C109  86 76                 STX   <$76                         ;[x]
  C10B  85 77                 STA   <$77                         ;[x]
L15_C10D:
  C10D  BD 1F 2F              LDA   $2F1F,X                      ;[x]
  C110  D0 31                 BNE   L15_C143                     ;[x]
  C112  20 AB E8              JSR   L00_E8AB                     ;[x]
  C115  AD 8F 3F              LDA   $3F8F                        ;[x]
  C118  29 1F                 AND   #$1F                         ;[x]
  C11A  18                    CLC                                ;[x]
  C11B  7D 76 C1              ADC   $C176,X                      ;[x]
  C11E  9D 4A 2B              STA   $2B4A,X                      ;[x]
  C121  9E DD 2A              STZ   $2ADD,X                      ;[x]
  C124  9E 91 2C              STZ   $2C91,X                      ;[x]
  C127  9E 24 2C              STZ   $2C24,X                      ;[x]
  C12A  20 AB E8              JSR   L00_E8AB                     ;[x]
  C12D  AD 8F 3F              LDA   $3F8F                        ;[x]
  C130  29 03                 AND   #$03                         ;[x]
  C132  A8                    TAY                                ;[x]
  C133  B9 72 C1              LDA   $C172,Y                      ;[x]
  C136  9D 40 31              STA   $3140,X                      ;[x]
  C139  A5 77                 LDA   <$77                         ;[x]
  C13B  9D 70 2A              STA   $2A70,X                      ;[x]
  C13E  9D 1F 2F              STA   $2F1F,X                      ;[x]
  C141  80 03                 BRA   L15_C146                     ;[x]

L15_C143:
  C143  CA                    DEX                                ;[x]
  C144  10 C7                 BPL   L15_C10D                     ;[x]
L15_C146:
  C146  A9 02                 LDA   #$02                         ;[x]
  C148  A4 76                 LDY   <$76                         ;[x]
  C14A  C0 05                 CPY   #$05                         ;[x]
  C14C  D0 03                 BNE   L15_C151                     ;[x]
  C14E  0A                    ASL   A                            ;[x]
  C14F  0A                    ASL   A                            ;[x]
  C150  0A                    ASL   A                            ;[x]
L15_C151:
  C151  85 75                 STA   <$75                         ;[x]
L15_C153:
  C153  A2 0F                 LDX   #$0F                         ;[x]
L15_C155:
  C155  BD 1F 2F              LDA   $2F1F,X                      ;[x]
  C158  F0 14                 BEQ   L15_C16E                     ;[x]
  C15A  BD 40 31              LDA   $3140,X                      ;[x]
  C15D  18                    CLC                                ;[x]
  C15E  7D 91 2C              ADC   $2C91,X                      ;[x]
  C161  B0 05                 BCS   L15_C168                     ;[x]
  C163  9D 91 2C              STA   $2C91,X                      ;[x]
  C166  80 06                 BRA   L15_C16E                     ;[x]

L15_C168:
  C168  9E 70 2A              STZ   $2A70,X                      ;[x]
  C16B  9E 1F 2F              STZ   $2F1F,X                      ;[x]
L15_C16E:
  C16E  CA                    DEX                                ;[x]
  C16F  10 E4                 BPL   L15_C155                     ;[x]
  C171  60                    RTS                                ;[x]

  C172  .db $05,$03,$05,$04,$38,$60,$88,$B0,$20,$50,$78,$A0,$C0,$10,$D0,$30
  C182  .db $94,$68,$40,$80,$8C,$88,$84,$80,$7C,$78,$74,$70,$8E,$2A,$2B,$2C
  C192  .db $2D,$2E,$2F,$30,$31
L15_C197:
  C197  A5 22                 LDA   <$22                         ;[x]
  C199  29 0C                 AND   #$0C                         ;[x]
  C19B  F0 07                 BEQ   L15_C1A4                     ;[x]
  C19D  A9 06                 LDA   #$06                         ;[ ]
  C19F  85 31                 STA   <$31                         ;[ ]
  C1A1  4C DD E3              JMP   L00_E3DD                     ;[ ]

L15_C1A4:
  C1A4  20 43 C4              JSR   L15_C443                     ;[x]
  C1A7  90 3D                 BCC   L15_C1E6                     ;[x]
  C1A9  A9 58                 LDA   #$58                         ;[x]
  C1AB  8D 71 3B              STA   $3B71                        ;[x]
  C1AE  9C 72 3B              STZ   $3B72                        ;[x]
  C1B1  A9 D2                 LDA   #$D2                         ;[x]
  C1B3  85 72                 STA   <$72                         ;[x]
  C1B5  A9 00                 LDA   #$00                         ;[x]
  C1B7  85 73                 STA   <$73                         ;[x]
  C1B9  E6 31                 INC   <$31                         ;[x]
  C1BB  A9 01                 LDA   #$01                         ;[x]
  C1BD  8D 38 2C              STA   $2C38                        ;[x]
  C1C0  8D 39 2C              STA   $2C39                        ;[x]
  C1C3  9C A6 2C              STZ   $2CA6                        ;[x]
  C1C6  A9 38                 LDA   #$38                         ;[x]
  C1C8  8D A5 2C              STA   $2CA5                        ;[x]
  C1CB  A9 30                 LDA   #$30                         ;[x]
  C1CD  8D 5F 2B              STA   $2B5F                        ;[x]
  C1D0  A9 80                 LDA   #$80                         ;[x]
  C1D2  8D 5E 2B              STA   $2B5E                        ;[x]
  C1D5  A9 50                 LDA   #$50                         ;[x]
  C1D7  8D 84 2A              STA   $2A84                        ;[x]
  C1DA  1A                    INC   A                            ;[x]
  C1DB  8D 85 2A              STA   $2A85                        ;[x]
  C1DE  A9 06                 LDA   #$06                         ;[x]
  C1E0  8D 68 2D              STA   $2D68                        ;[x]
  C1E3  9C C6 36              STZ   $36C6                        ;[x]
L15_C1E6:
  C1E6  60                    RTS                                ;[x]

  C1E7  A5 22                 LDA   <$22                         ;[x]
  C1E9  29 0C                 AND   #$0C                         ;[x]
  C1EB  F0 07                 BEQ   L15_C1F4                     ;[x]
  C1ED  A9 06                 LDA   #$06                         ;[ ]
  C1EF  85 31                 STA   <$31                         ;[ ]
  C1F1  4C DD E3              JMP   L00_E3DD                     ;[ ]

L15_C1F4:
  C1F4  20 43 C4              JSR   L15_C443                     ;[x]
  C1F7  90 05                 BCC   L15_C1FE                     ;[x]
  C1F9  E6 31                 INC   <$31                         ;[x]
  C1FB  9C EC 35              STZ   $35EC                        ;[x]
L15_C1FE:
  C1FE  A2 01                 LDX   #$01                         ;[x]
L15_C200:
  C200  BD 12 2D              LDA   $2D12,X                      ;[x]
  C203  38                    SEC                                ;[x]
  C204  E9 9C                 SBC   #$9C                         ;[x]
  C206  9D 12 2D              STA   $2D12,X                      ;[x]
  C209  BD A5 2C              LDA   $2CA5,X                      ;[x]
  C20C  E9 00                 SBC   #$00                         ;[x]
  C20E  9D A5 2C              STA   $2CA5,X                      ;[x]
  C211  BD 38 2C              LDA   $2C38,X                      ;[x]
  C214  E9 00                 SBC   #$00                         ;[x]
  C216  9D 38 2C              STA   $2C38,X                      ;[x]
  C219  CA                    DEX                                ;[x]
  C21A  10 E4                 BPL   L15_C200                     ;[x]
  C21C  A2 0F                 LDX   #$0F                         ;[x]
L15_C21E:
  C21E  BD 1F 2F              LDA   $2F1F,X                      ;[x]
  C221  F0 19                 BEQ   L15_C23C                     ;[x]
  C223  BD FE 2C              LDA   $2CFE,X                      ;[x]
  C226  38                    SEC                                ;[x]
  C227  E9 D4                 SBC   #$D4                         ;[x]
  C229  9D FE 2C              STA   $2CFE,X                      ;[x]
  C22C  BD 91 2C              LDA   $2C91,X                      ;[x]
  C22F  E9 01                 SBC   #$01                         ;[x]
  C231  9D 91 2C              STA   $2C91,X                      ;[x]
  C234  B0 06                 BCS   L15_C23C                     ;[x]
  C236  9E 70 2A              STZ   $2A70,X                      ;[x]
  C239  9E 1F 2F              STZ   $2F1F,X                      ;[x]
L15_C23C:
  C23C  CA                    DEX                                ;[x]
  C23D  10 DF                 BPL   L15_C21E                     ;[x]
  C23F  AD FB 2C              LDA   $2CFB                        ;[x]
  C242  18                    CLC                                ;[x]
  C243  69 9A                 ADC   #$9A                         ;[x]
  C245  8D FB 2C              STA   $2CFB                        ;[x]
  C248  AD 8E 2C              LDA   $2C8E                        ;[x]
  C24B  69 00                 ADC   #$00                         ;[x]
  C24D  8D 8E 2C              STA   $2C8E                        ;[x]
  C250  AD 21 2C              LDA   $2C21                        ;[x]
  C253  69 00                 ADC   #$00                         ;[x]
  C255  8D 21 2C              STA   $2C21                        ;[x]
  C258  AD C6 36              LDA   $36C6                        ;[x]
  C25B  F0 05                 BEQ   L15_C262                     ;[x]
  C25D  CE C6 36              DEC   $36C6                        ;[x]
  C260  80 14                 BRA   L15_C276                     ;[x]

L15_C262:
  C262  A9 07                 LDA   #$07                         ;[x]
  C264  8D C6 36              STA   $36C6                        ;[x]
  C267  AD 68 2D              LDA   $2D68                        ;[x]
  C26A  1A                    INC   A                            ;[x]
  C26B  29 07                 AND   #$07                         ;[x]
  C26D  8D 68 2D              STA   $2D68                        ;[x]
  C270  18                    CLC                                ;[x]
  C271  69 6F                 ADC   #$6F                         ;[x]
  C273  8D 6D 2A              STA   $2A6D                        ;[x]
L15_C276:
  C276  AD 72 3B              LDA   $3B72                        ;[x]
  C279  38                    SEC                                ;[x]
  C27A  E9 6B                 SBC   #$6B                         ;[x]
  C27C  8D 72 3B              STA   $3B72                        ;[x]
  C27F  AD 71 3B              LDA   $3B71                        ;[x]
  C282  E9 00                 SBC   #$00                         ;[x]
  C284  8D BA 3D              STA   $3DBA                        ;[x]
  C287  8D 71 3B              STA   $3B71                        ;[x]
  C28A  AD 8E 2C              LDA   $2C8E                        ;[x]
  C28D  A4 74                 LDY   <$74                         ;[x]
  C28F  F0 0D                 BEQ   L15_C29E                     ;[x]
  C291  D9 85 C1              CMP   $C185,Y                      ;[x]
  C294  D0 08                 BNE   L15_C29E                     ;[x]
  C296  C6 74                 DEC   <$74                         ;[x]
  C298  B9 8D C1              LDA   $C18D,Y                      ;[x]
  C29B  20 D4 E8              JSR   L00_E8D4                     ;[x]
L15_C29E:
  C29E  60                    RTS                                ;[x]

  C29F  A5 22                 LDA   <$22                         ;[x]
  C2A1  29 0C                 AND   #$0C                         ;[x]
  C2A3  F0 07                 BEQ   L15_C2AC                     ;[x]
  C2A5  A9 06                 LDA   #$06                         ;[x]
  C2A7  85 31                 STA   <$31                         ;[x]
  C2A9  4C DD E3              JMP   L00_E3DD                     ;[x]

L15_C2AC:
  C2AC  AD 59 36              LDA   $3659                        ;[x]
  C2AF  F0 04                 BEQ   L15_C2B5                     ;[x]
  C2B1  CE 59 36              DEC   $3659                        ;[x]
  C2B4  60                    RTS                                ;[x]

L15_C2B5:
  C2B5  A9 90                 LDA   #$90                         ;[x]
  C2B7  8D 8E 2C              STA   $2C8E                        ;[x]
  C2BA  A9 06                 LDA   #$06                         ;[x]
  C2BC  8D 59 36              STA   $3659                        ;[x]
  C2BF  AC EC 35              LDY   $35EC                        ;[x]
  C2C2  C0 08                 CPY   #$08                         ;[x]
  C2C4  B0 0A                 BCS   L15_C2D0                     ;[x]
  C2C6  B9 F8 C2              LDA   $C2F8,Y                      ;[x]
  C2C9  8D 6D 2A              STA   $2A6D                        ;[x]
  C2CC  EE EC 35              INC   $35EC                        ;[x]
  C2CF  60                    RTS                                ;[x]

L15_C2D0:
  C2D0  E6 31                 INC   <$31                         ;[x]
  C2D2  A9 FF                 LDA   #$FF                         ;[x]
  C2D4  8D DB 2A              STA   $2ADB                        ;[x]
  C2D7  A9 D0                 LDA   #$D0                         ;[x]
  C2D9  8D 48 2B              STA   $2B48                        ;[x]
  C2DC  A9 98                 LDA   #$98                         ;[x]
  C2DE  8D 8F 2C              STA   $2C8F                        ;[x]
  C2E1  A9 4F                 LDA   #$4F                         ;[x]
  C2E3  8D 6E 2A              STA   $2A6E                        ;[x]
  C2E6  A9 F0                 LDA   #$F0                         ;[x]
  C2E8  85 72                 STA   <$72                         ;[x]
  C2EA  A9 0B                 LDA   #$0B                         ;[x]
  C2EC  8D 12 35              STA   $3512                        ;[x]
  C2EF  3A                    DEC   A                            ;[x]
  C2F0  8D 68 2D              STA   $2D68                        ;[x]
  C2F3  82                    CLX                                ;[x]
  C2F4  20 10 D8              JSR   L15_D810                     ;[x]
  C2F7  60                    RTS                                ;[x]

  C2F8  .db $76,$77,$78,$79,$7A,$7B,$7C,$52
L15_C300:
  C300  A5 22                 LDA   <$22                         ;[x]
  C302  29 0C                 AND   #$0C                         ;[x]
  C304  F0 07                 BEQ   L15_C30D                     ;[x]
  C306  A9 06                 LDA   #$06                         ;[ ]
  C308  85 31                 STA   <$31                         ;[ ]
  C30A  4C DD E3              JMP   L00_E3DD                     ;[ ]

L15_C30D:
  C30D  82                    CLX                                ;[x]
  C30E  20 38 D8              JSR   L15_D838                     ;[x]
  C311  AD 7F 35              LDA   $357F                        ;[x]
  C314  8D A0 37              STA   $37A0                        ;[x]
  C317  AD B5 2B              LDA   $2BB5                        ;[x]
  C31A  18                    CLC                                ;[x]
  C31B  69 4C                 ADC   #$4C                         ;[x]
  C31D  8D B5 2B              STA   $2BB5                        ;[x]
  C320  AD 48 2B              LDA   $2B48                        ;[x]
  C323  69 00                 ADC   #$00                         ;[x]
  C325  8D 48 2B              STA   $2B48                        ;[x]
  C328  AD DB 2A              LDA   $2ADB                        ;[x]
  C32B  69 00                 ADC   #$00                         ;[x]
  C32D  8D DB 2A              STA   $2ADB                        ;[x]
  C330  AD CB 2B              LDA   $2BCB                        ;[x]
  C333  18                    CLC                                ;[x]
  C334  69 44                 ADC   #$44                         ;[x]
  C336  8D CB 2B              STA   $2BCB                        ;[x]
  C339  AD 5E 2B              LDA   $2B5E                        ;[x]
  C33C  69 00                 ADC   #$00                         ;[x]
  C33E  8D 5E 2B              STA   $2B5E                        ;[x]
  C341  AD B4 2B              LDA   $2BB4                        ;[x]
  C344  18                    CLC                                ;[x]
  C345  69 44                 ADC   #$44                         ;[x]
  C347  8D B4 2B              STA   $2BB4                        ;[x]
  C34A  AD 47 2B              LDA   $2B47                        ;[x]
  C34D  69 00                 ADC   #$00                         ;[x]
  C34F  8D 47 2B              STA   $2B47                        ;[x]
  C352  C6 72                 DEC   <$72                         ;[x]
  C354  F0 01                 BEQ   L15_C357                     ;[x]
  C356  60                    RTS                                ;[x]

L15_C357:
  C357  E6 31                 INC   <$31                         ;[ ]
  C359  60                    RTS                                ;[ ]

  C35A  9C BA 3D              STZ   $3DBA                        ;[x]
  C35D  A2 13                 LDX   #$13                         ;[x]
L15_C35F:
  C35F  9E 6D 2A              STZ   $2A6D,X                      ;[x]
  C362  CA                    DEX                                ;[x]
  C363  E0 03                 CPX   #$03                         ;[x]
  C365  B0 F8                 BCS   L15_C35F                     ;[x]
  C367  A2 01                 LDX   #$01                         ;[x]
L15_C369:
  C369  BD D5 C3              LDA   $C3D5,X                      ;[x]
  C36C  9D 6D 2A              STA   $2A6D,X                      ;[x]
  C36F  BD D7 C3              LDA   $C3D7,X                      ;[x]
  C372  9D 47 2B              STA   $2B47,X                      ;[x]
  C375  BD D9 C3              LDA   $C3D9,X                      ;[x]
  C378  9D 8E 2C              STA   $2C8E,X                      ;[x]
  C37B  9E DA 2A              STZ   $2ADA,X                      ;[x]
  C37E  9E 21 2C              STZ   $2C21,X                      ;[x]
  C381  BD DB C3              LDA   $C3DB,X                      ;[x]
  C384  9D 84 2A              STA   $2A84,X                      ;[x]
  C387  BD DD C3              LDA   $C3DD,X                      ;[x]
  C38A  9D 5E 2B              STA   $2B5E,X                      ;[x]
  C38D  BD DF C3              LDA   $C3DF,X                      ;[x]
  C390  9D A5 2C              STA   $2CA5,X                      ;[x]
  C393  9E F1 2A              STZ   $2AF1,X                      ;[x]
  C396  9E 38 2C              STZ   $2C38,X                      ;[x]
  C399  CA                    DEX                                ;[x]
  C39A  10 CD                 BPL   L15_C369                     ;[x]
  C39C  9C 5A 36              STZ   $365A                        ;[x]
  C39F  A9 0B                 LDA   #$0B                         ;[x]
  C3A1  8D 12 35              STA   $3512                        ;[x]
  C3A4  3A                    DEC   A                            ;[x]
  C3A5  8D 68 2D              STA   $2D68                        ;[x]
  C3A8  82                    CLX                                ;[x]
  C3A9  20 10 D8              JSR   L15_D810                     ;[x]
  C3AC  AD A0 37              LDA   $37A0                        ;[x]
  C3AF  8D 7F 35              STA   $357F                        ;[x]
  C3B2  82                    CLX                                ;[x]
  C3B3  20 38 D8              JSR   L15_D838                     ;[x]
  C3B6  A9 8E                 LDA   #$8E                         ;[x]
  C3B8  20 D4 E8              JSR   L00_E8D4                     ;[x]
  C3BB  A9 04                 LDA   #$04                         ;[x]
  C3BD  20 2B EE              JSR   L00_EE2B                     ;[x]
  C3C0  A9 08                 LDA   #$08                         ;[x]
  C3C2  20 2B EE              JSR   L00_EE2B                     ;[x]
  C3C5  A9 09                 LDA   #$09                         ;[x]
  C3C7  20 2B EE              JSR   L00_EE2B                     ;[x]
  C3CA  A9 0A                 LDA   #$0A                         ;[x]
  C3CC  20 2B EE              JSR   L00_EE2B                     ;[x]
  C3CF  E6 31                 INC   <$31                         ;[x]
  C3D1  20 4F C4              JSR   L15_C44F                     ;[x]
  C3D4  60                    RTS                                ;[x]

  C3D5  .db $67,$4F,$C0,$18,$90,$98,$50,$51,$C0,$30,$B8,$80
L15_C3E1:
  C3E1  A5 22                 LDA   <$22                         ;[x]
  C3E3  89 5C                 BIT   #$5C                         ;[x]
  C3E5  F0 2F                 BEQ   L15_C416                     ;[x]
  C3E7  89 08                 BIT   #$08                         ;[x]
  C3E9  F0 08                 BEQ   L15_C3F3                     ;[x]
  C3EB  20 DD E3              JSR   L00_E3DD                     ;[x]
  C3EE  A9 80                 LDA   #$80                         ;[x]
  C3F0  85 37                 STA   <$37                         ;[x]
  C3F2  60                    RTS                                ;[x]

L15_C3F3:
  C3F3  A5 22                 LDA   <$22                         ;[ ]
  C3F5  89 44                 BIT   #$44                         ;[ ]
  C3F7  D0 0D                 BNE   L15_C406                     ;[ ]
  C3F9  AD 24 3F              LDA   $3F24                        ;[ ]
  C3FC  3A                    DEC   A                            ;[ ]
  C3FD  10 02                 BPL   L15_C401                     ;[ ]
  C3FF  A9 02                 LDA   #$02                         ;[ ]
L15_C401:
  C401  8D 24 3F              STA   $3F24                        ;[ ]
  C404  80 10                 BRA   L15_C416                     ;[ ]

L15_C406:
  C406  20 4F C4              JSR   L15_C44F                     ;[ ]
  C409  EE 24 3F              INC   $3F24                        ;[ ]
  C40C  AD 24 3F              LDA   $3F24                        ;[ ]
  C40F  C9 03                 CMP   #$03                         ;[ ]
  C411  90 03                 BCC   L15_C416                     ;[ ]
  C413  9C 24 3F              STZ   $3F24                        ;[ ]
L15_C416:
  C416  44 40                 BSR   L15_C458                     ;[x]
  C418  44 29                 BSR   L15_C443                     ;[x]
  C41A  90 04                 BCC   L15_C420                     ;[x]
  C41C  A9 01                 LDA   #$01                         ;[ ]
  C41E  85 37                 STA   <$37                         ;[ ]
L15_C420:
  C420  AC 24 3F              LDY   $3F24                        ;[x]
  C423  B9 40 C4              LDA   $C440,Y                      ;[x]
  C426  20 2B EE              JSR   L00_EE2B                     ;[x]
  C429  82                    CLX                                ;[x]
  C42A  20 38 D8              JSR   L15_D838                     ;[x]
  C42D  EE 5A 36              INC   $365A                        ;[x]
  C430  AD 5A 36              LDA   $365A                        ;[x]
  C433  29 7F                 AND   #$7F                         ;[x]
  C435  A8                    TAY                                ;[x]
  C436  A9 90                 LDA   #$90                         ;[x]
  C438  18                    CLC                                ;[x]
  C439  79 E2 E4              ADC   $E4E2,Y                      ;[x]
  C43C  8D 8F 2C              STA   $2C8F                        ;[x]
  C43F  60                    RTS                                ;[x]

  C440  .db $05,$06,$07
L15_C443:
  C443  C6 72                 DEC   <$72                         ;[x]
  C445  D0 06                 BNE   L15_C44D                     ;[x]
  C447  C6 73                 DEC   <$73                         ;[x]
  C449  10 02                 BPL   L15_C44D                     ;[x]
  C44B  38                    SEC                                ;[x]
  C44C  60                    RTS                                ;[x]

L15_C44D:
  C44D  18                    CLC                                ;[x]
  C44E  60                    RTS                                ;[x]

L15_C44F:
  C44F  A9 80                 LDA   #$80                         ;[x]
  C451  85 72                 STA   <$72                         ;[x]
  C453  A9 02                 LDA   #$02                         ;[x]
  C455  85 73                 STA   <$73                         ;[x]
  C457  60                    RTS                                ;[x]

L15_C458:
  C458  82                    CLX                                ;[x]
L15_C459:
  C459  AD A0 3F              LDA   $3FA0                        ;[x]
  C45C  3D E9 C4              AND   $C4E9,X                      ;[x]
  C45F  D0 41                 BNE   L15_C4A2                     ;[x]
  C461  B5 22                 LDA   <$22,X                       ;[x]
  C463  F0 3D                 BEQ   L15_C4A2                     ;[x]
  C465  E0 00                 CPX   #$00                         ;[ ]
  C467  F0 04                 BEQ   L15_C46D                     ;[ ]
  C469  C5 22                 CMP   <$22                         ;[ ]
  C46B  F0 35                 BEQ   L15_C4A2                     ;[ ]
L15_C46D:
  C46D  8A                    TXA                                ;[ ]
  C46E  0A                    ASL   A                            ;[ ]
  C46F  A8                    TAY                                ;[ ]
  C470  B9 AD C4              LDA   $C4AD,Y                      ;[ ]
  C473  85 00                 STA   <$00                         ;[ ]
  C475  B9 AE C4              LDA   $C4AE,Y                      ;[ ]
  C478  85 01                 STA   <$01                         ;[ ]
  C47A  BC A1 3F              LDY   $3FA1,X                      ;[ ]
  C47D  B5 22                 LDA   <$22,X                       ;[ ]
  C47F  D1 00                 CMP   (<$00),Y                     ;[ ]
  C481  D0 25                 BNE   L15_C4A8                     ;[ ]
  C483  C8                    INY                                ;[ ]
  C484  98                    TYA                                ;[ ]
  C485  9D A1 3F              STA   $3FA1,X                      ;[ ]
  C488  C9 0A                 CMP   #$0A                         ;[ ]
  C48A  90 16                 BCC   L15_C4A2                     ;[ ]
  C48C  AD A0 3F              LDA   $3FA0                        ;[ ]
  C48F  3D EE C4              AND   $C4EE,X                      ;[ ]
  C492  D0 0E                 BNE   L15_C4A2                     ;[ ]
  C494  AD A0 3F              LDA   $3FA0                        ;[ ]
  C497  1D E9 C4              ORA   $C4E9,X                      ;[ ]
  C49A  8D A0 3F              STA   $3FA0                        ;[ ]
  C49D  A9 3A                 LDA   #$3A                         ;[ ]
  C49F  20 FC E3              JSR   L00_E3FC                     ;[ ]
L15_C4A2:
  C4A2  E8                    INX                                ;[x]
  C4A3  E0 05                 CPX   #$05                         ;[x]
  C4A5  90 B2                 BCC   L15_C459                     ;[x]
  C4A7  60                    RTS                                ;[x]

L15_C4A8:
  C4A8  9E A1 3F              STZ   $3FA1,X                      ;[ ]
  C4AB  80 F5                 BRA   L15_C4A2                     ;[ ]

  C4AD  .db $B7,$C4,$C1,$C4,$CB,$C4,$D5,$C4,$DF,$C4,$10,$10,$40,$40,$80,$20
  C4BD  .db $80,$20,$02,$01,$10,$10,$40,$40,$20,$80,$20,$80,$01,$02,$01,$02
  C4CD  .db $20,$80,$20,$80,$40,$40,$10,$10,$10,$20,$40,$80,$40,$20,$10,$01
  C4DD  .db $02,$80,$10,$01,$20,$02,$40,$01,$80,$02,$10,$04,$01,$02,$04,$08
  C4ED  .db $10,$02,$01,$00,$00,$00,$A5,$3F,$20,$A2,$E7,$00,$C5,$BC,$C5,$E4
  C4FD  .db $C5,$20,$C6,$20,$DD,$E3,$20,$3F,$EC,$A9,$09,$20,$92,$E7,$13,$50
  C50D  .db $A9,$37,$20,$64,$F0,$A2,$01,$AD,$A0,$3F,$2D,$EB,$C4,$4A,$4A,$18
  C51D  .db $69,$19,$20,$65,$F0,$A9,$90,$20,$D4,$E8,$A9,$80,$8D,$8E,$2C,$A9
  C52D  .db $78,$8D,$47,$2B,$A9,$0A,$8D,$12,$35,$A9,$1F,$8D,$68,$2D,$82,$20
  C53D  .db $10,$D8,$9C,$BA,$3D,$9C,$B6,$3D,$A9,$02,$18,$6D,$9C,$3F,$85,$4C
  C54D  .db $64,$70,$64,$73,$20,$6A,$C5,$AD,$A0,$3F,$2D,$EB,$C4,$F0,$04,$A9
  C55D  .db $05,$80,$02,$A9,$04,$85,$76,$20,$6D,$CA,$E6,$3F,$60,$AD,$A0,$3F
  C56D  .db $2D,$E9,$C4,$F0,$04,$A9,$09,$80,$02,$A9,$05,$AC,$99,$3F,$C0,$03
  C57D  .db $90,$02,$A9,$05,$85,$74,$AD,$A0,$3F,$2D,$EA,$C4,$F0,$04,$A9,$10
  C58D  .db $80,$02,$A9,$05,$AC,$99,$3F,$C0,$03,$90,$02,$A9,$05,$85,$75,$AD
  C59D  .db $99,$3F,$C9,$03,$90,$18,$AD,$9A,$3F,$C5,$74,$90,$05,$A5,$74,$8D
  C5AD  .db $9A,$3F,$AD,$9B,$3F,$C5,$75,$90,$05,$A5,$75,$8D,$9B,$3F,$60,$A9
  C5BD  .db $0B,$20,$2B,$EE,$AD,$99,$3F,$20,$34,$C7,$AD,$9A,$3F,$20,$B0,$C7
  C5CD  .db $AD,$9B,$3F,$20,$BE,$C7,$AD,$9C,$3F,$20,$5F,$C7,$A5,$73,$20,$EA
  C5DD  .db $C7,$20,$82,$C7,$E6,$3F,$60,$82,$20,$38,$D8,$A5,$22,$85,$71,$29
  C5ED  .db $08,$F0,$05,$A9,$03,$85,$3F,$60,$7F,$71,$03,$4C,$5B,$C6,$6F,$71
  C5FD  .db $03,$4C,$42,$C6,$5F,$71,$03,$4C,$4C,$C6,$4F,$71,$03,$4C,$30,$C6
  C60D  .db $2F,$71,$03,$4C,$42,$C6,$1F,$71,$03,$4C,$19,$C7,$0F,$71,$03,$4C
  C61D  .db $0A,$C7,$60,$20,$DD,$E3,$20,$3F,$EC,$64,$4C,$A9,$80,$85,$37,$9C
  C62D  .db $24,$3F,$60,$A5,$70,$3A,$10,$03,$A5,$76,$3A,$85,$70,$20,$82,$C7
  C63D  .db $A9,$3C,$4C,$FC,$E3,$A5,$70,$1A,$C5,$76,$90,$EF,$62,$80,$EC,$A5
  C64D  .db $70,$20,$A2,$E7,$87,$C6,$B8,$C6,$DE,$C6,$F4,$C6,$6A,$C6,$A5,$70
  C65D  .db $20,$A2,$E7,$7D,$C6,$A8,$C6,$CE,$C6,$01,$C7,$6A,$C6,$AD,$9C,$3F
  C66D  .db $F0,$06,$62,$8D,$9C,$3F,$80,$05,$A9,$01,$8D,$9C,$3F,$4C,$5F,$C7
  C67D  .db $AD,$99,$3F,$3A,$10,$0D,$A9,$03,$80,$09,$AD,$99,$3F,$1A,$C9,$04
  C68D  .db $90,$01,$62,$8D,$99,$3F,$20,$6A,$C5,$AD,$99,$3F,$20,$34,$C7,$AD
  C69D  .db $9A,$3F,$20,$B0,$C7,$AD,$9B,$3F,$4C,$BE,$C7,$AD,$9A,$3F,$F8,$38
  C6AD  .db $E9,$01,$D8,$C9,$01,$B0,$14,$A5,$74,$80,$10,$AD,$9A,$3F,$F8,$18
  C6BD  .db $69,$01,$D8,$C5,$74,$F0,$04,$90,$02,$A9,$01,$8D,$9A,$3F,$4C,$B0
  C6CD  .db $C7,$AD,$9B,$3F,$F8,$38,$E9,$01,$D8,$C9,$01,$B0,$14,$A5,$75,$80
  C6DD  .db $10,$AD,$9B,$3F,$F8,$18,$69,$01,$D8,$C5,$75,$F0,$04,$90,$02,$A9
  C6ED  .db $01,$8D,$9B,$3F,$4C,$BE,$C7,$A5,$73,$1A,$C9,$3F,$90,$01,$62,$85
  C6FD  .db $73,$4C,$EA,$C7,$A5,$73,$3A,$10,$F6,$A9,$3E,$80,$F2,$A5,$70,$20
  C70D  .db $A2,$E7,$30,$C7,$30,$C7,$30,$C7,$28,$C7,$30,$C7,$A5,$70,$20,$A2
  C71D  .db $E7,$30,$C7,$30,$C7,$30,$C7,$31,$C7,$30,$C7,$A4,$73,$B9,$43,$C8
  C72D  .db $20,$FC,$E3,$60,$4C,$DD,$E3,$48,$20,$8D,$E7,$13,$11,$23,$02,$20
  C73D  .db $85,$E7,$68,$0A,$A8,$B9,$0F,$C8,$85,$00,$B9,$10,$C8,$85,$01,$C2
  C74D  .db $B1,$00,$C9,$FF,$F0,$0B,$8D,$02,$00,$A9,$01,$8D,$03,$00,$C8,$80
  C75D  .db $EF,$60,$A8,$AD,$A0,$3F,$2D,$EB,$C4,$D0,$01,$60,$98,$48,$18,$69
  C76D  .db $02,$85,$4C,$20,$8D,$E7,$13,$09,$23,$04,$20,$85,$E7,$68,$0A,$A8
  C77D  .db $18,$69,$08,$80,$BF,$A9,$10,$20,$9A,$E7,$20,$8D,$E7,$13,$07,$23
  C78D  .db $02,$20,$85,$E7,$C2,$C4,$70,$D0,$04,$A9,$38,$80,$02,$A9,$10,$8D
  C79D  .db $02,$00,$A9,$01,$8D,$03,$00,$13,$10,$23,$01,$C8,$C4,$76,$D0,$E5
  C7AD  .db $4C,$99,$E7,$48,$20,$8D,$E7,$13,$93,$23,$02,$20,$85,$E7,$68,$80
  C7BD  .db $0C,$48,$20,$8D,$E7,$13,$13,$23,$03,$20,$85,$E7,$68,$85,$02,$4A
  C7CD  .db $4A,$4A,$4A,$D0,$09,$A9,$10,$8D,$02,$00,$23,$01,$80,$02,$44,$04
  C7DD  .db $A5,$02,$29,$0F,$18,$69,$11,$8D,$02,$00,$23,$01,$60,$20,$8D,$E7
  C7ED  .db $13,$93,$23,$03,$20,$85,$E7,$A5,$73,$4A,$4A,$4A,$4A,$18,$69,$11
  C7FD  .db $8D,$02,$00,$23,$01,$A5,$73,$29,$0F,$18,$69,$11,$8D,$02,$00,$23
  C80D  .db $01,$60,$1B,$C8,$22,$C8,$29,$C8,$30,$C8,$37,$C8,$3D,$C8,$1F,$1B
  C81D  .db $2D,$33,$10,$10,$FF,$28,$29,$2C,$27,$1B,$26,$FF,$22,$1B,$2C,$1E
  C82D  .db $10,$10,$FF,$2A,$2C,$29,$10,$10,$10,$FF,$22,$27,$29,$1E,$1F,$FF
  C83D  .db $30,$27,$29,$1E,$1F,$FF,$0B,$3E
L15_C845:
  C845  11 17                 ORA   (<$17),Y                     ;[ ]
  C847  18                    CLC                                ;[ ]
  C848  19 1A 1B              ORA   $1B1A,Y                      ;[ ]
  C84B  1C 1D 1E              TRB   $1E1D                        ;[ ]
  C84E  2D 1F 23              AND   $231F                        ;[ ]
  C851  20 21 2B              JSR   $2B21                        ;[ ]
  C854  31 22                 AND   (<$22),Y                     ;[ ]
  C856  24 26                 BIT   <$26                         ;[ ]
  C858  2E 40 2F              ROL   $2F40                        ;[ ]
  C85B  32 35                 AND   (<$35)                       ;[ ]
  C85D  36 37                 ROL   <$37,X                       ;[ ]
  C85F  3C 38 28              BIT   $2838,X                      ;[ ]
  C862  45 2C                 EOR   <$2C                         ;[ ]
  C864  3A                    DEC   A                            ;[ ]
  C865  .db $3B,$33,$34,$39,$29,$4D,$53,$5B,$62,$67,$6C,$71,$7B,$80,$87,$8C
  C875  .db $91,$97,$9D,$A3,$01,$02,$03,$04,$05,$06,$07,$08,$0A
L15_C882:
  C882  A5 31                 LDA   <$31                         ;[x]
  C884  20 A2 E7              JSR   L00_E7A2                     ;[x]
  C887  95 C8                 STA   <$C8,X                       ;[ ]
  C889  E1 C8                 SBC   (<$C8,X)                     ;[ ]
  C88B  0C C9 59              TSB   $59C9                        ;[ ]
  C88E  C9 A9                 CMP   #$A9                         ;[ ]
  C890  C9 CF                 CMP   #$CF                         ;[ ]
  C892  C9 E9                 CMP   #$E9                         ;[ ]
  C894  C9 20                 CMP   #$20                         ;[ ]
  C896  DD E3 20              CMP   $20E3,X                      ;[ ]
  C899  3F EC A9              BBR3  <$EC,L15_C845                ;[ ]
  C89C  09 20                 ORA   #$20                         ;[ ]
  C89E  92 E7                 STA   (<$E7)                       ;[ ]
  C8A0  13 50                 ST1   #$50                         ;[x]
  C8A2  A9 15                 LDA   #$15                         ;[x]
  C8A4  20 64 F0              JSR   L00_F064                     ;[x]
  C8A7  A9 32                 LDA   #$32                         ;[x]
  C8A9  20 D4 E8              JSR   L00_E8D4                     ;[x]
  C8AC  A9 4D                 LDA   #$4D                         ;[x]
  C8AE  20 FC E3              JSR   L00_E3FC                     ;[x]
  C8B1  64 77                 STZ   <$77                         ;[x]
  C8B3  A2 03                 LDX   #$03                         ;[x]
L15_C8B5:
  C8B5  BD D5 C8              LDA   $C8D5,X                      ;[x]
  C8B8  9D 8E 2C              STA   $2C8E,X                      ;[x]
  C8BB  BD D9 C8              LDA   $C8D9,X                      ;[x]
  C8BE  9D 47 2B              STA   $2B47,X                      ;[x]
  C8C1  BD DD C8              LDA   $C8DD,X                      ;[x]
  C8C4  9D 6D 2A              STA   $2A6D,X                      ;[x]
  C8C7  CA                    DEX                                ;[x]
  C8C8  10 EB                 BPL   L15_C8B5                     ;[x]
  C8CA  A9 00                 LDA   #$00                         ;[x]
  C8CC  8D BA 3D              STA   $3DBA                        ;[x]
  C8CF  20 6D CA              JSR   L15_CA6D                     ;[x]
  C8D2  E6 31                 INC   <$31                         ;[x]
  C8D4  60                    RTS                                ;[x]

  C8D5  .db $F0,$42,$42,$78,$80,$80,$80,$80,$19,$00,$11,$00
L15_C8E1:
  C8E1  20 18 CA              JSR   L15_CA18                     ;[x]
  C8E4  90 01                 BCC   L15_C8E7                     ;[x]
  C8E6  60                    RTS                                ;[ ]

L15_C8E7:
  C8E7  AD 8E 2C              LDA   $2C8E                        ;[x]
  C8EA  38                    SEC                                ;[x]
  C8EB  E9 01                 SBC   #$01                         ;[x]
  C8ED  8D 8E 2C              STA   $2C8E                        ;[x]
  C8F0  C9 6D                 CMP   #$6D                         ;[x]
  C8F2  90 0E                 BCC   L15_C902                     ;[x]
  C8F4  C9 A0                 CMP   #$A0                         ;[x]
  C8F6  90 04                 BCC   L15_C8FC                     ;[x]
  C8F8  A9 81                 LDA   #$81                         ;[x]
  C8FA  80 02                 BRA   L15_C8FE                     ;[x]

L15_C8FC:
  C8FC  A9 82                 LDA   #$82                         ;[x]
L15_C8FE:
  C8FE  8D 42 2E              STA   $2E42                        ;[x]
  C901  60                    RTS                                ;[x]

L15_C902:
  C902  A9 0F                 LDA   #$0F                         ;[x]
  C904  8D 5B 36              STA   $365B                        ;[x]
  C907  E6 77                 INC   <$77                         ;[x]
  C909  E6 31                 INC   <$31                         ;[x]
  C90B  60                    RTS                                ;[x]

  C90C  20 18 CA              JSR   L15_CA18                     ;[x]
  C90F  90 01                 BCC   L15_C912                     ;[x]
  C911  60                    RTS                                ;[ ]

L15_C912:
  C912  20 5C CA              JSR   L15_CA5C                     ;[x]
  C915  CE 5B 36              DEC   $365B                        ;[x]
  C918  D0 3E                 BNE   L15_C958                     ;[x]
  C91A  AD 6F 2A              LDA   $2A6F                        ;[x]
  C91D  1A                    INC   A                            ;[x]
  C91E  8D 6F 2A              STA   $2A6F                        ;[x]
  C921  C9 13                 CMP   #$13                         ;[x]
  C923  90 2E                 BCC   L15_C953                     ;[x]
  C925  A9 16                 LDA   #$16                         ;[x]
  C927  8D 6E 2A              STA   $2A6E                        ;[x]
  C92A  A9 88                 LDA   #$88                         ;[x]
  C92C  8D 5B 36              STA   $365B                        ;[x]
  C92F  A9 08                 LDA   #$08                         ;[x]
  C931  8D 5A 36              STA   $365A                        ;[x]
  C934  A9 1A                 LDA   #$1A                         ;[x]
  C936  8D 70 2A              STA   $2A70                        ;[x]
  C939  A9 0B                 LDA   #$0B                         ;[x]
  C93B  8D EF 35              STA   $35EF                        ;[x]
  C93E  A9 8A                 LDA   #$8A                         ;[x]
  C940  8D 45 2E              STA   $2E45                        ;[x]
  C943  A9 04                 LDA   #$04                         ;[x]
  C945  8D 5C 36              STA   $365C                        ;[x]
  C948  A9 71                 LDA   #$71                         ;[x]
  C94A  85 72                 STA   <$72                         ;[x]
  C94C  A9 02                 LDA   #$02                         ;[x]
  C94E  85 73                 STA   <$73                         ;[x]
  C950  E6 31                 INC   <$31                         ;[x]
  C952  60                    RTS                                ;[x]

L15_C953:
  C953  A9 0F                 LDA   #$0F                         ;[x]
  C955  8D 5B 36              STA   $365B                        ;[x]
L15_C958:
  C958  60                    RTS                                ;[x]

  C959  20 18 CA              JSR   L15_CA18                     ;[x]
  C95C  90 01                 BCC   L15_C95F                     ;[x]
  C95E  60                    RTS                                ;[ ]

L15_C95F:
  C95F  20 28 CA              JSR   L15_CA28                     ;[x]
  C962  20 44 CA              JSR   L15_CA44                     ;[x]
  C965  20 5C CA              JSR   L15_CA5C                     ;[x]
  C968  CE 5C 36              DEC   $365C                        ;[x]
  C96B  D0 14                 BNE   L15_C981                     ;[x]
  C96D  AC EF 35              LDY   $35EF                        ;[x]
  C970  88                    DEY                                ;[x]
  C971  30 0E                 BMI   L15_C981                     ;[x]
  C973  8C EF 35              STY   $35EF                        ;[x]
  C976  B9 9D C9              LDA   $C99D,Y                      ;[x]
  C979  8D 45 2E              STA   $2E45                        ;[x]
  C97C  A9 04                 LDA   #$04                         ;[x]
  C97E  8D 5C 36              STA   $365C                        ;[x]
L15_C981:
  C981  20 43 C4              JSR   L15_C443                     ;[x]
  C984  B0 01                 BCS   L15_C987                     ;[x]
  C986  60                    RTS                                ;[x]

L15_C987:
  C987  A9 12                 LDA   #$12                         ;[x]
  C989  8D 6F 2A              STA   $2A6F                        ;[x]
  C98C  A9 0F                 LDA   #$0F                         ;[x]
  C98E  8D 5B 36              STA   $365B                        ;[x]
  C991  9C 6E 2A              STZ   $2A6E                        ;[x]
  C994  A9 4B                 LDA   #$4B                         ;[x]
  C996  85 72                 STA   <$72                         ;[x]
  C998  64 73                 STZ   <$73                         ;[x]
  C99A  E6 31                 INC   <$31                         ;[x]
  C99C  60                    RTS                                ;[x]

  C99D  .db $83,$8C,$8B,$8C,$83,$84,$85,$86,$87,$88,$89,$8A
L15_C9A9:
  C9A9  20 18 CA              JSR   L15_CA18                     ;[x]
  C9AC  90 01                 BCC   L15_C9AF                     ;[x]
  C9AE  60                    RTS                                ;[ ]

L15_C9AF:
  C9AF  20 5C CA              JSR   L15_CA5C                     ;[x]
  C9B2  CE 5B 36              DEC   $365B                        ;[x]
  C9B5  D0 10                 BNE   L15_C9C7                     ;[x]
  C9B7  AD 6F 2A              LDA   $2A6F                        ;[x]
  C9BA  3A                    DEC   A                            ;[x]
  C9BB  C9 11                 CMP   #$11                         ;[x]
  C9BD  90 03                 BCC   L15_C9C2                     ;[x]
  C9BF  8D 6F 2A              STA   $2A6F                        ;[x]
L15_C9C2:
  C9C2  A9 0F                 LDA   #$0F                         ;[x]
  C9C4  8D 5B 36              STA   $365B                        ;[x]
L15_C9C7:
  C9C7  20 43 C4              JSR   L15_C443                     ;[x]
  C9CA  90 02                 BCC   L15_C9CE                     ;[x]
  C9CC  E6 31                 INC   <$31                         ;[x]
L15_C9CE:
  C9CE  60                    RTS                                ;[x]

  C9CF  A5 77                 LDA   <$77                         ;[x]
  C9D1  F0 03                 BEQ   L15_C9D6                     ;[x]
  C9D3  20 5C CA              JSR   L15_CA5C                     ;[x]
L15_C9D6:
  C9D6  A9 33                 LDA   #$33                         ;[x]
  C9D8  20 D4 E8              JSR   L00_E8D4                     ;[x]
  C9DB  A9 04                 LDA   #$04                         ;[x]
  C9DD  8D 5C 36              STA   $365C                        ;[x]
  C9E0  A9 5C                 LDA   #$5C                         ;[x]
  C9E2  85 72                 STA   <$72                         ;[x]
  C9E4  64 73                 STZ   <$73                         ;[x]
  C9E6  E6 31                 INC   <$31                         ;[x]
  C9E8  60                    RTS                                ;[x]

  C9E9  A5 77                 LDA   <$77                         ;[x]
  C9EB  F0 03                 BEQ   L15_C9F0                     ;[x]
  C9ED  20 5C CA              JSR   L15_CA5C                     ;[x]
L15_C9F0:
  C9F0  CE 5C 36              DEC   $365C                        ;[x]
  C9F3  D0 16                 BNE   L15_CA0B                     ;[x]
  C9F5  AC EF 35              LDY   $35EF                        ;[x]
  C9F8  C8                    INY                                ;[x]
  C9F9  C0 0C                 CPY   #$0C                         ;[x]
  C9FB  B0 0E                 BCS   L15_CA0B                     ;[x]
  C9FD  8C EF 35              STY   $35EF                        ;[x]
  CA00  B9 9D C9              LDA   $C99D,Y                      ;[x]
  CA03  8D 45 2E              STA   $2E45                        ;[x]
  CA06  A9 04                 LDA   #$04                         ;[x]
  CA08  8D 5C 36              STA   $365C                        ;[x]
L15_CA0B:
  CA0B  20 43 C4              JSR   L15_C443                     ;[x]
  CA0E  B0 01                 BCS   L15_CA11                     ;[x]
  CA10  60                    RTS                                ;[x]

L15_CA11:
  CA11  A9 80                 LDA   #$80                         ;[x]
  CA13  85 37                 STA   <$37                         ;[x]
  CA15  20 DD E3              JSR   L00_E3DD                     ;[x]
L15_CA18:
  CA18  A5 22                 LDA   <$22                         ;[x]
  CA1A  05 23                 ORA   <$23                         ;[x]
  CA1C  29 0C                 AND   #$0C                         ;[x]
  CA1E  F0 06                 BEQ   L15_CA26                     ;[x]
  CA20  A9 05                 LDA   #$05                         ;[ ]
  CA22  85 31                 STA   <$31                         ;[ ]
  CA24  38                    SEC                                ;[ ]
  CA25  60                    RTS                                ;[ ]

L15_CA26:
  CA26  18                    CLC                                ;[x]
  CA27  60                    RTS                                ;[x]

L15_CA28:
  CA28  CE 5B 36              DEC   $365B                        ;[x]
  CA2B  D0 16                 BNE   L15_CA43                     ;[x]
  CA2D  AD 6F 2A              LDA   $2A6F                        ;[x]
  CA30  1A                    INC   A                            ;[x]
  CA31  C9 16                 CMP   #$16                         ;[x]
  CA33  D0 06                 BNE   L15_CA3B                     ;[x]
  CA35  A9 13                 LDA   #$13                         ;[x]
  CA37  A0 88                 LDY   #$88                         ;[x]
  CA39  80 02                 BRA   L15_CA3D                     ;[x]

L15_CA3B:
  CA3B  A0 08                 LDY   #$08                         ;[x]
L15_CA3D:
  CA3D  8D 6F 2A              STA   $2A6F                        ;[x]
  CA40  8C 5B 36              STY   $365B                        ;[x]
L15_CA43:
  CA43  60                    RTS                                ;[x]

L15_CA44:
  CA44  CE 5A 36              DEC   $365A                        ;[x]
  CA47  D0 12                 BNE   L15_CA5B                     ;[x]
  CA49  AD 6E 2A              LDA   $2A6E                        ;[x]
  CA4C  1A                    INC   A                            ;[x]
  CA4D  C9 19                 CMP   #$19                         ;[x]
  CA4F  90 02                 BCC   L15_CA53                     ;[x]
  CA51  A9 16                 LDA   #$16                         ;[x]
L15_CA53:
  CA53  8D 6E 2A              STA   $2A6E                        ;[x]
  CA56  A0 08                 LDY   #$08                         ;[x]
  CA58  8C 5A 36              STY   $365A                        ;[x]
L15_CA5B:
  CA5B  60                    RTS                                ;[x]

L15_CA5C:
  CA5C  AD 42 2E              LDA   $2E42                        ;[x]
  CA5F  C9 81                 CMP   #$81                         ;[x]
  CA61  D0 04                 BNE   L15_CA67                     ;[x]
  CA63  A9 82                 LDA   #$82                         ;[x]
  CA65  80 02                 BRA   L15_CA69                     ;[x]

L15_CA67:
  CA67  A9 81                 LDA   #$81                         ;[x]
L15_CA69:
  CA69  8D 42 2E              STA   $2E42                        ;[x]
  CA6C  60                    RTS                                ;[x]

L15_CA6D:
  CA6D  A2 6C                 LDX   #$6C                         ;[x]
  CA6F  A9 0A                 LDA   #$0A                         ;[x]
L15_CA71:
  CA71  9D 00 2A              STA   $2A00,X                      ;[x]
  CA74  CA                    DEX                                ;[x]
  CA75  10 FA                 BPL   L15_CA71                     ;[x]
  CA77  60                    RTS                                ;[x]

  CA78  .db $A5,$3F,$20,$A2,$E7,$BB,$CA,$14,$CB,$2E,$CB,$67,$CB,$D2,$CB,$FD
  CA88  .db $CB,$29,$CC,$6F,$CC,$F5,$CC,$39,$CD,$81,$CD,$BF,$CD,$DE,$CD,$06
  CA98  .db $CE,$2D,$CE,$6A,$CE,$7B,$CE,$0E,$CF,$2B,$CF,$36,$CF,$72,$CF,$A3
  CAA8  .db $CF,$B1,$CF,$EA,$CF,$1C,$D0,$6C,$D0,$84,$D0,$AC,$D0,$DC,$D0,$F0
  CAB8  .db $D0,$F6,$D0,$20,$DD,$E3,$20,$3F,$EC,$A9,$09,$20,$92,$E7,$13,$50
  CAC8  .db $A9,$2C,$20,$64,$F0,$A9,$69,$20,$D4,$E8,$A9,$1A,$8D,$72,$2A,$A9
  CAD8  .db $51,$8D,$93,$2C,$A9,$20,$8D,$4C,$2B,$9C,$BA,$3D,$9C,$B6,$3D,$A9
  CAE8  .db $01,$8D,$BC,$3D,$9C,$B8,$3D,$20,$96,$A2,$A9,$01,$8D,$B9,$3D,$8D
  CAF8  .db $C5,$3D,$A9,$5F,$8D,$BB,$3D,$8D,$C3,$3D,$9C,$B7,$3D,$A9,$01,$85
  CB08  .db $45,$8D,$C6,$3D,$8D,$D5,$3D,$64,$89,$E6,$3F,$60,$A9,$2D,$20,$64
  CB18  .db $F0,$A9,$6C,$8D,$F1,$35,$20,$D4,$E8,$E6,$3F,$A9,$97,$20,$FC,$E3
  CB28  .db $A9,$12,$8D,$5E,$36,$60,$CE,$5E,$36,$D0,$33,$A9,$12,$8D,$5E,$36
  CB38  .db $AD,$F1,$35,$C9,$79,$B0,$08,$1A,$8D,$F1,$35,$20,$D4,$E8,$60,$A9
  CB48  .db $80,$8D,$8E,$2C,$8D,$91,$2C,$8D,$47,$2B,$8D,$4A,$2B,$A9,$1B,$8D
  CB58  .db $6D,$2A,$A9,$8F,$8D,$42,$2E,$A9,$04,$8D,$59,$36,$E6,$3F,$60,$CE
  CB68  .db $59,$36,$F0,$01,$60,$A9,$04,$8D,$59,$36,$AD,$42,$2E,$3A,$C9,$8D
  CB78  .db $90,$04,$8D,$42,$2E,$60,$A9,$2E,$20,$64,$F0,$A9,$88,$8D,$92,$2C
  CB88  .db $A9,$80,$8D,$4B,$2B,$A9,$19,$8D,$71,$2A,$A9,$81,$8D,$46,$2E,$A9
  CB98  .db $5A,$8D,$90,$2C,$8D,$8F,$2C,$A9,$80,$8D,$49,$2B,$8D,$48,$2B,$A9
  CBA8  .db $13,$8D,$6F,$2A,$A9,$16,$8D,$6E,$2A,$A9,$1C,$8D,$70,$2A,$A9,$08
  CBB8  .db $8D,$5A,$36,$A9,$88,$8D,$5B,$36,$A9,$8A,$8D,$45,$2E,$A9,$0B,$8D
  CBC8  .db $EF,$35,$A9,$04,$8D,$5C,$36,$E6,$3F,$60,$20,$0D,$A0,$20,$29,$A0
  CBD8  .db $20,$41,$A0,$CE,$5C,$36,$D0,$14,$AC,$EF,$35,$88,$30,$0F,$8C,$EF
  CBE8  .db $35,$B9,$9D,$C9,$8D,$45,$2E,$A9,$04,$8D,$5C,$36,$60,$A9,$B4,$8D
  CBF8  .db $5C,$36,$E6,$3F,$60,$20,$0D,$A0,$20,$29,$A0,$20,$41,$A0,$CE,$5C
  CC08  .db $36,$D0,$10,$AD,$70,$2A,$1A,$C9,$20,$B0,$09,$8D,$70,$2A,$A9,$B4
  CC18  .db $8D,$5C,$36,$60,$A9,$16,$8D,$6E,$2A,$E6,$3F,$A9,$04,$8D,$5C,$36
  CC28  .db $60,$20,$0D,$A0,$20,$41,$A0,$CE,$5C,$36,$D0,$16,$AC,$EF,$35,$C8
  CC38  .db $C0,$0C,$B0,$0F,$8C,$EF,$35,$B9,$9D,$C9,$8D,$45,$2E,$A9,$04,$8D
  CC48  .db $5C,$36,$60,$A9,$2F,$20,$64,$F0,$A9,$34,$A2,$01,$20,$65,$F0,$9C
  CC58  .db $6D,$2A,$9C,$70,$2A,$9C,$71,$2A,$9C,$6F,$2A,$9C,$6E,$2A,$E6,$3F
  CC68  .db $EE,$93,$2C,$9C,$5E,$36,$60,$EE,$5E,$36,$AD,$5E,$36,$29,$01,$F0
  CC78  .db $41,$AD,$93,$2C,$18,$69,$01,$8D,$93,$2C,$AD,$26,$2C,$69,$00,$8D
  CC88  .db $26,$2C,$AD,$BB,$3D,$18,$69,$01,$C9,$F0,$90,$02,$64,$45,$8D,$BB
  CC98  .db $3D,$29,$01,$D0,$01,$60,$AD,$BA,$3D,$38,$E9,$01,$8D,$BA,$3D,$AD
  CCA8  .db $BC,$3D,$E9,$00,$29,$01,$8D,$BC,$3D,$D0,$07,$AD,$BA,$3D,$C9,$51
  CCB8  .db $90,$01,$60,$A9,$6B,$20,$D4,$E8,$AD,$99,$3F,$18,$6D,$E4,$3E,$F0
  CCC8  .db $27,$A9,$32,$20,$64,$F0,$E6,$3F,$A2,$05,$20,$52,$A0,$A9,$60,$8D
  CCD8  .db $8F,$2C,$A9,$80,$8D,$48,$2B,$8D,$47,$2B,$8D,$8E,$2C,$A9,$20,$8D
  CCE8  .db $6E,$2A,$A9,$B4,$8D,$59,$36,$60,$A9,$1A,$85,$3F,$60,$8F,$83,$05
  CCF8  .db $9C,$6E,$2A,$80,$05,$A9,$20,$8D,$6E,$2A,$AD,$59,$36,$F0,$04,$CE
  CD08  .db $59,$36,$60,$A9,$21,$8D,$6D,$2A,$AD,$8E,$2C,$38,$E9,$01,$8D,$8E
  CD18  .db $2C,$AD,$21,$2C,$E9,$00,$8D,$21,$2C,$30,$01,$60,$AD,$8E,$2C,$C9
  CD28  .db $F0,$90,$01,$60,$A2,$01,$20,$52,$A0,$A9,$30,$20,$64,$F0,$E6,$3F
  CD38  .db $60,$AD,$BA,$3D,$38,$E9,$01,$8D,$BA,$3D,$AD,$BC,$3D,$E9,$00,$29
  CD48  .db $01,$8D,$BC,$3D,$F0,$07,$AD,$BA,$3D,$C9,$50,$90,$01,$60,$A9,$33
  CD58  .db $20,$64,$F0,$E6,$3F,$A2,$02,$BD,$D4,$A1,$9D,$F0,$35,$BD,$D7,$A1
  CD68  .db $9D,$6C,$2D,$A9,$01,$9D,$21,$2C,$A9,$10,$9D,$8E,$2C,$CA,$10,$E7
  CD78  .db $A9,$C0,$85,$72,$A9,$04,$85,$73,$60,$20,$00,$A0,$A0,$01,$20,$4D
  CD88  .db $A1,$20,$43,$C4,$90,$30,$E6,$3F,$A2,$02,$9E,$6D,$2A,$BD,$E3,$A1
  CD98  .db $9D,$92,$2C,$BD,$E0,$A1,$9D,$25,$2C,$BD,$E6,$A1,$9D,$DE,$2A,$BD
  CDA8  .db $E9,$A1,$9D,$4B,$2B,$BD,$DA,$A1,$9D,$71,$2A,$9D,$F0,$35,$A9,$03
  CDB8  .db $9D,$5D,$36,$CA,$10,$D4,$60,$20,$00,$A0,$20,$26,$A1,$A2,$02,$20
  CDC8  .db $D1,$A0,$AD,$27,$2C,$D0,$0E,$AD,$94,$2C,$C9,$50,$90,$07,$E6,$3F
  CDD8  .db $A9,$40,$8D,$CA,$36,$60,$20,$00,$A0,$20,$26,$A1,$A2,$01,$20,$D1
  CDE8  .db $A0,$AD,$CA,$36,$D0,$06,$82,$20,$D1,$A0,$80,$03,$CE,$CA,$36,$AD
  CDF8  .db $DF,$2A,$D0,$09,$AD,$4C,$2B,$C9,$40,$90,$02,$E6,$3F,$60,$20,$00
  CE08  .db $A0,$20,$26,$A1,$82,$20,$D1,$A0,$AD,$DE,$2A,$D0,$17,$AD,$4B,$2B
  CE18  .db $C9,$C1,$B0,$10,$E6,$3F,$A9,$80,$8D,$91,$2C,$8D,$4A,$2B,$9C,$5C
  CE28  .db $36,$9C,$EF,$35,$60,$20,$00,$A0,$20,$26,$A1,$20,$46,$A2,$90,$26
  CE38  .db $E6,$3F,$AD,$99,$3F,$C9,$03,$F0,$1E,$E6,$3F,$A2,$02,$A9,$40,$9D
  CE48  .db $AE,$31,$9E,$41,$31,$CA,$10,$F5,$A9,$80,$85,$72,$A9,$01,$85,$73
  CE58  .db $9C,$CA,$36,$9C,$37,$37,$60,$A9,$60,$8D,$70,$2A,$A9,$B4,$8D,$5C
  CE68  .db $36,$60,$20,$00,$A0,$20,$26,$A1,$CE,$5C,$36,$D0,$05,$9C,$70,$2A
  CE78  .db $80,$C7,$60,$20,$A1,$A2,$20,$00,$A0,$20,$26,$A1,$A2,$02,$20,$0A
  CE88  .db $A1,$CA,$10,$FA,$20,$43,$C4,$90,$03,$E6,$3F,$60,$AD,$CA,$36,$F0
  CE98  .db $04,$CE,$CA,$36,$60,$A9,$20,$8D,$CA,$36,$AE,$37,$37,$E0,$1E,$B0
  CEA8  .db $F3,$BD,$23,$2F,$F0,$06,$E8,$E0,$1E,$90,$F6,$60,$A5,$83,$29,$03
  CEB8  .db $C9,$03,$90,$01,$3A,$A8,$A9,$01,$9D,$23,$2F,$20,$AB,$E8,$AD,$8F
  CEC8  .db $3F,$29,$07,$18,$79,$92,$2C,$9D,$95,$2C,$B9,$4B,$2B,$38,$E9,$10
  CED8  .db $9D,$A7,$37,$5A,$20,$AB,$E8,$AD,$8F,$3F,$29,$1F,$18,$7D,$A7,$37
  CEE8  .db $9D,$4E,$2B,$9E,$14,$38,$AD,$90,$3F,$29,$03,$A8,$9D,$F3,$35,$B9
  CEF8  .db $F5,$A2,$9D,$74,$2A,$20,$AB,$E8,$AD,$8F,$3F,$29,$07,$9D,$60,$36
  CF08  .db $7A,$E8,$8E,$37,$37,$60,$20,$A1,$A2,$20,$00,$A0,$AD,$BA,$3D,$C9
  CF18  .db $50,$F0,$01,$60,$E6,$3F,$A9,$80,$85,$72,$9C,$BC,$3D,$A9,$35,$20
  CF28  .db $64,$F0,$60,$20,$F9,$A2,$C6,$72,$F0,$01,$60,$E6,$3F,$60,$20,$3C
  CF38  .db $A3,$AD,$BA,$3D,$18,$69,$01,$8D,$BA,$3D,$AD,$BC,$3D,$69,$00,$29
  CF48  .db $01,$8D,$BC,$3D,$F0,$07,$AD,$BA,$3D,$C9,$60,$B0,$01,$60,$E6,$3F
  CF58  .db $A2,$25,$20,$52,$A0,$A9,$A0,$8D,$5B,$2B,$A9,$30,$8D,$A2,$2C,$A9
  CF68  .db $46,$8D,$81,$2A,$A9,$0A,$8D,$6D,$36,$60,$AD,$6D,$36,$F0,$04,$CE
  CF78  .db $6D,$36,$60,$A9,$0A,$8D,$6D,$36,$AD,$81,$2A,$1A,$C9,$49,$B0,$04
  CF88  .db $8D,$81,$2A,$60,$AD,$99,$3F,$18,$6D,$E4,$3E,$C9,$01,$F0,$07,$E6
  CF98  .db $3F,$A9,$80,$85,$72,$60,$A9,$1A,$85,$3F,$60,$20,$43,$C4,$B0,$01
  CFA8  .db $60,$E6,$3F,$A9,$0A,$8D,$6D,$36,$60,$AD,$6D,$36,$F0,$04,$CE,$6D
  CFB8  .db $36,$60,$A9,$0A,$8D,$6D,$36,$AD,$81,$2A,$3A,$C9,$46,$90,$04,$8D
  CFC8  .db $81,$2A,$60,$E6,$3F,$A2,$14,$20,$58,$A0,$A9,$45,$8D,$70,$2A,$A9
  CFD8  .db $C0,$8D,$4A,$2B,$A9,$30,$8D,$91,$2C,$A9,$0A,$8D,$5C,$36,$9C,$EF
  CFE8  .db $35,$60,$AD,$5C,$36,$F0,$04,$CE,$5C,$36,$60,$A9,$0A,$8D,$5C,$36
  CFF8  .db $AD,$EF,$35,$18,$69,$7A,$C9,$8E,$B0,$07,$20,$D4,$E8,$EE,$EF,$35
  D008  .db $60,$AD,$99,$3F,$18,$6D,$E4,$3E,$C9,$02,$F0,$03,$E6,$3F,$60,$A9
  D018  .db $1A,$85,$3F,$60,$82,$C2,$A9,$10,$85,$00,$A9,$40,$85,$01,$A9,$40
  D028  .db $9D,$A4,$37,$9D,$92,$2C,$A9,$01,$9D,$DE,$2A,$A5,$00,$9D,$4B,$2B
  D038  .db $18,$69,$10,$85,$00,$A9,$4D,$9D,$71,$2A,$A9,$02,$9D,$67,$30,$9E
  D048  .db $D4,$30,$9E,$F0,$35,$9E,$8D,$2F,$A5,$01,$9D,$5D,$36,$38,$E9,$06
  D058  .db $85,$01,$98,$9D,$6C,$2D,$18,$69,$04,$29,$7F,$A8,$E8,$E0,$0A,$90
  D068  .db $BD,$E6,$3F,$60,$64,$00,$20,$90,$A3,$A5,$00,$C9,$0A,$B0,$01,$60
  D078  .db $82,$9E,$71,$2A,$E8,$E0,$0A,$90,$F8,$E6,$3F,$60,$A2,$02,$20,$58
  D088  .db $A0,$CA,$10,$FA,$A2,$0A,$20,$58,$A0,$E8,$E0,$0E,$90,$F8,$9C,$A0
  D098  .db $37,$9C,$89,$2F,$A9,$48,$8D,$8E,$2C,$A9,$58,$8D,$8F,$2C,$8D,$90
  D0A8  .db $2C,$E6,$3F,$60,$64,$00,$20,$54,$A4,$A5,$00,$D0,$01,$60,$E6,$3F
  D0B8  .db $A9,$01,$85,$73,$64,$72,$A9,$3A,$20,$64,$F0,$A9,$8F,$20,$D4,$E8
  D0C8  .db $A9,$80,$8D,$9C,$2C,$8D,$55,$2B,$9C,$2F,$2C,$9C,$E8,$2A,$A9,$5F
  D0D8  .db $8D,$7B,$2A,$60,$20,$43,$C4,$B0,$01,$60,$E6,$3F,$A9,$F0,$85,$72
  D0E8  .db $64,$73,$A9,$FE,$4C,$FC,$E3,$60,$20,$43,$C4,$B0,$01,$60,$A9,$80
  D0F8  .db $85,$82,$20,$DD,$E3,$9C,$C6,$3D,$9C,$D5,$3D,$A9,$01,$8D,$E4,$3E
  D108  .db $60,$E6,$83,$A5,$31,$20,$A2,$E7,$1C,$D1,$21,$D1,$3C,$D1,$51,$D1
  D118  .db $82,$D1,$9F,$D1,$64,$70,$E6,$31,$60,$20,$3F,$EC,$A9,$03,$85,$27
  D128  .db $64,$3F,$64,$82,$A9,$00,$20,$64,$F0,$A9,$34,$20,$D4,$E8,$20,$D2
  D138  .db $D1,$E6,$31,$60,$A5,$71,$C9,$06,$90,$04,$A9,$0D,$80,$02,$A9,$0C
  D148  .db $20,$2B,$EE,$20,$A4,$D1,$E6,$31,$60,$A5,$22,$85,$00,$3F,$00,$05
  D158  .db $A9,$05,$85,$31,$60,$0F,$00,$04,$A9,$04,$80,$F6,$4F,$00,$0D,$A5
  D168  .db $70,$3A,$10,$03,$A5,$71,$3A,$85,$70,$4C,$A4,$D1,$EF,$00,$01,$60
  D178  .db $A5,$70,$1A,$C5,$71,$90,$F0,$62,$80,$ED,$A5,$82,$F0,$08,$A9,$01
  D188  .db $85,$31,$9C,$E4,$3E,$60,$A5,$70,$20,$A2,$E7,$3D,$D2,$FC,$D2,$98
  D198  .db $D3,$49,$D4,$B4,$D4,$78,$CA,$A9,$80,$85,$37,$60,$A9,$10,$20,$9A
  D1A8  .db $E7,$20,$8D,$E7,$13,$0D,$23,$02,$20,$85,$E7,$C2,$C4,$70,$D0,$04
  D1B8  .db $A9,$09,$80,$02,$A9,$00,$8D,$02,$00,$A9,$23,$8D,$03,$00,$13,$00
  D1C8  .db $23,$23,$C8,$C4,$71,$D0,$E5,$4C,$99,$E7,$A2,$03,$BD,$80,$3F,$DD
  D1D8  .db $F9,$D1,$D0,$18,$BD,$84,$3F,$DD,$F9,$D1,$D0,$10,$BD,$88,$3F,$DD
  D1E8  .db $F9,$D1,$D0,$08,$CA,$10,$E5,$A9,$06,$85,$71,$60,$A9
L15_D1F5:
  D1F5  05 85                 ORA   <$85                         ;[ ]
  D1F7  71 60                 ADC   (<$60),Y                     ;[ ]
  D1F9  00                    BRK                                ;[ ]
L15_D1FA:
  D1FA  05 73                 ORA   <$73                         ;[ ]
  D1FC  00                    BRK                                ;[ ]
  D1FD  .db $A5,$31,$20,$A2,$E7,$08,$D2,$16,$D2,$26,$D2,$20,$3F,$EC,$A9,$03
  D20D  .db $85,$27,$64,$3F,$64,$82,$E6,$31,$60,$A5,$82,$D0,$0C,$A5,$3E,$29
  D21D  .db $01,$D0,$03,$4C,$FC,$D2,$4C,$3D,$D2,$20,$3F,$EC,$A9,$80,$85,$37
  D22D  .db $60
L15_D22E:
  D22E  A5 92                 LDA   <$92                         ;[x]
  D230  20 A2 E7              JSR   L00_E7A2                     ;[x]
  D233  3D D2 FC              AND   $FCD2,X                      ;[ ]
  D236  D2 98                 CMP   (<$98)                       ;[ ]
  D238  D3 49 D4 B4 D4 A5 3F  TIN   $D449,$D4B4,$3FA5            ;[ ]
  D23F  20 A2 E7              JSR   L00_E7A2                     ;[x]
  D242  48                    PHA                                ;[ ]
  D243  D2 89                 CMP   (<$89)                       ;[ ]
  D245  D2 A1                 CMP   (<$A1)                       ;[ ]
  D247  D2 20                 CMP   (<$20)                       ;[ ]
  D249  3F EC A9              BBR3  <$EC,L15_D1F5                ;[ ]
  D24C  1C 20 64              TRB   $6420                        ;[ ]
  D24F  F0 A9                 BEQ   L15_D1FA                     ;[ ]
  D251  20 A2 01              JSR   $01A2                        ;[ ]
  D254  20 65 F0              JSR   L00_F065                     ;[x]
  D257  A9 51                 LDA   #$51                         ;[x]
  D259  20 D4 E8              JSR   L00_E8D4                     ;[x]
  D25C  A9 80                 LDA   #$80                         ;[x]
  D25E  85 72                 STA   <$72                         ;[x]
  D260  A9 6B                 LDA   #$6B                         ;[x]
  D262  8D 47 2B              STA   $2B47                        ;[x]
  D265  A9 6F                 LDA   #$6F                         ;[x]
  D267  8D 8E 2C              STA   $2C8E                        ;[x]
  D26A  A9 01                 LDA   #$01                         ;[x]
  D26C  8D 12 35              STA   $3512                        ;[x]
  D26F  A9 0C                 LDA   #$0C                         ;[x]
  D271  8D 68 2D              STA   $2D68                        ;[x]
  D274  82                    CLX                                ;[x]
  D275  20 10 D8              JSR   L15_D810                     ;[x]
  D278  A9 6A                 LDA   #$6A                         ;[x]
  D27A  8D CA 3B              STA   $3BCA                        ;[x]
  D27D  9C CB 3B              STZ   $3BCB                        ;[x]
  D280  20 06 D8              JSR   L15_D806                     ;[x]
  D283  20 6D CA              JSR   L15_CA6D                     ;[x]
  D286  E6 3F                 INC   <$3F                         ;[x]
  D288  60                    RTS                                ;[x]

  D289  82                    CLX                                ;[x]
  D28A  20 38 D8              JSR   L15_D838                     ;[x]
  D28D  20 AB D2              JSR   L15_D2AB                     ;[x]
  D290  C6 72                 DEC   <$72                         ;[x]
  D292  D0 0C                 BNE   L15_D2A0                     ;[x]
  D294  20 0B D8              JSR   L15_D80B                     ;[x]
  D297  A9 10                 LDA   #$10                         ;[x]
  D299  85 72                 STA   <$72                         ;[x]
  D29B  E6 3F                 INC   <$3F                         ;[x]
  D29D  9C C8 3B              STZ   $3BC8                        ;[x]
L15_D2A0:
  D2A0  60                    RTS                                ;[x]

  D2A1  20 AB D2              JSR   L15_D2AB                     ;[x]
  D2A4  82                    CLX                                ;[x]
  D2A5  20 38 D8              JSR   L15_D838                     ;[x]
  D2A8  4C 98 D5              JMP   L15_D598                     ;[x]

L15_D2AB:
  D2AB  CE CA 3B              DEC   $3BCA                        ;[x]
  D2AE  D0 F0                 BNE   L15_D2A0                     ;[x]
  D2B0  AD CB 3B              LDA   $3BCB                        ;[x]
  D2B3  C9 02                 CMP   #$02                         ;[x]
  D2B5  F0 32                 BEQ   L15_D2E9                     ;[x]
  D2B7  B0 E7                 BCS   L15_D2A0                     ;[x]
  D2B9  AA                    TAX                                ;[x]
  D2BA  0A                    ASL   A                            ;[x]
  D2BB  0A                    ASL   A                            ;[x]
  D2BC  A8                    TAY                                ;[x]
  D2BD  20 8D E7              JSR   L00_E78D                     ;[x]
  D2C0  13 4B                 ST1   #$4B                         ;[x]
  D2C2  23 02                 ST2   #$02                         ;[x]
  D2C4  20 85 E7              JSR   L00_E785                     ;[x]
  D2C7  B9 F4 D2              LDA   $D2F4,Y                      ;[x]
  D2CA  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D2CD  B9 F5 D2              LDA   $D2F5,Y                      ;[x]
  D2D0  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D2D3  B9 F6 D2              LDA   $D2F6,Y                      ;[x]
  D2D6  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D2D9  B9 F7 D2              LDA   $D2F7,Y                      ;[x]
  D2DC  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D2DF  BD F2 D2              LDA   $D2F2,X                      ;[x]
  D2E2  8D CA 3B              STA   $3BCA                        ;[x]
  D2E5  EE CB 3B              INC   $3BCB                        ;[x]
  D2E8  60                    RTS                                ;[x]

L15_D2E9:
  D2E9  A9 23                 LDA   #$23                         ;[x]
  D2EB  20 64 F0              JSR   L00_F064                     ;[x]
  D2EE  EE CB 3B              INC   $3BCB                        ;[x]
  D2F1  60                    RTS                                ;[x]

  D2F2  .db $05,$10,$2E,$62,$2F,$62,$21,$62,$22,$62,$A5,$3F,$20,$A2,$E7,$07
  D302  .db $D3,$63,$D3,$80,$D3,$20,$3F,$EC,$A9,$1C,$20,$64,$F0,$A9,$21,$A2
  D312  .db $01,$20,$65,$F0,$A9,$52,$20,$D4,$E8,$A9,$80,$85,$72,$A9,$58,$8D
  D322  .db $47,$2B,$A9,$60,$8D,$8E,$2C,$A9,$02,$8D,$12,$35,$A9,$05,$8D,$68
  D332  .db $2D,$82,$20,$10,$D8,$A2,$01,$A9,$32,$9D,$6D,$2A,$BD,$8E,$D3,$9D
  D342  .db $8E,$2C,$BD,$91,$D3,$9D,$47,$2B,$BD,$94,$D3,$9D,$D0,$30,$A9,$FF
  D352  .db $9D,$63,$30,$E8,$E0,$04,$90,$DF,$20,$06,$D8,$20,$6D,$CA,$E6,$3F
  D362  .db $60,$82,$20,$38,$D8,$E8,$20,$71,$D5,$E0,$03,$90,$F8,$C6,$72,$D0
  D372  .db $0C,$20,$0B,$D8,$A9,$10,$85,$72,$E6,$3F,$9C,$C8,$3B,$60,$82,$20
  D382  .db $38,$D8,$E8,$20,$71,$D5,$E0,$03,$90,$F8,$4C,$98,$D5,$50,$68,$78
  D392  .db $B0,$88,$B8,$F5,$EF,$EF,$A5,$3F,$20,$A2,$E7,$A3,$D3,$16,$D4,$35
  D3A2  .db $D4,$20,$3F,$EC,$A9,$1D,$20,$64,$F0,$A9,$22,$A2,$01,$20,$65,$F0
  D3B2  .db $A9,$53,$20,$D4,$E8,$A9,$80,$85,$72,$A9,$BA,$85,$74,$64,$75,$64
  D3C2  .db $76,$A9,$78,$8D,$47,$2B,$8D,$48,$2B,$A9,$30,$8D,$8E,$2C,$8D,$8F
  D3D2  .db $2C,$A9,$06,$8D,$12,$35,$A9,$04,$8D,$68,$2D,$82,$20,$10,$D8,$9C
  D3E2  .db $13,$35,$A9,$06,$8D,$69,$2D,$A2,$01,$20,$10,$D8,$A9,$31,$8D,$6F
  D3F2  .db $2A,$A9,$A8,$8D,$49,$2B,$A9,$70,$8D,$90,$2C,$9C,$D2,$30,$9C,$65
  D402  .db $30,$A9,$DE,$8D,$AC,$31,$A9,$FF,$8D,$3F,$31,$20,$06,$D8,$20,$6D
  D412  .db $CA,$E6,$3F,$60,$20,$EE,$D7,$82,$20,$38,$D8,$A2,$01,$20,$38,$D8
  D422  .db $A2,$02,$20,$71,$D5,$C6,$72,$D0,$09,$A9,$10,$85,$72,$E6,$3F,$9C
  D432  .db $C8,$3B,$60,$20,$EE,$D7,$82,$20,$38,$D8,$A2,$01,$20,$38,$D8,$A2
  D442  .db $02,$20,$71,$D5,$4C,$98,$D5,$A5,$3F,$20,$A2,$E7,$54,$D4,$95,$D4
  D452  .db $AA,$D4,$20,$3F,$EC,$A9,$1E,$20,$64,$F0,$A9,$28,$A2,$01,$20,$65
  D462  .db $F0,$A9,$54,$20,$D4,$E8,$A9,$80,$85,$72,$A9,$F3,$85,$74,$64,$75
  D472  .db $64,$76,$A9,$48,$8D,$47,$2B,$A9,$38,$8D,$8E,$2C,$A9,$03,$8D,$12
  D482  .db $35,$A9,$1D,$8D,$68,$2D,$82,$20,$10,$D8,$20,$06,$D8,$20,$6D,$CA
  D492  .db $E6,$3F,$60,$20,$EE,$D7,$82,$20,$38,$D8,$C6,$72,$D0,$09,$A9,$10
  D4A2  .db $85,$72,$E6,$3F,$9C,$C8,$3B,$60,$20,$EE,$D7,$82,$20,$38,$D8,$4C
  D4B2  .db $98,$D5,$A5,$3F,$20,$A2,$E7,$BF,$D4,$2B,$D5,$48,$D5,$20,$3F,$EC
  D4C2  .db $A9,$1F,$20,$64,$F0,$A9,$2B,$A2,$01,$20,$65,$F0,$A9,$55,$20,$D4
  D4D2  .db $E8,$A9,$80,$85,$72,$A9,$CF,$85,$74,$64,$75,$64,$76,$A9,$3D,$8D
  D4E2  .db $6D,$2A,$A9,$3A,$8D,$6E,$2A,$A9,$40,$8D,$47,$2B,$8D,$48,$2B,$A9
  D4F2  .db $30,$8D,$8E,$2C,$8D,$8F,$2C,$A9,$04,$8D,$12,$35,$1A,$8D,$13,$35
  D502  .db $A9,$1F,$8D,$68,$2D,$A9,$03,$8D,$69,$2D,$82,$20,$10,$D8,$A2,$01
  D512  .db $20,$10,$D8,$A9,$03,$85,$7C,$A9,$5E,$85,$7D,$A2,$01,$20,$D5,$E8
  D522  .db $20,$06,$D8,$20,$6D,$CA,$E6,$3F,$60,$20,$EE,$D7,$82,$20,$38,$D8
  D532  .db $A2,$01,$20,$38,$D8,$20,$5A,$D5,$C6,$72,$D0,$09,$A9,$10,$85,$72
  D542  .db $E6,$3F,$9C,$C8,$3B,$60,$20,$EE,$D7,$82,$20,$38,$D8,$A2,$01,$20
  D552  .db $38,$D8,$20,$5A,$D5,$4C,$98,$D5,$C6,$7C,$D0,$12,$A9,$03,$85,$7C
  D562  .db $A5,$7D,$1A,$C9,$63,$90,$02,$A9,$5E,$85,$7D,$4C,$D4,$E8,$60,$BD
  D572  .db $FB,$2C,$18,$7D,$AA,$31,$9D,$FB,$2C,$BD,$8E,$2C,$7D,$3D,$31,$9D
  D582  .db $8E,$2C,$BD,$B4,$2B,$18,$7D
L15_D589:
  D589  D0 30                 BNE   L15_D5BB                     ;[ ]
  D58B  9D B4 2B              STA   $2BB4,X                      ;[ ]
  D58E  BD 47 2B              LDA   $2B47,X                      ;[ ]
  D591  7D 63 30              ADC   $3063,X                      ;[ ]
  D594  9D 47 2B              STA   $2B47,X                      ;[ ]
  D597  60                    RTS                                ;[ ]

L15_D598:
  D598  AD C8 3B              LDA   $3BC8                        ;[x]
  D59B  20 A2 E7              JSR   L00_E7A2                     ;[x]
  D59E  A6 D5                 LDX   <$D5                         ;[ ]
  D5A0  B1 D5                 LDA   (<$D5),Y                     ;[ ]
  D5A2  BF D5 E4              BBS3  <$D5,L15_D589                ;[ ]
  D5A5  D5 A5                 CMP   <$A5,X                       ;[ ]
  D5A7  72 F0                 ADC   (<$F0)                       ;[ ]
  D5A9  03 C6                 ST0   #$C6                         ;[ ]
  D5AB  72 60                 ADC   (<$60)                       ;[ ]
L15_D5AD:
  D5AD  EE C8 3B              INC   $3BC8                        ;[x]
  D5B0  60                    RTS                                ;[x]

  D5B1  A9 0A                 LDA   #$0A                         ;[x]
  D5B3  85 72                 STA   <$72                         ;[x]
  D5B5  9C C9 3B              STZ   $3BC9                        ;[x]
  D5B8  EE C8 3B              INC   $3BC8                        ;[x]
L15_D5BB:
  D5BB  82                    CLX                                ;[x]
  D5BC  4C F0 D5              JMP   L15_D5F0                     ;[x]

  D5BF  C6 72                 DEC   <$72                         ;[x]
  D5C1  D0 20                 BNE   L15_D5E3                     ;[x]
  D5C3  A9 0A                 LDA   #$0A                         ;[x]
  D5C5  85 72                 STA   <$72                         ;[x]
  D5C7  AD C9 3B              LDA   $3BC9                        ;[x]
  D5CA  18                    CLC                                ;[x]
  D5CB  69 02                 ADC   #$02                         ;[x]
  D5CD  C9 12                 CMP   #$12                         ;[x]
  D5CF  B0 07                 BCS   L15_D5D8                     ;[x]
  D5D1  8D C9 3B              STA   $3BC9                        ;[x]
  D5D4  AA                    TAX                                ;[x]
  D5D5  4C F0 D5              JMP   L15_D5F0                     ;[x]

L15_D5D8:
  D5D8  A9 80                 LDA   #$80                         ;[x]
  D5DA  85 72                 STA   <$72                         ;[x]
  D5DC  A9 00                 LDA   #$00                         ;[x]
  D5DE  85 73                 STA   <$73                         ;[x]
  D5E0  EE C8 3B              INC   $3BC8                        ;[x]
L15_D5E3:
  D5E3  60                    RTS                                ;[x]

  D5E4  20 43 C4              JSR   L15_C443                     ;[x]
  D5E7  90 FA                 BCC   L15_D5E3                     ;[x]
  D5E9  A9 80                 LDA   #$80                         ;[x]
  D5EB  85 82                 STA   <$82                         ;[x]
  D5ED  4C DD E3              JMP   L00_E3DD                     ;[x]

L15_D5F0:
  D5F0  20 8D E7              JSR   L00_E78D                     ;[x]
  D5F3  BD 50 D6              LDA   $D650,X                      ;[x]
  D5F6  85 04                 STA   <$04                         ;[x]
  D5F8  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D5FB  BD 51 D6              LDA   $D651,X                      ;[x]
  D5FE  85 05                 STA   <$05                         ;[x]
  D600  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D603  20 85 E7              JSR   L00_E785                     ;[x]
  D606  BD 62 D6              LDA   $D662,X                      ;[x]
  D609  85 00                 STA   <$00                         ;[x]
  D60B  BD 63 D6              LDA   $D663,X                      ;[x]
  D60E  85 01                 STA   <$01                         ;[x]
  D610  BD 74 D6              LDA   $D674,X                      ;[x]
  D613  85 02                 STA   <$02                         ;[x]
  D615  BD 75 D6              LDA   $D675,X                      ;[x]
  D618  85 03                 STA   <$03                         ;[x]
  D61A  C2                    CLY                                ;[x]
L15_D61B:
  D61B  B1 02                 LDA   (<$02),Y                     ;[x]
  D61D  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D620  C8                    INY                                ;[x]
  D621  B1 02                 LDA   (<$02),Y                     ;[x]
  D623  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D626  C8                    INY                                ;[x]
  D627  C6 00                 DEC   <$00                         ;[x]
  D629  D0 F0                 BNE   L15_D61B                     ;[x]
  D62B  C6 01                 DEC   <$01                         ;[x]
  D62D  F0 20                 BEQ   L15_D64F                     ;[x]
  D62F  BD 62 D6              LDA   $D662,X                      ;[x]
  D632  85 00                 STA   <$00                         ;[x]
  D634  20 8D E7              JSR   L00_E78D                     ;[x]
  D637  A5 04                 LDA   <$04                         ;[x]
  D639  18                    CLC                                ;[x]
  D63A  69 40                 ADC   #$40                         ;[x]
  D63C  8D 02 00              STA   VDC_DATA_L                   ;[x]
  D63F  85 04                 STA   <$04                         ;[x]
  D641  A5 05                 LDA   <$05                         ;[x]
  D643  69 00                 ADC   #$00                         ;[x]
  D645  8D 03 00              STA   VDC_DATA_H                   ;[x]
  D648  85 05                 STA   <$05                         ;[x]
  D64A  20 85 E7              JSR   L00_E785                     ;[x]
  D64D  80 CC                 BRA   L15_D61B                     ;[x]

L15_D64F:
  D64F  60                    RTS                                ;[x]

  D650  .db $52,$06,$53,$06,$54,$06,$55,$06,$57,$06,$59,$06,$5B,$06,$D1,$05
  D660  .db $D1,$05,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$02,$03
  D670  .db $0C,$05,$0C,$05,$86,$D6,$98,$D6,$AA,$D6,$BC,$D6,$CE,$D6,$E0,$D6
  D680  .db $F2,$D6,$FE,$D6,$76,$D7,$4B,$31,$45,$31,$46,$31,$5B,$31,$55,$31
  D690  .db $3E,$11,$6C,$31,$3E,$11,$3E,$11,$4C,$31,$4D,$31,$47,$31,$5C,$31
  D6A0  .db $5D,$31,$56,$31,$6D,$31,$6E,$31,$3E,$11,$4D,$31,$4E,$31,$57,$31
  D6B0  .db $5D,$31,$48,$31,$3E,$11,$6E,$31,$58,$31,$3E,$11,$4E,$31,$4F,$31
  D6C0  .db $3E,$11,$5E,$31,$5F,$31,$49,$31,$6F,$31,$70,$31,$3E,$11,$60,$31
  D6D0  .db $61,$31,$62,$31,$66,$31,$67,$31,$59,$31,$71,$31,$72,$31,$5A,$31
  D6E0  .db $62,$31,$63,$31,$3E,$11,$68,$31,$69,$31,$4A,$31,$73,$31,$74,$31
  D6F0  .db $3E,$11,$64,$31,$65,$31,$6A,$31,$6B,$31,$75,$31,$3E,$11,$40,$41
  D700  .db $41,$41,$42,$41,$43,$41,$44,$41,$3E,$11,$3E,$11,$3E,$11,$3E,$11
  D710  .db $3E,$11,$3E,$11,$3E,$11,$50,$41,$51,$41,$52,$41,$53,$41,$54,$41
  D720  .db $3E,$11,$3E,$11,$3E,$11,$3E,$11,$3E,$11,$3E,$11,$3E,$11,$77,$41
  D730  .db $4B,$51,$4C,$51,$4D,$51,$4E,$51,$4F,$51,$60,$51,$61,$51,$62,$51
  D740  .db $63,$51,$64,$51,$65,$51,$3E,$11,$5B,$51,$5C,$51,$5D,$51,$5E,$51
  D750  .db $5F,$51,$66,$51,$67,$51,$68,$51,$69,$51,$6A,$51,$6B,$51,$3E,$11
  D760  .db $6C,$51,$6D,$51,$6E,$51,$6F,$51,$70,$51,$71,$51,$72,$51,$73,$51
  D770  .db $74,$51,$75,$51,$76,$51,$40,$21,$41,$21,$42,$21,$43,$21,$44,$21
  D780  .db $3E,$11,$3E,$11,$3E,$11,$3E,$11,$3E,$11,$3E,$11,$3E,$11,$50,$21
  D790  .db $51,$21,$52,$21,$53,$21,$54,$21,$3E,$11,$3E,$11,$3E,$11,$3E,$11
  D7A0  .db $3E,$11,$3E,$11,$3E,$11,$77,$21,$4B,$11,$4C,$11,$4D,$11,$4E,$11
  D7B0  .db $4F,$11,$60,$11,$61,$11,$62,$11,$63,$11,$64,$11,$65,$11,$3E,$11
  D7C0  .db $5B,$11,$5C,$11,$5D,$11,$5E,$11,$5F,$11,$66,$11,$67,$11,$68,$11
  D7D0  .db $69,$11,$6A,$11,$6B,$11,$3E,$11,$6C,$11,$6D,$11,$6E,$11,$6F,$11
  D7E0  .db $70,$11,$71,$11,$72,$11,$73,$11,$74,$11,$75,$11,$76,$11,$A5,$76
  D7F0  .db $D0,$0F,$A5,$74,$38,$E9,$01,$85,$74,$B0,$06,$A5,$75,$F0,$03,$C6
  D800  .db $75,$60,$E6,$76,$80,$05
L15_D806:
  D806  A9 91                 LDA   #$91                         ;[x]
  D808  4C FC E3              JMP   L00_E3FC                     ;[x]

L15_D80B:
  D80B  A9 0A                 LDA   #$0A                         ;[x]
  D80D  4C FC E3              JMP   L00_E3FC                     ;[x]

L15_D810:
  D810  BD 12 35              LDA   $3512,X                      ;[x]
  D813  0A                    ASL   A                            ;[x]
  D814  A8                    TAY                                ;[x]
  D815  B9 83 D8              LDA   $D883,Y                      ;[x]
  D818  85 08                 STA   <$08                         ;[x]
  D81A  B9 84 D8              LDA   $D884,Y                      ;[x]
  D81D  85 09                 STA   <$09                         ;[x]
  D81F  B9 9B D8              LDA   $D89B,Y                      ;[x]
  D822  85 0A                 STA   <$0A                         ;[x]
  D824  B9 9C D8              LDA   $D89C,Y                      ;[x]
  D827  85 0B                 STA   <$0B                         ;[x]
  D829  9E 7F 35              STZ   $357F,X                      ;[x]
  D82C  C2                    CLY                                ;[x]
  D82D  B1 08                 LDA   (<$08),Y                     ;[x]
  D82F  9D 59 36              STA   $3659,X                      ;[x]
  D832  B1 0A                 LDA   (<$0A),Y                     ;[x]
  D834  9D 6D 2A              STA   $2A6D,X                      ;[x]
  D837  60                    RTS                                ;[x]

L15_D838:
  D838  BD 59 36              LDA   $3659,X                      ;[x]
  D83B  1A                    INC   A                            ;[x]
  D83C  F0 44                 BEQ   L15_D882                     ;[x]
  D83E  DE 59 36              DEC   $3659,X                      ;[x]
  D841  D0 3F                 BNE   L15_D882                     ;[x]
  D843  BD 12 35              LDA   $3512,X                      ;[x]
  D846  0A                    ASL   A                            ;[x]
  D847  A8                    TAY                                ;[x]
  D848  B9 83 D8              LDA   $D883,Y                      ;[x]
  D84B  85 08                 STA   <$08                         ;[x]
  D84D  B9 84 D8              LDA   $D884,Y                      ;[x]
  D850  85 09                 STA   <$09                         ;[x]
  D852  B9 9B D8              LDA   $D89B,Y                      ;[x]
  D855  85 0A                 STA   <$0A                         ;[x]
  D857  B9 9C D8              LDA   $D89C,Y                      ;[x]
  D85A  85 0B                 STA   <$0B                         ;[x]
  D85C  FE 7F 35              INC   $357F,X                      ;[x]
L15_D85F:
  D85F  BD 7F 35              LDA   $357F,X                      ;[x]
  D862  DD 68 2D              CMP   $2D68,X                      ;[x]
  D865  90 04                 BCC   L15_D86B                     ;[x]
  D867  62                    CLA                                ;[x]
  D868  9E 7F 35              STZ   $357F,X                      ;[x]
L15_D86B:
  D86B  A8                    TAY                                ;[x]
  D86C  B1 08                 LDA   (<$08),Y                     ;[x]
  D86E  C9 FE                 CMP   #$FE                         ;[x]
  D870  D0 08                 BNE   L15_D87A                     ;[x]
  D872  C8                    INY                                ;[ ]
  D873  B1 08                 LDA   (<$08),Y                     ;[ ]
  D875  9D 7F 35              STA   $357F,X                      ;[ ]
  D878  80 E5                 BRA   L15_D85F                     ;[ ]

L15_D87A:
  D87A  9D 59 36              STA   $3659,X                      ;[x]
  D87D  B1 0A                 LDA   (<$0A),Y                     ;[x]
  D87F  9D 6D 2A              STA   $2A6D,X                      ;[x]
L15_D882:
  D882  60                    RTS                                ;[x]

  D883  .db $B3,$D8,$C3,$D8,$DB,$D8,$E5,$D8,$1F,$D9,$5B,$D9,$BD,$D8,$61,$D9
  D893  .db $65,$D9,$6F,$D9,$73,$D9,$B1,$D9,$B9,$D8,$CF,$D8,$E0,$D8,$02,$D9
  D8A3  .db $3E,$D9,$5E,$D9,$C0,$D8,$63,$D9,$6A,$D9,$71,$D9,$92,$D9,$BB,$D9
  D8B3  .db $0D,$0D,$0D,$0D,$FE,$00,$48,$49,$4A,$49,$B4,$06,$FF,$00,$4B,$4C
  D8C3  .db $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$1F,$20,$21,$22
  D8D3  .db $23,$24,$25,$26,$27,$28,$29,$2A,$78,$05,$05,$05,$FF,$2B,$2C,$2D
  D8E3  .db $2C,$2B,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09
  D8F3  .db $09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$FF,$33
  D903  .db $34,$35,$34,$33,$33,$34,$35,$34,$33,$33,$34,$35,$34,$33,$33,$34
  D913  .db $35,$34,$33,$33,$34,$35,$34,$33,$36,$37,$38,$39,$07,$07,$07,$07
  D923  .db $07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07
  D933  .db $07,$07,$07,$10,$07,$07,$07,$0A,$0A,$FE,$1B,$3D,$3E,$3F,$40,$41
  D943  .db $42,$41,$40,$3F,$3E,$3D,$3E,$3F,$40,$41,$42,$41,$40,$3F,$3E,$3D
  D953  .db $3E,$3F,$40,$43,$44,$45,$46,$47,$C6,$09,$FF,$3A,$3B,$3C,$0E,$0E
  D963  .db $22,$23,$07,$07,$07,$07,$07,$24,$25,$26,$27,$28,$4A,$01,$29,$2A
  D973  .db $03,$03,$03,$03,$03,$03,$03,$03,$03,$05,$05,$05,$05,$05,$05,$05
  D983  .db $05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$50,$54
  D993  .db $55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60,$5F,$5E,$5D,$5E
  D9A3  .db $5F,$60,$5F,$5E,$5D,$5E,$5F,$60,$61,$62,$63,$64,$65,$66,$03,$03
  D9B3  .db $03,$05,$03,$03,$03,$03,$05,$03,$67,$68,$69,$6A,$69,$6B,$6C,$6D
  D9C3  .db $6E,$6D,$A5,$3F,$20,$A2,$E7,$D4,$D9,$3E,$DA,$51,$DA,$6F,$DA,$88
  D9D3  .db $DA,$20,$DD,$E3,$20,$3F,$EC,$A9,$09,$20,$92,$E7,$13,$50,$A9,$1B
  D9E3  .db $20,$64,$F0,$A2,$01,$A9,$31,$20,$65,$F0,$A9,$47,$20,$D4,$E8,$A9
  D9F3  .db $18,$8D,$47,$2B,$A9,$60,$8D,$48,$2B,$A9,$5F,$8D,$49,$2B,$A9,$94
  DA03  .db $8D,$8E,$2C,$A9,$80,$8D,$8F,$2C,$A9,$9C,$8D,$90,$2C,$A9,$07,$8D
  DA13  .db $12,$35,$1A,$8D,$13,$35,$1A,$8D,$14,$35,$A9,$02,$8D,$68,$2D,$8D
  DA23  .db $6A,$2D,$A9,$05,$8D,$69,$2D,$82,$20,$10,$D8,$A2,$01,$20,$10,$D8
  DA33  .db $A2,$02,$20,$10,$D8,$20,$96,$A2,$E6,$3F,$60,$A9,$A3,$20,$FC,$E3
  DA43  .db $20,$9D,$DA,$E6,$3F,$A9,$68,$85,$72,$A9,$01,$85,$73,$60,$82,$20
  DA53  .db $38,$D8,$A2,$01,$20,$38,$D8,$A2,$02,$20,$38,$D8,$20,$43,$C4,$90
  DA63  .db $0A,$E6,$3F,$A9,$98,$85,$72,$A9,$03,$85,$73,$60,$82,$20,$38,$D8
  DA73  .db $A2,$01,$20,$38,$D8,$A2,$02,$20,$38,$D8,$20,$8F,$DA,$20,$43,$C4
  DA83  .db $90,$02,$E6,$3F,$60,$A9,$80,$85,$82,$4C,$DD,$E3,$A5,$22,$05,$23
  DA93  .db $29,$0F,$F0,$05,$A9,$04,$85,$3F,$60,$60,$20,$99,$E7,$C2,$B9,$3B
  DAA3  .db $DB,$C9,$FF,$F0,$26,$C9,$FE,$F0,$0B,$8D,$02,$00,$A9,$01,$8D,$03
  DAB3  .db $00,$C8,$80,$EA,$20,$8D,$E7,$C8,$B9,$3B,$DB,$8D,$02,$00,$C8,$B9
  DAC3  .db $3B,$DB,$8D,$03,$00,$C8,$20,$85,$E7,$80,$D3,$82,$A9,$54,$A0,$04
  DAD3  .db $44,$0E,$A2,$04,$A9,$14,$A0,$05,$44,$06,$A2,$08,$A9,$D4,$A0,$05
  DAE3  .db $64,$00,$48,$20,$8D,$E7,$68,$8D,$02,$00,$8C,$03,$00,$20,$85,$E7
  DAF3  .db $A0,$03,$BD,$80,$3F,$86,$B2,$48,$4A,$4A,$4A,$4A,$D0,$08,$A6,$00
  DB03  .db $D0,$04,$A9,$10,$80,$05,$E6,$00,$18,$69,$11,$8D,$02,$00,$A9,$01
  DB13  .db $8D,$03,$00,$68,$29,$0F,$D0,$0C,$A6,$00,$D0,$08,$C0,$00,$F0,$04
  DB23  .db $A9,$10,$80,$05,$E6,$00,$18,$69,$11,$8D,$02,$00,$A9,$01,$8D,$03
  DB33  .db $00,$A6,$B2,$E8,$88,$10,$BB,$60,$FE,$14,$04,$22,$23,$36,$2D,$1D
  DB43  .db $29,$2C,$1F,$FE,$D4,$04,$2A,$26,$1B,$33,$1F,$2C,$10,$12,$FE,$94
  DB53  .db $05,$2A,$26,$1B,$33,$1F,$2C,$10,$13,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB63  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB73  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB83  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB93  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBA3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBB3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBC3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBD3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBE3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DBF3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC03  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC13  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC23  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC33  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC43  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC53  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC63  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC73  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC83  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DC93  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCA3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCB3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCC3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCD3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCE3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DCF3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD03  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD13  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD23  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD33  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD43  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD53  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD63  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD73  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD83  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DD93  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDA3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDB3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDC3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDD3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDE3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DDF3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE03  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE13  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE23  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE33  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE43  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE53  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE63  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE73  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE83  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DE93  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEA3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEB3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEC3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DED3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEE3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEF3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF03  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF13  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF23  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF33  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF43  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF53  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF63  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF73  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF83  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DF93  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFA3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFB3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFC3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFD3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFE3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DFF3  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
