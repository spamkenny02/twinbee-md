; Detana!! TwinBee (PCE) - banque $02, vue en $4000-$5FFF
; 2519 octets de code (2335 exécutés en émulation)
; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique

L02_4000:
  4000  A5 3B                 LDA   <$3B                         ;[x]
  4002  CD 0B 28              CMP   $280B                        ;[x]
  4005  F0 2D                 BEQ   L02_4034                     ;[x]
  4007  8D 0B 28              STA   $280B                        ;[ ]
  400A  C9 00                 CMP   #$00                         ;[ ]
  400C  F0 03                 BEQ   L02_4011                     ;[ ]
  400E  4C C1 4A              JMP   L02_4AC1                     ;[ ]

L02_4011:
  4011  8D 1C 27              STA   $271C                        ;[ ]
  4014  8D 22 27              STA   $2722                        ;[ ]
  4017  8D 10 28              STA   $2810                        ;[ ]
  401A  20 35 40              JSR   L02_4035                     ;[ ]
  401D  AD 0A 28              LDA   $280A                        ;[ ]
  4020  F0 03                 BEQ   L02_4025                     ;[ ]
  4022  20 EE 4A              JSR   L02_4AEE                     ;[ ]
L02_4025:
  4025  82                    CLX                                ;[ ]
L02_4026:
  4026  BD 1C 27              LDA   $271C,X                      ;[ ]
  4029  D0 04                 BNE   L02_402F                     ;[ ]
  402B  8A                    TXA                                ;[ ]
  402C  20 5A 40              JSR   L02_405A                     ;[ ]
L02_402F:
  402F  E8                    INX                                ;[ ]
  4030  E0 06                 CPX   #$06                         ;[ ]
  4032  90 F2                 BCC   L02_4026                     ;[ ]
L02_4034:
  4034  60                    RTS                                ;[x]

L02_4035:
  4035  DA                    PHX                                ;[x]
  4036  A2 05                 LDX   #$05                         ;[x]
  4038  BD 1C 27              LDA   $271C,X                      ;[x]
  403B  D0 03                 BNE   L02_4040                     ;[x]
  403D  4C 58 40              JMP   L02_4058                     ;[x]

L02_4040:
  4040  AD 0B 28              LDA   $280B                        ;[x]
  4043  D0 13                 BNE   L02_4058                     ;[x]
  4045  8E 00 08              STX   PSG_CH                       ;[x]
  4048  BD BD 27              LDA   $27BD,X                      ;[x]
  404B  20 A6 47              JSR   L02_47A6                     ;[x]
  404E  BD 2A 27              LDA   $272A,X                      ;[x]
  4051  8D 05 08              STA   PSG_PAN                      ;[x]
  4054  62                    CLA                                ;[x]
  4055  8D 07 08              STA   PSG_NOISE                    ;[x]
L02_4058:
  4058  FA                    PLX                                ;[x]
  4059  60                    RTS                                ;[x]

L02_405A:
  405A  48                    PHA                                ;[ ]
  405B  8D 00 08              STA   PSG_CH                       ;[ ]
  405E  A9 00                 LDA   #$00                         ;[ ]
  4060  8D 04 08              STA   PSG_CTRL                     ;[ ]
  4063  68                    PLA                                ;[ ]
  4064  60                    RTS                                ;[ ]

  4065  20 00 40              JSR   L02_4000                     ;[x]
  4068  AD 16 28              LDA   $2816                        ;[x]
  406B  F0 1E                 BEQ   L02_408B                     ;[x]
  406D  AD 0B 28              LDA   $280B                        ;[x]
  4070  D0 19                 BNE   L02_408B                     ;[x]
  4072  CE 17 28              DEC   $2817                        ;[x]
  4075  D0 14                 BNE   L02_408B                     ;[x]
  4077  A9 10                 LDA   #$10                         ;[x]
  4079  8D 17 28              STA   $2817                        ;[x]
  407C  EE 16 28              INC   $2816                        ;[x]
  407F  A9 0E                 LDA   #$0E                         ;[x]
  4081  CD 16 28              CMP   $2816                        ;[x]
  4084  B0 05                 BCS   L02_408B                     ;[x]
  4086  A9 FF                 LDA   #$FF                         ;[x]
  4088  20 EE 4A              JSR   L02_4AEE                     ;[x]
L02_408B:
  408B  A2 00                 LDX   #$00                         ;[x]
L02_408D:
  408D  8E 11 28              STX   $2811                        ;[x]
  4090  8A                    TXA                                ;[x]
  4091  C9 06                 CMP   #$06                         ;[x]
  4093  D0 01                 BNE   L02_4096                     ;[x]
  4095  3A                    DEC   A                            ;[x]
L02_4096:
  4096  8D 00 08              STA   PSG_CH                       ;[x]
  4099  BD 1C 27              LDA   $271C,X                      ;[x]
  409C  F0 03                 BEQ   L02_40A1                     ;[x]
  409E  20 A7 40              JSR   L02_40A7                     ;[x]
L02_40A1:
  40A1  E8                    INX                                ;[x]
  40A2  E0 07                 CPX   #$07                         ;[x]
  40A4  90 E7                 BCC   L02_408D                     ;[x]
  40A6  60                    RTS                                ;[x]

L02_40A7:
  40A7  AC 0B 28              LDY   $280B                        ;[x]
  40AA  F0 04                 BEQ   L02_40B0                     ;[x]
  40AC  C9 3E                 CMP   #$3E                         ;[ ]
  40AE  D0 7D                 BNE   L02_412D                     ;[ ]
L02_40B0:
  40B0  C9 00                 CMP   #$00                         ;[x]
  40B2  D0 07                 BNE   L02_40BB                     ;[x]
  40B4  AD 21 28              LDA   $2821                        ;[ ]
  40B7  C9 00                 CMP   #$00                         ;[ ]
  40B9  D0 72                 BNE   L02_412D                     ;[ ]
L02_40BB:
  40BB  BD 38 27              LDA   $2738,X                      ;[x]
  40BE  4A                    LSR   A                            ;[x]
  40BF  90 0D                 BCC   L02_40CE                     ;[x]
  40C1  BD 00 27              LDA   $2700,X                      ;[x]
  40C4  F0 05                 BEQ   L02_40CB                     ;[x]
  40C6  DE 00 27              DEC   $2700,X                      ;[x]
  40C9  D0 62                 BNE   L02_412D                     ;[x]
L02_40CB:
  40CB  4C C6 41              JMP   L02_41C6                     ;[x]

L02_40CE:
  40CE  BD 00 27              LDA   $2700,X                      ;[x]
  40D1  38                    SEC                                ;[x]
  40D2  FD 46 27              SBC   $2746,X                      ;[x]
  40D5  9D 00 27              STA   $2700,X                      ;[x]
  40D8  F0 14                 BEQ   L02_40EE                     ;[x]
  40DA  B0 1D                 BCS   L02_40F9                     ;[x]
  40DC  BD 07 27              LDA   $2707,X                      ;[x]
  40DF  E9 00                 SBC   #$00                         ;[x]
  40E1  9D 07 27              STA   $2707,X                      ;[x]
  40E4  B0 13                 BCS   L02_40F9                     ;[x]
  40E6  A9 00                 LDA   #$00                         ;[x]
  40E8  9D 5B 27              STA   $275B,X                      ;[x]
  40EB  4C C6 41              JMP   L02_41C6                     ;[x]

L02_40EE:
  40EE  BD 07 27              LDA   $2707,X                      ;[x]
  40F1  D0 06                 BNE   L02_40F9                     ;[x]
  40F3  9D 5B 27              STA   $275B,X                      ;[x]
  40F6  4C C6 41              JMP   L02_41C6                     ;[x]

L02_40F9:
  40F9  BD 38 27              LDA   $2738,X                      ;[x]
  40FC  29 41                 AND   #$41                         ;[x]
  40FE  D0 2D                 BNE   L02_412D                     ;[x]
  4100  A9 20                 LDA   #$20                         ;[x]
  4102  3D 38 27              AND   $2738,X                      ;[x]
  4105  F0 08                 BEQ   L02_410F                     ;[x]
  4107  CE 0E 28              DEC   $280E                        ;[x]
  410A  D0 21                 BNE   L02_412D                     ;[x]
  410C  4C 2E 41              JMP   L02_412E                     ;[x]

L02_410F:
  410F  FE 9A 27              INC   $279A,X                      ;[x]
  4112  20 CC 45              JSR   L02_45CC                     ;[x]
  4115  20 9D 45              JSR   L02_459D                     ;[x]
  4118  BD 15 27              LDA   $2715,X                      ;[x]
  411B  8D 13 28              STA   $2813                        ;[x]
  411E  BD 0E 27              LDA   $270E,X                      ;[x]
  4121  8D 14 28              STA   $2814                        ;[x]
  4124  20 76 45              JSR   L02_4576                     ;[x]
  4127  20 19 46              JSR   L02_4619                     ;[x]
  412A  20 68 46              JSR   L02_4668                     ;[x]
L02_412D:
  412D  60                    RTS                                ;[x]

L02_412E:
  412E  93 FF 20 28           TST   #$FF,$2820                   ;[x]
  4132  F0 01                 BEQ   L02_4135                     ;[x]
  4134  60                    RTS                                ;[x]

L02_4135:
  4135  5A                    PHY                                ;[x]
  4136  C2                    CLY                                ;[x]
  4137  B1 58                 LDA   (<$58),Y                     ;[x]
  4139  29 F0                 AND   #$F0                         ;[x]
  413B  D0 06                 BNE   L02_4143                     ;[x]
  413D  B1 58                 LDA   (<$58),Y                     ;[x]
  413F  8D 0F 28              STA   $280F                        ;[x]
L02_4142:
  4142  C8                    INY                                ;[x]
L02_4143:
  4143  B1 58                 LDA   (<$58),Y                     ;[x]
  4145  C9 F0                 CMP   #$F0                         ;[x]
  4147  90 39                 BCC   L02_4182                     ;[x]
  4149  C9 F4                 CMP   #$F4                         ;[x]
  414B  D0 08                 BNE   L02_4155                     ;[x]
  414D  C8                    INY                                ;[x]
  414E  B1 58                 LDA   (<$58),Y                     ;[x]
  4150  20 A6 47              JSR   L02_47A6                     ;[x]
  4153  80 ED                 BRA   L02_4142                     ;[x]

L02_4155:
  4155  C9 F5                 CMP   #$F5                         ;[x]
  4157  D0 08                 BNE   L02_4161                     ;[x]
  4159  C8                    INY                                ;[x]
  415A  B1 58                 LDA   (<$58),Y                     ;[x]
  415C  20 09 48              JSR   L02_4809                     ;[x]
  415F  80 E1                 BRA   L02_4142                     ;[x]

L02_4161:
  4161  C9 F6                 CMP   #$F6                         ;[x]
  4163  D0 08                 BNE   L02_416D                     ;[x]
  4165  C8                    INY                                ;[x]
  4166  B1 58                 LDA   (<$58),Y                     ;[x]
  4168  20 50 47              JSR   L02_4750                     ;[x]
  416B  80 D5                 BRA   L02_4142                     ;[x]

L02_416D:
  416D  C9 FF                 CMP   #$FF                         ;[x]
  416F  D0 0F                 BNE   L02_4180                     ;[x]
  4171  A9 00                 LDA   #$00                         ;[x]
  4173  8D 04 08              STA   PSG_CTRL                     ;[x]
  4176  A9 BF                 LDA   #$BF                         ;[x]
  4178  3D 38 27              AND   $2738,X                      ;[x]
  417B  9D 38 27              STA   $2738,X                      ;[x]
  417E  80 41                 BRA   L02_41C1                     ;[x]

L02_4180:
  4180  80 C0                 BRA   L02_4142                     ;[ ]

L02_4182:
  4182  AD 0F 28              LDA   $280F                        ;[x]
  4185  8D 0E 28              STA   $280E                        ;[x]
  4188  B1 58                 LDA   (<$58),Y                     ;[x]
  418A  48                    PHA                                ;[x]
  418B  29 0F                 AND   #$0F                         ;[x]
  418D  8D 14 28              STA   $2814                        ;[x]
  4190  C8                    INY                                ;[x]
  4191  B1 58                 LDA   (<$58),Y                     ;[x]
  4193  8D 13 28              STA   $2813                        ;[x]
  4196  A9 80                 LDA   #$80                         ;[x]
  4198  3D 38 27              AND   $2738,X                      ;[x]
  419B  D0 05                 BNE   L02_41A2                     ;[x]
  419D  20 76 45              JSR   L02_4576                     ;[x]
  41A0  80 06                 BRA   L02_41A8                     ;[x]

L02_41A2:
  41A2  9C 14 28              STZ   $2814                        ;[x]
  41A5  20 52 49              JSR   L02_4952                     ;[x]
L02_41A8:
  41A8  68                    PLA                                ;[x]
  41A9  4A                    LSR   A                            ;[x]
  41AA  4A                    LSR   A                            ;[x]
  41AB  4A                    LSR   A                            ;[x]
  41AC  4A                    LSR   A                            ;[x]
  41AD  38                    SEC                                ;[x]
  41AE  ED 07 28              SBC   $2807                        ;[x]
  41B1  20 60 49              JSR   L02_4960                     ;[x]
  41B4  C8                    INY                                ;[x]
  41B5  98                    TYA                                ;[x]
  41B6  18                    CLC                                ;[x]
  41B7  65 58                 ADC   <$58                         ;[x]
  41B9  85 58                 STA   <$58                         ;[x]
  41BB  A9 00                 LDA   #$00                         ;[x]
  41BD  65 59                 ADC   <$59                         ;[x]
  41BF  85 59                 STA   <$59                         ;[x]
L02_41C1:
  41C1  7A                    PLY                                ;[x]
  41C2  60                    RTS                                ;[x]

L02_41C3:
  41C3  C8                    INY                                ;[x]
  41C4  80 03                 BRA   L02_41C9                     ;[x]

L02_41C6:
  41C6  20 E2 48              JSR   L02_48E2                     ;[x]
L02_41C9:
  41C9  BD 38 27              LDA   $2738,X                      ;[x]
  41CC  4A                    LSR   A                            ;[x]
  41CD  B0 28                 BCS   L02_41F7                     ;[x]
  41CF  B1 56                 LDA   (<$56),Y                     ;[x]
  41D1  C9 D0                 CMP   #$D0                         ;[x]
  41D3  B0 03                 BCS   L02_41D8                     ;[x]
  41D5  4C 60 42              JMP   L02_4260                     ;[x]

L02_41D8:
  41D8  C9 E0                 CMP   #$E0                         ;[x]
  41DA  B0 03                 BCS   L02_41DF                     ;[x]
  41DC  4C F3 46              JMP   L02_46F3                     ;[x]

L02_41DF:
  41DF  E9 E0                 SBC   #$E0                         ;[x]
  41E1  0A                    ASL   A                            ;[x]
  41E2  AA                    TAX                                ;[x]
  41E3  BD 72 4A              LDA   $4A72,X                      ;[x]
  41E6  85 54                 STA   <$54                         ;[x]
  41E8  BD 73 4A              LDA   $4A73,X                      ;[x]
  41EB  85 55                 STA   <$55                         ;[x]
L02_41ED:
  41ED  AE 11 28              LDX   $2811                        ;[x]
  41F0  B1 56                 LDA   (<$56),Y                     ;[x]
  41F2  29 0F                 AND   #$0F                         ;[x]
  41F4  6C 54 20              JMP   ($2054)                      ;[x]

L02_41F7:
  41F7  B1 56                 LDA   (<$56),Y                     ;[x]
  41F9  C9 F0                 CMP   #$F0                         ;[x]
  41FB  90 11                 BCC   L02_420E                     ;[x]
  41FD  E9 F0                 SBC   #$F0                         ;[x]
  41FF  0A                    ASL   A                            ;[x]
  4200  AA                    TAX                                ;[x]
  4201  BD 52 4A              LDA   $4A52,X                      ;[x]
  4204  85 54                 STA   <$54                         ;[x]
  4206  BD 53 4A              LDA   $4A53,X                      ;[x]
  4209  85 55                 STA   <$55                         ;[x]
  420B  4C ED 41              JMP   L02_41ED                     ;[x]

L02_420E:
  420E  29 F0                 AND   #$F0                         ;[x]
  4210  C9 00                 CMP   #$00                         ;[x]
  4212  D0 0D                 BNE   L02_4221                     ;[x]
  4214  B1 56                 LDA   (<$56),Y                     ;[x]
  4216  D0 03                 BNE   L02_421B                     ;[x]
  4218  C8                    INY                                ;[ ]
  4219  B1 56                 LDA   (<$56),Y                     ;[ ]
L02_421B:
  421B  9D 46 27              STA   $2746,X                      ;[x]
  421E  C8                    INY                                ;[x]
  421F  80 D6                 BRA   L02_41F7                     ;[x]

L02_4221:
  4221  BD 46 27              LDA   $2746,X                      ;[x]
  4224  9D 00 27              STA   $2700,X                      ;[x]
  4227  20 2D 42              JSR   L02_422D                     ;[x]
  422A  4C 6A 43              JMP   L02_436A                     ;[x]

L02_422D:
  422D  B1 56                 LDA   (<$56),Y                     ;[x]
  422F  48                    PHA                                ;[x]
  4230  29 0F                 AND   #$0F                         ;[x]
  4232  8D 14 28              STA   $2814                        ;[x]
  4235  C8                    INY                                ;[x]
  4236  B1 56                 LDA   (<$56),Y                     ;[x]
  4238  8D 13 28              STA   $2813                        ;[x]
  423B  A9 80                 LDA   #$80                         ;[x]
  423D  3D 38 27              AND   $2738,X                      ;[x]
  4240  D0 05                 BNE   L02_4247                     ;[x]
  4242  20 65 45              JSR   L02_4565                     ;[x]
  4245  80 06                 BRA   L02_424D                     ;[x]

L02_4247:
  4247  9C 14 28              STZ   $2814                        ;[x]
  424A  20 52 49              JSR   L02_4952                     ;[x]
L02_424D:
  424D  68                    PLA                                ;[x]
  424E  4A                    LSR   A                            ;[x]
  424F  4A                    LSR   A                            ;[x]
  4250  4A                    LSR   A                            ;[x]
  4251  4A                    LSR   A                            ;[x]
  4252  18                    CLC                                ;[x]
  4253  69 10                 ADC   #$10                         ;[x]
  4255  38                    SEC                                ;[x]
  4256  FD 23 27              SBC   $2723,X                      ;[x]
  4259  B0 02                 BCS   L02_425D                     ;[x]
  425B  A9 00                 LDA   #$00                         ;[ ]
L02_425D:
  425D  4C 74 49              JMP   L02_4974                     ;[x]

L02_4260:
  4260  48                    PHA                                ;[x]
  4261  A9 39                 LDA   #$39                         ;[x]
  4263  3D 38 27              AND   $2738,X                      ;[x]
  4266  9D 38 27              STA   $2738,X                      ;[x]
  4269  68                    PLA                                ;[x]
  426A  20 34 44              JSR   L02_4434                     ;[x]
  426D  8A                    TXA                                ;[x]
  426E  C9 04                 CMP   #$04                         ;[x]
  4270  D0 0A                 BNE   L02_427C                     ;[x]
  4272  A9 20                 LDA   #$20                         ;[x]
  4274  3D 38 27              AND   $2738,X                      ;[x]
  4277  F0 03                 BEQ   L02_427C                     ;[x]
  4279  4C 7A 43              JMP   L02_437A                     ;[x]

L02_427C:
  427C  BD 3F 27              LDA   $273F,X                      ;[x]
  427F  29 02                 AND   #$02                         ;[x]
  4281  D0 28                 BNE   L02_42AB                     ;[x]
  4283  62                    CLA                                ;[x]
  4284  9D 70 27              STA   $2770,X                      ;[x]
  4287  9D B6 27              STA   $27B6,X                      ;[x]
  428A  9D 9A 27              STA   $279A,X                      ;[x]
  428D  1A                    INC   A                            ;[x]
  428E  9D 69 27              STA   $2769,X                      ;[x]
  4291  9D A1 27              STA   $27A1,X                      ;[x]
  4294  20 19 46              JSR   L02_4619                     ;[x]
  4297  20 CC 45              JSR   L02_45CC                     ;[x]
  429A  BD 3F 27              LDA   $273F,X                      ;[x]
  429D  29 01                 AND   #$01                         ;[x]
  429F  F0 0A                 BEQ   L02_42AB                     ;[x]
  42A1  BD 3F 27              LDA   $273F,X                      ;[x]
  42A4  29 FE                 AND   #$FE                         ;[x]
  42A6  09 02                 ORA   #$02                         ;[x]
  42A8  9D 3F 27              STA   $273F,X                      ;[x]
L02_42AB:
  42AB  BD 3F 27              LDA   $273F,X                      ;[x]
  42AE  29 03                 AND   #$03                         ;[x]
  42B0  C9 03                 CMP   #$03                         ;[x]
  42B2  D0 08                 BNE   L02_42BC                     ;[x]
  42B4  BD 3F 27              LDA   $273F,X                      ;[x]
  42B7  29 FC                 AND   #$FC                         ;[x]
  42B9  9D 3F 27              STA   $273F,X                      ;[x]
L02_42BC:
  42BC  B1 56                 LDA   (<$56),Y                     ;[x]
  42BE  29 F0                 AND   #$F0                         ;[x]
  42C0  C9 C0                 CMP   #$C0                         ;[x]
  42C2  D0 03                 BNE   L02_42C7                     ;[x]
  42C4  4C 58 43              JMP   L02_4358                     ;[x]

L02_42C7:
  42C7  4A                    LSR   A                            ;[x]
  42C8  4A                    LSR   A                            ;[x]
  42C9  4A                    LSR   A                            ;[x]
  42CA  4A                    LSR   A                            ;[x]
  42CB  48                    PHA                                ;[x]
  42CC  BD 77 27              LDA   $2777,X                      ;[x]
  42CF  4A                    LSR   A                            ;[x]
  42D0  4A                    LSR   A                            ;[x]
  42D1  4A                    LSR   A                            ;[x]
  42D2  4A                    LSR   A                            ;[x]
  42D3  18                    CLC                                ;[x]
  42D4  7D 4D 27              ADC   $274D,X                      ;[x]
  42D7  29 07                 AND   #$07                         ;[x]
  42D9  1A                    INC   A                            ;[x]
  42DA  85 54                 STA   <$54                         ;[x]
  42DC  68                    PLA                                ;[x]
  42DD  18                    CLC                                ;[x]
L02_42DE:
  42DE  C6 54                 DEC   <$54                         ;[x]
  42E0  F0 04                 BEQ   L02_42E6                     ;[x]
  42E2  69 0C                 ADC   #$0C                         ;[x]
  42E4  80 F8                 BRA   L02_42DE                     ;[x]

L02_42E6:
  42E6  48                    PHA                                ;[x]
  42E7  BD 77 27              LDA   $2777,X                      ;[x]
  42EA  29 0F                 AND   #$0F                         ;[x]
  42EC  85 54                 STA   <$54                         ;[x]
  42EE  BD 77 27              LDA   $2777,X                      ;[x]
  42F1  29 80                 AND   #$80                         ;[x]
  42F3  D0 07                 BNE   L02_42FC                     ;[x]
  42F5  68                    PLA                                ;[x]
  42F6  18                    CLC                                ;[x]
  42F7  65 54                 ADC   <$54                         ;[x]
  42F9  4C 00 43              JMP   L02_4300                     ;[x]

L02_42FC:
  42FC  68                    PLA                                ;[ ]
  42FD  38                    SEC                                ;[ ]
  42FE  E5 54                 SBC   <$54                         ;[ ]
L02_4300:
  4300  0A                    ASL   A                            ;[x]
  4301  AA                    TAX                                ;[x]
  4302  BD 93 49              LDA   $4993,X                      ;[x]
  4305  48                    PHA                                ;[x]
  4306  BD 92 49              LDA   $4992,X                      ;[x]
  4309  48                    PHA                                ;[x]
  430A  AE 11 28              LDX   $2811                        ;[x]
  430D  BD 54 27              LDA   $2754,X                      ;[x]
  4310  29 80                 AND   #$80                         ;[x]
  4312  D0 17                 BNE   L02_432B                     ;[x]
  4314  68                    PLA                                ;[x]
  4315  18                    CLC                                ;[x]
  4316  7D 54 27              ADC   $2754,X                      ;[x]
  4319  8D 13 28              STA   $2813                        ;[x]
  431C  9D 15 27              STA   $2715,X                      ;[x]
  431F  68                    PLA                                ;[x]
  4320  69 00                 ADC   #$00                         ;[x]
  4322  8D 14 28              STA   $2814                        ;[x]
  4325  9D 0E 27              STA   $270E,X                      ;[x]
  4328  4C 4F 43              JMP   L02_434F                     ;[x]

L02_432B:
  432B  BD 54 27              LDA   $2754,X                      ;[ ]
  432E  29 7F                 AND   #$7F                         ;[ ]
  4330  9D 54 27              STA   $2754,X                      ;[ ]
  4333  68                    PLA                                ;[ ]
  4334  38                    SEC                                ;[ ]
  4335  FD 54 27              SBC   $2754,X                      ;[ ]
  4338  8D 13 28              STA   $2813                        ;[ ]
  433B  9D 15 27              STA   $2715,X                      ;[ ]
  433E  68                    PLA                                ;[ ]
  433F  E9 00                 SBC   #$00                         ;[ ]
  4341  8D 14 28              STA   $2814                        ;[ ]
  4344  9D 0E 27              STA   $270E,X                      ;[ ]
  4347  BD 54 27              LDA   $2754,X                      ;[ ]
  434A  09 80                 ORA   #$80                         ;[ ]
  434C  9D 54 27              STA   $2754,X                      ;[ ]
L02_434F:
  434F  20 76 45              JSR   L02_4576                     ;[x]
  4352  20 68 46              JSR   L02_4668                     ;[x]
  4355  4C 6A 43              JMP   L02_436A                     ;[x]

L02_4358:
  4358  20 24 49              JSR   L02_4924                     ;[x]
  435B  B0 05                 BCS   L02_4362                     ;[x]
  435D  A9 00                 LDA   #$00                         ;[x]
  435F  8D 04 08              STA   PSG_CTRL                     ;[x]
L02_4362:
  4362  BD 38 27              LDA   $2738,X                      ;[x]
  4365  09 40                 ORA   #$40                         ;[x]
  4367  9D 38 27              STA   $2738,X                      ;[x]
L02_436A:
  436A  C8                    INY                                ;[x]
  436B  98                    TYA                                ;[x]
  436C  18                    CLC                                ;[x]
  436D  65 56                 ADC   <$56                         ;[x]
  436F  9D C4 27              STA   $27C4,X                      ;[x]
  4372  A9 00                 LDA   #$00                         ;[x]
  4374  65 57                 ADC   <$57                         ;[x]
  4376  9D CB 27              STA   $27CB,X                      ;[x]
  4379  60                    RTS                                ;[x]

L02_437A:
  437A  9C 20 28              STZ   $2820                        ;[x]
  437D  B1 56                 LDA   (<$56),Y                     ;[x]
  437F  29 F0                 AND   #$F0                         ;[x]
  4381  4A                    LSR   A                            ;[x]
  4382  4A                    LSR   A                            ;[x]
  4383  4A                    LSR   A                            ;[x]
  4384  48                    PHA                                ;[x]
  4385  BD 4D 27              LDA   $274D,X                      ;[x]
  4388  D0 04                 BNE   L02_438E                     ;[x]
  438A  68                    PLA                                ;[x]
  438B  4C 9A 43              JMP   L02_439A                     ;[x]

L02_438E:
  438E  29 07                 AND   #$07                         ;[x]
  4390  85 54                 STA   <$54                         ;[x]
  4392  68                    PLA                                ;[x]
  4393  18                    CLC                                ;[x]
L02_4394:
  4394  69 18                 ADC   #$18                         ;[x]
  4396  C6 54                 DEC   <$54                         ;[x]
  4398  D0 FA                 BNE   L02_4394                     ;[x]
L02_439A:
  439A  AA                    TAX                                ;[x]
  439B  C9 04                 CMP   #$04                         ;[x]
  439D  F0 27                 BEQ   L02_43C6                     ;[x]
  439F  C9 0A                 CMP   #$0A                         ;[x]
  43A1  F0 23                 BEQ   L02_43C6                     ;[x]
  43A3  C9 0C                 CMP   #$0C                         ;[x]
  43A5  F0 1F                 BEQ   L02_43C6                     ;[x]
  43A7  C9 0E                 CMP   #$0E                         ;[x]
  43A9  F0 1B                 BEQ   L02_43C6                     ;[x]
  43AB  C9 40                 CMP   #$40                         ;[x]
  43AD  D0 04                 BNE   L02_43B3                     ;[x]
  43AF  A9 10                 LDA   #$10                         ;[ ]
  43B1  80 13                 BRA   L02_43C6                     ;[ ]

L02_43B3:
  43B3  BD 62 B3              LDA   $B362,X                      ;[x]
  43B6  85 58                 STA   <$58                         ;[x]
  43B8  BD 63 B3              LDA   $B363,X                      ;[x]
  43BB  85 59                 STA   <$59                         ;[x]
  43BD  AE 11 28              LDX   $2811                        ;[x]
  43C0  20 2E 41              JSR   L02_412E                     ;[x]
  43C3  4C 6A 43              JMP   L02_436A                     ;[x]

L02_43C6:
  43C6  48                    PHA                                ;[x]
  43C7  BD 14 44              LDA   $4414,X                      ;[x]
  43CA  85 5A                 STA   <$5A                         ;[x]
  43CC  BD 15 44              LDA   $4415,X                      ;[x]
  43CF  85 5B                 STA   <$5B                         ;[x]
  43D1  A9 40                 LDA   #$40                         ;[x]
  43D3  8D 04 08              STA   PSG_CTRL                     ;[x]
  43D6  62                    CLA                                ;[x]
  43D7  8D 06 08              STA   PSG_WAVE                     ;[x]
  43DA  8D 07 08              STA   PSG_NOISE                    ;[x]
  43DD  1A                    INC   A                            ;[x]
  43DE  8D 20 28              STA   $2820                        ;[x]
  43E1  A9 1F                 LDA   #$1F                         ;[x]
  43E3  38                    SEC                                ;[x]
  43E4  ED 07 28              SBC   $2807                        ;[x]
  43E7  38                    SEC                                ;[x]
  43E8  ED 16 28              SBC   $2816                        ;[x]
  43EB  09 C0                 ORA   #$C0                         ;[x]
  43ED  8D 04 08              STA   PSG_CTRL                     ;[x]
  43F0  68                    PLA                                ;[x]
  43F1  C9 04                 CMP   #$04                         ;[x]
  43F3  D0 04                 BNE   L02_43F9                     ;[x]
  43F5  A9 FF                 LDA   #$FF                         ;[x]
  43F7  80 12                 BRA   L02_440B                     ;[x]

L02_43F9:
  43F9  C9 0A                 CMP   #$0A                         ;[x]
  43FB  D0 04                 BNE   L02_4401                     ;[x]
  43FD  A9 EE                 LDA   #$EE                         ;[x]
  43FF  80 0A                 BRA   L02_440B                     ;[x]

L02_4401:
  4401  C9 0C                 CMP   #$0C                         ;[x]
  4403  D0 04                 BNE   L02_4409                     ;[x]
  4405  A9 EE                 LDA   #$EE                         ;[x]
  4407  80 02                 BRA   L02_440B                     ;[x]

L02_4409:
  4409  A9 EE                 LDA   #$EE                         ;[x]
L02_440B:
  440B  8D 05 08              STA   PSG_PAN                      ;[x]
  440E  AE 11 28              LDX   $2811                        ;[x]
  4411  4C 6A 43              JMP   L02_436A                     ;[x]

  4414  .db $00,$40,$00,$40,$01,$40,$00,$40,$00,$40,$EC,$41,$71,$44,$F5,$46
  4424  .db $32,$65,$00,$40,$00,$40,$00,$40,$00,$40,$00,$40,$00,$40,$00,$40
L02_4434:
  4434  5A                    PHY                                ;[x]
  4435  29 0F                 AND   #$0F                         ;[x]
  4437  0A                    ASL   A                            ;[x]
  4438  A8                    TAY                                ;[x]
  4439  BD 00 27              LDA   $2700,X                      ;[x]
  443C  18                    CLC                                ;[x]
  443D  79 65 44              ADC   $4465,Y                      ;[x]
  4440  9D 00 27              STA   $2700,X                      ;[x]
  4443  BD 07 27              LDA   $2707,X                      ;[x]
  4446  79 66 44              ADC   $4466,Y                      ;[x]
  4449  9D 07 27              STA   $2707,X                      ;[x]
  444C  98                    TYA                                ;[x]
  444D  BC 93 27              LDY   $2793,X                      ;[x]
  4450  18                    CLC                                ;[x]
L02_4451:
  4451  69 20                 ADC   #$20                         ;[x]
  4453  88                    DEY                                ;[x]
  4454  D0 FB                 BNE   L02_4451                     ;[x]
  4456  A8                    TAY                                ;[x]
  4457  B9 85 44              LDA   $4485,Y                      ;[x]
  445A  9D 85 27              STA   $2785,X                      ;[x]
  445D  B9 86 44              LDA   $4486,Y                      ;[x]
  4460  9D 8C 27              STA   $278C,X                      ;[x]
  4463  7A                    PLY                                ;[x]
  4464  60                    RTS                                ;[x]

  4465  .db $C0,$00,$20,$01,$80,$01,$40,$02,$00,$03,$80,$04,$00,$06,$00,$09
  4475  .db $00,$0C,$00,$12,$00,$18,$80,$00,$00,$01,$00,$02,$00,$04,$00,$08
  4485  .db $26,$00,$3A,$00,$4D,$00,$73,$00,$9A,$00,$E6,$00,$33,$01,$CD,$01
  4495  .db $66,$02,$99,$03,$CD,$04,$1A,$00,$33,$00,$66,$00,$CD,$00,$9A,$01
  44A5  .db $3A,$00,$56,$00,$73,$00,$AD,$00,$E6,$00,$5A,$01,$CD,$01,$B3,$02
  44B5  .db $9A,$03,$66,$05,$33,$07,$26,$00,$4D,$00,$9A,$00,$33,$01,$66,$02
  44C5  .db $4D,$00,$73,$00,$9A,$00,$E6,$00,$33,$01,$CD,$01,$66,$02,$9A,$03
  44D5  .db $CD,$04,$33,$07,$9A,$09,$33,$00,$66,$00,$CD,$00,$9A,$01,$33,$03
  44E5  .db $60,$00,$90,$00,$C0,$00,$20,$01,$80,$01,$40,$02,$00,$03,$80,$04
  44F5  .db $00,$06,$00,$09,$00,$0C,$40,$00,$80,$00,$00,$01,$00,$02,$00,$04
  4505  .db $73,$00,$AD,$00,$E6,$00,$5A,$01,$CD,$01,$B3,$02,$9A,$03,$66,$05
  4515  .db $33,$07,$CD,$0A,$66,$0E,$4D,$00,$9A,$00,$33,$01,$66,$02,$CD,$04
  4525  .db $86,$00,$CA,$00,$0D,$01,$93,$01,$1A,$02,$26,$03,$33,$04,$4C,$06
  4535  .db $66,$08,$9A,$0C,$CD,$10,$5A,$00,$B3,$00,$66,$01,$CD,$02,$9A,$05
  4545  .db $9A,$00,$E6,$00,$33,$01,$CD,$01,$66,$02,$99,$03,$CD,$04,$33,$07
  4555  .db $9A,$09,$66,$0E,$33,$13,$66,$00,$CD,$00,$9A,$01,$33,$03,$66,$06
L02_4565:
  4565  AD 13 28              LDA   $2813                        ;[x]
  4568  18                    CLC                                ;[x]
  4569  7D A8 27              ADC   $27A8,X                      ;[x]
  456C  8D 13 28              STA   $2813                        ;[x]
  456F  AD 14 28              LDA   $2814                        ;[x]
  4572  69 00                 ADC   #$00                         ;[x]
  4574  80 1B                 BRA   L02_4591                     ;[x]

L02_4576:
  4576  AD 13 28              LDA   $2813                        ;[x]
  4579  38                    SEC                                ;[x]
  457A  FD A8 27              SBC   $27A8,X                      ;[x]
  457D  8D 13 28              STA   $2813                        ;[x]
  4580  BD A8 27              LDA   $27A8,X                      ;[x]
  4583  10 07                 BPL   L02_458C                     ;[x]
  4585  AD 14 28              LDA   $2814                        ;[x]
  4588  E9 FF                 SBC   #$FF                         ;[x]
  458A  80 05                 BRA   L02_4591                     ;[x]

L02_458C:
  458C  AD 14 28              LDA   $2814                        ;[x]
  458F  E9 00                 SBC   #$00                         ;[x]
L02_4591:
  4591  8D 14 28              STA   $2814                        ;[x]
  4594  20 24 49              JSR   L02_4924                     ;[x]
  4597  B0 03                 BCS   L02_459C                     ;[x]
  4599  20 41 49              JSR   L02_4941                     ;[x]
L02_459C:
  459C  60                    RTS                                ;[x]

L02_459D:
  459D  BD 5B 27              LDA   $275B,X                      ;[x]
  45A0  29 80                 AND   #$80                         ;[x]
  45A2  D0 13                 BNE   L02_45B7                     ;[x]
  45A4  BD 15 27              LDA   $2715,X                      ;[x]
  45A7  38                    SEC                                ;[x]
  45A8  FD 5B 27              SBC   $275B,X                      ;[x]
  45AB  9D 15 27              STA   $2715,X                      ;[x]
  45AE  BD 0E 27              LDA   $270E,X                      ;[x]
  45B1  E9 00                 SBC   #$00                         ;[x]
  45B3  9D 0E 27              STA   $270E,X                      ;[x]
  45B6  60                    RTS                                ;[x]

L02_45B7:
  45B7  BD 5B 27              LDA   $275B,X                      ;[ ]
  45BA  29 7F                 AND   #$7F                         ;[ ]
  45BC  18                    CLC                                ;[ ]
  45BD  7D 15 27              ADC   $2715,X                      ;[ ]
  45C0  9D 15 27              STA   $2715,X                      ;[ ]
  45C3  A9 00                 LDA   #$00                         ;[ ]
  45C5  7D 0E 27              ADC   $270E,X                      ;[ ]
  45C8  9D 0E 27              STA   $270E,X                      ;[ ]
  45CB  60                    RTS                                ;[ ]

L02_45CC:
  45CC  5A                    PHY                                ;[x]
  45CD  A9 04                 LDA   #$04                         ;[x]
  45CF  3D 38 27              AND   $2738,X                      ;[x]
  45D2  D0 29                 BNE   L02_45FD                     ;[x]
  45D4  DE A1 27              DEC   $27A1,X                      ;[x]
  45D7  D0 24                 BNE   L02_45FD                     ;[x]
L02_45D9:
  45D9  BD EE 27              LDA   $27EE,X                      ;[x]
  45DC  85 54                 STA   <$54                         ;[x]
  45DE  BD F5 27              LDA   $27F5,X                      ;[x]
  45E1  85 55                 STA   <$55                         ;[x]
  45E3  BC B6 27              LDY   $27B6,X                      ;[x]
  45E6  B1 54                 LDA   (<$54),Y                     ;[x]
  45E8  C9 FE                 CMP   #$FE                         ;[x]
  45EA  B0 13                 BCS   L02_45FF                     ;[x]
  45EC  9D A1 27              STA   $27A1,X                      ;[x]
  45EF  FE B6 27              INC   $27B6,X                      ;[x]
  45F2  BC B6 27              LDY   $27B6,X                      ;[x]
  45F5  B1 54                 LDA   (<$54),Y                     ;[x]
  45F7  9D A8 27              STA   $27A8,X                      ;[x]
  45FA  FE B6 27              INC   $27B6,X                      ;[x]
L02_45FD:
  45FD  7A                    PLY                                ;[x]
  45FE  60                    RTS                                ;[x]

L02_45FF:
  45FF  D0 0E                 BNE   L02_460F                     ;[x]
  4601  FE B6 27              INC   $27B6,X                      ;[x]
  4604  BC B6 27              LDY   $27B6,X                      ;[x]
  4607  B1 54                 LDA   (<$54),Y                     ;[x]
  4609  9D B6 27              STA   $27B6,X                      ;[x]
  460C  4C D9 45              JMP   L02_45D9                     ;[x]

L02_460F:
  460F  A9 04                 LDA   #$04                         ;[x]
  4611  1D 38 27              ORA   $2738,X                      ;[x]
  4614  9D 38 27              STA   $2738,X                      ;[x]
  4617  80 E4                 BRA   L02_45FD                     ;[x]

L02_4619:
  4619  5A                    PHY                                ;[x]
  461A  A9 02                 LDA   #$02                         ;[x]
  461C  3D 38 27              AND   $2738,X                      ;[x]
  461F  D0 2B                 BNE   L02_464C                     ;[x]
  4621  DE 69 27              DEC   $2769,X                      ;[x]
  4624  D0 26                 BNE   L02_464C                     ;[x]
L02_4626:
  4626  BD E0 27              LDA   $27E0,X                      ;[x]
  4629  85 54                 STA   <$54                         ;[x]
  462B  BD E7 27              LDA   $27E7,X                      ;[x]
  462E  85 55                 STA   <$55                         ;[x]
  4630  BC 70 27              LDY   $2770,X                      ;[x]
  4633  B1 54                 LDA   (<$54),Y                     ;[x]
  4635  C9 FE                 CMP   #$FE                         ;[x]
  4637  B0 15                 BCS   L02_464E                     ;[x]
  4639  9D 69 27              STA   $2769,X                      ;[x]
  463C  FE 70 27              INC   $2770,X                      ;[x]
  463F  BC 70 27              LDY   $2770,X                      ;[x]
  4642  B1 54                 LDA   (<$54),Y                     ;[x]
  4644  29 1F                 AND   #$1F                         ;[x]
  4646  9D 23 27              STA   $2723,X                      ;[x]
  4649  FE 70 27              INC   $2770,X                      ;[x]
L02_464C:
  464C  7A                    PLY                                ;[x]
  464D  60                    RTS                                ;[x]

L02_464E:
  464E  D0 0E                 BNE   L02_465E                     ;[x]
  4650  FE 70 27              INC   $2770,X                      ;[x]
  4653  BC 70 27              LDY   $2770,X                      ;[x]
  4656  B1 54                 LDA   (<$54),Y                     ;[x]
  4658  9D 70 27              STA   $2770,X                      ;[x]
  465B  4C 26 46              JMP   L02_4626                     ;[x]

L02_465E:
  465E  A9 02                 LDA   #$02                         ;[x]
  4660  1D 38 27              ORA   $2738,X                      ;[x]
  4663  9D 38 27              STA   $2738,X                      ;[x]
  4666  80 E4                 BRA   L02_464C                     ;[x]

L02_4668:
  4668  BD 8C 27              LDA   $278C,X                      ;[x]
  466B  1D 85 27              ORA   $2785,X                      ;[x]
  466E  D0 06                 BNE   L02_4676                     ;[x]
  4670  EE 9A 27              INC   $279A                        ;[x]
  4673  4C AC 46              JMP   L02_46AC                     ;[x]

L02_4676:
  4676  BD 85 27              LDA   $2785,X                      ;[x]
  4679  38                    SEC                                ;[x]
  467A  FD 46 27              SBC   $2746,X                      ;[x]
  467D  9D 85 27              STA   $2785,X                      ;[x]
  4680  F0 1A                 BEQ   L02_469C                     ;[x]
  4682  B0 23                 BCS   L02_46A7                     ;[x]
  4684  BD 8C 27              LDA   $278C,X                      ;[x]
  4687  E9 00                 SBC   #$00                         ;[x]
  4689  9D 8C 27              STA   $278C,X                      ;[x]
  468C  B0 19                 BCS   L02_46A7                     ;[x]
  468E  A9 00                 LDA   #$00                         ;[x]
  4690  9D 8C 27              STA   $278C,X                      ;[x]
  4693  9D 85 27              STA   $2785,X                      ;[x]
  4696  9D 9A 27              STA   $279A,X                      ;[x]
  4699  4C AC 46              JMP   L02_46AC                     ;[x]

L02_469C:
  469C  BD 8C 27              LDA   $278C,X                      ;[x]
  469F  D0 06                 BNE   L02_46A7                     ;[x]
  46A1  9D 9A 27              STA   $279A,X                      ;[x]
  46A4  4C AC 46              JMP   L02_46AC                     ;[x]

L02_46A7:
  46A7  A9 00                 LDA   #$00                         ;[x]
  46A9  4C D0 46              JMP   L02_46D0                     ;[x]

L02_46AC:
  46AC  BD 3F 27              LDA   $273F,X                      ;[x]
  46AF  29 02                 AND   #$02                         ;[x]
  46B1  D0 F4                 BNE   L02_46A7                     ;[x]
  46B3  BD 9A 27              LDA   $279A,X                      ;[x]
  46B6  85 55                 STA   <$55                         ;[x]
  46B8  BD 7E 27              LDA   $277E,X                      ;[x]
  46BB  4A                    LSR   A                            ;[x]
  46BC  4A                    LSR   A                            ;[x]
  46BD  4A                    LSR   A                            ;[x]
  46BE  4A                    LSR   A                            ;[x]
  46BF  85 54                 STA   <$54                         ;[x]
  46C1  20 7A 49              JSR   L02_497A                     ;[x]
  46C4  BD 7E 27              LDA   $277E,X                      ;[x]
  46C7  29 0F                 AND   #$0F                         ;[x]
  46C9  18                    CLC                                ;[x]
  46CA  65 55                 ADC   <$55                         ;[x]
  46CC  90 02                 BCC   L02_46D0                     ;[x]
  46CE  A9 FF                 LDA   #$FF                         ;[ ]
L02_46D0:
  46D0  85 54                 STA   <$54                         ;[x]
  46D2  BD 23 27              LDA   $2723,X                      ;[x]
  46D5  38                    SEC                                ;[x]
  46D6  E5 54                 SBC   <$54                         ;[x]
  46D8  B0 05                 BCS   L02_46DF                     ;[x]
  46DA  A9 00                 LDA   #$00                         ;[x]
  46DC  4C E7 46              JMP   L02_46E7                     ;[x]

L02_46DF:
  46DF  38                    SEC                                ;[x]
  46E0  FD 03 28              SBC   $2803,X                      ;[x]
  46E3  B0 02                 BCS   L02_46E7                     ;[x]
  46E5  A9 00                 LDA   #$00                         ;[x]
L02_46E7:
  46E7  20 24 49              JSR   L02_4924                     ;[x]
  46EA  B0 03                 BCS   L02_46EF                     ;[x]
  46EC  20 63 49              JSR   L02_4963                     ;[x]
L02_46EF:
  46EF  60                    RTS                                ;[x]

  46F0  4C C3 41              JMP   L02_41C3                     ;[x]

L02_46F3:
  46F3  29 0F                 AND   #$0F                         ;[x]
  46F5  9D 4D 27              STA   $274D,X                      ;[x]
  46F8  4C C3 41              JMP   L02_41C3                     ;[x]

  46FB  C8                    INY                                ;[x]
  46FC  B1 56                 LDA   (<$56),Y                     ;[x]
  46FE  3A                    DEC   A                            ;[x]
  46FF  3A                    DEC   A                            ;[x]
  4700  9D 93 27              STA   $2793,X                      ;[x]
  4703  C8                    INY                                ;[x]
  4704  B1 56                 LDA   (<$56),Y                     ;[x]
  4706  9D 7E 27              STA   $277E,X                      ;[x]
  4709  4C C3 41              JMP   L02_41C3                     ;[x]

  470C  C8                    INY                                ;[x]
  470D  B1 56                 LDA   (<$56),Y                     ;[x]
  470F  0A                    ASL   A                            ;[x]
  4710  AA                    TAX                                ;[x]
  4711  BD AC B1              LDA   $B1AC,X                      ;[x]
  4714  48                    PHA                                ;[x]
  4715  BD AD B1              LDA   $B1AD,X                      ;[x]
  4718  AE 11 28              LDX   $2811                        ;[x]
  471B  9D F5 27              STA   $27F5,X                      ;[x]
  471E  68                    PLA                                ;[x]
  471F  9D EE 27              STA   $27EE,X                      ;[x]
  4722  4C C3 41              JMP   L02_41C3                     ;[x]

  4725  C8                    INY                                ;[x]
  4726  B1 56                 LDA   (<$56),Y                     ;[x]
  4728  0A                    ASL   A                            ;[x]
  4729  AA                    TAX                                ;[x]
  472A  BD E8 AD              LDA   $ADE8,X                      ;[x]
  472D  48                    PHA                                ;[x]
  472E  BD E9 AD              LDA   $ADE9,X                      ;[x]
  4731  AE 11 28              LDX   $2811                        ;[x]
  4734  9D E7 27              STA   $27E7,X                      ;[x]
  4737  68                    PLA                                ;[x]
  4738  9D E0 27              STA   $27E0,X                      ;[x]
  473B  4C C3 41              JMP   L02_41C3                     ;[x]

  473E  C8                    INY                                ;[x]
  473F  B1 56                 LDA   (<$56),Y                     ;[x]
  4741  9D 77 27              STA   $2777,X                      ;[x]
  4744  4C C3 41              JMP   L02_41C3                     ;[x]

  4747  20 4D 47              JSR   L02_474D                     ;[x]
  474A  4C C3 41              JMP   L02_41C3                     ;[x]

L02_474D:
  474D  C8                    INY                                ;[x]
  474E  B1 56                 LDA   (<$56),Y                     ;[x]
L02_4750:
  4750  09 00                 ORA   #$00                         ;[x]
  4752  D0 02                 BNE   L02_4756                     ;[x]
  4754  A9 FF                 LDA   #$FF                         ;[ ]
L02_4756:
  4756  9D 2A 27              STA   $272A,X                      ;[x]
  4759  20 24 49              JSR   L02_4924                     ;[x]
  475C  B0 03                 BCS   L02_4761                     ;[x]
  475E  8D 05 08              STA   PSG_PAN                      ;[x]
L02_4761:
  4761  60                    RTS                                ;[x]

  4762  C8                    INY                                ;[x]
  4763  B1 56                 LDA   (<$56),Y                     ;[x]
  4765  09 00                 ORA   #$00                         ;[x]
  4767  F0 07                 BEQ   L02_4770                     ;[x]
  4769  A9 20                 LDA   #$20                         ;[x]
  476B  1D 38 27              ORA   $2738,X                      ;[x]
  476E  80 05                 BRA   L02_4775                     ;[x]

L02_4770:
  4770  A9 DF                 LDA   #$DF                         ;[ ]
  4772  3D 38 27              AND   $2738,X                      ;[ ]
L02_4775:
  4775  9D 38 27              STA   $2738,X                      ;[x]
  4778  4C C3 41              JMP   L02_41C3                     ;[x]

  477B  C8                    INY                                ;[x]
  477C  B1 56                 LDA   (<$56),Y                     ;[x]
  477E  9D 46 27              STA   $2746,X                      ;[x]
  4781  4C C3 41              JMP   L02_41C3                     ;[x]

  4784  .db $29,$03,$8D,$09,$08,$C8,$B1,$56,$8D,$08,$08,$4C,$C3,$41
L02_4792:
  4792  C8                    INY                                ;[x]
  4793  B1 56                 LDA   (<$56),Y                     ;[x]
  4795  29 1F                 AND   #$1F                         ;[x]
  4797  9D 03 28              STA   $2803,X                      ;[x]
  479A  4C C3 41              JMP   L02_41C3                     ;[x]

  479D  20 A3 47              JSR   L02_47A3                     ;[x]
  47A0  4C C3 41              JMP   L02_41C3                     ;[x]

L02_47A3:
  47A3  C8                    INY                                ;[x]
  47A4  B1 56                 LDA   (<$56),Y                     ;[x]
L02_47A6:
  47A6  9D BD 27              STA   $27BD,X                      ;[x]
  47A9  20 24 49              JSR   L02_4924                     ;[x]
  47AC  B0 51                 BCS   L02_47FF                     ;[x]
  47AE  DA                    PHX                                ;[x]
  47AF  48                    PHA                                ;[x]
  47B0  E0 04                 CPX   #$04                         ;[x]
  47B2  D0 03                 BNE   L02_47B7                     ;[x]
  47B4  9C 20 28              STZ   $2820                        ;[x]
L02_47B7:
  47B7  62                    CLA                                ;[x]
  47B8  8D 04 08              STA   PSG_CTRL                     ;[x]
  47BB  A9 40                 LDA   #$40                         ;[x]
  47BD  8D 04 08              STA   PSG_CTRL                     ;[x]
  47C0  62                    CLA                                ;[x]
  47C1  8D 04 08              STA   PSG_CTRL                     ;[x]
  47C4  68                    PLA                                ;[x]
  47C5  0A                    ASL   A                            ;[x]
  47C6  AA                    TAX                                ;[x]
  47C7  BD 7C A2              LDA   $A27C,X                      ;[x]
  47CA  8D 19 28              STA   $2819                        ;[x]
  47CD  BD 7D A2              LDA   $A27D,X                      ;[x]
  47D0  8D 1A 28              STA   $281A                        ;[x]
  47D3  FA                    PLX                                ;[x]
  47D4  A9 06                 LDA   #$06                         ;[x]
  47D6  8D 1B 28              STA   $281B                        ;[x]
  47D9  A9 08                 LDA   #$08                         ;[x]
  47DB  8D 1C 28              STA   $281C                        ;[x]
  47DE  A9 D3                 LDA   #$D3                         ;[x]
  47E0  8D 18 28              STA   $2818                        ;[x]
  47E3  A9 20                 LDA   #$20                         ;[x]
  47E5  8D 1D 28              STA   $281D                        ;[x]
  47E8  A9 00                 LDA   #$00                         ;[x]
  47EA  8D 1E 28              STA   $281E                        ;[x]
  47ED  A9 60                 LDA   #$60                         ;[x]
  47EF  8D 1F 28              STA   $281F                        ;[x]
  47F2  20 18 28              JSR   $2818                        ;[x]
  47F5  A9 FF                 LDA   #$FF                         ;[x]
  47F7  8D 01 08              STA   PSG_VOL                      ;[x]
  47FA  A9 80                 LDA   #$80                         ;[x]
  47FC  8D 04 08              STA   PSG_CTRL                     ;[x]
L02_47FF:
  47FF  60                    RTS                                ;[x]

  4800  20 06 48              JSR   L02_4806                     ;[x]
  4803  4C C3 41              JMP   L02_41C3                     ;[x]

L02_4806:
  4806  C8                    INY                                ;[x]
  4807  B1 56                 LDA   (<$56),Y                     ;[x]
L02_4809:
  4809  09 00                 ORA   #$00                         ;[x]
  480B  F0 0E                 BEQ   L02_481B                     ;[x]
  480D  E0 04                 CPX   #$04                         ;[x]
  480F  D0 03                 BNE   L02_4814                     ;[x]
  4811  9C 20 28              STZ   $2820                        ;[x]
L02_4814:
  4814  A9 80                 LDA   #$80                         ;[x]
  4816  1D 38 27              ORA   $2738,X                      ;[x]
  4819  80 05                 BRA   L02_4820                     ;[x]

L02_481B:
  481B  A9 7F                 LDA   #$7F                         ;[x]
  481D  3D 38 27              AND   $2738,X                      ;[x]
L02_4820:
  4820  9D 38 27              STA   $2738,X                      ;[x]
  4823  60                    RTS                                ;[x]

  4824  A9 01                 LDA   #$01                         ;[x]
  4826  1D 3F 27              ORA   $273F,X                      ;[x]
  4829  9D 3F 27              STA   $273F,X                      ;[x]
  482C  4C C3 41              JMP   L02_41C3                     ;[x]

  482F  C8                    INY                                ;[x]
  4830  B1 56                 LDA   (<$56),Y                     ;[x]
  4832  9D 54 27              STA   $2754,X                      ;[x]
  4835  4C C3 41              JMP   L02_41C3                     ;[x]

  4838  .db $C8,$B1,$56,$9D,$A8,$27,$4C,$C3,$41
L02_4841:
  4841  C8                    INY                                ;[x]
  4842  B1 56                 LDA   (<$56),Y                     ;[x]
  4844  9D 5B 27              STA   $275B,X                      ;[x]
  4847  4C C3 41              JMP   L02_41C3                     ;[x]

  484A  C8                    INY                                ;[x]
  484B  B1 56                 LDA   (<$56),Y                     ;[x]
  484D  20 EE 4A              JSR   L02_4AEE                     ;[x]
  4850  4C C3 41              JMP   L02_41C3                     ;[x]

  4853  AD 16 28              LDA   $2816                        ;[x]
  4856  D0 0A                 BNE   L02_4862                     ;[x]
  4858  A9 01                 LDA   #$01                         ;[x]
  485A  8D 16 28              STA   $2816                        ;[x]
  485D  A9 30                 LDA   #$30                         ;[x]
  485F  8D 17 28              STA   $2817                        ;[x]
L02_4862:
  4862  4C C3 41              JMP   L02_41C3                     ;[x]

  4865  20 D5 48              JSR   L02_48D5                     ;[x]
  4868  C8                    INY                                ;[x]
  4869  98                    TYA                                ;[x]
  486A  18                    CLC                                ;[x]
  486B  65 56                 ADC   <$56                         ;[x]
  486D  9D D2 27              STA   $27D2,X                      ;[x]
  4870  A9 00                 LDA   #$00                         ;[x]
  4872  65 57                 ADC   <$57                         ;[x]
  4874  9D D9 27              STA   $27D9,X                      ;[x]
  4877  BD 38 27              LDA   $2738,X                      ;[x]
  487A  09 08                 ORA   #$08                         ;[x]
  487C  9D 38 27              STA   $2738,X                      ;[x]
  487F  20 E2 48              JSR   L02_48E2                     ;[x]
  4882  4C C9 41              JMP   L02_41C9                     ;[x]

  4885  C8                    INY                                ;[x]
  4886  B1 56                 LDA   (<$56),Y                     ;[x]
  4888  30 08                 BMI   L02_4892                     ;[x]
  488A  FE FC 27              INC   $27FC,X                      ;[x]
  488D  DD FC 27              CMP   $27FC,X                      ;[x]
  4890  F0 2F                 BEQ   L02_48C1                     ;[x]
L02_4892:
  4892  BD 38 27              LDA   $2738,X                      ;[x]
  4895  4A                    LSR   A                            ;[x]
  4896  90 20                 BCC   L02_48B8                     ;[x]
  4898  BD FC 27              LDA   $27FC,X                      ;[x]
  489B  85 55                 STA   <$55                         ;[x]
  489D  C8                    INY                                ;[x]
  489E  B1 56                 LDA   (<$56),Y                     ;[x]
  48A0  48                    PHA                                ;[x]
  48A1  4A                    LSR   A                            ;[x]
  48A2  4A                    LSR   A                            ;[x]
  48A3  4A                    LSR   A                            ;[x]
  48A4  4A                    LSR   A                            ;[x]
  48A5  85 54                 STA   <$54                         ;[x]
  48A7  68                    PLA                                ;[x]
  48A8  29 0F                 AND   #$0F                         ;[x]
  48AA  C6 55                 DEC   <$55                         ;[x]
  48AC  F0 07                 BEQ   L02_48B5                     ;[x]
  48AE  18                    CLC                                ;[x]
L02_48AF:
  48AF  65 54                 ADC   <$54                         ;[x]
  48B1  C6 55                 DEC   <$55                         ;[x]
  48B3  D0 FA                 BNE   L02_48AF                     ;[x]
L02_48B5:
  48B5  9D 23 27              STA   $2723,X                      ;[x]
L02_48B8:
  48B8  20 D5 48              JSR   L02_48D5                     ;[x]
  48BB  20 E2 48              JSR   L02_48E2                     ;[x]
  48BE  4C C9 41              JMP   L02_41C9                     ;[x]

L02_48C1:
  48C1  A9 00                 LDA   #$00                         ;[x]
  48C3  9D FC 27              STA   $27FC,X                      ;[x]
  48C6  C8                    INY                                ;[x]
  48C7  C8                    INY                                ;[x]
  48C8  BD 38 27              LDA   $2738,X                      ;[x]
  48CB  4A                    LSR   A                            ;[x]
  48CC  90 04                 BCC   L02_48D2                     ;[x]
  48CE  9E 23 27              STZ   $2723,X                      ;[x]
  48D1  C8                    INY                                ;[x]
L02_48D2:
  48D2  4C C3 41              JMP   L02_41C3                     ;[x]

L02_48D5:
  48D5  C8                    INY                                ;[x]
  48D6  B1 56                 LDA   (<$56),Y                     ;[x]
  48D8  9D C4 27              STA   $27C4,X                      ;[x]
  48DB  C8                    INY                                ;[x]
  48DC  B1 56                 LDA   (<$56),Y                     ;[x]
  48DE  9D CB 27              STA   $27CB,X                      ;[x]
  48E1  60                    RTS                                ;[x]

L02_48E2:
  48E2  A0 00                 LDY   #$00                         ;[x]
  48E4  BD C4 27              LDA   $27C4,X                      ;[x]
  48E7  85 56                 STA   <$56                         ;[x]
  48E9  BD CB 27              LDA   $27CB,X                      ;[x]
  48EC  85 57                 STA   <$57                         ;[x]
  48EE  60                    RTS                                ;[x]

L02_48EF:
  48EF  BD D2 27              LDA   $27D2,X                      ;[x]
  48F2  85 56                 STA   <$56                         ;[x]
  48F4  BD D9 27              LDA   $27D9,X                      ;[x]
  48F7  85 57                 STA   <$57                         ;[x]
  48F9  BD 38 27              LDA   $2738,X                      ;[x]
  48FC  29 F7                 AND   #$F7                         ;[x]
  48FE  9D 38 27              STA   $2738,X                      ;[x]
  4901  A0 00                 LDY   #$00                         ;[x]
  4903  4C C9 41              JMP   L02_41C9                     ;[x]

  4906  BD 38 27              LDA   $2738,X                      ;[x]
  4909  29 08                 AND   #$08                         ;[x]
  490B  D0 E2                 BNE   L02_48EF                     ;[x]
  490D  BD 1C 27              LDA   $271C,X                      ;[x]
  4910  C9 FF                 CMP   #$FF                         ;[x]
  4912  F0 0F                 BEQ   L02_4923                     ;[x]
  4914  A9 00                 LDA   #$00                         ;[x]
  4916  9D 1C 27              STA   $271C,X                      ;[x]
  4919  8D 04 08              STA   PSG_CTRL                     ;[x]
  491C  E0 06                 CPX   #$06                         ;[x]
  491E  D0 03                 BNE   L02_4923                     ;[x]
  4920  20 35 40              JSR   L02_4035                     ;[x]
L02_4923:
  4923  60                    RTS                                ;[x]

L02_4924:
  4924  48                    PHA                                ;[x]
  4925  E0 00                 CPX   #$00                         ;[x]
  4927  D0 0D                 BNE   L02_4936                     ;[x]
  4929  AD 21 28              LDA   $2821                        ;[x]
  492C  C9 00                 CMP   #$00                         ;[x]
  492E  D0 03                 BNE   L02_4933                     ;[x]
L02_4930:
  4930  18                    CLC                                ;[x]
  4931  68                    PLA                                ;[x]
  4932  60                    RTS                                ;[x]

L02_4933:
  4933  38                    SEC                                ;[x]
  4934  68                    PLA                                ;[x]
  4935  60                    RTS                                ;[x]

L02_4936:
  4936  E0 05                 CPX   #$05                         ;[x]
  4938  D0 F6                 BNE   L02_4930                     ;[x]
  493A  AD 22 27              LDA   $2722                        ;[x]
  493D  D0 F4                 BNE   L02_4933                     ;[x]
  493F  80 EF                 BRA   L02_4930                     ;[x]

L02_4941:
  4941  62                    CLA                                ;[x]
  4942  8D 07 08              STA   PSG_NOISE                    ;[x]
  4945  AD 14 28              LDA   $2814                        ;[x]
  4948  8D 03 08              STA   PSG_FREQ_H                   ;[x]
  494B  AD 13 28              LDA   $2813                        ;[x]
  494E  8D 02 08              STA   PSG_FREQ_L                   ;[x]
  4951  60                    RTS                                ;[x]

L02_4952:
  4952  8A                    TXA                                ;[x]
  4953  C9 04                 CMP   #$04                         ;[x]
  4955  90 08                 BCC   L02_495F                     ;[x]
  4957  AD 13 28              LDA   $2813                        ;[x]
  495A  09 80                 ORA   #$80                         ;[x]
  495C  8D 07 08              STA   PSG_NOISE                    ;[x]
L02_495F:
  495F  60                    RTS                                ;[x]

L02_4960:
  4960  18                    CLC                                ;[x]
  4961  69 10                 ADC   #$10                         ;[x]
L02_4963:
  4963  48                    PHA                                ;[x]
  4964  BD 1C 27              LDA   $271C,X                      ;[x]
  4967  C9 4D                 CMP   #$4D                         ;[x]
  4969  68                    PLA                                ;[x]
  496A  90 08                 BCC   L02_4974                     ;[x]
  496C  38                    SEC                                ;[x]
  496D  ED 16 28              SBC   $2816                        ;[x]
  4970  10 02                 BPL   L02_4974                     ;[x]
  4972  A9 00                 LDA   #$00                         ;[x]
L02_4974:
  4974  09 80                 ORA   #$80                         ;[x]
  4976  8D 04 08              STA   PSG_CTRL                     ;[x]
  4979  60                    RTS                                ;[x]

L02_497A:
  497A  A2 08                 LDX   #$08                         ;[x]
  497C  A9 00                 LDA   #$00                         ;[x]
L02_497E:
  497E  26 55                 ROL   <$55                         ;[x]
  4980  2A                    ROL   A                            ;[x]
  4981  C5 54                 CMP   <$54                         ;[x]
  4983  90 02                 BCC   L02_4987                     ;[x]
  4985  E5 54                 SBC   <$54                         ;[x]
L02_4987:
  4987  CA                    DEX                                ;[x]
  4988  D0 F4                 BNE   L02_497E                     ;[x]
  498A  26 55                 ROL   <$55                         ;[x]
  498C  AE 11 28              LDX   $2811                        ;[x]
  498F  09 00                 ORA   #$00                         ;[x]
  4991  60                    RTS                                ;[x]

  4992  .db $5D,$0D,$9D,$0C,$E7,$0B,$3D,$0B,$9B,$0A,$03,$0A,$73,$09,$EB,$08
  49A2  .db $6A,$08,$F2,$07,$80,$07,$14,$07,$AF,$06,$4F,$06,$F4,$05,$9E,$05
  49B2  .db $4E,$05,$02,$05,$B9,$04,$76,$04,$35,$04,$F9,$03,$C0,$03,$8A,$03
  49C2  .db $57,$03,$27,$03,$FA,$02,$CF,$02,$A7,$02,$81,$02,$5D,$02,$3B,$02
  49D2  .db $1B,$02,$FC,$01,$E0,$01,$C5,$01,$AC,$01,$93,$01,$7D,$01,$68,$01
  49E2  .db $53,$01,$40,$01,$2E,$01,$1D,$01,$0D,$01,$FE,$00,$F0,$00,$E3,$00
  49F2  .db $D6,$00,$CA,$00,$BE,$00,$B4,$00,$AA,$00,$A0,$00,$97,$00,$8F,$00
  4A02  .db $87,$00,$7F,$00,$78,$00,$71,$00,$6B,$00,$65,$00,$5F,$00,$5A,$00
  4A12  .db $55,$00,$50,$00,$4B,$00,$46,$00,$43,$00,$40,$00,$3C,$00,$39,$00
  4A22  .db $35,$00,$32,$00,$30,$00,$2D,$00,$2A,$00,$28,$00,$26,$00,$24,$00
  4A32  .db $22,$00,$20,$00,$1E,$00,$1C,$00,$1B,$00,$19,$00,$18,$00,$17,$00
  4A42  .db $15,$00,$14,$00,$13,$00,$12,$00,$11,$00,$10,$00,$0F,$00,$0E,$00
  4A52  .db $84,$47,$84,$47,$84,$47,$84,$47,$9D,$47,$00,$48,$47,$47,$38,$48
  4A62  .db $F0,$46,$F0,$46,$F0,$46,$F0,$46,$F0,$46,$F0,$46,$85,$48,$06,$49
  4A72  .db $F0,$46,$F0,$46,$F0,$46,$F0,$46,$F0,$46,$F0,$46,$F0,$46,$FB,$46
  4A82  .db $0C,$47,$25,$47,$3E,$47,$47,$47,$F0,$46,$F0,$46,$F0,$46,$F0,$46
  4A92  .db $62,$47,$7B,$47,$F0,$46,$92,$47,$9D,$47,$F0,$46,$24,$48,$2F,$48
  4AA2  .db $41,$48,$F0,$46,$F0,$46,$4A,$48,$53,$48,$65,$48,$85,$48,$06,$49
L02_4AB2:
  4AB2  A2 06                 LDX   #$06                         ;[x]
  4AB4  62                    CLA                                ;[x]
  4AB5  8D 16 28              STA   $2816                        ;[x]
  4AB8  8D 21 28              STA   $2821                        ;[x]
L02_4ABB:
  4ABB  9D 1C 27              STA   $271C,X                      ;[x]
  4ABE  CA                    DEX                                ;[x]
  4ABF  10 FA                 BPL   L02_4ABB                     ;[x]
L02_4AC1:
  4AC1  A9 01                 LDA   #$01                         ;[x]
  4AC3  8D 12 28              STA   $2812                        ;[x]
  4AC6  A2 05                 LDX   #$05                         ;[x]
L02_4AC8:
  4AC8  8E 00 08              STX   PSG_CH                       ;[x]
  4ACB  A9 00                 LDA   #$00                         ;[x]
  4ACD  8D 04 08              STA   PSG_CTRL                     ;[x]
  4AD0  CA                    DEX                                ;[x]
  4AD1  10 F5                 BPL   L02_4AC8                     ;[x]
  4AD3  A9 00                 LDA   #$00                         ;[x]
  4AD5  8D 09 08              STA   PSG_LFO_C                    ;[x]
  4AD8  A9 00                 LDA   #$00                         ;[x]
  4ADA  8D 12 28              STA   $2812                        ;[x]
  4ADD  60                    RTS                                ;[x]

L02_4ADE:
  4ADE  AD 16 28              LDA   $2816                        ;[x]
  4AE1  D0 0A                 BNE   L02_4AED                     ;[x]
  4AE3  A9 01                 LDA   #$01                         ;[x]
  4AE5  8D 16 28              STA   $2816                        ;[x]
  4AE8  A9 30                 LDA   #$30                         ;[x]
  4AEA  8D 17 28              STA   $2817                        ;[x]
L02_4AED:
  4AED  60                    RTS                                ;[x]

L02_4AEE:
  4AEE  C9 FF                 CMP   #$FF                         ;[x]
  4AF0  F0 C0                 BEQ   L02_4AB2                     ;[x]
  4AF2  C9 FE                 CMP   #$FE                         ;[x]
  4AF4  F0 E8                 BEQ   L02_4ADE                     ;[x]
  4AF6  C9 AA                 CMP   #$AA                         ;[x]
  4AF8  90 01                 BCC   L02_4AFB                     ;[x]
  4AFA  60                    RTS                                ;[ ]

L02_4AFB:
  4AFB  DA                    PHX                                ;[x]
  4AFC  5A                    PHY                                ;[x]
  4AFD  48                    PHA                                ;[x]
  4AFE  AD 44 28              LDA   $2844                        ;[x]
  4B01  F0 04                 BEQ   L02_4B07                     ;[x]
  4B03  68                    PLA                                ;[ ]
  4B04  7A                    PLY                                ;[ ]
  4B05  FA                    PLX                                ;[ ]
  4B06  60                    RTS                                ;[ ]

L02_4B07:
  4B07  A9 01                 LDA   #$01                         ;[x]
  4B09  8D 44 28              STA   $2844                        ;[x]
  4B0C  AD 0B 28              LDA   $280B                        ;[x]
  4B0F  F0 10                 BEQ   L02_4B21                     ;[x]
  4B11  68                    PLA                                ;[ ]
  4B12  C9 3E                 CMP   #$3E                         ;[ ]
  4B14  F0 0C                 BEQ   L02_4B22                     ;[ ]
  4B16  B0 03                 BCS   L02_4B1B                     ;[ ]
  4B18  4C 1F 4C              JMP   L02_4C1F                     ;[ ]

L02_4B1B:
  4B1B  8D 0A 28              STA   $280A                        ;[ ]
  4B1E  4C 1F 4C              JMP   L02_4C1F                     ;[ ]

L02_4B21:
  4B21  68                    PLA                                ;[x]
L02_4B22:
  4B22  8D 0A 28              STA   $280A                        ;[x]
  4B25  A9 9A                 LDA   #$9A                         ;[x]
  4B27  85 50                 STA   <$50                         ;[x]
  4B29  A9 B6                 LDA   #$B6                         ;[x]
  4B2B  85 51                 STA   <$51                         ;[x]
  4B2D  A2 03                 LDX   #$03                         ;[x]
L02_4B2F:
  4B2F  AD 0A 28              LDA   $280A                        ;[x]
  4B32  18                    CLC                                ;[x]
  4B33  65 50                 ADC   <$50                         ;[x]
  4B35  85 50                 STA   <$50                         ;[x]
  4B37  A9 00                 LDA   #$00                         ;[x]
  4B39  65 51                 ADC   <$51                         ;[x]
  4B3B  85 51                 STA   <$51                         ;[x]
  4B3D  CA                    DEX                                ;[x]
  4B3E  D0 EF                 BNE   L02_4B2F                     ;[x]
  4B40  C2                    CLY                                ;[x]
  4B41  B1 50                 LDA   (<$50),Y                     ;[x]
  4B43  4A                    LSR   A                            ;[x]
  4B44  4A                    LSR   A                            ;[x]
  4B45  4A                    LSR   A                            ;[x]
  4B46  4A                    LSR   A                            ;[x]
  4B47  29 07                 AND   #$07                         ;[x]
L02_4B49:
  4B49  48                    PHA                                ;[x]
  4B4A  B1 50                 LDA   (<$50),Y                     ;[x]
  4B4C  29 07                 AND   #$07                         ;[x]
  4B4E  AA                    TAX                                ;[x]
  4B4F  AD 0A 28              LDA   $280A                        ;[x]
  4B52  C9 3E                 CMP   #$3E                         ;[x]
  4B54  F0 68                 BEQ   L02_4BBE                     ;[x]
  4B56  B0 69                 BCS   L02_4BC1                     ;[x]
  4B58  C9 0B                 CMP   #$0B                         ;[x]
  4B5A  B0 59                 BCS   L02_4BB5                     ;[x]
  4B5C  A9 01                 LDA   #$01                         ;[x]
  4B5E  8D 12 28              STA   $2812                        ;[x]
  4B61  C8                    INY                                ;[x]
  4B62  B1 50                 LDA   (<$50),Y                     ;[x]
  4B64  85 5C                 STA   <$5C                         ;[x]
  4B66  C8                    INY                                ;[x]
  4B67  B1 50                 LDA   (<$50),Y                     ;[x]
  4B69  85 5D                 STA   <$5D                         ;[x]
  4B6B  A9 00                 LDA   #$00                         ;[x]
  4B6D  8D 00 08              STA   PSG_CH                       ;[x]
  4B70  A9 40                 LDA   #$40                         ;[x]
  4B72  8D 04 08              STA   PSG_CTRL                     ;[x]
  4B75  62                    CLA                                ;[x]
  4B76  8D 06 08              STA   PSG_WAVE                     ;[x]
  4B79  8D 07 08              STA   PSG_NOISE                    ;[x]
  4B7C  1A                    INC   A                            ;[x]
  4B7D  8D 21 28              STA   $2821                        ;[x]
  4B80  A9 1F                 LDA   #$1F                         ;[x]
  4B82  38                    SEC                                ;[x]
  4B83  09 C0                 ORA   #$C0                         ;[x]
  4B85  8D 04 08              STA   PSG_CTRL                     ;[x]
  4B88  A9 FF                 LDA   #$FF                         ;[x]
  4B8A  8D 05 08              STA   PSG_PAN                      ;[x]
  4B8D  AD 11 28              LDA   $2811                        ;[x]
  4B90  8D 00 08              STA   PSG_CH                       ;[x]
  4B93  A9 FF                 LDA   #$FF                         ;[x]
  4B95  9D 1C 27              STA   $271C,X                      ;[x]
  4B98  8D 01 08              STA   PSG_VOL                      ;[x]
  4B9B  AD B2 4B              LDA   $4BB2                        ;[x]
  4B9E  8D C4 27              STA   $27C4                        ;[x]
  4BA1  AD B3 4B              LDA   $4BB3                        ;[x]
  4BA4  8D CB 27              STA   $27CB                        ;[x]
  4BA7  A9 00                 LDA   #$00                         ;[x]
  4BA9  9D 38 27              STA   $2738,X                      ;[x]
  4BAC  8D 12 28              STA   $2812                        ;[x]
  4BAF  68                    PLA                                ;[x]
  4BB0  F0 68                 BEQ   L02_4C1A                     ;[x]
  4BB2  B4 4B                 LDY   <$4B,X                       ;[ ]
  4BB4  FF DD 1C              BBS7  <$DD,L02_4BD3                ;[ ]
  4BB7  27 B0                 RMB2  <$B0                         ;[ ]
  4BB9  07 C8                 RMB0  <$C8                         ;[ ]
  4BBB  C8                    INY                                ;[x]
  4BBC  80 48                 BRA   L02_4C06                     ;[x]

L02_4BBE:
  4BBE  9C 21 28              STZ   $2821                        ;[ ]
L02_4BC1:
  4BC1  9D 1C 27              STA   $271C,X                      ;[x]
  4BC4  C8                    INY                                ;[x]
  4BC5  B1 50                 LDA   (<$50),Y                     ;[x]
  4BC7  9D C4 27              STA   $27C4,X                      ;[x]
  4BCA  85 52                 STA   <$52                         ;[x]
  4BCC  C8                    INY                                ;[x]
  4BCD  B1 50                 LDA   (<$50),Y                     ;[x]
  4BCF  9D CB 27              STA   $27CB,X                      ;[x]
  4BD2  85 53                 STA   <$53                         ;[x]
  4BD4  A9 00                 LDA   #$00                         ;[x]
  4BD6  9D FC 27              STA   $27FC,X                      ;[x]
  4BD9  9D 23 27              STA   $2723,X                      ;[x]
  4BDC  9D 77 27              STA   $2777,X                      ;[x]
  4BDF  9D A8 27              STA   $27A8,X                      ;[x]
  4BE2  9D 3F 27              STA   $273F,X                      ;[x]
  4BE5  9D 00 27              STA   $2700,X                      ;[x]
  4BE8  9D 07 27              STA   $2707,X                      ;[x]
  4BEB  9D 46 27              STA   $2746,X                      ;[x]
  4BEE  9D 54 27              STA   $2754,X                      ;[x]
  4BF1  9D 03 28              STA   $2803,X                      ;[x]
  4BF4  9D 4D 27              STA   $274D,X                      ;[x]
  4BF7  5A                    PHY                                ;[x]
  4BF8  C2                    CLY                                ;[x]
  4BF9  B1 52                 LDA   (<$52),Y                     ;[x]
  4BFB  7A                    PLY                                ;[x]
  4BFC  29 80                 AND   #$80                         ;[x]
  4BFE  49 80                 EOR   #$80                         ;[x]
  4C00  18                    CLC                                ;[x]
  4C01  2A                    ROL   A                            ;[x]
  4C02  2A                    ROL   A                            ;[x]
  4C03  9D 38 27              STA   $2738,X                      ;[x]
L02_4C06:
  4C06  C8                    INY                                ;[x]
  4C07  68                    PLA                                ;[x]
  4C08  3A                    DEC   A                            ;[x]
  4C09  30 03                 BMI   L02_4C0E                     ;[x]
  4C0B  4C 49 4B              JMP   L02_4B49                     ;[x]

L02_4C0E:
  4C0E  AD 0A 28              LDA   $280A                        ;[x]
  4C11  C9 4D                 CMP   #$4D                         ;[x]
  4C13  90 05                 BCC   L02_4C1A                     ;[x]
  4C15  A9 00                 LDA   #$00                         ;[x]
  4C17  8D 16 28              STA   $2816                        ;[x]
L02_4C1A:
  4C1A  A9 00                 LDA   #$00                         ;[x]
  4C1C  8D 0A 28              STA   $280A                        ;[x]
L02_4C1F:
  4C1F  9C 44 28              STZ   $2844                        ;[x]
  4C22  7A                    PLY                                ;[x]
  4C23  FA                    PLX                                ;[x]
  4C24  60                    RTS                                ;[x]

  4C25  .db $F1,$C0,$AC,$AC,$AC,$AC,$AC,$F3,$08,$FE,$FF,$55,$4C,$F1,$C0,$AC
  4C35  .db $AC,$AC,$AC,$F3,$06,$FE,$FF,$55,$4C,$F1,$C0,$AC,$AC,$9C,$F3,$04
  4C45  .db $FE,$FF,$55,$4C,$F1,$C0,$AC,$8C,$F3,$02,$FE,$FF,$55,$4C,$EA,$01
  4C55  .db $F1,$C0,$F4,$31,$E7,$00,$10,$E8,$00,$E9,$00,$EB,$DD,$D1,$00,$D3
  4C65  .db $B0,$D1,$10,$D3,$B0,$EB,$EE,$D1,$20,$D3,$A0,$D1,$30,$D3,$A0,$EB
  4C75  .db $FF,$D1,$40,$D3,$90,$D1,$50,$D3,$90,$D1,$60,$D3,$80,$D1,$70,$D3
  4C85  .db $80,$D1,$80,$D3,$70,$D1,$90,$D3,$70,$D1,$A0,$D3,$60,$D1,$B0,$D3
  4C95  .db $60,$D2,$00,$D3,$50,$D2,$10,$D3,$50,$D2,$20,$D3,$40,$D2,$30,$D3
  4CA5  .db $40,$D2,$40,$D3,$30,$D2,$50,$D3,$30,$D2,$60,$D3,$20,$D2,$70,$D3
  4CB5  .db $20,$D2,$80,$D3,$10,$D2,$90,$D3,$10,$D2,$A0,$D3,$00,$D2,$B0,$D3
  4CC5  .db $00,$D3,$00,$D3,$B0,$D3,$10,$D2,$B0,$D3,$20,$D3,$A0,$D3,$30,$D2
  4CD5  .db $A0,$D3,$40,$D3,$90,$D3,$50,$D2,$90,$D3,$60,$D3,$80,$D3,$70,$D2
  4CE5  .db $80,$D3,$80,$D3,$70,$D3,$90,$D2,$70,$D3,$A0,$D3,$60,$D3,$B0,$D2
  4CF5  .db $60,$D3,$B0,$D3,$50,$D3,$A0,$D2,$50,$D3,$90,$D3,$40,$D3,$80,$D2
  4D05  .db $40,$D3,$70,$D3,$30,$D3,$60,$D2,$30,$D3,$50,$D3,$20,$D3,$40,$D2
  4D15  .db $20,$D3,$30,$D3,$10,$D3,$20,$D2,$10,$D3,$10,$D3,$00,$D3,$00,$D2
  4D25  .db $00,$D2,$B0,$D2,$B0,$D2,$A0,$D1,$B0,$D2,$90,$D2,$A0,$D2,$80,$D1
  4D35  .db $A0,$D2,$70,$D2,$90,$D2,$60,$D1,$90,$D2,$50,$D2,$80,$D2,$40,$D1
  4D45  .db $80,$D2,$30,$D2,$70,$D2,$20,$D1,$70,$D2,$10,$D2,$60,$D2,$00,$D1
  4D55  .db $60,$D1,$B0,$D2,$50,$D1,$A0,$D1,$50,$EB,$EE,$D1,$90,$D1,$40,$D1
  4D65  .db $80,$D1,$40,$EB,$DD,$D1,$70,$D1,$30,$D1,$60,$D1,$30,$EB,$CC,$D1
  4D75  .db $50,$D1,$20,$D1,$40,$D1,$20,$EB,$BB,$D1,$30,$D1,$10,$D1,$20,$D1
  4D85  .db $10,$EB,$AA,$D1,$10,$D1,$00,$D1,$00,$D1,$00,$FF,$F0,$01,$F1,$10
  4D95  .db $D0,$14,$14,$14,$14,$24,$24,$24,$24,$34,$34,$34,$34,$44,$44,$44
  4DA5  .db $44,$54,$54,$54,$54,$64,$64,$64,$64,$74,$74,$74,$74,$84,$84,$84
  4DB5  .db $84,$94,$94,$94,$94,$A4,$A4,$A4,$A4,$B4,$B4,$B4,$B4,$D1,$14,$14
  4DC5  .db $14,$14,$24,$24,$24,$24,$34,$34,$34,$34,$44,$44,$44,$44,$54,$54
  4DD5  .db $54,$54,$64,$64,$64,$64,$74,$74,$74,$74,$84,$84,$84,$84,$94,$94
  4DE5  .db $94,$94,$A4,$A4,$A4,$A4,$B4,$B4,$B4,$B4,$FF,$FF,$E7,$03,$77,$F1
  4DF5  .db $38,$E8,$03,$E9,$03,$F4,$06,$D6,$EB,$DD,$04,$FF,$D5,$58,$78,$88
  4E05  .db $A8,$06,$D4,$F6,$B9,$F6,$BA,$A6,$F6,$99,$F6,$9A,$D5,$06,$F6,$B6
  4E15  .db $F6,$BA,$D6,$16,$F6,$06,$F6,$0A,$FF,$F1,$60,$F3,$00,$F4,$01,$E7
  4E25  .db $05,$11,$E8,$01,$E9,$01,$EB,$FF,$EA,$00,$D3,$04,$EA,$02,$04,$EA
  4E35  .db $04,$04,$EA,$05,$04,$EA,$07,$04,$EA,$09,$04,$EA,$0B,$04,$EA,$10
  4E45  .db $04,$24,$44,$54,$74,$94,$B4,$FE,$80,$2D,$4E,$D4,$E7,$18,$10,$E8
  4E55  .db $01,$E9,$11,$EB,$FF,$F4,$32,$E4,$0A,$2A,$4A,$5A,$7A,$9A,$BA,$E3
  4E65  .db $0A,$2A,$4A,$5A,$7A,$9A,$BA,$E2,$0A,$2A,$4A,$5A,$7A,$9A,$BA,$E1
  4E75  .db $0A,$2A,$4A,$5A,$7A,$9A,$BA,$FF,$FF,$D4,$E7,$18,$10,$E8,$01,$E9
  4E85  .db $11,$EB,$AA,$F4,$32,$C4,$E4,$0A,$2A,$4A,$5A,$7A,$9A,$BA,$E3,$0A
  4E95  .db $2A,$4A,$5A,$7A,$9A,$BA,$E2,$0A,$2A,$4A,$5A,$7A,$9A,$BA,$E1,$0A
  4EA5  .db $2A,$4A,$5A,$7A,$9A,$BA,$FF,$FF,$D2,$E7,$06,$10,$E8,$03,$E9,$01
  4EB5  .db $EB,$FF,$F4,$2A,$EA,$00,$E6,$04,$E5,$04,$E6,$24,$E5,$24,$E6,$44
  4EC5  .db $E5,$44,$E6,$54,$E5,$54,$E6,$74,$E5,$74,$E6,$94,$E5,$94,$E6,$B4
  4ED5  .db $E5,$B4,$FF,$F1,$40,$E7,$05,$40,$F4,$10,$E8,$00,$E9,$01,$EB,$99
  4EE5  .db $D3,$B6,$EB,$DD,$D4,$B6,$EB,$CC,$B6,$E7,$02,$40,$EB,$88,$D3,$F6
  4EF5  .db $B4,$F6,$B8,$FF,$F1,$40,$C2,$E7,$05,$80,$F4,$10,$E8,$00,$E9,$01
  4F05  .db $EB,$AA,$D4,$06,$EB,$EE,$D5,$06,$E7,$02,$80,$EB,$BB,$D4,$F6,$74
  4F15  .db $F6,$78,$FF,$F1,$40,$C4,$E7,$05,$80,$F4,$10,$E8,$00,$E9,$01,$EB
  4F25  .db $BB,$D4,$46,$EB,$FF,$D5,$46,$E7,$02,$80,$EB,$AA,$D4,$F6,$44,$F6
  4F35  .db $48,$FF,$F1,$40,$C5,$E7,$05,$80,$F4,$10,$E8,$00,$E9,$01,$EB,$CC
  4F45  .db $D4,$76,$EB,$EE,$D5,$06,$E7,$02,$80,$EB,$99,$D4,$F6,$04,$F6,$08
  4F55  .db $FF,$F1,$40,$C0,$E7,$00,$C0,$F4,$10,$E8,$01,$E9,$01,$EB,$88,$D3
  4F65  .db $B4,$EB,$AA,$D4,$44,$EB,$CC,$B4,$EB,$DD,$D5,$44,$EB,$BB,$D4,$B4
  4F75  .db $EB,$99,$44,$E7,$03,$C0,$EB,$77,$D3,$B8,$FF,$F1,$40,$C0,$C1,$E7
  4F85  .db $00,$C0,$F4,$10,$E8,$01,$E9,$01,$EB,$99,$D4,$04,$EB,$BB,$74,$EB
  4F95  .db $DD,$D5,$04,$04,$EB,$AA,$D4,$74,$EB,$88,$04,$FF,$F1,$50,$E7,$03
  4FA5  .db $77,$F4,$10,$E8,$00,$E9,$02,$EB,$00,$D3,$92,$72,$04,$F1,$38,$E8
  4FB5  .db $03,$E9,$03,$F4,$06,$D4,$EB,$EE,$72,$D5,$EB,$DD,$04,$FF,$F1,$A0
  4FC5  .db $E7,$03,$77,$F4,$03,$E8,$02,$E9,$04,$EB,$EE,$D5,$92,$D4,$92,$D5
  4FD5  .db $72,$D4,$72,$D5,$02,$D4,$02,$F1,$38,$E8,$03,$E9,$03,$EB,$00,$D4
  4FE5  .db $52,$F1,$A0,$C2,$F1,$38,$EB,$AA,$72,$D5,$EB,$99,$04,$FF,$EB,$FF
  4FF5  .db $F1,$90,$F4,$10,$E8,$00,$E9,$05,$E7,$06,$44,$D4,$52,$02,$52,$92
  5005  .db $D5,$58,$FF,$F1,$50,$EB,$AA,$F7,$02,$C5,$FE,$FF,$F5,$4F,$F1,$50
  5015  .db $EB,$77,$F7,$01,$C5,$C5,$FE,$FF,$F5,$4F,$EB,$BB,$EA,$10,$FE,$FF
  5025  .db $F5,$4F,$F1,$50,$EB,$99,$EA,$10,$F7,$01,$C5,$FE,$FF,$F5,$4F,$F1
  5035  .db $50,$EB,$66,$EA,$10,$F7,$00,$C5,$C5,$FE,$FF,$F5,$4F,$F1,$34,$E7
  5045  .db $03,$10,$E8,$09,$E9,$07,$EA,$70,$F3,$01,$F4,$1B,$EB,$99,$E7,$03
  5055  .db $10,$F7,$04,$C3,$D4,$24,$44,$64,$90,$F4,$05,$F7,$00,$E7,$07,$10
  5065  .db $D4,$EB,$DD,$64,$67,$F4,$1B,$EB,$99,$E7,$03,$10,$F7,$04,$C3,$D4
  5075  .db $04,$24,$44,$70,$F4,$05,$F7,$00,$E7,$07,$10,$D4,$EB,$DD,$44,$47
  5085  .db $F4,$1B,$EB,$99,$E7,$03,$10,$F7,$04,$C3,$D4,$24,$44,$64,$90,$E7
  5095  .db $07,$10,$F4,$05,$F7,$00,$D4,$EB,$DD,$64,$67,$E7,$03,$10,$F4,$1B
  50A5  .db $EB,$99,$F7,$04,$C3,$D4,$74,$44,$04,$D4,$70,$E7,$07,$10,$F4,$05
  50B5  .db $F7,$00,$D4,$EB,$DD,$94,$97,$E7,$03,$10,$F4,$1B,$EB,$99,$F7,$04
  50C5  .db $C3,$D5,$64,$24,$D4,$B4,$60,$E7,$07,$10,$F4,$05,$F7,$00,$D4,$EB
  50D5  .db $DD,$B4,$B7,$E7,$03,$10,$F4,$1B,$EB,$99,$F4,$05,$F7,$04,$C3,$D5
  50E5  .db $44,$14,$D4,$94,$60,$E7,$07,$10,$F4,$05,$F7,$00,$D4,$EB,$DD,$94
  50F5  .db $F6,$94,$FC,$F6,$96,$E8,$0A,$D5,$EB,$DD,$48,$D4,$A8,$D5,$28,$18
  5105  .db $E8,$09,$FF,$F1,$34,$E7,$07,$40,$E8,$0A,$E9,$06,$F4,$16,$EA,$70
  5115  .db $EB,$DD,$F3,$01,$FE,$FF,$33,$51,$F1,$34,$E7,$07,$40,$E8,$00,$E9
  5125  .db $06,$F4,$16,$F7,$03,$EA,$70,$F4,$05,$EB,$CC,$F3,$02,$C3,$D3,$F6
  5135  .db $98,$F6,$94,$94,$B4,$D4,$04,$D4,$F6,$28,$F6,$24,$04,$D3,$B2,$D4
  5145  .db $02,$D3,$B2,$72,$D3,$F6,$98,$F6,$94,$94,$D4,$24,$64,$77,$64,$44
  5155  .db $64,$74,$94,$D4,$6D,$7D,$6D,$28,$D3,$B4,$D4,$24,$E4,$4D,$6D,$4D
  5165  .db $18,$D3,$B4,$D4,$14,$D4,$2D,$4D,$2D,$D3,$BD,$D4,$1D,$2D,$7D,$6D
  5175  .db $7D,$D5,$2D,$0D,$D4,$AD,$9A,$FF,$F1,$34,$E7,$07,$10,$E8,$09,$E9
  5185  .db $05,$F4,$1A,$EA,$70,$EB,$FF,$F3,$01,$D2,$F6,$29,$F6,$24,$24,$D2
  5195  .db $F6,$09,$F6,$04,$04,$D2,$F6,$29,$F6,$24,$24,$D2,$08,$28,$D2,$F6
  51A5  .db $79,$F6,$74,$74,$D2,$F6,$69,$F6,$64,$64,$D2,$F6,$49,$F6,$44,$44
  51B5  .db $D1,$9A,$FF,$F1,$34,$F0,$01,$F3,$01,$14,$44,$C4,$44,$24,$44,$C4
  51C5  .db $44,$14,$44,$C4,$44,$24,$26,$44,$14,$44,$C4,$44,$24,$44,$C4,$44
  51D5  .db $14,$26,$14,$54,$64,$74,$24,$14,$44,$C4,$44,$24,$44,$C4,$44,$14
  51E5  .db $44,$C4,$44,$24,$26,$44,$64,$74,$26,$14,$24,$24,$24,$14,$26,$14
  51F5  .db $54,$64,$74,$24,$FF,$F1,$34,$E7,$03,$10,$E8,$09,$E9,$07,$EA,$70
  5205  .db $F3,$01,$F4,$1B,$EB,$CC,$D4,$24,$44,$64,$94,$F4,$05,$E7,$07,$10
  5215  .db $D5,$EB,$DD,$24,$27,$F4,$1B,$E7,$03,$10,$EB,$CC,$D4,$04,$24,$44
  5225  .db $74,$F4,$05,$E7,$07,$10,$D5,$EB,$DD,$04,$07,$F4,$1B,$E7,$03,$10
  5235  .db $EB,$CC,$D4,$24,$44,$64,$94,$F4,$05,$E7,$07,$10,$D5,$EB,$DD,$24
  5245  .db $27,$F4,$1B,$E7,$03,$10,$EB,$CC,$D4,$74,$44,$04,$D4,$74,$F4,$05
  5255  .db $E7,$07,$10,$D5,$EB,$DD,$24,$27,$F4,$1B,$E7,$03,$10,$EB,$CC,$D5
  5265  .db $64,$24,$D4,$B4,$64,$F4,$05,$E7,$07,$10,$D5,$EB,$DD,$74,$77,$F4
  5275  .db $1B,$E7,$03,$10,$EB,$CC,$D5,$44,$14,$D4,$94,$64,$F4,$05,$E7,$07
  5285  .db $10,$D5,$EB,$DD,$64,$77,$F4,$1B,$E7,$03,$10,$EB,$CC,$D6,$B4,$74
  5295  .db $24,$D5,$B4,$74,$24,$D3,$A4,$74,$D6,$94,$44,$24,$D5,$94,$D6,$94
  52A5  .db $44,$14,$D5,$94,$FF,$F1,$44,$E7,$07,$30,$E8,$00,$E9,$06,$F4,$16
  52B5  .db $F7,$03,$EA,$70,$EB,$BB,$F3,$01,$C3,$D4,$99,$D5,$04,$D4,$BA,$C4
  52C5  .db $A6,$66,$A6,$D5,$04,$D4,$F6,$90,$F6,$98,$EB,$DD,$F6,$02,$22,$42
  52D5  .db $52,$72,$92,$A2,$F6,$B2,$C3,$EB,$BB,$D5,$09,$54,$2A,$C4,$F4,$05
  52E5  .db $E7,$05,$21,$D4,$27,$24,$27,$26,$44,$46,$F6,$02,$22,$42,$52,$72
  52F5  .db $92,$A2,$D5,$F6,$02,$D4,$57,$54,$57,$56,$74,$76,$F6,$02,$22,$42
  5305  .db $52,$72,$92,$A2,$D5,$F6,$02,$F4,$1D,$E7,$07,$30,$F3,$01,$D4,$99
  5315  .db $D5,$06,$D4,$A6,$96,$76,$56,$76,$24,$76,$24,$79,$76,$96,$A7,$F6
  5325  .db $D5,$04,$F6,$08,$17,$F6,$34,$F6,$38,$F6,$0A,$F6,$0A,$D4,$99,$D5
  5335  .db $06,$D4,$A6,$96,$76,$56,$76,$24,$76,$24,$79,$76,$96,$A7,$D5,$57
  5345  .db $A8,$A6,$96,$76,$94,$54,$F6,$04,$F6,$08,$EB,$BB,$E7,$05,$11,$F4
  5355  .db $10,$E8,$00,$E9,$01,$D5,$A4,$94,$54,$09,$EB,$BB,$F3,$01,$E7,$07
  5365  .db $11,$C6,$D5,$56,$4E,$2E,$0E,$26,$56,$4E,$0E,$4E,$C6,$56,$4E,$2E
  5375  .db $0E,$2E,$D4,$AE,$D5,$2E,$4E,$0E,$4E,$C6,$86,$7E,$5E,$3E,$56,$86
  5385  .db $7E,$3E,$7E,$C4,$14,$54,$84,$D6,$06,$D5,$76,$A6,$56,$7E,$9E,$AE
  5395  .db $BE,$D6,$2E,$D5,$BE,$D6,$1E,$D5,$9E,$6E,$4E,$BE,$D6,$2E,$6E,$1E
  53A5  .db $D5,$9E,$F4,$05,$E8,$00,$E9,$06,$E7,$05,$21,$EB,$BB,$D4,$58,$78
  53B5  .db $88,$A8,$D5,$06,$D4,$F6,$B9,$F6,$BA,$A6,$F6,$99,$F6,$9A,$D5,$06
  53C5  .db $D4,$F6,$B9,$F6,$BA,$D5,$16,$F6,$09,$F6,$0A,$FE,$FF,$E3,$52,$F1
  53D5  .db $44,$E7,$07,$30,$E8,$0A,$E9,$06,$F4,$16,$EA,$70,$EB,$DD,$F3,$01
  53E5  .db $D4,$99,$D5,$04,$D4,$B7,$F4,$05,$E7,$05,$21,$D5,$26,$26,$26,$F4
  53F5  .db $16,$E7,$07,$30,$D4,$A6,$66,$A6,$D5,$04,$D4,$97,$F4,$05,$E7,$05
  5405  .db $21,$D5,$06,$06,$06,$F4,$16,$E7,$07,$30,$D5,$09,$54,$27,$F4,$05
  5415  .db $E7,$05,$21,$D5,$26,$26,$26,$F4,$05,$E7,$05,$21,$D4,$27,$24,$27
  5425  .db $26,$44,$46,$F6,$02,$22,$42,$52,$72,$92,$A2,$D5,$F6,$02,$D4,$57
  5435  .db $54,$57,$56,$74,$76,$F6,$02,$22,$42,$52,$72,$92,$A2,$D5,$F6,$02
  5445  .db $F4,$1D,$E7,$07,$30,$F3,$00,$D4,$99,$D5,$06,$D4,$A6,$96,$76,$56
  5455  .db $76,$24,$76,$24,$79,$76,$96,$A7,$F6,$D5,$04,$F6,$08,$17,$F6,$34
  5465  .db $F6,$38,$06,$F4,$05,$E7,$05,$21,$E8,$0A,$E9,$06,$EB,$BB,$D4,$74
  5475  .db $46,$74,$44,$74,$C4,$D3,$74,$76,$D5,$04,$07,$F4,$1D,$E7,$07,$30
  5485  .db $EB,$DD,$D4,$99,$D5,$06,$D4,$A6,$96,$76,$56,$76,$24,$76,$24,$79
  5495  .db $76,$96,$A7,$D5,$57,$A8,$A6,$96,$76,$94,$54,$F6,$04,$F6,$08,$EB
  54A5  .db $DD,$E7,$05,$11,$F4,$10,$E8,$00,$E9,$01,$D5,$A4,$94,$54,$09,$EB
  54B5  .db $EE,$E7,$07,$11,$F3,$01,$C6,$D5,$56,$4E,$2E,$0E,$26,$56,$4E,$0E
  54C5  .db $4E,$C6,$56,$4E,$2E,$0E,$2E,$D4,$AE,$D5,$2E,$4E,$0E,$4E,$C6,$86
  54D5  .db $7E,$5E,$3E,$56,$86,$7E,$3E,$7E,$C4,$14,$54,$84,$D6,$06,$D5,$76
  54E5  .db $A6,$56,$7E,$9E,$AE,$BE,$D6,$2E,$D5,$BE,$D6,$1E,$D5,$9E,$6E,$4E
  54F5  .db $BE,$D6,$2E,$6E,$1E,$D5,$9E,$F4,$05,$E8,$0A,$E9,$06,$E7,$05,$21
  5505  .db $EB,$DD,$D4,$58,$78,$88,$A8,$D5,$06,$D4,$B6,$D5,$76,$26,$76,$26
  5515  .db $76,$26,$D4,$A6,$96,$D5,$56,$06,$56,$06,$56,$06,$D5,$06,$D4,$B6
  5525  .db $D5,$76,$26,$76,$26,$76,$26,$D5,$16,$06,$D5,$56,$06,$56,$06,$56
  5535  .db $06,$FE,$FF,$1C,$54,$F1,$44,$E7,$07,$10,$E8,$09,$E9,$05,$F4,$1A
  5545  .db $EA,$70,$EB,$FF,$F3,$03,$FD,$A3,$56,$F3,$03,$D2,$A4,$14,$64,$12
  5555  .db $D1,$A4,$A4,$D2,$12,$D1,$A4,$D2,$56,$54,$F3,$01,$D2,$54,$D1,$54
  5565  .db $D2,$54,$D1,$54,$D2,$54,$D1,$54,$F3,$03,$FD,$A3,$56,$F3,$02,$D1
  5575  .db $A4,$A4,$A4,$54,$A4,$54,$94,$A6,$D2,$04,$04,$04,$04,$D1,$74,$44
  5585  .db $D2,$04,$D1,$A4,$A4,$A4,$54,$A4,$54,$94,$A6,$D2,$04,$04,$04,$54
  5595  .db $44,$24,$04,$D2,$57,$54,$57,$54,$57,$56,$04,$56,$D1,$A7,$A4,$A7
  55A5  .db $A4,$A7,$94,$D2,$26,$06,$17,$14,$17,$14,$D1,$A7,$A4,$A7,$A4,$D2
  55B5  .db $07,$D3,$06,$D2,$86,$76,$76,$46,$46,$04,$57,$54,$57,$54,$57,$56
  55C5  .db $56,$54,$D1,$A7,$A4,$A7,$A4,$A6,$96,$D2,$26,$06,$27,$24,$D1,$A7
  55D5  .db $A4,$D2,$57,$56,$16,$D1,$A4,$D2,$57,$54,$57,$54,$54,$54,$04,$54
  55E5  .db $C4,$56,$54,$D1,$A4,$A6,$A4,$A4,$A6,$A4,$D1,$74,$76,$74,$94,$96
  55F5  .db $94,$D1,$A4,$A6,$A4,$A4,$A6,$A4,$D1,$74,$94,$A4,$D2,$24,$04,$24
  5605  .db $44,$04,$D1,$A4,$A6,$A4,$D2,$04,$06,$04,$D2,$24,$26,$24,$04,$06
  5615  .db $04,$D1,$A4,$A6,$A4,$D2,$04,$06,$04,$D2,$14,$16,$14,$34,$36,$34
  5625  .db $D2,$44,$46,$44,$64,$66,$64,$D2,$74,$76,$74,$94,$96,$94,$04,$06
  5635  .db $04,$04,$06,$04,$04,$06,$04,$54,$26,$D1,$A4,$F3,$03,$D2,$54,$D3
  5645  .db $04,$D2,$54,$54,$D2,$54,$D3,$54,$D2,$54,$54,$B4,$54,$54,$D3,$54
  5655  .db $D2,$54,$04,$24,$44,$54,$A4,$54,$54,$D3,$04,$D2,$54,$54,$D3,$54
  5665  .db $D2,$54,$A4,$94,$74,$54,$D3,$02,$D2,$54,$D3,$54,$D2,$52,$D2,$54
  5675  .db $D3,$04,$D2,$54,$54,$D2,$54,$D3,$54,$D2,$54,$54,$B4,$54,$54,$D3
  5685  .db $54,$D2,$54,$04,$24,$44,$84,$D3,$14,$D2,$54,$04,$D3,$54,$D2,$56
  5695  .db $54,$D3,$04,$D2,$56,$54,$54,$44,$24,$04,$FE,$FF,$72,$55,$D2,$54
  56A5  .db $D1,$54,$D2,$54,$02,$D1,$94,$94,$D2,$02,$54,$76,$74,$F3,$01,$D2
  56B5  .db $74,$D1,$74,$D2,$74,$D1,$74,$D2,$74,$D1,$74,$FF,$F1,$44,$EA,$70
  56C5  .db $EB,$CC,$E7,$05,$40,$F4,$10,$E8,$00,$E9,$01,$F3,$01,$D4,$52,$D5
  56D5  .db $02,$52,$02,$FE,$04,$D2,$56,$D4,$72,$D5,$22,$72,$22,$F4,$05,$E7
  56E5  .db $05,$21,$E9,$06,$EB,$DD,$D5,$76,$76,$76,$E9,$01,$E7,$05,$40,$EB
  56F5  .db $CC,$F4,$10,$D4,$62,$D5,$12,$62,$12,$FE,$04,$F8,$56,$D4,$52,$D5
  5705  .db $02,$52,$02,$F4,$05,$E7,$05,$21,$E9,$06,$EB,$DD,$D5,$56,$56,$56
  5715  .db $E9,$01,$E7,$05,$40,$EB,$CC,$F4,$10,$D4,$52,$D5,$02,$52,$02,$FE
  5725  .db $04,$1E,$57,$D4,$72,$D5,$22,$62,$22,$F4,$05,$E7,$05,$21,$E9,$06
  5735  .db $EB,$DD,$D5,$76,$76,$76,$E7,$05,$21,$E8,$0A,$E9,$06,$F4,$05,$D3
  5745  .db $A7,$A4,$A7,$A6,$D4,$04,$06,$D5,$08,$D4,$27,$24,$27,$26,$44,$46
  5755  .db $D5,$08,$EB,$CC,$E7,$07,$40,$E8,$0A,$E9,$06,$F4,$0C,$F3,$00,$F6
  5765  .db $D4,$5C,$6C,$7C,$8C,$9C,$AC,$BC,$D5,$0C,$1C,$2C,$3C,$4C,$5C,$4C
  5775  .db $3C,$2C,$1C,$0C,$D4,$BC,$AC,$9C,$8C,$7C,$F6,$6C,$FE,$02,$64,$57
  5785  .db $F6,$D4,$7C,$8C,$9C,$AC,$BC,$D5,$0C,$1C,$2C,$3C,$4C,$5C,$6C,$7C
  5795  .db $6C,$5C,$4C,$3C,$2C,$1C,$0C,$D4,$BC,$AC,$9C,$F6,$8C,$FE,$02,$85
  57A5  .db $57,$F6,$D4,$AC,$BC,$D5,$0C,$1C,$2C,$3C,$4C,$5C,$6C,$7C,$8C,$9C
  57B5  .db $BC,$9C,$8C,$7C,$6C,$5C,$4C,$3C,$2C,$1C,$0C,$D4,$F6,$BC,$FE,$02
  57C5  .db $A6,$57,$E7,$05,$21,$E8,$0A,$E9,$06,$F4,$05,$EB,$DD,$D4,$04,$04
  57D5  .db $D5,$04,$D4,$76,$D5,$04,$D4,$74,$D5,$04,$C4,$D4,$04,$06,$D5,$44
  57E5  .db $47,$EB,$CC,$E7,$07,$40,$E8,$0A,$E9,$06,$F4,$0C,$F6,$D4,$5C,$6C
  57F5  .db $7C,$8C,$9C,$AC,$BC,$D5,$0C,$1C,$2C,$3C,$4C,$5C,$4C,$3C,$2C,$1C
  5805  .db $0C,$D4,$BC,$AC,$9C,$8C,$7C,$F6,$6C,$FE,$02,$F1,$57,$F6,$D4,$7C
  5815  .db $8C,$9C,$AC,$BC,$D5,$0C,$1C,$2C,$3C,$4C,$5C,$6C,$7C,$6C,$5C,$4C
  5825  .db $3C,$2C,$1C,$0C,$D4,$BC,$AC,$9C,$F6,$8C,$FE,$02,$12,$58,$F6,$D4
  5835  .db $AC,$BC,$D5,$0C,$1C,$2C,$3C,$4C,$5C,$6C,$7C,$8C,$9C,$BC,$9C,$8C
  5845  .db $7C,$6C,$5C,$4C,$3C,$2C,$1C,$0C,$D4,$F6,$BC,$FE,$02,$33,$58,$F6
  5855  .db $D4,$5C,$6C,$7C,$8C,$9C,$AC,$BC,$D5,$0C,$1C,$2C,$3C,$F6,$4C,$52
  5865  .db $02,$D4,$92,$52,$D5,$02,$D4,$92,$62,$02,$D5,$92,$52,$02,$D4,$92
  5875  .db $D5,$52,$02,$D4,$92,$52,$D5,$02,$D4,$92,$62,$02,$92,$52,$02,$D3
  5885  .db $92,$EB,$EE,$F3,$01,$D5,$28,$48,$58,$78,$58,$78,$28,$08,$58,$78
  5895  .db $98,$78,$58,$78,$58,$78,$D6,$B2,$A2,$92,$82,$72,$62,$52,$42,$32
  58A5  .db $22,$12,$02,$D5,$B2,$A2,$92,$82,$D6,$72,$62,$52,$42,$32,$22,$12
  58B5  .db $02,$D5,$B2,$A2,$92,$82,$72,$62,$52,$42,$F4,$05,$E8,$0A,$E9,$06
  58C5  .db $E7,$05,$21,$EB,$DD,$D4,$24,$26,$24,$44,$46,$44,$54,$56,$54,$74
  58D5  .db $76,$74,$FD,$ED,$58,$D4,$B6,$96,$FD,$19,$59,$FD,$ED,$58,$D4,$16
  58E5  .db $06,$FD,$19,$59,$FE,$FF,$3B,$57,$E7,$05,$40,$F4,$10,$E8,$00,$E9
  58F5  .db $01,$D5,$06,$D4,$B6,$F4,$05,$E8,$0A,$E9,$06,$E7,$05,$21,$D5,$26
  5905  .db $D4,$B6,$D5,$26,$D4,$B6,$D5,$26,$D4,$26,$E7,$05,$40,$F4,$10,$E8
  5915  .db $00,$E9,$01,$FF,$F4,$05,$E8,$0A,$E9,$06,$E7,$05,$21,$D5,$06,$D4
  5925  .db $96,$D5,$06,$D4,$96,$D5,$06,$D4,$96,$FF,$F1,$44,$F0,$01,$F3,$01
  5935  .db $14,$42,$42,$22,$44,$42,$12,$42,$12,$42,$24,$34,$14,$14,$24,$14
  5945  .db $24,$14,$24,$14,$FE,$03,$35,$59,$14,$42,$42,$24,$12,$42,$14,$42
  5955  .db $42,$24,$34,$14,$14,$24,$42,$42,$54,$62,$72,$22,$12,$42,$22,$14
  5965  .db $42,$42,$24,$12,$42,$14,$42,$42,$24,$34,$14,$14,$24,$22,$22,$52
  5975  .db $52,$52,$62,$62,$62,$72,$72,$14,$44,$24,$42,$42,$14,$44,$24,$34
  5985  .db $FE,$03,$7C,$59,$14,$34,$24,$22,$22,$14,$44,$24,$22,$22,$14,$44
  5995  .db $24,$42,$42,$14,$44,$24,$34,$FE,$02,$93,$59,$24,$24,$24,$84,$14
  59A5  .db $94,$14,$A4,$14,$24,$94,$22,$22,$A4,$B4,$14,$22,$22,$14,$34,$24
  59B5  .db $42,$42,$14,$44,$24,$34,$14,$44,$24,$42,$42,$14,$44,$24,$34,$14
  59C5  .db $44,$24,$42,$42,$14,$44,$24,$34,$14,$34,$24,$22,$22,$14,$44,$24
  59D5  .db $22,$22,$14,$44,$24,$42,$42,$14,$44,$24,$34,$FE,$03,$D7,$59,$24
  59E5  .db $24,$24,$54,$22,$22,$64,$22,$22,$74,$14,$34,$24,$44,$14,$34,$24
  59F5  .db $44,$FE,$07,$EE,$59,$14,$24,$26,$14,$24,$24,$22,$22,$14,$42,$42
  5A05  .db $24,$42,$42,$14,$42,$42,$24,$34,$FE,$02,$02,$5A,$14,$24,$24,$52
  5A15  .db $52,$14,$24,$24,$62,$62,$14,$24,$24,$72,$72,$22,$12,$22,$12,$22
  5A25  .db $52,$62,$72,$14,$44,$24,$42,$42,$12,$44,$42,$22,$42,$34,$14,$44
  5A35  .db $24,$42,$42,$12,$44,$42,$22,$42,$12,$42,$FE,$03,$28,$5A,$14,$44
  5A45  .db $24,$42,$42,$12,$44,$42,$22,$42,$34,$14,$44,$24,$34,$22,$22,$24
  5A55  .db $22,$22,$24,$FE,$FF,$4D,$59,$F1,$33,$F7,$03,$EA,$70,$C3,$F4,$0B
  5A65  .db $E7,$05,$21,$E8,$00,$E9,$01,$EB,$CC,$F3,$01,$D5,$04,$06,$F4,$10
  5A75  .db $E7,$05,$40,$D3,$A2,$82,$62,$42,$22,$02,$D2,$AC,$8C,$6C,$4C,$2C
  5A85  .db $0C,$F4,$0B,$E7,$05,$21,$D5,$04,$06,$F4,$10,$E7,$05,$40,$D4,$A2
  5A95  .db $82,$62,$42,$22,$02,$D3,$AC,$8C,$6C,$40,$F4,$0B,$E9,$06,$E7,$05
  5AA5  .db $21,$EB,$DD,$D4,$76,$76,$A6,$A6,$56,$56,$86,$86,$74,$64,$74,$94
  5AB5  .db $A4,$94,$A4,$D5,$04,$54,$D3,$84,$D4,$14,$54,$84,$D5,$14,$54,$84
  5AC5  .db $C5,$F4,$04,$E8,$00,$E7,$07,$11,$EB,$CC,$D5,$04,$D4,$64,$D5,$07
  5AD5  .db $F4,$23,$D4,$A2,$82,$64,$82,$A2,$D5,$04,$22,$42,$64,$42,$22,$02
  5AE5  .db $22,$42,$22,$02,$D4,$B2,$92,$72,$6A,$74,$D5,$7C,$9C,$BC,$D6,$0C
  5AF5  .db $D5,$BC,$9C,$7C,$5C,$4C,$5C,$4C,$2C,$0C,$D4,$BC,$9C,$BC,$9C,$7C
  5B05  .db $5C,$4C,$2C,$F4,$04,$D5,$34,$D4,$A4,$D5,$37,$F4,$23,$22,$D4,$B2
  5B15  .db $94,$B2,$D5,$22,$34,$52,$72,$94,$72,$52,$32,$52,$72,$52,$32,$12
  5B25  .db $D4,$B2,$92,$6A,$74,$D5,$7C,$9C,$BC,$D6,$0C,$D5,$BC,$9C,$7C,$5C
  5B35  .db $4C,$5C,$4C,$2C,$0C,$D4,$BC,$9C,$BC,$9B,$F4,$0B,$E8,$00,$E9,$06
  5B45  .db $E7,$05,$21,$C5,$D3,$74,$72,$72,$D4,$76,$D3,$54,$52,$52,$D4,$56
  5B55  .db $D4,$76,$56,$74,$54,$34,$14,$F4,$23,$EB,$CC,$E8,$00,$E7,$07,$11
  5B65  .db $D4,$05,$A5,$05,$85,$04,$74,$05,$A5,$05,$85,$04,$74,$05,$A5,$05
  5B75  .db $85,$04,$74,$05,$D5,$05,$35,$D4,$A5,$D5,$14,$D4,$84,$FE,$FF,$C6
  5B85  .db $5A,$F1,$33,$EA,$70,$EB,$EE,$F3,$01,$F4,$0B,$E7,$05,$21,$E8,$0A
  5B95  .db $E9,$01,$D3,$74,$D4,$76,$F4,$10,$E7,$05,$40,$E8,$00,$D3,$A2,$82
  5BA5  .db $62,$42,$22,$02,$D2,$AC,$8C,$6C,$4C,$2C,$0C,$F4,$0B,$E7,$05,$21
  5BB5  .db $E8,$0A,$D3,$74,$D4,$76,$F4,$10,$E7,$05,$40,$E8,$00,$D4,$A2,$82
  5BC5  .db $62,$42,$22,$02,$D3,$AC,$8C,$6C,$4C,$2C,$0C,$F4,$0B,$E7,$05,$21
  5BD5  .db $E8,$0A,$E9,$06,$D5,$06,$06,$36,$36,$D4,$86,$86,$D5,$16,$16,$04
  5BE5  .db $D4,$B4,$D5,$04,$24,$44,$24,$44,$54,$D4,$84,$24,$64,$84,$D5,$14
  5BF5  .db $54,$84,$D6,$14,$F4,$05,$E8,$00,$E7,$07,$11,$D5,$04,$D4,$64,$D5
  5C05  .db $07,$F4,$23,$E8,$04,$D4,$A2,$82,$64,$82,$A2,$D5,$04,$22,$42,$64
  5C15  .db $42,$22,$02,$22,$42,$22,$02,$D4,$B2,$92,$72,$6A,$74,$D5,$7C,$9C
  5C25  .db $BC,$D6,$0C,$D5,$BC,$9C,$7C,$5C,$4C,$5C,$4C,$2C,$0C,$D4,$BC,$9C
  5C35  .db $BC,$9C,$7C,$5C,$4C,$2C,$F4,$05,$E8,$00,$E7,$07,$11,$D5,$34,$D4
  5C45  .db $A4,$D5,$37,$F4,$23,$E8,$04,$22,$D4,$B2,$94,$B2,$D5,$22,$34,$52
  5C55  .db $72,$94,$72,$52,$32,$52,$72,$52,$32,$12,$D4,$B2,$92,$6A,$74,$D5
  5C65  .db $7C,$9C,$BC,$D6,$0C,$D5,$BC,$9C,$7C,$5C,$4C,$5C,$4C,$2C,$0C,$D4
  5C75  .db $BC,$9C,$BC,$9C,$7C,$5C,$4C,$2C,$F4,$0B,$E8,$0A,$E9,$06,$E7,$05
  5C85  .db $21,$EB,$EE,$D4,$74,$72,$72,$D5,$76,$D4,$54,$52,$52,$D5,$56,$D4
  5C95  .db $76,$56,$74,$54,$34,$14,$F4,$23,$E8,$04,$E7,$07,$11,$D4,$05,$A5
  5CA5  .db $05,$85,$04,$74,$05,$A5,$05,$85,$04,$74,$05,$A5,$05,$85,$04,$74
  5CB5  .db $05,$D5,$05,$35,$D4,$A5,$D5,$14,$D4,$84,$FE,$FF,$F9,$5B,$F1,$33
  5CC5  .db $F4,$1A,$E7,$07,$10,$E8,$09,$E9,$05,$EA,$70,$EB,$FF,$F3,$01,$D2
  5CD5  .db $08,$C8,$08,$C8,$04,$02,$02,$FE,$08,$D9,$5C,$04,$04,$04,$04,$04
  5CE5  .db $04,$04,$04,$D1,$84,$14,$54,$84,$14,$54,$84,$D2,$14,$F3,$02,$D2
  5CF5  .db $04,$D1,$64,$D2,$05,$02,$D1,$A5,$A2,$65,$A2,$D2,$04,$D1,$64,$D2
  5D05  .db $05,$04,$D1,$62,$82,$A2,$D2,$02,$22,$62,$42,$D2,$64,$04,$65,$62
  5D15  .db $35,$32,$05,$32,$D2,$74,$D1,$74,$D2,$75,$72,$55,$52,$25,$22,$D2
  5D25  .db $34,$D1,$A4,$D2,$35,$32,$15,$12,$D1,$95,$D2,$12,$D2,$34,$D1,$A4
  5D35  .db $D2,$35,$32,$D1,$94,$D2,$32,$52,$D1,$92,$D2,$94,$52,$D2,$64,$24
  5D45  .db $65,$62,$25,$22,$D1,$95,$D2,$62,$D2,$75,$72,$55,$52,$35,$32,$25
  5D55  .db $22,$F3,$01,$D1,$74,$72,$72,$D2,$76,$D1,$54,$52,$52,$D2,$56,$D1
  5D65  .db $76,$66,$D2,$74,$64,$34,$14,$D1,$02,$02,$A2,$32,$02,$82,$72,$32
  5D75  .db $54,$32,$74,$12,$82,$32,$FE,$03,$6C,$5D,$D1,$02,$02,$A2,$32,$02
  5D85  .db $82,$72,$32,$D1,$34,$D2,$A2,$D1,$22,$02,$D3,$04,$D1,$02,$FE,$FF
  5D95  .db $F2,$5C,$F1,$33,$F4,$0B,$E8,$00,$EA,$70,$F3,$01,$E7,$05,$21,$E9
  5DA5  .db $01,$EB,$EE,$D5,$04,$E7,$08,$21,$EB,$CC,$E9,$08,$D6,$07,$E7,$05
  5DB5  .db $21,$EB,$DD,$D3,$08,$FE,$02,$A1,$5D,$EB,$DD,$E9,$06,$D4,$46,$46
  5DC5  .db $76,$76,$16,$16,$56,$56,$44,$14,$44,$64,$74,$64,$74,$84,$F4,$17
  5DD5  .db $E7,$07,$40,$E8,$0A,$E9,$06,$EA,$70,$EB,$DD,$D4,$8C,$9C,$AC,$BC
  5DE5  .db $D5,$0C,$1C,$2C,$3C,$4C,$5C,$6C,$7C,$8C,$9C,$AC,$BC,$D6,$0C,$1C
  5DF5  .db $20,$30,$40,$50,$60,$70,$90,$B0,$F4,$05,$E7,$07,$40,$E8,$0A,$E9
  5E05  .db $06,$EA,$70,$EB,$DD,$D4,$74,$44,$74,$F4,$16,$E7,$03,$10,$E8,$00
  5E15  .db $E9,$07,$EA,$00,$EB,$CC,$D4,$A2,$42,$D5,$02,$D4,$62,$FE,$06,$1B
  5E25  .db $5E,$D4,$A2,$42,$D5,$02,$D4,$62,$92,$32,$D5,$02,$D4,$62,$92,$32
  5E35  .db $D5,$02,$D4,$62,$92,$32,$D5,$02,$D4,$62,$F4,$1E,$E7,$07,$40,$E9
  5E45  .db $03,$EA,$70,$EB,$EE,$D6,$0C,$2C,$3C,$D6,$46,$F4,$16,$E7,$03,$10
  5E55  .db $E8,$00,$E9,$07,$EA,$00,$EB,$CC,$D4,$B2,$22,$72,$22,$B2,$22,$72
  5E65  .db $22,$B2,$22,$72,$22,$F4,$05,$E7,$07,$40,$E8,$0A,$E9,$06,$EA,$70
  5E75  .db $EB,$DD,$D4,$A4,$D4,$74,$D4,$A4,$F4,$16,$E7,$03,$10,$E8,$00,$E9
  5E85  .db $07,$EA,$00,$EB,$CC,$D5,$12,$D4,$72,$D5,$32,$D4,$A2,$FE,$06,$8A
  5E95  .db $5E,$D5,$12,$D4,$72,$D5,$22,$D4,$62,$92,$62,$D5,$22,$D4,$62,$92
  5EA5  .db $62,$D5,$22,$D4,$62,$92,$62,$D5,$22,$D4,$62,$F4,$1E,$E7,$07,$40
  5EB5  .db $E9,$03,$EA,$70,$EB,$EE,$D6,$0C,$2C,$3C,$D6,$46,$F4,$16,$E7,$03
  5EC5  .db $10,$E8,$00,$E9,$07,$EA,$00,$EB,$CC,$D4,$B2,$22,$72,$22,$B2,$22
  5ED5  .db $72,$22,$B2,$22,$72,$22,$F4,$0B,$E8,$0A,$E9,$06,$E7,$05,$21,$EB
  5EE5  .db $DD,$D3,$24,$22,$22,$D4,$26,$D3,$04,$02,$02,$D4,$06,$EB,$DD,$D4
  5EF5  .db $26,$06,$24,$04,$D3,$A4,$84,$F4,$16,$E7,$03,$10,$E8,$00,$E9,$07
  5F05  .db $EA,$00,$EB,$CC,$D5,$02,$D4,$62,$A2,$42,$FE,$0C,$09,$5F,$D6,$02
  5F15  .db $D5,$62,$A2,$52,$82,$32,$72,$12,$52,$02,$32,$D4,$A2,$D5,$12,$D4
  5F25  .db $82,$B2,$42,$FE,$FF,$FD,$5D,$F1,$33,$F0,$01,$F3,$01,$A4,$A7,$22
  5F35  .db $22,$22,$22,$22,$22,$22,$22,$FE,$02,$32,$5F,$22,$14,$12,$22,$14
  5F45  .db $12,$22,$14,$12,$22,$14,$12,$FE,$03,$40,$5F,$22,$14,$12,$22,$14
  5F55  .db $12,$22,$14,$12,$26,$24,$B2,$12,$B2,$42,$42,$12,$12,$42,$42,$12
  5F65  .db $A2,$A2,$42,$12,$B4,$42,$12,$12,$42,$42,$12,$12,$42,$42,$12,$92
  5F75  .db $92,$A2,$A2,$B4,$42,$12,$12,$42,$42,$12,$12,$42,$42,$12,$A2,$A2
  5F85  .db $42,$12,$B4,$42,$12,$12,$42,$42,$12,$12,$42,$42,$12,$92,$92,$A2
  5F95  .db $A2,$FE,$02,$5A,$5F,$A4,$22,$22,$12,$22,$22,$22,$B4,$22,$22,$12
  5FA5  .db $22,$22,$22,$54,$22,$22,$64,$22,$22,$52,$62,$72,$72,$12,$22,$22
  5FB5  .db $22,$12,$42,$34,$12,$42,$42,$42,$12,$44,$42,$12,$42,$92,$82,$FE
  5FC5  .db $03,$B6,$5F,$12,$42,$42,$12,$52,$54,$52,$52,$5C,$5C,$5C,$62,$62
  5FD5  .db $22,$22,$22,$FE,$FF,$5A,$5F,$F4,$1E,$F1,$38,$E7,$05,$10,$E8,$00
  5FE5  .db $E9,$06,$EA,$70,$EB,$BB,$C1,$C0,$F7,$01,$F3,$00,$FE,$FF,$06,$60
  5FF5  .db $F4,$1E,$F1,$38,$E7,$05,$10,$E8,$00,$E9,$06
