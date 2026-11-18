; Detana!! TwinBee (PCE) - banque $0B, vue en $4000-$5FFF
; 4041 octets de code (3596 exécutés en émulation)
; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique

L0B_4000:
  4000  A2 05                 LDX   #$05                         ;[x]
L0B_4002:
  4002  BD DD 2F              LDA   $2FDD,X                      ;[x]
  4005  C9 01                 CMP   #$01                         ;[x]
  4007  F0 02                 BEQ   L0B_400B                     ;[x]
  4009  80 0A                 BRA   L0B_4015                     ;[x]

L0B_400B:
  400B  A9 02                 LDA   #$02                         ;[ ]
  400D  9D DD 2F              STA   $2FDD,X                      ;[ ]
  4010  A9 24                 LDA   #$24                         ;[ ]
  4012  9D C1 2A              STA   $2AC1,X                      ;[ ]
L0B_4015:
  4015  9E F9 34              STZ   $34F9,X                      ;[x]
  4018  CA                    DEX                                ;[x]
  4019  10 E7                 BPL   L0B_4002                     ;[x]
  401B  60                    RTS                                ;[x]

L0B_401C:
  401C  A5 86                 LDA   <$86                         ;[x]
  401E  85 00                 STA   <$00                         ;[x]
  4020  98                    TYA                                ;[x]
  4021  1A                    INC   A                            ;[x]
  4022  25 00                 AND   <$00                         ;[x]
  4024  D0 0A                 BNE   L0B_4030                     ;[x]
  4026  98                    TYA                                ;[x]
  4027  49 01                 EOR   #$01                         ;[x]
  4029  A8                    TAY                                ;[x]
  402A  1A                    INC   A                            ;[x]
  402B  25 00                 AND   <$00                         ;[x]
  402D  D0 01                 BNE   L0B_4030                     ;[x]
  402F  C2                    CLY                                ;[x]
L0B_4030:
  4030  64 04                 STZ   <$04                         ;[x]
  4032  18                    CLC                                ;[x]
  4033  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  4036  F9 8E 2C              SBC   $2C8E,Y                      ;[x]
  4039  85 00                 STA   <$00                         ;[x]
  403B  BD 21 2C              LDA   $2C21,X                      ;[x]
  403E  F9 21 2C              SBC   $2C21,Y                      ;[x]
  4041  85 02                 STA   <$02                         ;[x]
  4043  29 80                 AND   #$80                         ;[x]
  4045  F0 13                 BEQ   L0B_405A                     ;[x]
  4047  E6 04                 INC   <$04                         ;[x]
  4049  A5 00                 LDA   <$00                         ;[x]
  404B  49 FF                 EOR   #$FF                         ;[x]
  404D  18                    CLC                                ;[x]
  404E  69 01                 ADC   #$01                         ;[x]
  4050  85 00                 STA   <$00                         ;[x]
  4052  A5 02                 LDA   <$02                         ;[x]
  4054  49 FF                 EOR   #$FF                         ;[x]
  4056  69 00                 ADC   #$00                         ;[x]
  4058  85 02                 STA   <$02                         ;[x]
L0B_405A:
  405A  18                    CLC                                ;[x]
  405B  BD 47 2B              LDA   $2B47,X                      ;[x]
  405E  F9 47 2B              SBC   $2B47,Y                      ;[x]
  4061  85 01                 STA   <$01                         ;[x]
  4063  BD DA 2A              LDA   $2ADA,X                      ;[x]
  4066  F9 DA 2A              SBC   $2ADA,Y                      ;[x]
  4069  85 03                 STA   <$03                         ;[x]
  406B  0A                    ASL   A                            ;[x]
  406C  26 04                 ROL   <$04                         ;[x]
  406E  29 80                 AND   #$80                         ;[x]
  4070  F0 11                 BEQ   L0B_4083                     ;[x]
  4072  A5 01                 LDA   <$01                         ;[x]
  4074  49 FF                 EOR   #$FF                         ;[x]
  4076  18                    CLC                                ;[x]
  4077  69 01                 ADC   #$01                         ;[x]
  4079  85 01                 STA   <$01                         ;[x]
  407B  A5 03                 LDA   <$03                         ;[x]
  407D  49 FF                 EOR   #$FF                         ;[x]
  407F  69 00                 ADC   #$00                         ;[x]
  4081  85 03                 STA   <$03                         ;[x]
L0B_4083:
  4083  C2                    CLY                                ;[x]
  4084  A5 02                 LDA   <$02                         ;[x]
  4086  C5 03                 CMP   <$03                         ;[x]
  4088  D0 04                 BNE   L0B_408E                     ;[x]
  408A  A5 00                 LDA   <$00                         ;[x]
  408C  C5 01                 CMP   <$01                         ;[x]
L0B_408E:
  408E  B0 01                 BCS   L0B_4091                     ;[x]
  4090  C8                    INY                                ;[x]
L0B_4091:
  4091  B9 02 20              LDA   $2002,Y                      ;[x]
  4094  D0 07                 BNE   L0B_409D                     ;[x]
  4096  B9 00 20              LDA   $2000,Y                      ;[x]
  4099  C9 08                 CMP   #$08                         ;[x]
  409B  90 0A                 BCC   L0B_40A7                     ;[x]
L0B_409D:
  409D  46 02                 LSR   <$02                         ;[x]
  409F  66 00                 ROR   <$00                         ;[x]
  40A1  46 03                 LSR   <$03                         ;[x]
  40A3  66 01                 ROR   <$01                         ;[x]
  40A5  80 EA                 BRA   L0B_4091                     ;[x]

L0B_40A7:
  40A7  A5 00                 LDA   <$00                         ;[x]
  40A9  0A                    ASL   A                            ;[x]
  40AA  0A                    ASL   A                            ;[x]
  40AB  0A                    ASL   A                            ;[x]
  40AC  18                    CLC                                ;[x]
  40AD  65 01                 ADC   <$01                         ;[x]
  40AF  A8                    TAY                                ;[x]
  40B0  B9 CD 40              LDA   $40CD,Y                      ;[x]
  40B3  85 00                 STA   <$00                         ;[x]
  40B5  A4 04                 LDY   <$04                         ;[x]
  40B7  98                    TYA                                ;[x]
  40B8  1A                    INC   A                            ;[x]
  40B9  29 02                 AND   #$02                         ;[x]
  40BB  F0 07                 BEQ   L0B_40C4                     ;[x]
  40BD  A9 08                 LDA   #$08                         ;[x]
  40BF  38                    SEC                                ;[x]
  40C0  E5 00                 SBC   <$00                         ;[x]
  40C2  85 00                 STA   <$00                         ;[x]
L0B_40C4:
  40C4  B9 0D 41              LDA   $410D,Y                      ;[x]
  40C7  18                    CLC                                ;[x]
  40C8  65 00                 ADC   <$00                         ;[x]
  40CA  85 00                 STA   <$00                         ;[x]
  40CC  60                    RTS                                ;[x]

  40CD  .db $04,$01,$01,$00,$00,$00,$00,$00,$06,$04,$02,$02,$01,$01,$01,$01
  40DD  .db $07,$05,$04,$03,$02,$02,$01,$01,$07,$06,$04,$04,$03,$02,$02,$02
  40ED  .db $07,$06,$05,$04,$04,$03,$03,$02,$07,$06,$05,$05,$04,$04,$03,$03
  40FD  .db $08,$06,$06,$05,$04,$04,$04,$03,$08,$07,$06,$05,$05,$04,$04,$04
  410D  .db $10,$18,$08,$00
L0B_4111:
  4111  48                    PHA                                ;[x]
  4112  5A                    PHY                                ;[x]
  4113  20 61 FE              JSR   L00_FE61                     ;[x]
  4116  62                    CLA                                ;[x]
  4117  A4 01                 LDY   <$01                         ;[x]
  4119  10 01                 BPL   L0B_411C                     ;[x]
  411B  3A                    DEC   A                            ;[x]
L0B_411C:
  411C  A0 03                 LDY   #$03                         ;[x]
L0B_411E:
  411E  06 00                 ASL   <$00                         ;[x]
  4120  26 01                 ROL   <$01                         ;[x]
  4122  2A                    ROL   A                            ;[x]
  4123  88                    DEY                                ;[x]
  4124  10 F8                 BPL   L0B_411E                     ;[x]
  4126  9D 63 30              STA   $3063,X                      ;[x]
  4129  A5 01                 LDA   <$01                         ;[x]
  412B  9D D0 30              STA   $30D0,X                      ;[x]
  412E  7A                    PLY                                ;[x]
  412F  68                    PLA                                ;[x]
  4130  20 67 FE              JSR   L00_FE67                     ;[x]
  4133  62                    CLA                                ;[x]
  4134  A4 01                 LDY   <$01                         ;[x]
  4136  10 01                 BPL   L0B_4139                     ;[x]
  4138  3A                    DEC   A                            ;[x]
L0B_4139:
  4139  A0 03                 LDY   #$03                         ;[x]
L0B_413B:
  413B  06 00                 ASL   <$00                         ;[x]
  413D  26 01                 ROL   <$01                         ;[x]
  413F  2A                    ROL   A                            ;[x]
  4140  88                    DEY                                ;[x]
  4141  10 F8                 BPL   L0B_413B                     ;[x]
  4143  9D 3D 31              STA   $313D,X                      ;[x]
  4146  A5 01                 LDA   <$01                         ;[x]
  4148  9D AA 31              STA   $31AA,X                      ;[x]
  414B  60                    RTS                                ;[x]

L0B_414C:
  414C  BD 59 36              LDA   $3659,X                      ;[x]
  414F  D0 2A                 BNE   L0B_417B                     ;[x]
  4151  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  4154  0A                    ASL   A                            ;[x]
  4155  A8                    TAY                                ;[x]
  4156  B9 D0 5A              LDA   $5AD0,Y                      ;[x]
  4159  85 0C                 STA   <$0C                         ;[x]
  415B  B9 D1 5A              LDA   $5AD1,Y                      ;[x]
  415E  85 0D                 STA   <$0D                         ;[x]
  4160  BD EC 35              LDA   $35EC,X                      ;[x]
  4163  0A                    ASL   A                            ;[x]
  4164  A8                    TAY                                ;[x]
L0B_4165:
  4165  B1 0C                 LDA   (<$0C),Y                     ;[x]
  4167  D0 06                 BNE   L0B_416F                     ;[x]
  4169  C2                    CLY                                ;[x]
  416A  9E EC 35              STZ   $35EC,X                      ;[x]
  416D  80 F6                 BRA   L0B_4165                     ;[x]

L0B_416F:
  416F  9D 59 36              STA   $3659,X                      ;[x]
  4172  C8                    INY                                ;[x]
  4173  B1 0C                 LDA   (<$0C),Y                     ;[x]
  4175  9D 6D 2A              STA   $2A6D,X                      ;[x]
  4178  FE EC 35              INC   $35EC,X                      ;[x]
L0B_417B:
  417B  DE 59 36              DEC   $3659,X                      ;[x]
  417E  60                    RTS                                ;[x]

L0B_417F:
  417F  85 0E                 STA   <$0E                         ;[x]
  4181  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  4184  0A                    ASL   A                            ;[x]
  4185  A8                    TAY                                ;[x]
  4186  B9 D0 5A              LDA   $5AD0,Y                      ;[x]
  4189  85 0C                 STA   <$0C                         ;[x]
  418B  B9 D1 5A              LDA   $5AD1,Y                      ;[x]
  418E  85 0D                 STA   <$0D                         ;[x]
  4190  A5 0E                 LDA   <$0E                         ;[x]
  4192  0A                    ASL   A                            ;[x]
  4193  A8                    TAY                                ;[x]
  4194  C8                    INY                                ;[x]
  4195  B1 0C                 LDA   (<$0C),Y                     ;[x]
  4197  9D 6D 2A              STA   $2A6D,X                      ;[x]
  419A  60                    RTS                                ;[x]

L0B_419B:
  419B  A5 86                 LDA   <$86                         ;[x]
  419D  89 01                 BIT   #$01                         ;[x]
  419F  F0 64                 BEQ   L0B_4205                     ;[x]
  41A1  89 02                 BIT   #$02                         ;[x]
  41A3  F0 6A                 BEQ   L0B_420F                     ;[x]
  41A5  BD 8E 2C              LDA   $2C8E,X                      ;[ ]
  41A8  85 00                 STA   <$00                         ;[ ]
  41AA  BD 21 2C              LDA   $2C21,X                      ;[ ]
  41AD  85 01                 STA   <$01                         ;[ ]
  41AF  C2                    CLY                                ;[ ]
  41B0  B9 8E 2C              LDA   $2C8E,Y                      ;[ ]
  41B3  38                    SEC                                ;[ ]
  41B4  E5 00                 SBC   <$00                         ;[ ]
  41B6  85 02                 STA   <$02                         ;[ ]
  41B8  B9 21 2C              LDA   $2C21,Y                      ;[ ]
  41BB  E5 01                 SBC   <$01                         ;[ ]
  41BD  85 03                 STA   <$03                         ;[ ]
  41BF  10 11                 BPL   L0B_41D2                     ;[ ]
  41C1  A5 02                 LDA   <$02                         ;[ ]
  41C3  49 FF                 EOR   #$FF                         ;[ ]
  41C5  18                    CLC                                ;[ ]
  41C6  69 01                 ADC   #$01                         ;[ ]
  41C8  85 02                 STA   <$02                         ;[ ]
  41CA  A5 03                 LDA   <$03                         ;[ ]
  41CC  49 FF                 EOR   #$FF                         ;[ ]
  41CE  69 00                 ADC   #$00                         ;[ ]
  41D0  85 03                 STA   <$03                         ;[ ]
L0B_41D2:
  41D2  C8                    INY                                ;[ ]
  41D3  B9 8E 2C              LDA   $2C8E,Y                      ;[ ]
  41D6  38                    SEC                                ;[ ]
  41D7  E5 00                 SBC   <$00                         ;[ ]
  41D9  85 04                 STA   <$04                         ;[ ]
  41DB  B9 21 2C              LDA   $2C21,Y                      ;[ ]
  41DE  E5 01                 SBC   <$01                         ;[ ]
  41E0  85 05                 STA   <$05                         ;[ ]
  41E2  10 11                 BPL   L0B_41F5                     ;[ ]
  41E4  A5 04                 LDA   <$04                         ;[ ]
  41E6  49 FF                 EOR   #$FF                         ;[ ]
  41E8  18                    CLC                                ;[ ]
  41E9  69 01                 ADC   #$01                         ;[ ]
  41EB  85 04                 STA   <$04                         ;[ ]
  41ED  A5 05                 LDA   <$05                         ;[ ]
  41EF  49 FF                 EOR   #$FF                         ;[ ]
  41F1  69 00                 ADC   #$00                         ;[ ]
  41F3  85 05                 STA   <$05                         ;[ ]
L0B_41F5:
  41F5  A5 03                 LDA   <$03                         ;[ ]
  41F7  C5 05                 CMP   <$05                         ;[ ]
  41F9  F0 02                 BEQ   L0B_41FD                     ;[ ]
  41FB  80 04                 BRA   L0B_4201                     ;[ ]

L0B_41FD:
  41FD  A5 02                 LDA   <$02                         ;[ ]
  41FF  C5 04                 CMP   <$04                         ;[ ]
L0B_4201:
  4201  B0 09                 BCS   L0B_420C                     ;[ ]
  4203  80 0A                 BRA   L0B_420F                     ;[ ]

L0B_4205:
  4205  89 02                 BIT   #$02                         ;[x]
  4207  D0 03                 BNE   L0B_420C                     ;[x]
  4209  A9 FF                 LDA   #$FF                         ;[x]
  420B  60                    RTS                                ;[x]

L0B_420C:
  420C  A9 01                 LDA   #$01                         ;[ ]
  420E  60                    RTS                                ;[ ]

L0B_420F:
  420F  62                    CLA                                ;[x]
  4210  60                    RTS                                ;[x]

L0B_4211:
  4211  A5 86                 LDA   <$86                         ;[x]
  4213  89 01                 BIT   #$01                         ;[x]
  4215  F0 5C                 BEQ   L0B_4273                     ;[x]
  4217  89 02                 BIT   #$02                         ;[x]
  4219  F0 62                 BEQ   L0B_427D                     ;[x]
  421B  BD 47 2B              LDA   $2B47,X                      ;[ ]
  421E  85 00                 STA   <$00                         ;[ ]
  4220  BD DA 2A              LDA   $2ADA,X                      ;[ ]
  4223  85 01                 STA   <$01                         ;[ ]
  4225  C2                    CLY                                ;[ ]
  4226  B9 47 2B              LDA   $2B47,Y                      ;[ ]
  4229  38                    SEC                                ;[ ]
  422A  E5 00                 SBC   <$00                         ;[ ]
  422C  85 02                 STA   <$02                         ;[ ]
  422E  B9 DA 2A              LDA   $2ADA,Y                      ;[ ]
  4231  E5 01                 SBC   <$01                         ;[ ]
  4233  85 03                 STA   <$03                         ;[ ]
  4235  10 11                 BPL   L0B_4248                     ;[ ]
  4237  A5 02                 LDA   <$02                         ;[ ]
  4239  49 FF                 EOR   #$FF                         ;[ ]
  423B  18                    CLC                                ;[ ]
  423C  69 01                 ADC   #$01                         ;[ ]
  423E  85 02                 STA   <$02                         ;[ ]
  4240  A5 03                 LDA   <$03                         ;[ ]
  4242  49 FF                 EOR   #$FF                         ;[ ]
  4244  69 00                 ADC   #$00                         ;[ ]
  4246  85 03                 STA   <$03                         ;[ ]
L0B_4248:
  4248  C8                    INY                                ;[ ]
  4249  B9 47 2B              LDA   $2B47,Y                      ;[ ]
  424C  38                    SEC                                ;[ ]
  424D  E5 00                 SBC   <$00                         ;[ ]
  424F  85 04                 STA   <$04                         ;[ ]
  4251  B9 DA 2A              LDA   $2ADA,Y                      ;[ ]
  4254  E5 01                 SBC   <$01                         ;[ ]
  4256  85 05                 STA   <$05                         ;[ ]
  4258  10 11                 BPL   L0B_426B                     ;[ ]
  425A  A5 04                 LDA   <$04                         ;[ ]
  425C  49 FF                 EOR   #$FF                         ;[ ]
  425E  18                    CLC                                ;[ ]
  425F  69 01                 ADC   #$01                         ;[ ]
  4261  85 04                 STA   <$04                         ;[ ]
  4263  A5 05                 LDA   <$05                         ;[ ]
  4265  49 FF                 EOR   #$FF                         ;[ ]
  4267  69 00                 ADC   #$00                         ;[ ]
  4269  85 05                 STA   <$05                         ;[ ]
L0B_426B:
  426B  A5 02                 LDA   <$02                         ;[ ]
  426D  C5 04                 CMP   <$04                         ;[ ]
  426F  B0 09                 BCS   L0B_427A                     ;[ ]
  4271  80 0A                 BRA   L0B_427D                     ;[ ]

L0B_4273:
  4273  89 02                 BIT   #$02                         ;[ ]
  4275  D0 03                 BNE   L0B_427A                     ;[ ]
  4277  A9 FF                 LDA   #$FF                         ;[ ]
  4279  60                    RTS                                ;[ ]

L0B_427A:
  427A  A9 01                 LDA   #$01                         ;[ ]
  427C  60                    RTS                                ;[ ]

L0B_427D:
  427D  62                    CLA                                ;[x]
  427E  60                    RTS                                ;[x]

L0B_427F:
  427F  18                    CLC                                ;[x]
  4280  A9 55                 LDA   #$55                         ;[x]
  4282  7D FB 2C              ADC   $2CFB,X                      ;[x]
  4285  9D FB 2C              STA   $2CFB,X                      ;[x]
  4288  62                    CLA                                ;[x]
  4289  7D 8E 2C              ADC   $2C8E,X                      ;[x]
  428C  9D 8E 2C              STA   $2C8E,X                      ;[x]
  428F  62                    CLA                                ;[x]
  4290  7D 21 2C              ADC   $2C21,X                      ;[x]
  4293  9D 21 2C              STA   $2C21,X                      ;[x]
  4296  60                    RTS                                ;[x]

  4297  .db $BD,$38,$34,$29,$01,$A8,$20,$1C,$40,$38,$FD,$0D,$38,$29,$1F,$C9
  42A7  .db $10,$B0,$05,$FE,$0D,$38,$80,$03,$DE,$0D,$38,$60
L0B_42B3:
  42B3  44 48                 BSR   L0B_42FD                     ;[x]
  42B5  D0 38                 BNE   L0B_42EF                     ;[x]
  42B7  A5 B4                 LDA   <$B4                         ;[x]
  42B9  C9 1F                 CMP   #$1F                         ;[x]
  42BB  B0 32                 BCS   L0B_42EF                     ;[x]
  42BD  85 02                 STA   <$02                         ;[x]
  42BF  A5 B5                 LDA   <$B5                         ;[x]
  42C1  46 02                 LSR   <$02                         ;[x]
  42C3  6A                    ROR   A                            ;[x]
  42C4  46 02                 LSR   <$02                         ;[x]
  42C6  6A                    ROR   A                            ;[x]
  42C7  85 03                 STA   <$03                         ;[x]
L0B_42C9:
  42C9  A5 98                 LDA   <$98                         ;[x]
  42CB  85 01                 STA   <$01                         ;[x]
  42CD  A5 97                 LDA   <$97                         ;[x]
  42CF  85 00                 STA   <$00                         ;[x]
  42D1  44 2F                 BSR   L0B_4302                     ;[x]
  42D3  90 1A                 BCC   L0B_42EF                     ;[x]
  42D5  C2                    CLY                                ;[x]
  42D6  B1 00                 LDA   (<$00),Y                     ;[x]
  42D8  85 08                 STA   <$08                         ;[x]
  42DA  C8                    INY                                ;[x]
  42DB  B1 00                 LDA   (<$00),Y                     ;[x]
  42DD  85 09                 STA   <$09                         ;[x]
  42DF  C8                    INY                                ;[x]
  42E0  B1 00                 LDA   (<$00),Y                     ;[x]
  42E2  85 0A                 STA   <$0A                         ;[x]
  42E4  C8                    INY                                ;[x]
  42E5  B1 00                 LDA   (<$00),Y                     ;[x]
  42E7  85 0B                 STA   <$0B                         ;[x]
  42E9  44 35                 BSR   L0B_4320                     ;[x]
  42EB  44 03                 BSR   L0B_42F0                     ;[x]
  42ED  80 DA                 BRA   L0B_42C9                     ;[x]

L0B_42EF:
  42EF  60                    RTS                                ;[x]

L0B_42F0:
  42F0  A5 97                 LDA   <$97                         ;[x]
  42F2  18                    CLC                                ;[x]
  42F3  69 04                 ADC   #$04                         ;[x]
  42F5  85 97                 STA   <$97                         ;[x]
  42F7  62                    CLA                                ;[x]
  42F8  65 98                 ADC   <$98                         ;[x]
  42FA  85 98                 STA   <$98                         ;[x]
  42FC  60                    RTS                                ;[x]

L0B_42FD:
  42FD  A5 B5                 LDA   <$B5                         ;[x]
  42FF  29 03                 AND   #$03                         ;[x]
  4301  60                    RTS                                ;[x]

L0B_4302:
  4302  A0 01                 LDY   #$01                         ;[x]
  4304  B1 00                 LDA   (<$00),Y                     ;[x]
  4306  4A                    LSR   A                            ;[x]
  4307  4A                    LSR   A                            ;[x]
  4308  4A                    LSR   A                            ;[x]
  4309  4A                    LSR   A                            ;[x]
  430A  4A                    LSR   A                            ;[x]
  430B  C5 02                 CMP   <$02                         ;[x]
  430D  F0 04                 BEQ   L0B_4313                     ;[x]
  430F  B0 0D                 BCS   L0B_431E                     ;[x]
  4311  80 09                 BRA   L0B_431C                     ;[x]

L0B_4313:
  4313  C2                    CLY                                ;[x]
  4314  B1 00                 LDA   (<$00),Y                     ;[x]
  4316  C5 03                 CMP   <$03                         ;[x]
  4318  F0 02                 BEQ   L0B_431C                     ;[x]
  431A  B0 02                 BCS   L0B_431E                     ;[x]
L0B_431C:
  431C  38                    SEC                                ;[x]
  431D  60                    RTS                                ;[x]

L0B_431E:
  431E  18                    CLC                                ;[x]
  431F  60                    RTS                                ;[x]

L0B_4320:
  4320  A5 0B                 LDA   <$0B                         ;[x]
  4322  89 80                 BIT   #$80                         ;[x]
  4324  F0 03                 BEQ   L0B_4329                     ;[x]
  4326  4C 68 45              JMP   L0B_4568                     ;[x]

L0B_4329:
  4329  89 40                 BIT   #$40                         ;[x]
  432B  F0 03                 BEQ   L0B_4330                     ;[x]
  432D  4C A6 46              JMP   L0B_46A6                     ;[x]

L0B_4330:
  4330  A5 0A                 LDA   <$0A                         ;[x]
  4332  10 03                 BPL   L0B_4337                     ;[x]
  4334  4C CD 43              JMP   L0B_43CD                     ;[x]

L0B_4337:
  4337  A5 0A                 LDA   <$0A                         ;[x]
  4339  29 7F                 AND   #$7F                         ;[x]
  433B  A8                    TAY                                ;[x]
  433C  B9 0F 47              LDA   $470F,Y                      ;[x]
  433F  29 80                 AND   #$80                         ;[x]
  4341  F0 04                 BEQ   L0B_4347                     ;[x]
  4343  44 11                 BSR   L0B_4356                     ;[x]
  4345  80 02                 BRA   L0B_4349                     ;[x]

L0B_4347:
  4347  44 1B                 BSR   L0B_4364                     ;[x]
L0B_4349:
  4349  E0 00                 CPX   #$00                         ;[x]
  434B  D0 25                 BNE   L0B_4372                     ;[x]
  434D  60                    RTS                                ;[x]

  434E  .db $AA,$44,$15,$E0,$00,$D0,$1D,$60
L0B_4356:
  4356  A2 60                 LDX   #$60                         ;[x]
L0B_4358:
  4358  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  435B  F0 06                 BEQ   L0B_4363                     ;[x]
  435D  E8                    INX                                ;[x]
  435E  E0 68                 CPX   #$68                         ;[x]
  4360  D0 F6                 BNE   L0B_4358                     ;[x]
  4362  82                    CLX                                ;[ ]
L0B_4363:
  4363  60                    RTS                                ;[x]

L0B_4364:
  4364  A2 42                 LDX   #$42                         ;[x]
L0B_4366:
  4366  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  4369  F0 06                 BEQ   L0B_4371                     ;[x]
  436B  E8                    INX                                ;[x]
  436C  E0 54                 CPX   #$54                         ;[x]
  436E  D0 F6                 BNE   L0B_4366                     ;[x]
  4370  82                    CLX                                ;[x]
L0B_4371:
  4371  60                    RTS                                ;[x]

L0B_4372:
  4372  A5 0A                 LDA   <$0A                         ;[x]
  4374  29 7F                 AND   #$7F                         ;[x]
  4376  9D 1C 2F              STA   $2F1C,X                      ;[x]
  4379  A8                    TAY                                ;[x]
  437A  B9 9D 47              LDA   $479D,Y                      ;[x]
  437D  9D 00 2A              STA   $2A00,X                      ;[x]
  4380  B9 0F 47              LDA   $470F,Y                      ;[x]
  4383  9D F1 32              STA   $32F1,X                      ;[x]
  4386  B9 56 47              LDA   $4756,Y                      ;[x]
  4389  9D C1 39              STA   $39C1,X                      ;[x]
  438C  9E EC 35              STZ   $35EC,X                      ;[x]
  438F  9E 59 36              STZ   $3659,X                      ;[x]
  4392  20 4C 41              JSR   L0B_414C                     ;[x]
  4395  44 21                 BSR   L0B_43B8                     ;[x]
  4397  A5 0B                 LDA   <$0B                         ;[x]
  4399  29 7F                 AND   #$7F                         ;[x]
  439B  9D 38 34              STA   $3438,X                      ;[x]
  439E  A5 0A                 LDA   <$0A                         ;[x]
  43A0  29 7F                 AND   #$7F                         ;[x]
  43A2  3A                    DEC   A                            ;[x]
  43A3  0A                    ASL   A                            ;[x]
  43A4  A8                    TAY                                ;[x]
  43A5  B9 E4 47              LDA   $47E4,Y                      ;[x]
  43A8  9D 5E 33              STA   $335E,X                      ;[x]
  43AB  C8                    INY                                ;[x]
  43AC  B9 E4 47              LDA   $47E4,Y                      ;[x]
  43AF  9D CB 33              STA   $33CB,X                      ;[x]
  43B2  A5 99                 LDA   <$99                         ;[x]
  43B4  9D 12 35              STA   $3512,X                      ;[x]
  43B7  60                    RTS                                ;[x]

L0B_43B8:
  43B8  A5 09                 LDA   <$09                         ;[x]
  43BA  29 1F                 AND   #$1F                         ;[x]
  43BC  0A                    ASL   A                            ;[x]
  43BD  0A                    ASL   A                            ;[x]
  43BE  0A                    ASL   A                            ;[x]
  43BF  9D 47 2B              STA   $2B47,X                      ;[x]
  43C2  A9 E0                 LDA   #$E0                         ;[x]
  43C4  9D 8E 2C              STA   $2C8E,X                      ;[x]
  43C7  A9 FF                 LDA   #$FF                         ;[x]
  43C9  9D 21 2C              STA   $2C21,X                      ;[x]
  43CC  60                    RTS                                ;[x]

L0B_43CD:
  43CD  82                    CLX                                ;[x]
L0B_43CE:
  43CE  BD D0 3B              LDA   $3BD0,X                      ;[x]
  43D1  F0 06                 BEQ   L0B_43D9                     ;[x]
  43D3  E8                    INX                                ;[x]
  43D4  E0 08                 CPX   #$08                         ;[x]
  43D6  90 F6                 BCC   L0B_43CE                     ;[x]
  43D8  60                    RTS                                ;[ ]

L0B_43D9:
  43D9  20 21 44              JSR   L0B_4421                     ;[x]
  43DC  A5 0A                 LDA   <$0A                         ;[x]
  43DE  29 7F                 AND   #$7F                         ;[x]
  43E0  9D D0 3B              STA   $3BD0,X                      ;[x]
  43E3  A8                    TAY                                ;[x]
  43E4  88                    DEY                                ;[x]
  43E5  B9 B5 46              LDA   $46B5,Y                      ;[x]
  43E8  9D E0 3B              STA   $3BE0,X                      ;[x]
  43EB  9D F0 3B              STA   $3BF0,X                      ;[x]
  43EE  B9 D3 46              LDA   $46D3,Y                      ;[x]
  43F1  9D E8 3B              STA   $3BE8,X                      ;[x]
  43F4  9D 18 3C              STA   $3C18,X                      ;[x]
  43F7  B9 F1 46              LDA   $46F1,Y                      ;[x]
  43FA  9D 00 3C              STA   $3C00,X                      ;[x]
  43FD  A5 09                 LDA   <$09                         ;[x]
  43FF  29 1F                 AND   #$1F                         ;[x]
  4401  9D F8 3B              STA   $3BF8,X                      ;[x]
  4404  A5 0B                 LDA   <$0B                         ;[x]
  4406  29 1F                 AND   #$1F                         ;[x]
  4408  9D 08 3C              STA   $3C08,X                      ;[x]
  440B  A5 0B                 LDA   <$0B                         ;[x]
  440D  29 20                 AND   #$20                         ;[x]
  440F  0A                    ASL   A                            ;[x]
  4410  0A                    ASL   A                            ;[x]
  4411  0A                    ASL   A                            ;[x]
  4412  2A                    ROL   A                            ;[x]
  4413  9D 20 3C              STA   $3C20,X                      ;[x]
  4416  A9 42                 LDA   #$42                         ;[x]
  4418  9D 30 3C              STA   $3C30,X                      ;[x]
  441B  8A                    TXA                                ;[x]
  441C  1A                    INC   A                            ;[x]
  441D  9D D8 3B              STA   $3BD8,X                      ;[x]
  4420  60                    RTS                                ;[x]

L0B_4421:
  4421  9E C8 3B              STZ   $3BC8,X                      ;[x]
  4424  9E D0 3B              STZ   $3BD0,X                      ;[x]
  4427  9E D8 3B              STZ   $3BD8,X                      ;[x]
  442A  9E E0 3B              STZ   $3BE0,X                      ;[x]
  442D  9E E8 3B              STZ   $3BE8,X                      ;[x]
  4430  9E F0 3B              STZ   $3BF0,X                      ;[x]
  4433  9E F8 3B              STZ   $3BF8,X                      ;[x]
  4436  9E 00 3C              STZ   $3C00,X                      ;[x]
  4439  9E 08 3C              STZ   $3C08,X                      ;[x]
  443C  9E 10 3C              STZ   $3C10,X                      ;[x]
  443F  9E 18 3C              STZ   $3C18,X                      ;[x]
  4442  9E 20 3C              STZ   $3C20,X                      ;[x]
  4445  9E 28 3C              STZ   $3C28,X                      ;[x]
  4448  9E 30 3C              STZ   $3C30,X                      ;[x]
  444B  60                    RTS                                ;[x]

L0B_444C:
  444C  64 0C                 STZ   <$0C                         ;[x]
  444E  64 0D                 STZ   <$0D                         ;[x]
  4450  64 0E                 STZ   <$0E                         ;[x]
  4452  80 0C                 BRA   L0B_4460                     ;[x]

  4454  .db $64,$0D,$A9,$01,$85,$0E,$80,$04
L0B_445C:
  445C  A9 01                 LDA   #$01                         ;[x]
  445E  85 0E                 STA   <$0E                         ;[x]
L0B_4460:
  4460  84 B3                 STY   <$B3                         ;[x]
  4462  86 B2                 STX   <$B2                         ;[x]
  4464  BD 21 2C              LDA   $2C21,X                      ;[x]
  4467  85 08                 STA   <$08                         ;[x]
  4469  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  446C  85 09                 STA   <$09                         ;[x]
  446E  BD DA 2A              LDA   $2ADA,X                      ;[x]
  4471  85 0A                 STA   <$0A                         ;[x]
  4473  BD 47 2B              LDA   $2B47,X                      ;[x]
  4476  85 0B                 STA   <$0B                         ;[x]
  4478  20 F9 44              JSR   L0B_44F9                     ;[x]
  447B  E0 00                 CPX   #$00                         ;[x]
  447D  F0 75                 BEQ   L0B_44F4                     ;[x]
  447F  A5 0E                 LDA   <$0E                         ;[x]
  4481  D0 07                 BNE   L0B_448A                     ;[x]
  4483  20 07 45              JSR   L0B_4507                     ;[x]
  4486  C9 00                 CMP   #$00                         ;[x]
  4488  F0 6A                 BEQ   L0B_44F4                     ;[x]
L0B_448A:
  448A  A5 08                 LDA   <$08                         ;[x]
  448C  9D 21 2C              STA   $2C21,X                      ;[x]
  448F  A5 09                 LDA   <$09                         ;[x]
  4491  9D 8E 2C              STA   $2C8E,X                      ;[x]
  4494  A5 0A                 LDA   <$0A                         ;[x]
  4496  9D DA 2A              STA   $2ADA,X                      ;[x]
  4499  A5 0B                 LDA   <$0B                         ;[x]
  449B  9D 47 2B              STA   $2B47,X                      ;[x]
  449E  A5 0C                 LDA   <$0C                         ;[x]
  44A0  D0 1E                 BNE   L0B_44C0                     ;[x]
  44A2  AD 80 26              LDA   $2680                        ;[x]
  44A5  29 01                 AND   #$01                         ;[x]
  44A7  A8                    TAY                                ;[x]
  44A8  20 1C 40              JSR   L0B_401C                     ;[x]
  44AB  85 0C                 STA   <$0C                         ;[x]
  44AD  EE 80 26              INC   $2680                        ;[x]
  44B0  20 AB E8              JSR   L00_E8AB                     ;[x]
  44B3  AD 90 3F              LDA   $3F90                        ;[x]
  44B6  29 03                 AND   #$03                         ;[x]
  44B8  18                    CLC                                ;[x]
  44B9  65 0C                 ADC   <$0C                         ;[x]
  44BB  3A                    DEC   A                            ;[x]
  44BC  29 1F                 AND   #$1F                         ;[x]
  44BE  85 0C                 STA   <$0C                         ;[x]
L0B_44C0:
  44C0  A9 01                 LDA   #$01                         ;[x]
  44C2  9D 1C 2F              STA   $2F1C,X                      ;[x]
  44C5  A9 06                 LDA   #$06                         ;[x]
  44C7  9D F1 32              STA   $32F1,X                      ;[x]
  44CA  A9 0B                 LDA   #$0B                         ;[x]
  44CC  9D 6D 2A              STA   $2A6D,X                      ;[x]
  44CF  A9 03                 LDA   #$03                         ;[x]
  44D1  9D 00 2A              STA   $2A00,X                      ;[x]
  44D4  A9 01                 LDA   #$01                         ;[x]
  44D6  9D 5E 33              STA   $335E,X                      ;[x]
  44D9  9D CB 33              STA   $33CB,X                      ;[x]
  44DC  A5 0D                 LDA   <$0D                         ;[x]
  44DE  D0 0C                 BNE   L0B_44EC                     ;[x]
  44E0  A5 8F                 LDA   <$8F                         ;[x]
  44E2  4A                    LSR   A                            ;[x]
  44E3  85 08                 STA   <$08                         ;[x]
  44E5  A5 B1                 LDA   <$B1                         ;[x]
  44E7  0A                    ASL   A                            ;[x]
  44E8  65 08                 ADC   <$08                         ;[x]
  44EA  69 10                 ADC   #$10                         ;[x]
L0B_44EC:
  44EC  A8                    TAY                                ;[x]
  44ED  A5 0C                 LDA   <$0C                         ;[x]
  44EF  29 1F                 AND   #$1F                         ;[x]
  44F1  20 11 41              JSR   L0B_4111                     ;[x]
L0B_44F4:
  44F4  A6 B2                 LDX   <$B2                         ;[x]
  44F6  A4 B3                 LDY   <$B3                         ;[x]
  44F8  60                    RTS                                ;[x]

L0B_44F9:
  44F9  A2 30                 LDX   #$30                         ;[x]
L0B_44FB:
  44FB  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  44FE  F0 06                 BEQ   L0B_4506                     ;[x]
  4500  E8                    INX                                ;[x]
  4501  E0 42                 CPX   #$42                         ;[x]
  4503  D0 F6                 BNE   L0B_44FB                     ;[x]
  4505  82                    CLX                                ;[ ]
L0B_4506:
  4506  60                    RTS                                ;[x]

L0B_4507:
  4507  A5 08                 LDA   <$08                         ;[x]
  4509  05 0A                 ORA   <$0A                         ;[x]
  450B  D0 31                 BNE   L0B_453E                     ;[x]
  450D  A5 0B                 LDA   <$0B                         ;[x]
  450F  C9 E0                 CMP   #$E0                         ;[x]
  4511  B0 2B                 BCS   L0B_453E                     ;[x]
  4513  C9 10                 CMP   #$10                         ;[x]
  4515  90 27                 BCC   L0B_453E                     ;[x]
  4517  44 2F                 BSR   L0B_4548                     ;[x]
  4519  C2                    CLY                                ;[x]
L0B_451A:
  451A  98                    TYA                                ;[x]
  451B  1A                    INC   A                            ;[x]
  451C  25 86                 AND   <$86                         ;[x]
  451E  F0 20                 BEQ   L0B_4540                     ;[x]
  4520  B9 8E 2C              LDA   $2C8E,Y                      ;[x]
  4523  38                    SEC                                ;[x]
  4524  E5 09                 SBC   <$09                         ;[x]
  4526  10 03                 BPL   L0B_452B                     ;[x]
  4528  49 FF                 EOR   #$FF                         ;[x]
  452A  1A                    INC   A                            ;[x]
L0B_452B:
  452B  C9 28                 CMP   #$28                         ;[x]
  452D  B0 11                 BCS   L0B_4540                     ;[x]
  452F  B9 47 2B              LDA   $2B47,Y                      ;[x]
  4532  38                    SEC                                ;[x]
  4533  E5 0B                 SBC   <$0B                         ;[x]
  4535  10 03                 BPL   L0B_453A                     ;[x]
  4537  49 FF                 EOR   #$FF                         ;[x]
  4539  1A                    INC   A                            ;[x]
L0B_453A:
  453A  C9 30                 CMP   #$30                         ;[x]
  453C  B0 02                 BCS   L0B_4540                     ;[x]
L0B_453E:
  453E  62                    CLA                                ;[x]
  453F  60                    RTS                                ;[x]

L0B_4540:
  4540  C8                    INY                                ;[x]
  4541  C0 02                 CPY   #$02                         ;[x]
  4543  D0 D5                 BNE   L0B_451A                     ;[x]
  4545  A9 01                 LDA   #$01                         ;[x]
  4547  60                    RTS                                ;[x]

L0B_4548:
  4548  A5 8F                 LDA   <$8F                         ;[x]
  454A  C9 0B                 CMP   #$0B                         ;[x]
  454C  90 02                 BCC   L0B_4550                     ;[x]
  454E  A9 0B                 LDA   #$0B                         ;[ ]
L0B_4550:
  4550  A8                    TAY                                ;[x]
  4551  B9 5C 45              LDA   $455C,Y                      ;[x]
  4554  C5 09                 CMP   <$09                         ;[x]
  4556  B0 03                 BCS   L0B_455B                     ;[x]
  4558  68                    PLA                                ;[x]
  4559  68                    PLA                                ;[x]
  455A  62                    CLA                                ;[x]
L0B_455B:
  455B  60                    RTS                                ;[x]

  455C  .db $40,$50,$60,$70,$78,$80,$88,$90,$98,$A0,$B0,$C0
L0B_4568:
  4568  A5 0B                 LDA   <$0B                         ;[x]
  456A  1A                    INC   A                            ;[x]
  456B  D0 03                 BNE   L0B_4570                     ;[x]
  456D  4C 6F 46              JMP   L0B_466F                     ;[x]

L0B_4570:
  4570  1A                    INC   A                            ;[x]
  4571  D0 03                 BNE   L0B_4576                     ;[x]
  4573  4C 7A 46              JMP   L0B_467A                     ;[x]

L0B_4576:
  4576  1A                    INC   A                            ;[x]
  4577  D0 03                 BNE   L0B_457C                     ;[x]
  4579  4C 00 40              JMP   L0B_4000                     ;[x]

L0B_457C:
  457C  A5 0A                 LDA   <$0A                         ;[x]
  457E  85 10                 STA   <$10                         ;[x]
  4580  62                    CLA                                ;[x]
  4581  06 10                 ASL   <$10                         ;[x]
  4583  2A                    ROL   A                            ;[x]
  4584  06 10                 ASL   <$10                         ;[x]
  4586  2A                    ROL   A                            ;[x]
  4587  0A                    ASL   A                            ;[x]
  4588  A8                    TAY                                ;[x]
  4589  B9 97 45              LDA   $4597,Y                      ;[x]
  458C  85 11                 STA   <$11                         ;[x]
  458E  C8                    INY                                ;[x]
  458F  B9 97 45              LDA   $4597,Y                      ;[x]
  4592  85 12                 STA   <$12                         ;[x]
  4594  6C 11 20              JMP   ($2011)                      ;[x]

  4597  .db $9F,$45,$B2,$45,$F2,$45,$01,$46
L0B_459F:
  459F  A5 0A                 LDA   <$0A                         ;[x]
  45A1  AA                    TAX                                ;[x]
  45A2  A5 09                 LDA   <$09                         ;[x]
  45A4  0A                    ASL   A                            ;[x]
  45A5  0A                    ASL   A                            ;[x]
  45A6  0A                    ASL   A                            ;[x]
  45A7  9D AF 2B              STA   $2BAF,X                      ;[x]
  45AA  A5 0B                 LDA   <$0B                         ;[x]
  45AC  29 7F                 AND   #$7F                         ;[x]
  45AE  9D 84 2F              STA   $2F84,X                      ;[x]
  45B1  60                    RTS                                ;[x]

  45B2  DF 0A 23              BBS5  <$0A,L0B_45D8                ;[x]
  45B5  CF 0A 2D              BBS4  <$0A,L0B_45E5                ;[x]
  45B8  A5 0A                 LDA   <$0A                         ;[x]
  45BA  29 0F                 AND   #$0F                         ;[x]
  45BC  0A                    ASL   A                            ;[x]
  45BD  A8                    TAY                                ;[x]
  45BE  B9 CC 45              LDA   $45CC,Y                      ;[x]
  45C1  8D 74 3B              STA   $3B74                        ;[x]
  45C4  C8                    INY                                ;[x]
  45C5  B9 CC 45              LDA   $45CC,Y                      ;[x]
  45C8  8D 75 3B              STA   $3B75                        ;[x]
  45CB  60                    RTS                                ;[x]

  45CC  .db $00,$CC,$04,$00,$02,$00,$00,$55,$00,$20,$00,$80
L0B_45D8:
  45D8  A5 0A                 LDA   <$0A                         ;[ ]
  45DA  29 0F                 AND   #$0F                         ;[ ]
  45DC  AA                    TAX                                ;[ ]
  45DD  A5 0B                 LDA   <$0B                         ;[ ]
  45DF  29 7F                 AND   #$7F                         ;[ ]
  45E1  20 65 F0              JSR   L00_F065                     ;[ ]
  45E4  60                    RTS                                ;[ ]

L0B_45E5:
  45E5  A5 0A                 LDA   <$0A                         ;[x]
  45E7  29 0F                 AND   #$0F                         ;[x]
  45E9  AA                    TAX                                ;[x]
  45EA  A5 0B                 LDA   <$0B                         ;[x]
  45EC  29 7F                 AND   #$7F                         ;[x]
  45EE  20 D5 E8              JSR   L00_E8D5                     ;[x]
  45F1  60                    RTS                                ;[x]

  45F2  A5 0A                 LDA   <$0A                         ;[x]
  45F4  29 3F                 AND   #$3F                         ;[x]
  45F6  A8                    TAY                                ;[x]
  45F7  B9 FD 45              LDA   $45FD,Y                      ;[x]
  45FA  4C FC E3              JMP   L00_E3FC                     ;[x]

  45FD  .db $80,$87,$8C,$FE
L0B_4601:
  4601  86 B2                 STX   <$B2                         ;[x]
  4603  84 B3                 STY   <$B3                         ;[x]
  4605  A5 0B                 LDA   <$0B                         ;[x]
  4607  29 04                 AND   #$04                         ;[x]
  4609  F0 06                 BEQ   L0B_4611                     ;[x]
  460B  A5 B1                 LDA   <$B1                         ;[x]
  460D  05 9E                 ORA   <$9E                         ;[x]
  460F  D0 4B                 BNE   L0B_465C                     ;[x]
L0B_4611:
  4611  20 61 46              JSR   L0B_4661                     ;[x]
  4614  E0 00                 CPX   #$00                         ;[x]
  4616  F0 44                 BEQ   L0B_465C                     ;[x]
  4618  A9 01                 LDA   #$01                         ;[x]
  461A  9D 1C 2F              STA   $2F1C,X                      ;[x]
  461D  A9 01                 LDA   #$01                         ;[x]
  461F  9D 6D 2A              STA   $2A6D,X                      ;[x]
  4622  A9 03                 LDA   #$03                         ;[x]
  4624  9D 00 2A              STA   $2A00,X                      ;[x]
  4627  A9 08                 LDA   #$08                         ;[x]
  4629  9D 5E 33              STA   $335E,X                      ;[x]
  462C  A9 08                 LDA   #$08                         ;[x]
  462E  9D CB 33              STA   $33CB,X                      ;[x]
  4631  A5 0B                 LDA   <$0B                         ;[x]
  4633  29 03                 AND   #$03                         ;[x]
  4635  3A                    DEC   A                            ;[x]
  4636  F0 0B                 BEQ   L0B_4643                     ;[x]
  4638  3A                    DEC   A                            ;[x]
  4639  D0 04                 BNE   L0B_463F                     ;[x]
  463B  A5 B1                 LDA   <$B1                         ;[x]
  463D  D0 04                 BNE   L0B_4643                     ;[x]
L0B_463F:
  463F  A9 03                 LDA   #$03                         ;[x]
  4641  80 01                 BRA   L0B_4644                     ;[x]

L0B_4643:
  4643  62                    CLA                                ;[x]
L0B_4644:
  4644  9D F1 32              STA   $32F1,X                      ;[x]
  4647  A5 0B                 LDA   <$0B                         ;[x]
  4649  29 08                 AND   #$08                         ;[x]
  464B  F0 07                 BEQ   L0B_4654                     ;[x]
  464D  A9 C0                 LDA   #$C0                         ;[x]
  464F  9D AA 31              STA   $31AA,X                      ;[x]
  4652  80 05                 BRA   L0B_4659                     ;[x]

L0B_4654:
  4654  A9 80                 LDA   #$80                         ;[x]
  4656  9D AA 31              STA   $31AA,X                      ;[x]
L0B_4659:
  4659  20 B8 43              JSR   L0B_43B8                     ;[x]
L0B_465C:
  465C  A6 B2                 LDX   <$B2                         ;[x]
  465E  A4 B3                 LDY   <$B3                         ;[x]
  4660  60                    RTS                                ;[x]

L0B_4661:
  4661  A2 5A                 LDX   #$5A                         ;[x]
L0B_4663:
  4663  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  4666  F0 06                 BEQ   L0B_466E                     ;[x]
  4668  E8                    INX                                ;[x]
  4669  E0 60                 CPX   #$60                         ;[x]
  466B  D0 F6                 BNE   L0B_4663                     ;[x]
  466D  82                    CLX                                ;[x]
L0B_466E:
  466E  60                    RTS                                ;[x]

L0B_466F:
  466F  A5 09                 LDA   <$09                         ;[x]
  4671  29 1F                 AND   #$1F                         ;[x]
  4673  C5 8F                 CMP   <$8F                         ;[x]
  4675  90 02                 BCC   L0B_4679                     ;[x]
  4677  80 15                 BRA   L0B_468E                     ;[ ]

L0B_4679:
  4679  60                    RTS                                ;[x]

L0B_467A:
  467A  A5 9E                 LDA   <$9E                         ;[x]
  467C  0A                    ASL   A                            ;[x]
  467D  65 9E                 ADC   <$9E                         ;[x]
  467F  65 B1                 ADC   <$B1                         ;[x]
  4681  85 10                 STA   <$10                         ;[x]
  4683  A5 09                 LDA   <$09                         ;[x]
  4685  29 0F                 AND   #$0F                         ;[x]
  4687  C5 10                 CMP   <$10                         ;[x]
  4689  90 02                 BCC   L0B_468D                     ;[x]
  468B  80 01                 BRA   L0B_468E                     ;[x]

L0B_468D:
  468D  60                    RTS                                ;[x]

L0B_468E:
  468E  64 10                 STZ   <$10                         ;[x]
  4690  06 0A                 ASL   <$0A                         ;[x]
  4692  26 10                 ROL   <$10                         ;[x]
  4694  06 0A                 ASL   <$0A                         ;[x]
  4696  26 10                 ROL   <$10                         ;[x]
  4698  A5 97                 LDA   <$97                         ;[x]
  469A  18                    CLC                                ;[x]
  469B  65 0A                 ADC   <$0A                         ;[x]
  469D  85 97                 STA   <$97                         ;[x]
  469F  A5 98                 LDA   <$98                         ;[x]
  46A1  65 10                 ADC   <$10                         ;[x]
  46A3  85 98                 STA   <$98                         ;[x]
  46A5  60                    RTS                                ;[x]

L0B_46A6:
  46A6  A2 42                 LDX   #$42                         ;[x]
L0B_46A8:
  46A8  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  46AB  E8                    INX                                ;[x]
  46AC  E0 68                 CPX   #$68                         ;[x]
  46AE  D0 F8                 BNE   L0B_46A8                     ;[x]
  46B0  A5 0A                 LDA   <$0A                         ;[x]
  46B2  85 B7                 STA   <$B7                         ;[x]
  46B4  60                    RTS                                ;[x]

  46B5  .db $00,$10,$10,$10,$10,$14,$00,$00,$00,$10,$0C,$02,$00,$00,$00,$0E
  46C5  .db $18,$00,$20,$14,$10,$0C,$10,$02,$10,$00,$10,$08,$10,$10,$03,$06
  46D5  .db $06,$06,$04,$08,$06,$06,$05,$06,$06,$06,$05,$04,$02,$05,$08,$05
  46E5  .db $06,$06,$06,$06,$08,$06,$05,$05,$05,$0A,$06,$08,$03,$05,$06,$07
  46F5  .db $08,$09,$0A,$11,$15,$16,$17,$17,$1A,$1B,$1F,$25,$22,$1E,$24,$28
  4705  .db $29,$2A,$2C,$32,$33,$35,$36,$31,$42,$3B,$00,$00,$00,$01,$01,$01
  4715  .db $00,$01,$01,$01,$00,$02,$01,$81,$81,$81,$01,$00,$00,$01,$80,$01
  4725  .db $01,$01,$01,$00,$01,$00,$01,$00,$00,$01,$81,$01,$00,$00,$01,$01
  4735  .db $05,$01,$01,$01,$05,$01,$01,$01,$81,$81,$01,$01,$01,$01,$01,$01
  4745  .db $01,$05,$81,$81,$81,$01,$01,$81,$01,$08,$01,$05,$01,$81,$05,$05
  4755  .db $05,$00,$00,$00,$03,$02,$01,$02,$01,$02,$03,$04,$00,$00,$00,$00
  4765  .db $00,$01,$01,$00,$01,$00,$01,$01,$02,$03,$01,$01,$01,$02,$00,$00
  4775  .db $01,$01,$01,$00,$00,$00,$02,$02,$01,$02,$01,$01,$08,$01,$00,$01
  4785  .db $01,$01,$01,$01,$01,$01,$01,$01,$00,$01,$01,$01,$00,$02,$01,$10
  4795  .db $08,$01,$00,$01,$01,$00,$00,$00,$00,$03,$03,$01,$01,$01,$01,$01
  47A5  .db $01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04
  47B5  .db $04,$04,$04,$04,$05,$03,$06,$06,$06,$06,$06,$06,$06,$06,$06,$08
  47C5  .db $08,$08,$08,$08,$08,$08,$08,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
  47D5  .db $0B,$0B,$0B,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$00
  47E5  .db $00,$00,$00,$05,$05,$02,$0B,$04,$05,$05,$05,$02,$05,$04,$05,$05
  47F5  .db $05,$09,$05,$0A,$05,$01,$01,$08,$08,$08,$08,$08,$08,$05,$05,$05
  4805  .db $05,$00,$00,$0B,$0D,$08,$08,$05,$09,$05,$05,$0B,$05,$05,$05,$05
  4815  .db $05,$05,$05,$09,$05,$06,$0D,$08,$08,$05,$05,$05,$05,$08,$08,$05
  4825  .db $05,$05,$05,$05,$05,$05,$05,$09,$0D,$0D,$09,$05,$05,$05,$05,$0C
  4835  .db $0C,$05,$05,$05,$05,$05,$05,$0D,$0C,$08,$08,$08,$08,$05,$05,$05
  4845  .db $05,$05,$05,$05,$05,$05,$05,$04,$04,$05,$05,$05,$05,$08,$08,$08
  4855  .db $08,$08,$08,$03,$03,$03,$03,$03,$03,$03,$03,$05,$07,$03,$0E,$01
  4865  .db $01,$03,$03,$02,$02,$09,$01,$11,$08,$0D,$05
L0B_4870:
  4870  AD 83 26              LDA   $2683                        ;[x]
  4873  29 07                 AND   #$07                         ;[x]
  4875  D0 53                 BNE   L0B_48CA                     ;[x]
  4877  A5 B7                 LDA   <$B7                         ;[x]
  4879  3A                    DEC   A                            ;[x]
  487A  0A                    ASL   A                            ;[x]
  487B  A8                    TAY                                ;[x]
  487C  B9 86 49              LDA   $4986,Y                      ;[x]
  487F  85 05                 STA   <$05                         ;[x]
  4881  B9 87 49              LDA   $4987,Y                      ;[x]
  4884  85 06                 STA   <$06                         ;[x]
  4886  A6 02                 LDX   <$02                         ;[x]
  4888  A9 04                 LDA   #$04                         ;[x]
  488A  18                    CLC                                ;[x]
  488B  65 02                 ADC   <$02                         ;[x]
  488D  85 02                 STA   <$02                         ;[x]
L0B_488F:
  488F  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  4892  D0 2E                 BNE   L0B_48C2                     ;[x]
  4894  AD 84 26              LDA   $2684                        ;[x]
  4897  0A                    ASL   A                            ;[x]
  4898  A8                    TAY                                ;[x]
  4899  B1 05                 LDA   (<$05),Y                     ;[x]
  489B  85 00                 STA   <$00                         ;[x]
  489D  C8                    INY                                ;[x]
  489E  B1 05                 LDA   (<$05),Y                     ;[x]
  48A0  85 01                 STA   <$01                         ;[x]
  48A2  05 00                 ORA   <$00                         ;[x]
  48A4  F0 29                 BEQ   L0B_48CF                     ;[x]
  48A6  A9 03                 LDA   #$03                         ;[x]
  48A8  9D 00 2A              STA   $2A00,X                      ;[x]
  48AB  A9 25                 LDA   #$25                         ;[x]
  48AD  9D 6D 2A              STA   $2A6D,X                      ;[x]
  48B0  A9 06                 LDA   #$06                         ;[x]
  48B2  9D 33 37              STA   $3733,X                      ;[x]
  48B5  20 D2 48              JSR   L0B_48D2                     ;[x]
  48B8  A9 40                 LDA   #$40                         ;[x]
  48BA  20 FC E3              JSR   L00_E3FC                     ;[x]
  48BD  EE 84 26              INC   $2684                        ;[x]
  48C0  80 08                 BRA   L0B_48CA                     ;[x]

L0B_48C2:
  48C2  E8                    INX                                ;[x]
  48C3  E4 02                 CPX   <$02                         ;[x]
  48C5  D0 C8                 BNE   L0B_488F                     ;[x]
  48C7  A9 FF                 LDA   #$FF                         ;[ ]
  48C9  60                    RTS                                ;[ ]

L0B_48CA:
  48CA  EE 83 26              INC   $2683                        ;[x]
  48CD  62                    CLA                                ;[x]
  48CE  60                    RTS                                ;[x]

L0B_48CF:
  48CF  A9 01                 LDA   #$01                         ;[x]
  48D1  60                    RTS                                ;[x]

L0B_48D2:
  48D2  A4 03                 LDY   <$03                         ;[x]
  48D4  64 04                 STZ   <$04                         ;[x]
  48D6  A5 00                 LDA   <$00                         ;[x]
  48D8  10 02                 BPL   L0B_48DC                     ;[x]
  48DA  C6 04                 DEC   <$04                         ;[x]
L0B_48DC:
  48DC  B9 47 2B              LDA   $2B47,Y                      ;[x]
  48DF  18                    CLC                                ;[x]
  48E0  65 00                 ADC   <$00                         ;[x]
  48E2  9D 47 2B              STA   $2B47,X                      ;[x]
  48E5  B9 DA 2A              LDA   $2ADA,Y                      ;[x]
  48E8  65 04                 ADC   <$04                         ;[x]
  48EA  9D DA 2A              STA   $2ADA,X                      ;[x]
  48ED  64 04                 STZ   <$04                         ;[x]
  48EF  A5 01                 LDA   <$01                         ;[x]
  48F1  10 02                 BPL   L0B_48F5                     ;[x]
  48F3  C6 04                 DEC   <$04                         ;[x]
L0B_48F5:
  48F5  B9 8E 2C              LDA   $2C8E,Y                      ;[x]
  48F8  18                    CLC                                ;[x]
  48F9  65 01                 ADC   <$01                         ;[x]
  48FB  9D 8E 2C              STA   $2C8E,X                      ;[x]
  48FE  B9 21 2C              LDA   $2C21,Y                      ;[x]
  4901  65 04                 ADC   <$04                         ;[x]
  4903  9D 21 2C              STA   $2C21,X                      ;[x]
  4906  60                    RTS                                ;[x]

L0B_4907:
  4907  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  490A  F0 1D                 BEQ   L0B_4929                     ;[x]
  490C  BD 33 37              LDA   $3733,X                      ;[x]
  490F  D0 15                 BNE   L0B_4926                     ;[x]
  4911  BD 7F 35              LDA   $357F,X                      ;[x]
  4914  9D 33 37              STA   $3733,X                      ;[x]
  4917  FE 6D 2A              INC   $2A6D,X                      ;[x]
  491A  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  491D  C9 14                 CMP   #$14                         ;[x]
  491F  D0 05                 BNE   L0B_4926                     ;[x]
  4921  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  4924  80 03                 BRA   L0B_4929                     ;[x]

L0B_4926:
  4926  DE 33 37              DEC   $3733,X                      ;[x]
L0B_4929:
  4929  60                    RTS                                ;[x]

L0B_492A:
  492A  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  492D  F0 1A                 BEQ   L0B_4949                     ;[x]
  492F  DE 33 37              DEC   $3733,X                      ;[x]
  4932  D0 15                 BNE   L0B_4949                     ;[x]
  4934  A9 06                 LDA   #$06                         ;[x]
  4936  9D 33 37              STA   $3733,X                      ;[x]
  4939  FE 6D 2A              INC   $2A6D,X                      ;[x]
  493C  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  493F  C9 29                 CMP   #$29                         ;[x]
  4941  F0 03                 BEQ   L0B_4946                     ;[x]
  4943  4C 26 49              JMP   L0B_4926                     ;[x]

L0B_4946:
  4946  20 2B 4D              JSR   L0B_4D2B                     ;[x]
L0B_4949:
  4949  60                    RTS                                ;[x]

L0B_494A:
  494A  A2 30                 LDX   #$30                         ;[x]
L0B_494C:
  494C  9E F1 32              STZ   $32F1,X                      ;[x]
  494F  E8                    INX                                ;[x]
  4950  E0 68                 CPX   #$68                         ;[x]
  4952  D0 F8                 BNE   L0B_494C                     ;[x]
  4954  60                    RTS                                ;[x]

  4955  .db $64,$00,$AD,$89,$2F,$C9,$06,$B0,$02,$E6,$00,$AD,$8A,$2F,$C9,$06
  4965  .db $B0,$06,$A5,$00,$09,$02,$85,$00,$C6,$00,$60
L0B_4970:
  4970  A9 07                 LDA   #$07                         ;[ ]
  4972  85 10                 STA   <$10                         ;[ ]
L0B_4974:
  4974  A5 0C                 LDA   <$0C                         ;[ ]
  4976  09 80                 ORA   #$80                         ;[ ]
  4978  85 0C                 STA   <$0C                         ;[ ]
  497A  20 60 44              JSR   L0B_4460                     ;[ ]
  497D  E6 0C                 INC   <$0C                         ;[ ]
  497F  E6 0C                 INC   <$0C                         ;[ ]
  4981  C6 10                 DEC   <$10                         ;[ ]
  4983  D0 EF                 BNE   L0B_4974                     ;[ ]
  4985  60                    RTS                                ;[ ]

  4986  .db $90,$49,$B2,$49,$90,$49,$90,$49,$90,$49,$E8,$F2,$20,$E0,$10,$20
  4996  .db $F7,$28,$00,$30,$18,$00,$F0,$F8,$1C,$10,$E4,$20,$00,$E0,$10,$10
  49A6  .db $E8,$00,$F0,$38,$28,$18,$E8,$F8,$18,$F8,$00,$00,$E0,$10,$20,$80
  49B6  .db $30,$00,$F0,$B8,$C0,$18,$10,$F0,$D0,$90,$08,$08,$00,$10,$00,$98
  49C6  .db $D8,$D8,$10,$B0,$C8,$20,$FF,$C0,$40,$F6,$E0,$A0,$F8,$30,$F0,$FC
  49D6  .db $13,$F0,$E2,$18,$00,$00
L0B_49DC:
  49DC  82                    CLX                                ;[x]
L0B_49DD:
  49DD  BD D0 3B              LDA   $3BD0,X                      ;[x]
  49E0  29 7F                 AND   #$7F                         ;[x]
  49E2  F0 02                 BEQ   L0B_49E6                     ;[x]
  49E4  44 06                 BSR   L0B_49EC                     ;[x]
L0B_49E6:
  49E6  E8                    INX                                ;[x]
  49E7  E0 08                 CPX   #$08                         ;[x]
  49E9  90 F2                 BCC   L0B_49DD                     ;[x]
  49EB  60                    RTS                                ;[x]

L0B_49EC:
  49EC  3A                    DEC   A                            ;[x]
  49ED  20 A2 E7              JSR   L00_E7A2                     ;[x]
  49F0  32 4A                 AND   (<$4A)                       ;[ ]
  49F2  3D 4B 3D              AND   $3D4B,X                      ;[ ]
  49F5  .db $4B,$3D,$4B,$3D,$4B,$5D,$4A,$85,$4A,$85,$4A,$A8,$4A,$3D,$4B,$E2
  4A05  .db $4A,$3D,$4B,$A8,$4A,$A8,$4A,$08,$4B,$3D,$4B,$3D,$4B,$85,$4A,$5D
  4A15  .db $4A,$5D,$4A,$3D,$4B,$3D,$4B,$3D,$4B,$4C,$4B,$C1,$4A,$85,$4A,$C1
  4A25  .db $4A,$1F,$4B,$3D,$4B,$5D,$4A
L0B_4A2C:
  4A2C  A9 80                 LDA   #$80                         ;[x]
  4A2E  9D D0 3B              STA   $3BD0,X                      ;[x]
  4A31  60                    RTS                                ;[x]

  4A32  BD F8 3B              LDA   $3BF8,X                      ;[x]
  4A35  85 09                 STA   <$09                         ;[x]
  4A37  BD 00 3C              LDA   $3C00,X                      ;[x]
  4A3A  85 0A                 STA   <$0A                         ;[x]
  4A3C  BD 08 3C              LDA   $3C08,X                      ;[x]
  4A3F  85 0B                 STA   <$0B                         ;[x]
  4A41  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4A44  E6 0A                 INC   <$0A                         ;[x]
  4A46  A5 09                 LDA   <$09                         ;[x]
  4A48  18                    CLC                                ;[x]
  4A49  69 04                 ADC   #$04                         ;[x]
  4A4B  85 09                 STA   <$09                         ;[x]
  4A4D  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4A50  A5 09                 LDA   <$09                         ;[x]
  4A52  18                    CLC                                ;[x]
  4A53  69 04                 ADC   #$04                         ;[x]
  4A55  85 09                 STA   <$09                         ;[x]
  4A57  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4A5A  4C 2C 4A              JMP   L0B_4A2C                     ;[x]

  4A5D  FE 28 3C              INC   $3C28,X                      ;[x]
  4A60  20 5B 4B              JSR   L0B_4B5B                     ;[x]
  4A63  BD F8 3B              LDA   $3BF8,X                      ;[x]
  4A66  85 09                 STA   <$09                         ;[x]
  4A68  BD 00 3C              LDA   $3C00,X                      ;[x]
  4A6B  85 0A                 STA   <$0A                         ;[x]
  4A6D  FE 08 3C              INC   $3C08,X                      ;[x]
  4A70  BD 08 3C              LDA   $3C08,X                      ;[x]
  4A73  49 01                 EOR   #$01                         ;[x]
  4A75  29 01                 AND   #$01                         ;[x]
  4A77  85 0B                 STA   <$0B                         ;[x]
  4A79  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4A7C  DE E8 3B              DEC   $3BE8,X                      ;[x]
  4A7F  D0 03                 BNE   L0B_4A84                     ;[x]
  4A81  4C 2C 4A              JMP   L0B_4A2C                     ;[x]

L0B_4A84:
  4A84  60                    RTS                                ;[x]

  4A85  BD F8 3B              LDA   $3BF8,X                      ;[x]
  4A88  85 09                 STA   <$09                         ;[x]
  4A8A  BD 00 3C              LDA   $3C00,X                      ;[x]
  4A8D  85 0A                 STA   <$0A                         ;[x]
  4A8F  BD 08 3C              LDA   $3C08,X                      ;[x]
  4A92  85 0B                 STA   <$0B                         ;[x]
L0B_4A94:
  4A94  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4A97  A5 09                 LDA   <$09                         ;[x]
  4A99  18                    CLC                                ;[x]
  4A9A  69 03                 ADC   #$03                         ;[x]
  4A9C  85 09                 STA   <$09                         ;[x]
  4A9E  E6 0B                 INC   <$0B                         ;[x]
  4AA0  DE E8 3B              DEC   $3BE8,X                      ;[x]
  4AA3  D0 EF                 BNE   L0B_4A94                     ;[x]
  4AA5  4C 2C 4A              JMP   L0B_4A2C                     ;[x]

  4AA8  BD F8 3B              LDA   $3BF8,X                      ;[x]
  4AAB  85 09                 STA   <$09                         ;[x]
  4AAD  BD 00 3C              LDA   $3C00,X                      ;[x]
  4AB0  85 0A                 STA   <$0A                         ;[x]
  4AB2  64 0B                 STZ   <$0B                         ;[x]
L0B_4AB4:
  4AB4  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4AB7  E6 0B                 INC   <$0B                         ;[x]
  4AB9  DE E8 3B              DEC   $3BE8,X                      ;[x]
  4ABC  D0 F6                 BNE   L0B_4AB4                     ;[x]
  4ABE  4C 2C 4A              JMP   L0B_4A2C                     ;[x]

  4AC1  .db $20,$5B,$4B,$BD,$F8,$3B,$85,$09,$BD,$00,$3C,$85,$0A,$BD,$08,$3C
  4AD1  .db $85,$0B,$20,$7C,$4B,$FE,$08,$3C,$DE,$E8,$3B,$D0,$03,$4C,$2C,$4A
  4AE1  .db $60
L0B_4AE2:
  4AE2  20 5B 4B              JSR   L0B_4B5B                     ;[x]
  4AE5  BD F8 3B              LDA   $3BF8,X                      ;[x]
  4AE8  85 09                 STA   <$09                         ;[x]
  4AEA  BD 00 3C              LDA   $3C00,X                      ;[x]
  4AED  85 0A                 STA   <$0A                         ;[x]
  4AEF  BD 08 3C              LDA   $3C08,X                      ;[x]
  4AF2  1A                    INC   A                            ;[x]
  4AF3  29 01                 AND   #$01                         ;[x]
  4AF5  9D 08 3C              STA   $3C08,X                      ;[x]
  4AF8  0A                    ASL   A                            ;[x]
  4AF9  1A                    INC   A                            ;[x]
  4AFA  85 0B                 STA   <$0B                         ;[x]
  4AFC  20 7C 4B              JSR   L0B_4B7C                     ;[x]
  4AFF  DE E8 3B              DEC   $3BE8,X                      ;[x]
  4B02  D0 03                 BNE   L0B_4B07                     ;[x]
  4B04  4C 2C 4A              JMP   L0B_4A2C                     ;[x]

L0B_4B07:
  4B07  60                    RTS                                ;[x]

  4B08  .db $BD,$F8,$3B,$85,$09,$BD,$00,$3C,$85,$0A,$64,$0B,$20,$7C,$4B,$E6
  4B18  .db $0B,$20,$7C,$4B,$4C,$2C,$4A,$20,$5B,$4B,$BD,$00,$3C,$85,$0A,$64
  4B28  .db $0B,$20,$7C,$4B,$E6,$0B,$20,$7C,$4B,$DE,$E8,$3B,$DE,$E8,$3B,$D0
  4B38  .db $03,$4C,$2C,$4A,$60
L0B_4B3D:
  4B3D  20 5B 4B              JSR   L0B_4B5B                     ;[x]
  4B40  20 6D 4B              JSR   L0B_4B6D                     ;[x]
  4B43  DE E8 3B              DEC   $3BE8,X                      ;[x]
  4B46  D0 03                 BNE   L0B_4B4B                     ;[x]
  4B48  4C 2C 4A              JMP   L0B_4A2C                     ;[x]

L0B_4B4B:
  4B4B  60                    RTS                                ;[x]

  4B4C  .db $20,$5B,$4B,$20,$9B,$4B,$DE,$E8,$3B,$D0,$03,$4C,$2C,$4A,$60
L0B_4B5B:
  4B5B  BD E0 3B              LDA   $3BE0,X                      ;[x]
  4B5E  F0 06                 BEQ   L0B_4B66                     ;[x]
  4B60  DE E0 3B              DEC   $3BE0,X                      ;[x]
  4B63  68                    PLA                                ;[x]
  4B64  68                    PLA                                ;[x]
  4B65  60                    RTS                                ;[x]

L0B_4B66:
  4B66  BD F0 3B              LDA   $3BF0,X                      ;[x]
  4B69  9D E0 3B              STA   $3BE0,X                      ;[x]
  4B6C  60                    RTS                                ;[x]

L0B_4B6D:
  4B6D  BD F8 3B              LDA   $3BF8,X                      ;[x]
  4B70  85 09                 STA   <$09                         ;[x]
  4B72  BD 00 3C              LDA   $3C00,X                      ;[x]
  4B75  85 0A                 STA   <$0A                         ;[x]
  4B77  BD 08 3C              LDA   $3C08,X                      ;[x]
  4B7A  85 0B                 STA   <$0B                         ;[x]
L0B_4B7C:
  4B7C  BD D8 3B              LDA   $3BD8,X                      ;[x]
  4B7F  85 99                 STA   <$99                         ;[x]
  4B81  86 B2                 STX   <$B2                         ;[x]
  4B83  20 37 43              JSR   L0B_4337                     ;[x]
  4B86  E0 00                 CPX   #$00                         ;[x]
  4B88  D0 0C                 BNE   L0B_4B96                     ;[x]
  4B8A  A6 B2                 LDX   <$B2                         ;[x]
  4B8C  DE 18 3C              DEC   $3C18,X                      ;[x]
  4B8F  D0 07                 BNE   L0B_4B98                     ;[x]
  4B91  20 21 44              JSR   L0B_4421                     ;[ ]
  4B94  80 02                 BRA   L0B_4B98                     ;[ ]

L0B_4B96:
  4B96  A6 B2                 LDX   <$B2                         ;[x]
L0B_4B98:
  4B98  64 99                 STZ   <$99                         ;[x]
  4B9A  60                    RTS                                ;[x]

  4B9B  .db $BD,$F8,$3B,$85,$09,$BD,$00,$3C,$85,$0A,$BD,$08,$3C,$85,$0B,$BD
  4BAB  .db $D8,$3B,$85,$99,$BD,$30,$3C,$86,$B2,$20,$4E,$43,$E0,$00,$D0,$0C
  4BBB  .db $A6,$B2,$DE,$18,$3C,$D0,$0B,$20,$21,$44,$80,$06,$8A,$A6,$B2,$9D
  4BCB  .db $30,$3C,$64,$99,$60
L0B_4BD0:
  4BD0  A2 42                 LDX   #$42                         ;[x]
L0B_4BD2:
  4BD2  86 B2                 STX   <$B2                         ;[x]
  4BD4  8A                    TXA                                ;[x]
  4BD5  C9 54                 CMP   #$54                         ;[x]
  4BD7  90 06                 BCC   L0B_4BDF                     ;[x]
  4BD9  C9 60                 CMP   #$60                         ;[x]
  4BDB  B0 02                 BCS   L0B_4BDF                     ;[x]
  4BDD  80 3D                 BRA   L0B_4C1C                     ;[x]

L0B_4BDF:
  4BDF  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  4BE2  F0 38                 BEQ   L0B_4C1C                     ;[x]
  4BE4  BD F1 32              LDA   $32F1,X                      ;[x]
  4BE7  29 3F                 AND   #$3F                         ;[x]
  4BE9  C9 01                 CMP   #$01                         ;[x]
  4BEB  F0 04                 BEQ   L0B_4BF1                     ;[x]
  4BED  C9 08                 CMP   #$08                         ;[x]
  4BEF  D0 1B                 BNE   L0B_4C0C                     ;[x]
L0B_4BF1:
  4BF1  BD F1 32              LDA   $32F1,X                      ;[x]
  4BF4  29 40                 AND   #$40                         ;[x]
  4BF6  F0 14                 BEQ   L0B_4C0C                     ;[x]
  4BF8  BD A5 34              LDA   $34A5,X                      ;[x]
  4BFB  10 05                 BPL   L0B_4C02                     ;[x]
  4BFD  20 F6 59              JSR   L0B_59F6                     ;[x]
  4C00  80 0A                 BRA   L0B_4C0C                     ;[x]

L0B_4C02:
  4C02  A9 08                 LDA   #$08                         ;[x]
  4C04  9D 33 37              STA   $3733,X                      ;[x]
  4C07  A9 02                 LDA   #$02                         ;[x]
  4C09  9D F1 32              STA   $32F1,X                      ;[x]
L0B_4C0C:
  4C0C  BD 33 37              LDA   $3733,X                      ;[x]
  4C0F  F0 03                 BEQ   L0B_4C14                     ;[x]
  4C11  20 A4 4D              JSR   L0B_4DA4                     ;[x]
L0B_4C14:
  4C14  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  4C17  44 0B                 BSR   L0B_4C24                     ;[x]
  4C19  20 C5 4C              JSR   L0B_4CC5                     ;[x]
L0B_4C1C:
  4C1C  A6 B2                 LDX   <$B2                         ;[x]
  4C1E  E8                    INX                                ;[x]
  4C1F  E0 68                 CPX   #$68                         ;[x]
  4C21  D0 AF                 BNE   L0B_4BD2                     ;[x]
  4C23  60                    RTS                                ;[x]

L0B_4C24:
  4C24  3A                    DEC   A                            ;[x]
  4C25  20 A2 E7              JSR   L00_E7A2                     ;[x]
  4C28  1F 59 1F              BBR1  <$59,L0B_4C4A                ;[ ]
  4C2B  59 0E 62              EOR   $620E,Y                      ;[ ]
  4C2E  0E 62 00              ASL   $0062                        ;[ ]
  4C31  61 7B                 ADC   (<$7B,X)                     ;[ ]
  4C33  .db $63,$34,$62,$8B,$64,$FE,$65,$2D,$65,$C5,$66,$F7,$67,$E0,$4E,$E0
  4C43  .db $4E,$2E,$4F,$EF,$7A,$20,$75
L0B_4C4A:
  4C4A  C2                    CLY                                ;[ ]
  4C4B  7A                    PLY                                ;[ ]
  4C4C  D3 7A D5 4F D7 78 0D  TIN   $D57A,$D74F,$0D78            ;[ ]
  4C53  76 6B                 ROR   <$6B,X                       ;[ ]
  4C55  76 AA                 ROR   <$AA,X                       ;[ ]
  4C57  77 1F                 RMB7  <$1F                         ;[ ]
  4C59  7A                    PLY                                ;[ ]
  4C5A  1C 77 80              TRB   $8077                        ;[ ]
  4C5D  .db $7B,$C7,$7C,$AA,$53,$EB,$96,$06,$95,$E0,$4E,$B2,$97,$B0,$99,$69
  4C6D  .db $99,$42,$96,$90,$95,$4A,$98,$7C,$A2,$57,$A3,$95,$A4,$4C,$A5,$FF
  4C7D  .db $A5,$3C,$A7,$B3,$A7,$E0,$4E,$E0,$4E,$C8,$B4,$8E,$B5,$09,$B6,$B7
  4C8D  .db $B6,$B8,$B7,$21,$B8,$82,$B8,$47,$B9,$47,$50,$18,$51,$E0,$4E,$62
  4C9D  .db $CC,$E0,$CC,$31,$52,$BD,$CD,$43,$CE,$BC,$CE,$CC,$CF,$8E,$D0,$E0
  4CAD  .db $4E,$0A,$D1,$DF,$D1,$32,$D3,$A8,$D5,$A9,$D5,$A9,$D5,$A9,$D5,$84
  4CBD  .db $D5,$C4,$4C,$74,$5A,$1F,$59,$60
L0B_4CC5:
  4CC5  20 EB 4D              JSR   L0B_4DEB                     ;[x]
  4CC8  20 06 4E              JSR   L0B_4E06                     ;[x]
  4CCB  20 21 4E              JSR   L0B_4E21                     ;[x]
  4CCE  20 4B 4E              JSR   L0B_4E4B                     ;[x]
  4CD1  BD 9B 3A              LDA   $3A9B,X                      ;[x]
  4CD4  29 80                 AND   #$80                         ;[x]
  4CD6  F0 03                 BEQ   L0B_4CDB                     ;[x]
  4CD8  4C A3 4D              JMP   L0B_4DA3                     ;[x]

L0B_4CDB:
  4CDB  BD 21 2C              LDA   $2C21,X                      ;[x]
  4CDE  C9 01                 CMP   #$01                         ;[x]
  4CE0  F0 30                 BEQ   L0B_4D12                     ;[x]
  4CE2  BD DA 2A              LDA   $2ADA,X                      ;[x]
  4CE5  C9 FF                 CMP   #$FF                         ;[x]
  4CE7  D0 07                 BNE   L0B_4CF0                     ;[x]
  4CE9  BD 47 2B              LDA   $2B47,X                      ;[x]
  4CEC  C9 E0                 CMP   #$E0                         ;[x]
  4CEE  90 22                 BCC   L0B_4D12                     ;[x]
L0B_4CF0:
  4CF0  BD DA 2A              LDA   $2ADA,X                      ;[x]
  4CF3  C9 01                 CMP   #$01                         ;[x]
  4CF5  D0 07                 BNE   L0B_4CFE                     ;[x]
  4CF7  BD 47 2B              LDA   $2B47,X                      ;[x]
  4CFA  C9 10                 CMP   #$10                         ;[x]
  4CFC  B0 14                 BCS   L0B_4D12                     ;[x]
L0B_4CFE:
  4CFE  BD 21 2C              LDA   $2C21,X                      ;[x]
  4D01  C9 FF                 CMP   #$FF                         ;[x]
  4D03  F0 03                 BEQ   L0B_4D08                     ;[x]
  4D05  4C A3 4D              JMP   L0B_4DA3                     ;[x]

L0B_4D08:
  4D08  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  4D0B  C9 D0                 CMP   #$D0                         ;[x]
  4D0D  90 03                 BCC   L0B_4D12                     ;[x]
  4D0F  4C A3 4D              JMP   L0B_4DA3                     ;[x]

L0B_4D12:
  4D12  BD 12 35              LDA   $3512,X                      ;[x]
  4D15  F0 14                 BEQ   L0B_4D2B                     ;[x]
  4D17  86 00                 STX   <$00                         ;[x]
  4D19  3A                    DEC   A                            ;[x]
  4D1A  AA                    TAX                                ;[x]
  4D1B  9E 20 3C              STZ   $3C20,X                      ;[x]
  4D1E  DE 18 3C              DEC   $3C18,X                      ;[x]
  4D21  BD 18 3C              LDA   $3C18,X                      ;[x]
  4D24  D0 03                 BNE   L0B_4D29                     ;[x]
  4D26  20 21 44              JSR   L0B_4421                     ;[x]
L0B_4D29:
  4D29  A6 00                 LDX   <$00                         ;[x]
L0B_4D2B:
  4D2B  9E DA 2A              STZ   $2ADA,X                      ;[x]
  4D2E  9E 47 2B              STZ   $2B47,X                      ;[x]
  4D31  9E B4 2B              STZ   $2BB4,X                      ;[x]
  4D34  9E 21 2C              STZ   $2C21,X                      ;[x]
  4D37  9E 8E 2C              STZ   $2C8E,X                      ;[x]
  4D3A  9E FB 2C              STZ   $2CFB,X                      ;[x]
  4D3D  9E 38 34              STZ   $3438,X                      ;[x]
L0B_4D40:
  4D40  9E 00 2A              STZ   $2A00,X                      ;[x]
  4D43  9E 6D 2A              STZ   $2A6D,X                      ;[x]
  4D46  9E 68 2D              STZ   $2D68,X                      ;[x]
  4D49  9E D5 2D              STZ   $2DD5,X                      ;[x]
  4D4C  9E 42 2E              STZ   $2E42,X                      ;[x]
  4D4F  9E AF 2E              STZ   $2EAF,X                      ;[x]
  4D52  9E 1C 2F              STZ   $2F1C,X                      ;[x]
  4D55  9E 89 2F              STZ   $2F89,X                      ;[x]
  4D58  9E F6 2F              STZ   $2FF6,X                      ;[x]
  4D5B  9E 63 30              STZ   $3063,X                      ;[x]
  4D5E  9E D0 30              STZ   $30D0,X                      ;[x]
  4D61  9E 3D 31              STZ   $313D,X                      ;[x]
  4D64  9E AA 31              STZ   $31AA,X                      ;[x]
  4D67  9E 17 32              STZ   $3217,X                      ;[x]
  4D6A  9E 84 32              STZ   $3284,X                      ;[x]
  4D6D  9E F1 32              STZ   $32F1,X                      ;[x]
  4D70  9E 5E 33              STZ   $335E,X                      ;[x]
  4D73  9E CB 33              STZ   $33CB,X                      ;[x]
  4D76  9E A5 34              STZ   $34A5,X                      ;[x]
  4D79  9E 7F 35              STZ   $357F,X                      ;[x]
  4D7C  9E 12 35              STZ   $3512,X                      ;[x]
  4D7F  9E EC 35              STZ   $35EC,X                      ;[x]
  4D82  9E 59 36              STZ   $3659,X                      ;[x]
  4D85  9E C6 36              STZ   $36C6,X                      ;[x]
  4D88  9E 33 37              STZ   $3733,X                      ;[x]
  4D8B  9E A0 37              STZ   $37A0,X                      ;[x]
  4D8E  9E 0D 38              STZ   $380D,X                      ;[x]
  4D91  9E 7A 38              STZ   $387A,X                      ;[x]
  4D94  9E E7 38              STZ   $38E7,X                      ;[x]
  4D97  9E 54 39              STZ   $3954,X                      ;[x]
  4D9A  9E C1 39              STZ   $39C1,X                      ;[x]
  4D9D  9E 2E 3A              STZ   $3A2E,X                      ;[x]
  4DA0  9E 9B 3A              STZ   $3A9B,X                      ;[x]
L0B_4DA3:
  4DA3  60                    RTS                                ;[x]

L0B_4DA4:
  4DA4  BD F1 32              LDA   $32F1,X                      ;[x]
  4DA7  29 0F                 AND   #$0F                         ;[x]
  4DA9  F0 20                 BEQ   L0B_4DCB                     ;[x]
  4DAB  BD 33 37              LDA   $3733,X                      ;[x]
  4DAE  C9 01                 CMP   #$01                         ;[x]
  4DB0  F0 0D                 BEQ   L0B_4DBF                     ;[x]
  4DB2  A5 32                 LDA   <$32                         ;[x]
  4DB4  29 01                 AND   #$01                         ;[x]
  4DB6  D0 0C                 BNE   L0B_4DC4                     ;[x]
  4DB8  A9 88                 LDA   #$88                         ;[x]
  4DBA  9D 42 2E              STA   $2E42,X                      ;[x]
  4DBD  80 08                 BRA   L0B_4DC7                     ;[x]

L0B_4DBF:
  4DBF  A9 01                 LDA   #$01                         ;[x]
  4DC1  9D F1 32              STA   $32F1,X                      ;[x]
L0B_4DC4:
  4DC4  9E 42 2E              STZ   $2E42,X                      ;[x]
L0B_4DC7:
  4DC7  DE 33 37              DEC   $3733,X                      ;[x]
  4DCA  60                    RTS                                ;[x]

L0B_4DCB:
  4DCB  BD 33 37              LDA   $3733,X                      ;[x]
  4DCE  C9 01                 CMP   #$01                         ;[x]
  4DD0  F0 0B                 BEQ   L0B_4DDD                     ;[x]
  4DD2  A5 32                 LDA   <$32                         ;[x]
  4DD4  29 01                 AND   #$01                         ;[x]
  4DD6  D0 0A                 BNE   L0B_4DE2                     ;[x]
  4DD8  9E 6D 2A              STZ   $2A6D,X                      ;[x]
  4DDB  80 EA                 BRA   L0B_4DC7                     ;[x]

L0B_4DDD:
  4DDD  A9 01                 LDA   #$01                         ;[x]
  4DDF  9D F1 32              STA   $32F1,X                      ;[x]
L0B_4DE2:
  4DE2  BD EC 35              LDA   $35EC,X                      ;[x]
  4DE5  3A                    DEC   A                            ;[x]
  4DE6  20 7F 41              JSR   L0B_417F                     ;[x]
  4DE9  80 DC                 BRA   L0B_4DC7                     ;[x]

L0B_4DEB:
  4DEB  18                    CLC                                ;[x]
  4DEC  BD D0 30              LDA   $30D0,X                      ;[x]
  4DEF  7D 17 32              ADC   $3217,X                      ;[x]
  4DF2  9D D0 30              STA   $30D0,X                      ;[x]
  4DF5  BD 17 32              LDA   $3217,X                      ;[x]
  4DF8  10 04                 BPL   L0B_4DFE                     ;[x]
  4DFA  A9 FF                 LDA   #$FF                         ;[x]
  4DFC  80 01                 BRA   L0B_4DFF                     ;[x]

L0B_4DFE:
  4DFE  62                    CLA                                ;[x]
L0B_4DFF:
  4DFF  7D 63 30              ADC   $3063,X                      ;[x]
  4E02  9D 63 30              STA   $3063,X                      ;[x]
  4E05  60                    RTS                                ;[x]

L0B_4E06:
  4E06  18                    CLC                                ;[x]
  4E07  BD AA 31              LDA   $31AA,X                      ;[x]
  4E0A  7D 84 32              ADC   $3284,X                      ;[x]
  4E0D  9D AA 31              STA   $31AA,X                      ;[x]
  4E10  BD 84 32              LDA   $3284,X                      ;[x]
  4E13  10 04                 BPL   L0B_4E19                     ;[x]
  4E15  A9 FF                 LDA   #$FF                         ;[x]
  4E17  80 01                 BRA   L0B_4E1A                     ;[x]

L0B_4E19:
  4E19  62                    CLA                                ;[x]
L0B_4E1A:
  4E1A  7D 3D 31              ADC   $313D,X                      ;[x]
  4E1D  9D 3D 31              STA   $313D,X                      ;[x]
  4E20  60                    RTS                                ;[x]

L0B_4E21:
  4E21  64 02                 STZ   <$02                         ;[x]
  4E23  BD D0 30              LDA   $30D0,X                      ;[x]
  4E26  85 00                 STA   <$00                         ;[x]
  4E28  BD 63 30              LDA   $3063,X                      ;[x]
  4E2B  85 01                 STA   <$01                         ;[x]
  4E2D  10 02                 BPL   L0B_4E31                     ;[x]
  4E2F  C6 02                 DEC   <$02                         ;[x]
L0B_4E31:
  4E31  BD B4 2B              LDA   $2BB4,X                      ;[x]
  4E34  18                    CLC                                ;[x]
  4E35  65 00                 ADC   <$00                         ;[x]
  4E37  9D B4 2B              STA   $2BB4,X                      ;[x]
  4E3A  BD 47 2B              LDA   $2B47,X                      ;[x]
  4E3D  65 01                 ADC   <$01                         ;[x]
  4E3F  9D 47 2B              STA   $2B47,X                      ;[x]
  4E42  BD DA 2A              LDA   $2ADA,X                      ;[x]
  4E45  65 02                 ADC   <$02                         ;[x]
  4E47  9D DA 2A              STA   $2ADA,X                      ;[x]
  4E4A  60                    RTS                                ;[x]

L0B_4E4B:
  4E4B  64 02                 STZ   <$02                         ;[x]
  4E4D  BD AA 31              LDA   $31AA,X                      ;[x]
  4E50  85 00                 STA   <$00                         ;[x]
  4E52  BD 3D 31              LDA   $313D,X                      ;[x]
  4E55  85 01                 STA   <$01                         ;[x]
  4E57  10 02                 BPL   L0B_4E5B                     ;[x]
  4E59  C6 02                 DEC   <$02                         ;[x]
L0B_4E5B:
  4E5B  BD FB 2C              LDA   $2CFB,X                      ;[x]
  4E5E  18                    CLC                                ;[x]
  4E5F  65 00                 ADC   <$00                         ;[x]
  4E61  9D FB 2C              STA   $2CFB,X                      ;[x]
  4E64  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  4E67  65 01                 ADC   <$01                         ;[x]
  4E69  9D 8E 2C              STA   $2C8E,X                      ;[x]
  4E6C  BD 21 2C              LDA   $2C21,X                      ;[x]
  4E6F  65 02                 ADC   <$02                         ;[x]
  4E71  9D 21 2C              STA   $2C21,X                      ;[x]
  4E74  60                    RTS                                ;[x]

L0B_4E75:
  4E75  20 EB 4D              JSR   L0B_4DEB                     ;[x]
  4E78  20 06 4E              JSR   L0B_4E06                     ;[x]
  4E7B  20 21 4E              JSR   L0B_4E21                     ;[x]
  4E7E  20 4B 4E              JSR   L0B_4E4B                     ;[x]
  4E81  60                    RTS                                ;[x]

  4E82  A5 B7                 LDA   <$B7                         ;[x]
  4E84  F0 11                 BEQ   L0B_4E97                     ;[x]
  4E86  3A                    DEC   A                            ;[x]
  4E87  F0 21                 BEQ   L0B_4EAA                     ;[x]
  4E89  3A                    DEC   A                            ;[ ]
  4E8A  F0 28                 BEQ   L0B_4EB4                     ;[ ]
  4E8C  3A                    DEC   A                            ;[ ]
  4E8D  F0 2F                 BEQ   L0B_4EBE                     ;[ ]
  4E8F  3A                    DEC   A                            ;[ ]
  4E90  F0 36                 BEQ   L0B_4EC8                     ;[ ]
  4E92  3A                    DEC   A                            ;[ ]
  4E93  F0 3A                 BEQ   L0B_4ECF                     ;[ ]
  4E95  80 42                 BRA   L0B_4ED9                     ;[ ]

L0B_4E97:
  4E97  20 B3 42              JSR   L0B_42B3                     ;[x]
  4E9A  20 DC 49              JSR   L0B_49DC                     ;[x]
  4E9D  20 6D 54              JSR   L0B_546D                     ;[x]
  4EA0  20 9B 5A              JSR   L0B_5A9B                     ;[x]
  4EA3  20 DF 58              JSR   L0B_58DF                     ;[x]
  4EA6  20 D0 4B              JSR   L0B_4BD0                     ;[x]
  4EA9  60                    RTS                                ;[x]

L0B_4EAA:
  4EAA  20 6D 54              JSR   L0B_546D                     ;[x]
  4EAD  20 DF 58              JSR   L0B_58DF                     ;[x]
  4EB0  20 BF 69              JSR   L0C_69BF                     ;[x]
  4EB3  60                    RTS                                ;[x]

L0B_4EB4:
  4EB4  20 6D 54              JSR   L0B_546D                     ;[ ]
  4EB7  20 DF 58              JSR   L0B_58DF                     ;[ ]
  4EBA  20 2F 7D              JSR   L0C_7D2F                     ;[ ]
  4EBD  60                    RTS                                ;[ ]

L0B_4EBE:
  4EBE  20 6D 54              JSR   L0B_546D                     ;[ ]
  4EC1  20 DF 58              JSR   L0B_58DF                     ;[ ]
  4EC4  20 21 9A              JSR   $9A21                        ;[ ]
  4EC7  60                    RTS                                ;[ ]

L0B_4EC8:
  4EC8  20 DF 58              JSR   L0B_58DF                     ;[ ]
  4ECB  20 42 A8              JSR   $A842                        ;[ ]
  4ECE  60                    RTS                                ;[ ]

L0B_4ECF:
  4ECF  20 6D 54              JSR   L0B_546D                     ;[ ]
  4ED2  20 DF 58              JSR   L0B_58DF                     ;[ ]
  4ED5  20 ED B9              JSR   $B9ED                        ;[ ]
  4ED8  60                    RTS                                ;[ ]

L0B_4ED9:
  4ED9  20 DF 58              JSR   L0B_58DF                     ;[ ]
  4EDC  20 2D C1              JSR   $C12D                        ;[ ]
  4EDF  60                    RTS                                ;[ ]

  4EE0  BD 89 2F              LDA   $2F89,X                      ;[x]
  4EE3  D0 10                 BNE   L0B_4EF5                     ;[x]
  4EE5  BD 38 34              LDA   $3438,X                      ;[x]
  4EE8  A8                    TAY                                ;[x]
  4EE9  B9 2C 4F              LDA   $4F2C,Y                      ;[x]
  4EEC  9D 59 36              STA   $3659,X                      ;[x]
  4EEF  9E EC 35              STZ   $35EC,X                      ;[x]
  4EF2  FE 89 2F              INC   $2F89,X                      ;[x]
L0B_4EF5:
  4EF5  20 40 54              JSR   L0B_5440                     ;[x]
  4EF8  BD 59 36              LDA   $3659,X                      ;[x]
  4EFB  D0 2B                 BNE   L0B_4F28                     ;[x]
  4EFD  BD EC 35              LDA   $35EC,X                      ;[x]
  4F00  D0 0A                 BNE   L0B_4F0C                     ;[x]
  4F02  FE EC 35              INC   $35EC,X                      ;[x]
  4F05  A9 0A                 LDA   #$0A                         ;[x]
  4F07  9D 59 36              STA   $3659,X                      ;[x]
  4F0A  80 16                 BRA   L0B_4F22                     ;[x]

L0B_4F0C:
  4F0C  9E EC 35              STZ   $35EC,X                      ;[x]
  4F0F  A9 F0                 LDA   #$F0                         ;[x]
  4F11  9D 59 36              STA   $3659,X                      ;[x]
  4F14  BD C1 39              LDA   $39C1,X                      ;[x]
  4F17  D0 06                 BNE   L0B_4F1F                     ;[x]
  4F19  A5 8F                 LDA   <$8F                         ;[x]
  4F1B  C9 06                 CMP   #$06                         ;[x]
  4F1D  90 03                 BCC   L0B_4F22                     ;[x]
L0B_4F1F:
  4F1F  20 4C 44              JSR   L0B_444C                     ;[ ]
L0B_4F22:
  4F22  BD EC 35              LDA   $35EC,X                      ;[x]
  4F25  20 7F 41              JSR   L0B_417F                     ;[x]
L0B_4F28:
  4F28  DE 59 36              DEC   $3659,X                      ;[x]
  4F2B  60                    RTS                                ;[x]

  4F2C  .db $F0,$78
L0B_4F2E:
  4F2E  BD 89 2F              LDA   $2F89,X                      ;[x]
  4F31  D0 1F                 BNE   L0B_4F52                     ;[x]
  4F33  BD 38 34              LDA   $3438,X                      ;[x]
  4F36  29 01                 AND   #$01                         ;[x]
  4F38  F0 04                 BEQ   L0B_4F3E                     ;[x]
  4F3A  A9 2D                 LDA   #$2D                         ;[x]
  4F3C  80 02                 BRA   L0B_4F40                     ;[x]

L0B_4F3E:
  4F3E  A9 2A                 LDA   #$2A                         ;[x]
L0B_4F40:
  4F40  9D 6D 2A              STA   $2A6D,X                      ;[x]
  4F43  9E A0 37              STZ   $37A0,X                      ;[x]
  4F46  9E 0D 38              STZ   $380D,X                      ;[x]
  4F49  A9 F0                 LDA   #$F0                         ;[x]
  4F4B  9D 59 36              STA   $3659,X                      ;[x]
  4F4E  FE 89 2F              INC   $2F89,X                      ;[x]
  4F51  60                    RTS                                ;[x]

L0B_4F52:
  4F52  20 40 54              JSR   L0B_5440                     ;[x]
  4F55  BD A0 37              LDA   $37A0,X                      ;[x]
  4F58  D0 4B                 BNE   L0B_4FA5                     ;[x]
L0B_4F5A:
  4F5A  BD 0D 38              LDA   $380D,X                      ;[x]
  4F5D  A8                    TAY                                ;[x]
  4F5E  B9 D0 4F              LDA   $4FD0,Y                      ;[x]
  4F61  D0 05                 BNE   L0B_4F68                     ;[x]
  4F63  9E 0D 38              STZ   $380D,X                      ;[x]
  4F66  80 F2                 BRA   L0B_4F5A                     ;[x]

L0B_4F68:
  4F68  9D A0 37              STA   $37A0,X                      ;[x]
  4F6B  C8                    INY                                ;[x]
  4F6C  B9 D0 4F              LDA   $4FD0,Y                      ;[x]
  4F6F  F0 22                 BEQ   L0B_4F93                     ;[x]
  4F71  BD 38 34              LDA   $3438,X                      ;[x]
  4F74  29 01                 AND   #$01                         ;[x]
  4F76  F0 07                 BEQ   L0B_4F7F                     ;[x]
  4F78  9E 63 30              STZ   $3063,X                      ;[x]
  4F7B  A9 20                 LDA   #$20                         ;[x]
  4F7D  80 07                 BRA   L0B_4F86                     ;[x]

L0B_4F7F:
  4F7F  A9 FF                 LDA   #$FF                         ;[x]
  4F81  9D 63 30              STA   $3063,X                      ;[x]
  4F84  A9 E0                 LDA   #$E0                         ;[x]
L0B_4F86:
  4F86  9D D0 30              STA   $30D0,X                      ;[x]
  4F89  A9 20                 LDA   #$20                         ;[x]
  4F8B  9D AA 31              STA   $31AA,X                      ;[x]
  4F8E  9E 3D 31              STZ   $313D,X                      ;[x]
  4F91  80 0C                 BRA   L0B_4F9F                     ;[x]

L0B_4F93:
  4F93  9E D0 30              STZ   $30D0,X                      ;[x]
  4F96  9E 63 30              STZ   $3063,X                      ;[x]
  4F99  9E AA 31              STZ   $31AA,X                      ;[x]
  4F9C  9E 3D 31              STZ   $313D,X                      ;[x]
L0B_4F9F:
  4F9F  FE 0D 38              INC   $380D,X                      ;[x]
  4FA2  FE 0D 38              INC   $380D,X                      ;[x]
L0B_4FA5:
  4FA5  BD 59 36              LDA   $3659,X                      ;[x]
  4FA8  D0 1F                 BNE   L0B_4FC9                     ;[x]
  4FAA  FE C6 36              INC   $36C6,X                      ;[x]
  4FAD  BD C6 36              LDA   $36C6,X                      ;[x]
  4FB0  29 01                 AND   #$01                         ;[x]
  4FB2  F0 0A                 BEQ   L0B_4FBE                     ;[x]
  4FB4  FE 6D 2A              INC   $2A6D,X                      ;[x]
  4FB7  A9 0A                 LDA   #$0A                         ;[x]
  4FB9  9D 59 36              STA   $3659,X                      ;[x]
  4FBC  80 0B                 BRA   L0B_4FC9                     ;[x]

L0B_4FBE:
  4FBE  DE 6D 2A              DEC   $2A6D,X                      ;[x]
  4FC1  A9 C0                 LDA   #$C0                         ;[x]
  4FC3  9D 59 36              STA   $3659,X                      ;[x]
  4FC6  20 4C 44              JSR   L0B_444C                     ;[x]
L0B_4FC9:
  4FC9  DE 59 36              DEC   $3659,X                      ;[x]
  4FCC  DE A0 37              DEC   $37A0,X                      ;[x]
  4FCF  60                    RTS                                ;[x]

  4FD0  .db $60,$00,$80,$01,$00
L0B_4FD5:
  4FD5  BD 89 2F              LDA   $2F89,X                      ;[x]
  4FD8  3A                    DEC   A                            ;[x]
  4FD9  F0 13                 BEQ   L0B_4FEE                     ;[x]
  4FDB  3A                    DEC   A                            ;[x]
  4FDC  F0 28                 BEQ   L0B_5006                     ;[x]
  4FDE  BD 38 34              LDA   $3438,X                      ;[x]
  4FE1  A8                    TAY                                ;[x]
  4FE2  B9 45 50              LDA   $5045,Y                      ;[x]
  4FE5  9D C6 36              STA   $36C6,X                      ;[x]
  4FE8  9E 6D 2A              STZ   $2A6D,X                      ;[x]
  4FEB  FE 89 2F              INC   $2F89,X                      ;[x]
L0B_4FEE:
  4FEE  20 40 54              JSR   L0B_5440                     ;[x]
  4FF1  BD C6 36              LDA   $36C6,X                      ;[x]
  4FF4  D0 0C                 BNE   L0B_5002                     ;[x]
  4FF6  FE C6 36              INC   $36C6,X                      ;[x]
  4FF9  FE F1 32              INC   $32F1,X                      ;[x]
  4FFC  9E 68 2D              STZ   $2D68,X                      ;[x]
  4FFF  FE 89 2F              INC   $2F89,X                      ;[x]
L0B_5002:
  5002  DE C6 36              DEC   $36C6,X                      ;[x]
  5005  60                    RTS                                ;[x]

L0B_5006:
  5006  20 40 54              JSR   L0B_5440                     ;[x]
  5009  BD C6 36              LDA   $36C6,X                      ;[x]
  500C  C9 80                 CMP   #$80                         ;[x]
  500E  D0 0F                 BNE   L0B_501F                     ;[x]
  5010  DE 89 2F              DEC   $2F89,X                      ;[x]
  5013  DE F1 32              DEC   $32F1,X                      ;[x]
  5016  9E 6D 2A              STZ   $2A6D,X                      ;[x]
  5019  A9 40                 LDA   #$40                         ;[x]
  501B  9D C6 36              STA   $36C6,X                      ;[x]
  501E  60                    RTS                                ;[x]

L0B_501F:
  501F  C9 00                 CMP   #$00                         ;[x]
  5021  F0 04                 BEQ   L0B_5027                     ;[x]
  5023  C9 7B                 CMP   #$7B                         ;[x]
  5025  D0 04                 BNE   L0B_502B                     ;[x]
L0B_5027:
  5027  A9 00                 LDA   #$00                         ;[x]
  5029  80 06                 BRA   L0B_5031                     ;[x]

L0B_502B:
  502B  C9 05                 CMP   #$05                         ;[x]
  502D  D0 08                 BNE   L0B_5037                     ;[x]
  502F  A9 01                 LDA   #$01                         ;[x]
L0B_5031:
  5031  9D EC 35              STA   $35EC,X                      ;[x]
  5034  20 7F 41              JSR   L0B_417F                     ;[x]
L0B_5037:
  5037  BD C6 36              LDA   $36C6,X                      ;[x]
  503A  C9 40                 CMP   #$40                         ;[x]
  503C  D0 03                 BNE   L0B_5041                     ;[x]
  503E  20 4C 44              JSR   L0B_444C                     ;[x]
L0B_5041:
  5041  FE C6 36              INC   $36C6,X                      ;[x]
  5044  60                    RTS                                ;[x]

  5045  .db $80,$A0,$20,$40,$54,$20,$4C,$41,$BD,$89,$2F,$3A,$F0,$3D,$3A,$F0
  5055  .db $4E,$BD,$38,$34,$29,$03,$0A,$7D,$38,$34,$A8,$B9,$0C,$51,$18,$7D
  5065  .db $47,$2B,$9D,$47,$2B,$B9,$0D,$51,$9D,$8E,$2C,$B9,$0E,$51,$9D,$0D
  5075  .db $38,$BD,$38,$34,$29,$03,$0A,$0A,$0A,$0A,$9D,$E7,$38,$A9,$40,$9D
  5085  .db $C6,$36,$A9,$80,$9D,$9B,$3A,$FE,$89,$2F,$60,$BD,$C6,$36,$D0,$0B
  5095  .db $A9,$05,$9D,$7A,$38,$FE,$C6,$36,$FE,$89,$2F,$DE,$C6,$36,$60,$44
  50A5  .db $50,$BD,$C6,$36,$D0,$1F,$DE,$7A,$38,$F0,$1E,$A9,$05,$9D,$C6,$36
  50B5  .db $BD,$D5,$2D,$D0,$08,$DE,$0D,$38,$DE,$0D,$38,$80,$06,$FE,$0D,$38
  50C5  .db $FE,$0D,$38,$44,$21,$DE,$C6,$36,$60,$44,$26,$A9,$40,$9D,$C6,$36
  50D5  .db $9E,$63,$30,$9E,$D0,$30,$9E,$3D,$31,$9E,$AA,$31,$9E,$68,$2D,$DE
  50E5  .db $89,$2F,$9E,$9B,$3A,$60,$BD,$0D,$38,$29,$1F,$A0,$20,$20,$11,$41
  50F5  .db $60,$BD,$E7,$38,$D0,$0D,$20,$4C,$44,$A5,$8F,$49,$0F,$0A,$0A,$0A
  5105  .db $9D,$E7,$38,$DE,$E7,$38,$60,$18,$E0,$18,$00,$C8,$10,$E8,$E0,$08
  5115  .db $00,$F8,$00,$20,$40,$54,$BD,$89,$2F,$3A,$F0,$1B,$3A,$D0,$03,$4C
  5125  .db $C2,$51,$BD,$38,$34,$29,$01,$4A,$6A,$6A,$6A,$69,$40,$9D,$0D,$38
  5135  .db $9E,$59,$36,$FE,$89,$2F,$60,$BD,$59,$36,$D0,$10,$BD,$EC,$35,$29
  5145  .db $03,$20,$7F,$41,$A9,$08,$9D,$59,$36,$FE,$EC,$35,$DE,$59,$36,$BD
  5155  .db $C6,$36,$D0,$28,$BD,$D5,$2D,$29,$03,$0A,$0A,$A8,$B9,$13,$52,$9D
  5165  .db $63,$30,$B9,$14,$52,$9D,$D0,$30,$B9,$15,$52,$9D,$3D,$31,$B9,$16
  5175  .db $52,$9D,$AA,$31,$A9,$20,$9D,$C6,$36,$FE,$D5,$2D,$DE,$C6,$36,$BD
  5185  .db $0D,$38,$D0,$35,$9E,$EC,$35,$9E,$59,$36,$BD,$63,$30,$9D,$7A,$38
  5195  .db $BD,$D0,$30,$9D,$E7,$38,$BD,$3D,$31,$9D,$54,$39,$BD,$AA,$31,$9D
  51A5  .db $C1,$39,$9E,$63,$30,$9E,$D0,$30,$9E,$3D,$31,$9E,$AA,$31,$A9,$81
  51B5  .db $9D,$F1,$32,$9E,$68,$2D,$FE,$89,$2F,$DE,$0D,$38,$60,$BD,$59,$36
  51C5  .db $D0,$21,$BD,$EC,$35,$C9,$06,$F0,$1E,$C9,$03,$D0,$05,$48,$20,$4C
  51D5  .db $44,$68,$0A,$A8,$B9,$23,$52,$9D,$59,$36,$B9,$24,$52,$20,$7F,$41
  51E5  .db $FE,$EC,$35,$DE,$59,$36,$60,$9E,$EC,$35,$A9,$80,$9D,$0D,$38,$BD
  51F5  .db $7A,$38,$9D,$63,$30,$BD,$E7,$38,$9D,$D0,$30,$BD,$54,$39,$9D,$3D
  5205  .db $31,$BD,$C1,$39,$9D,$AA,$31,$9E,$F1,$32,$DE,$89,$2F,$60,$FF,$C0
  5215  .db $00,$40,$00,$40,$00,$40,$00,$40,$FF,$C0,$FF,$C0,$FF,$C0,$04,$04
  5225  .db $18,$05,$08,$06,$08,$06,$18,$05,$04,$04,$04,$00,$20,$40,$54,$BD
  5235  .db $89,$2F,$3A,$F0,$2E,$3A,$F0,$75,$3A,$D0,$03,$4C,$DF,$52,$3A,$D0
  5245  .db $03,$4C,$12,$53,$A9,$00,$9D,$63,$30,$A9,$40,$9D,$D0,$30,$BD,$38
  5255  .db $34,$0A,$0A,$0A,$0A,$69,$50,$9D,$D5,$2D,$A9,$40,$9D,$C6,$36,$FE
  5265  .db $89,$2F,$60,$20,$27,$53,$DE,$D5,$2D,$F0,$2B,$DE,$C6,$36,$D0,$25
  5275  .db $BD,$63,$30,$85,$00,$BD,$D0,$30,$85,$01,$A5,$01,$49,$FF,$18,$69
  5285  .db $01,$85,$01,$A5,$00,$49,$FF,$69,$00,$85,$00,$A5,$00,$9D,$63,$30
  5295  .db $A5,$01,$9D,$D0,$30,$60,$BD,$63,$30,$30,$04,$A9,$02,$80,$02,$A9
  52A5  .db $06,$20,$7F,$41,$A9,$08,$9D,$C6,$36,$FE,$89,$2F,$60,$DE,$C6,$36
  52B5  .db $D0,$27,$BD,$63,$30,$9D,$0D,$38,$BD,$D0,$30,$9D,$7A,$38,$9E,$63
  52C5  .db $30,$9E,$D0,$30,$A9,$20,$9D,$C6,$36,$A9,$03,$20,$7F,$41,$9E,$68
  52D5  .db $2D,$A9,$81,$9D,$F1,$32,$FE,$89,$2F,$60,$DE,$C6,$36,$D0,$23,$BD
  52E5  .db $7A,$38,$9D,$D0,$30,$BD,$0D,$38,$9D,$63,$30,$30,$04,$A9,$06,$80
  52F5  .db $02,$A9,$02,$20,$7F,$41,$A9,$08,$9D,$C6,$36,$9E,$F1,$32,$FE,$89
  5305  .db $2F,$60,$BD,$C6,$36,$C9,$0C,$D0,$03,$20,$4C,$44,$60,$DE,$C6,$36
  5315  .db $D0,$0F,$A9,$60,$9D,$D5,$2D,$A9,$40,$9D,$C6,$36,$A9,$01,$9D,$89
  5325  .db $2F,$60,$DE,$59,$36,$D0,$1E,$A9,$08,$9D,$59,$36,$BD,$63,$30,$30
  5335  .db $07,$BD,$EC,$35,$09,$04,$80,$05,$BD,$EC,$35,$29,$01,$49,$01,$9D
  5345  .db $EC,$35,$20,$7F,$41,$60,$BD,$89,$2F,$D0,$0B,$A9,$78,$9D,$59,$36
  5355  .db $9E,$EC,$35,$FE,$89,$2F,$BD,$38,$34,$29,$03,$A8,$B9,$42,$2B,$9D
  5365  .db $DA,$2A,$B9,$AF,$2B,$9D,$47,$2B,$B9,$F6,$2C,$38,$E9,$08,$9D,$8E
  5375  .db $2C,$B9,$89,$2C,$E9,$00,$9D,$21,$2C,$DE,$59,$36,$D0,$26,$BD,$EC
  5385  .db $35,$D0,$0A,$FE,$EC,$35,$A9,$0A,$9D,$59,$36,$80,$11,$9E,$EC,$35
  5395  .db $A9,$F0,$9D,$59,$36,$A5,$8F,$C9,$02,$90,$03,$20,$4C,$44,$BD,$EC
  53A5  .db $35,$20,$7F,$41,$60
L0B_53AA:
  53AA  BD 89 2F              LDA   $2F89,X                      ;[x]
  53AD  3A                    DEC   A                            ;[x]
  53AE  F0 38                 BEQ   L0B_53E8                     ;[x]
  53B0  3A                    DEC   A                            ;[x]
  53B1  F0 7D                 BEQ   L0B_5430                     ;[x]
  53B3  BD 38 34              LDA   $3438,X                      ;[x]
  53B6  D0 15                 BNE   L0B_53CD                     ;[x]
  53B8  64 00                 STZ   <$00                         ;[x]
  53BA  A5 32                 LDA   <$32                         ;[x]
  53BC  89 01                 BIT   #$01                         ;[x]
  53BE  F0 02                 BEQ   L0B_53C2                     ;[x]
  53C0  E6 00                 INC   <$00                         ;[x]
L0B_53C2:
  53C2  89 02                 BIT   #$02                         ;[x]
  53C4  F0 02                 BEQ   L0B_53C8                     ;[x]
  53C6  E6 00                 INC   <$00                         ;[x]
L0B_53C8:
  53C8  A5 00                 LDA   <$00                         ;[x]
  53CA  18                    CLC                                ;[x]
  53CB  69 05                 ADC   #$05                         ;[x]
L0B_53CD:
  53CD  18                    CLC                                ;[x]
  53CE  69 14                 ADC   #$14                         ;[x]
  53D0  9D 6D 2A              STA   $2A6D,X                      ;[x]
  53D3  A9 82                 LDA   #$82                         ;[x]
  53D5  9D F1 32              STA   $32F1,X                      ;[x]
  53D8  A9 03                 LDA   #$03                         ;[x]
  53DA  9D 00 2A              STA   $2A00,X                      ;[x]
  53DD  A9 08                 LDA   #$08                         ;[x]
  53DF  9D 5E 33              STA   $335E,X                      ;[x]
  53E2  9D CB 33              STA   $33CB,X                      ;[x]
  53E5  FE 89 2F              INC   $2F89,X                      ;[x]
L0B_53E8:
  53E8  BD F1 32              LDA   $32F1,X                      ;[x]
  53EB  29 40                 AND   #$40                         ;[x]
  53ED  F0 08                 BEQ   L0B_53F7                     ;[x]
  53EF  BD 38 34              LDA   $3438,X                      ;[x]
  53F2  F0 07                 BEQ   L0B_53FB                     ;[x]
  53F4  20 2B 4D              JSR   L0B_4D2B                     ;[x]
L0B_53F7:
  53F7  20 40 54              JSR   L0B_5440                     ;[x]
  53FA  60                    RTS                                ;[x]

L0B_53FB:
  53FB  A9 40                 LDA   #$40                         ;[x]
  53FD  9D C6 36              STA   $36C6,X                      ;[x]
  5400  9E F1 32              STZ   $32F1,X                      ;[x]
  5403  FE 89 2F              INC   $2F89,X                      ;[x]
  5406  20 AB E8              JSR   L00_E8AB                     ;[x]
  5409  AD 8F 3F              LDA   $3F8F                        ;[x]
  540C  89 01                 BIT   #$01                         ;[x]
  540E  D0 03                 BNE   L0B_5413                     ;[x]
  5410  62                    CLA                                ;[x]
  5411  80 0A                 BRA   L0B_541D                     ;[x]

L0B_5413:
  5413  89 02                 BIT   #$02                         ;[x]
  5415  D0 04                 BNE   L0B_541B                     ;[x]
  5417  A9 01                 LDA   #$01                         ;[x]
  5419  80 02                 BRA   L0B_541D                     ;[x]

L0B_541B:
  541B  A9 02                 LDA   #$02                         ;[x]
L0B_541D:
  541D  85 00                 STA   <$00                         ;[x]
  541F  18                    CLC                                ;[x]
  5420  69 1C                 ADC   #$1C                         ;[x]
  5422  9D 6D 2A              STA   $2A6D,X                      ;[x]
  5425  BD AF 2E              LDA   $2EAF,X                      ;[x]
  5428  8D 91 3F              STA   $3F91                        ;[x]
  542B  A5 00                 LDA   <$00                         ;[x]
  542D  20 EE E7              JSR   L00_E7EE                     ;[x]
L0B_5430:
  5430  BD C6 36              LDA   $36C6,X                      ;[x]
  5433  F0 07                 BEQ   L0B_543C                     ;[x]
  5435  20 40 54              JSR   L0B_5440                     ;[x]
  5438  DE C6 36              DEC   $36C6,X                      ;[x]
  543B  60                    RTS                                ;[x]

L0B_543C:
  543C  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  543F  60                    RTS                                ;[x]

L0B_5440:
  5440  64 00                 STZ   <$00                         ;[x]
  5442  AD 6F 3B              LDA   $3B6F                        ;[x]
  5445  10 02                 BPL   L0B_5449                     ;[x]
  5447  C6 00                 DEC   <$00                         ;[ ]
L0B_5449:
  5449  38                    SEC                                ;[x]
  544A  BD 47 2B              LDA   $2B47,X                      ;[x]
  544D  ED 6F 3B              SBC   $3B6F                        ;[x]
  5450  9D 47 2B              STA   $2B47,X                      ;[x]
  5453  BD DA 2A              LDA   $2ADA,X                      ;[x]
  5456  E5 00                 SBC   <$00                         ;[x]
  5458  9D DA 2A              STA   $2ADA,X                      ;[x]
  545B  18                    CLC                                ;[x]
  545C  AD 77 3B              LDA   $3B77                        ;[x]
  545F  7D 8E 2C              ADC   $2C8E,X                      ;[x]
  5462  9D 8E 2C              STA   $2C8E,X                      ;[x]
  5465  62                    CLA                                ;[x]
  5466  7D 21 2C              ADC   $2C21,X                      ;[x]
  5469  9D 21 2C              STA   $2C21,X                      ;[x]
  546C  60                    RTS                                ;[x]

L0B_546D:
  546D  A2 68                 LDX   #$68                         ;[x]
L0B_546F:
  546F  86 B2                 STX   <$B2                         ;[x]
  5471  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  5474  F0 02                 BEQ   L0B_5478                     ;[x]
  5476  44 08                 BSR   L0B_5480                     ;[x]
L0B_5478:
  5478  A6 B2                 LDX   <$B2                         ;[x]
  547A  E8                    INX                                ;[x]
  547B  E0 6D                 CPX   #$6D                         ;[x]
  547D  D0 F0                 BNE   L0B_546F                     ;[x]
  547F  60                    RTS                                ;[x]

L0B_5480:
  5480  3A                    DEC   A                            ;[x]
  5481  20 A2 E7              JSR   L00_E7A2                     ;[x]
  5484  B0 54                 BCS   L0B_54DA                     ;[ ]
  5486  F2 54                 SBC   (<$54)                       ;[ ]
  5488  7D 55 FE              ADC   $FE55,X                      ;[ ]
  548B  55 66                 EOR   <$66,X                       ;[ ]
  548D  56 0C                 LSR   <$0C,X                       ;[ ]
  548F  57 0C                 RMB5  <$0C                         ;[ ]
  5491  57 0C                 RMB5  <$0C                         ;[ ]
  5493  57 0C                 RMB5  <$0C                         ;[ ]
  5495  57 0C                 RMB5  <$0C                         ;[ ]
  5497  57 66                 RMB5  <$66                         ;[ ]
  5499  57 66                 RMB5  <$66                         ;[ ]
  549B  57 66                 RMB5  <$66                         ;[ ]
  549D  57 9E                 RMB5  <$9E                         ;[ ]
  549F  57 CF                 RMB5  <$CF                         ;[ ]
  54A1  57 32                 RMB5  <$32                         ;[ ]
  54A3  58                    CLI                                ;[ ]
  54A4  78                    SEI                                ;[ ]
  54A5  58                    CLI                                ;[ ]
  54A6  A1 58                 LDA   (<$58,X)                     ;[ ]
  54A8  AC 58 B4              LDY   $B458                        ;[ ]
  54AB  58                    CLI                                ;[ ]
  54AC  BA                    TSX                                ;[ ]
  54AD  58                    CLI                                ;[ ]
  54AE  DE 58 BD              DEC   $BD58,X                      ;[ ]
  54B1  89 2F                 BIT   #$2F                         ;[ ]
  54B3  D0 2A                 BNE   L0B_54DF                     ;[x]
  54B5  A9 FF                 LDA   #$FF                         ;[x]
  54B7  9D 21 2C              STA   $2C21,X                      ;[x]
  54BA  A9 F0                 LDA   #$F0                         ;[x]
  54BC  9D 8E 2C              STA   $2C8E,X                      ;[x]
  54BF  A9 00                 LDA   #$00                         ;[x]
  54C1  9D 3D 31              STA   $313D,X                      ;[x]
  54C4  A9 80                 LDA   #$80                         ;[x]
  54C6  9D AA 31              STA   $31AA,X                      ;[x]
  54C9  A9 02                 LDA   #$02                         ;[x]
  54CB  9D 00 2A              STA   $2A00,X                      ;[x]
  54CE  A9 1D                 LDA   #$1D                         ;[x]
  54D0  9D 6D 2A              STA   $2A6D,X                      ;[x]
  54D3  A9 78                 LDA   #$78                         ;[x]
  54D5  9D 47 2B              STA   $2B47,X                      ;[x]
  54D8  9E DA 2A              STZ   $2ADA,X                      ;[x]
  54DB  FE 89 2F              INC   $2F89,X                      ;[x]
  54DE  60                    RTS                                ;[x]

L0B_54DF:
  54DF  20 75 4E              JSR   L0B_4E75                     ;[x]
  54E2  BD 21 2C              LDA   $2C21,X                      ;[x]
  54E5  D0 0A                 BNE   L0B_54F1                     ;[x]
  54E7  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  54EA  C9 F0                 CMP   #$F0                         ;[x]
  54EC  90 03                 BCC   L0B_54F1                     ;[x]
  54EE  20 2B 4D              JSR   L0B_4D2B                     ;[x]
L0B_54F1:
  54F1  60                    RTS                                ;[x]

  54F2  BD 89 2F              LDA   $2F89,X                      ;[x]
  54F5  D0 4B                 BNE   L0B_5542                     ;[x]
  54F7  8A                    TXA                                ;[x]
  54F8  C9 69                 CMP   #$69                         ;[x]
  54FA  D0 0C                 BNE   L0B_5508                     ;[x]
  54FC  A9 FF                 LDA   #$FF                         ;[x]
  54FE  9D 21 2C              STA   $2C21,X                      ;[x]
  5501  A9 70                 LDA   #$70                         ;[x]
  5503  9D 8E 2C              STA   $2C8E,X                      ;[x]
  5506  80 1A                 BRA   L0B_5522                     ;[x]

L0B_5508:
  5508  C9 6A                 CMP   #$6A                         ;[x]
  550A  D0 0C                 BNE   L0B_5518                     ;[x]
  550C  A9 FE                 LDA   #$FE                         ;[x]
  550E  9D 21 2C              STA   $2C21,X                      ;[x]
  5511  A9 F0                 LDA   #$F0                         ;[x]
  5513  9D 8E 2C              STA   $2C8E,X                      ;[x]
  5516  80 0A                 BRA   L0B_5522                     ;[x]

L0B_5518:
  5518  A9 FE                 LDA   #$FE                         ;[x]
  551A  9D 21 2C              STA   $2C21,X                      ;[x]
  551D  A9 70                 LDA   #$70                         ;[x]
  551F  9D 8E 2C              STA   $2C8E,X                      ;[x]
L0B_5522:
  5522  A9 00                 LDA   #$00                         ;[x]
  5524  9D 3D 31              STA   $313D,X                      ;[x]
  5527  A9 80                 LDA   #$80                         ;[x]
  5529  9D AA 31              STA   $31AA,X                      ;[x]
  552C  A9 02                 LDA   #$02                         ;[x]
  552E  9D 00 2A              STA   $2A00,X                      ;[x]
  5531  A9 1E                 LDA   #$1E                         ;[x]
  5533  9D 6D 2A              STA   $2A6D,X                      ;[x]
  5536  A9 78                 LDA   #$78                         ;[x]
  5538  9D 47 2B              STA   $2B47,X                      ;[x]
  553B  9E DA 2A              STZ   $2ADA,X                      ;[x]
  553E  FE 89 2F              INC   $2F89,X                      ;[x]
  5541  60                    RTS                                ;[x]

L0B_5542:
  5542  20 75 4E              JSR   L0B_4E75                     ;[x]
  5545  BD 21 2C              LDA   $2C21,X                      ;[x]
  5548  D0 32                 BNE   L0B_557C                     ;[x]
  554A  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  554D  C9 F0                 CMP   #$F0                         ;[x]
  554F  90 2B                 BCC   L0B_557C                     ;[x]
  5551  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  5554  38                    SEC                                ;[x]
  5555  E9 80                 SBC   #$80                         ;[x]
  5557  9D 8E 2C              STA   $2C8E,X                      ;[x]
  555A  BD 21 2C              LDA   $2C21,X                      ;[x]
  555D  E9 01                 SBC   #$01                         ;[x]
  555F  9D 21 2C              STA   $2C21,X                      ;[x]
  5562  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  5565  C9 1F                 CMP   #$1F                         ;[x]
  5567  F0 13                 BEQ   L0B_557C                     ;[x]
  5569  A5 B4                 LDA   <$B4                         ;[x]
  556B  C9 15                 CMP   #$15                         ;[x]
  556D  90 0D                 BCC   L0B_557C                     ;[x]
  556F  D0 06                 BNE   L0B_5577                     ;[x]
  5571  A5 B5                 LDA   <$B5                         ;[ ]
  5573  C9 C0                 CMP   #$C0                         ;[ ]
  5575  90 05                 BCC   L0B_557C                     ;[ ]
L0B_5577:
  5577  A9 1F                 LDA   #$1F                         ;[x]
  5579  9D 6D 2A              STA   $2A6D,X                      ;[x]
L0B_557C:
  557C  60                    RTS                                ;[x]

  557D  .db $BD,$89,$2F,$3A,$F0,$2E,$3A,$F0,$5C,$8A,$38,$E9,$68,$29,$02,$D0
  558D  .db $0C,$A9,$02,$9D,$3D,$31,$9E,$AA,$31,$A9,$20,$80,$0C,$A9,$01,$9D
  559D  .db $3D,$31,$A9,$80,$9D,$AA,$31,$A9,$14,$9D,$6D,$2A,$A9,$03,$9D,$00
  55AD  .db $2A,$FE,$89,$2F,$20,$AB,$E8,$AD,$90,$3F,$4A,$4A,$9D,$C6,$36,$AD
  55BD  .db $8F,$3F,$4A,$85,$00,$8A,$29,$01,$18,$D0,$06,$A5,$00,$69,$60,$80
  55CD  .db $04,$A5,$00,$69,$18,$9D,$47,$2B,$A9,$FF,$9D,$21,$2C,$A9,$F0,$9D
  55DD  .db $8E,$2C,$FE,$89,$2F,$BD,$C6,$36,$F0,$04,$DE,$C6,$36,$60,$20,$75
  55ED  .db $4E,$BD,$21,$2C,$D0,$0A,$BD,$8E,$2C,$C9,$E0,$90,$03,$DE,$89,$2F
  55FD  .db $60,$BD,$89,$2F,$3A,$F0,$29,$3A,$F0,$DB,$8A,$38,$E9,$68,$85,$00
  560D  .db $0A,$65,$00,$A8,$B9,$5A,$56,$9D,$3D,$31,$C8,$B9,$5A,$56,$9D,$AA
  561D  .db $31,$C8,$B9,$5A,$56,$9D,$6D,$2A,$A9,$03,$9D,$00,$2A,$FE,$89,$2F
  562D  .db $8A,$38,$E9,$68,$A8,$B9,$63,$56,$9D,$C6,$36,$20,$AB,$E8,$AD,$8F
  563D  .db $3F,$4A,$4A,$85,$00,$0A,$65,$00,$69,$18,$9D,$47,$2B,$A9,$FF,$9D
  564D  .db $21,$2C,$A9,$E0,$9D,$8E,$2C,$FE,$89,$2F,$4C,$E2,$55,$02,$00,$20
  565D  .db $01,$80,$1F,$01,$00,$14,$20,$10,$00,$BD,$89,$2F,$3A,$F0,$1F,$3A
  566D  .db $F0,$3F,$3A,$F0,$5F,$3A,$F0,$67,$3A,$F0,$7D,$9E,$3D,$31,$A9,$30
  567D  .db $9D,$AA,$31,$A9,$07,$9D,$00,$2A,$9E,$EC,$35,$FE,$89,$2F,$BD,$EC
  568D  .db $35,$29,$03,$85,$00,$A8,$B9,$06,$57,$9D,$47,$2B,$A9,$FF,$9D,$21
  569D  .db $2C,$A9,$A8,$9D,$8E,$2C,$A9,$22,$18,$65,$00,$9D,$6D,$2A,$FE,$89
  56AD  .db $2F,$20,$75,$4E,$BD,$21,$2C,$C9,$01,$D0,$18,$BD,$8E,$2C,$C9,$22
  56BD  .db $90,$11,$BD,$EC,$35,$C9,$06,$D0,$04,$FE,$89,$2F,$60,$FE,$EC,$35
  56CD  .db $DE,$89,$2F,$60,$A9,$21,$9D,$6D,$2A,$9E,$EC,$35,$FE,$89,$2F,$BD
  56DD  .db $EC,$35,$29,$01,$A8,$B9,$0A,$57,$9D,$47,$2B,$A9,$FF,$9D,$21,$2C
  56ED  .db $A9,$F0,$9D,$8E,$2C,$FE,$89,$2F,$20,$75,$4E,$BD,$21,$2C,$C9,$01
  56FD  .db $D0,$06,$FE,$EC,$35,$DE,$89,$2F,$60,$38,$A8,$98,$A8,$C8,$38,$BD
  570D  .db $89,$2F,$D0,$41,$BD,$1C,$2F,$38,$E9,$06,$85,$00,$0A,$65,$00,$A8
  571D  .db $B9,$43,$57,$9D,$8E,$2C,$B9,$44,$57,$9D,$AA,$31,$B9,$45,$57,$9D
  572D  .db $6D,$2A,$A9,$0C,$9D,$00,$2A,$A9,$FF,$9D,$21,$2C,$9E,$DA,$2A,$9E
  573D  .db $3D,$31,$FE,$89,$2F,$60,$A9,$40,$33,$86,$40,$34,$98,$40,$35,$B2
  574D  .db $40,$36,$A9,$28,$37,$20,$75,$4E,$BD,$21,$2C,$3A,$D0,$0A,$BD,$8E
  575D  .db $2C,$C9,$4A,$90,$03,$20,$2B,$4D,$60,$BD,$89,$2F,$D0,$1F,$BD,$1C
  576D  .db $2F,$18,$69,$3B,$9D,$6D,$2A,$A9,$0D,$9D,$00,$2A,$A9,$A1,$9D,$8E
  577D  .db $2C,$A9,$FF,$9D,$21,$2C,$9E,$DA,$2A,$FE,$89,$2F,$60,$20,$40,$54
  578D  .db $BD,$21,$2C,$3A,$D0,$D2,$BD,$8E,$2C,$C9,$2F,$90,$03,$20,$2B,$4D
  579D  .db $60,$BD,$89,$2F,$D0,$18,$A9,$0D,$9D,$00,$2A,$A9,$49,$9D,$6D,$2A
  57AD  .db $A9,$80,$9D,$8E,$2C,$A9,$FF,$9D,$21,$2C,$FE,$89,$2F,$60,$20,$40
  57BD  .db $54,$BD,$21,$2C,$3A,$D0,$0A,$BD,$8E,$2C,$C9,$52,$90,$03,$20,$2B
  57CD  .db $4D,$60,$BD,$89,$2F,$D0,$1D,$A9,$0D,$9D,$00,$2A,$A9,$4A,$9D,$6D
  57DD  .db $2A,$A9,$CA,$9D,$D5,$2D,$A9,$80,$9D,$8E,$2C,$A9,$FF,$9D,$21,$2C
  57ED  .db $FE,$89,$2F,$60,$20,$40,$54,$AD,$A6,$3D,$D0,$38,$DE,$D5,$2D,$F0
  57FD  .db $30,$FE,$68,$2D,$BD,$68,$2D,$29,$0F,$F0,$13,$BD,$8E,$2C,$38,$E9
  580D  .db $01,$9D,$8E,$2C,$BD,$21,$2C,$E9,$00,$9D,$21,$2C,$80,$16,$BD,$8E
  581D  .db $2C,$18,$69,$0F,$9D,$8E,$2C,$BD,$21,$2C,$69,$00,$9D,$21,$2C,$80
  582D  .db $03,$20,$2B,$4D,$60,$BD,$89,$2F,$D0,$18,$A9,$0D,$9D,$00,$2A,$A9
  583D  .db $4B,$9D,$6D,$2A,$A9,$FA,$9D,$8E,$2C,$A9,$FF,$9D,$21,$2C,$FE,$89
  584D  .db $2F,$60,$20,$40,$54,$AD,$A8,$3D,$D0,$11,$BD,$8E,$2C,$38,$E9,$01
  585D  .db $9D,$8E,$2C,$BD,$21,$2C,$E9,$00,$9D,$21,$2C,$BD,$21,$2C,$D0,$0A
  586D  .db $BD,$8E,$2C,$C9,$D6,$90,$03,$20,$2B,$4D,$60,$BD,$68,$2D,$D0,$1C
  587D  .db $A9,$09,$9D,$68,$2D,$BD,$EC,$35,$18,$69,$64,$DA,$A2,$05,$20,$D5
  588D  .db $E8,$FA,$FE,$EC,$35,$BD,$EC,$35,$C9,$05,$F0,$04,$DE,$68,$2D,$60
  589D  .db $20,$2B,$4D,$60,$A2,$68,$20,$2B,$4D,$E8,$E0,$6D,$D0,$F8,$60,$A9
  58AD  .db $01,$85,$84,$20,$2B,$4D,$60,$64,$84,$20,$2B,$4D,$60,$BD,$89,$2F
  58BD  .db $D0,$18,$A9,$01,$9D,$00,$2A,$A9,$2F,$9D,$6D,$2A,$A9,$20,$9D,$D0
  58CD  .db $30,$A9,$20,$9D,$AA,$31,$FE,$89,$2F,$60,$20,$40,$54,$20,$C5,$4C
  58DD  .db $60,$60
L0B_58DF:
  58DF  A2 30                 LDX   #$30                         ;[x]
L0B_58E1:
  58E1  86 B2                 STX   <$B2                         ;[x]
  58E3  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  58E6  F0 02                 BEQ   L0B_58EA                     ;[x]
  58E8  44 08                 BSR   L0B_58F2                     ;[x]
L0B_58EA:
  58EA  A6 B2                 LDX   <$B2                         ;[x]
  58EC  E8                    INX                                ;[x]
  58ED  E0 42                 CPX   #$42                         ;[x]
  58EF  D0 F0                 BNE   L0B_58E1                     ;[x]
  58F1  60                    RTS                                ;[x]

L0B_58F2:
  58F2  44 04                 BSR   L0B_58F8                     ;[x]
  58F4  20 C5 4C              JSR   L0B_4CC5                     ;[x]
  58F7  60                    RTS                                ;[x]

L0B_58F8:
  58F8  BD 59 36              LDA   $3659,X                      ;[x]
  58FB  D0 1A                 BNE   L0B_5917                     ;[x]
  58FD  A9 04                 LDA   #$04                         ;[x]
  58FF  9D 59 36              STA   $3659,X                      ;[x]
  5902  FE EC 35              INC   $35EC,X                      ;[x]
  5905  BD EC 35              LDA   $35EC,X                      ;[x]
  5908  C9 04                 CMP   #$04                         ;[x]
  590A  D0 04                 BNE   L0B_5910                     ;[x]
  590C  9E EC 35              STZ   $35EC,X                      ;[x]
  590F  62                    CLA                                ;[x]
L0B_5910:
  5910  A8                    TAY                                ;[x]
  5911  B9 1B 59              LDA   $591B,Y                      ;[x]
  5914  9D 6D 2A              STA   $2A6D,X                      ;[x]
L0B_5917:
  5917  DE 59 36              DEC   $3659,X                      ;[x]
  591A  60                    RTS                                ;[x]

  591B  .db $0B,$0C,$0D,$0E
L0B_591F:
  591F  BD 89 2F              LDA   $2F89,X                      ;[x]
  5922  F0 03                 BEQ   L0B_5927                     ;[x]
  5924  4C E3 59              JMP   L0B_59E3                     ;[x]

L0B_5927:
  5927  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  592A  3A                    DEC   A                            ;[x]
  592B  D0 05                 BNE   L0B_5932                     ;[x]
  592D  20 7F 42              JSR   L0B_427F                     ;[x]
  5930  80 03                 BRA   L0B_5935                     ;[x]

L0B_5932:
  5932  20 40 54              JSR   L0B_5440                     ;[x]
L0B_5935:
  5935  20 4C 41              JSR   L0B_414C                     ;[x]
  5938  BD EC 35              LDA   $35EC,X                      ;[x]
  593B  C9 05                 CMP   #$05                         ;[x]
  593D  D0 54                 BNE   L0B_5993                     ;[x]
  593F  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  5942  C9 01                 CMP   #$01                         ;[x]
  5944  D0 4E                 BNE   L0B_5994                     ;[x]
  5946  A5 9E                 LDA   <$9E                         ;[x]
  5948  F0 0D                 BEQ   L0B_5957                     ;[x]
  594A  AD 86 26              LDA   $2686                        ;[ ]
  594D  29 01                 AND   #$01                         ;[ ]
  594F  F0 03                 BEQ   L0B_5954                     ;[ ]
  5951  20 4C 44              JSR   L0B_444C                     ;[ ]
L0B_5954:
  5954  EE 86 26              INC   $2686                        ;[ ]
L0B_5957:
  5957  BD 38 34              LDA   $3438,X                      ;[x]
  595A  F0 34                 BEQ   L0B_5990                     ;[x]
  595C  29 01                 AND   #$01                         ;[x]
  595E  F0 05                 BEQ   L0B_5965                     ;[x]
  5960  A9 81                 LDA   #$81                         ;[ ]
  5962  9D 42 2E              STA   $2E42,X                      ;[ ]
L0B_5965:
  5965  BD 38 34              LDA   $3438,X                      ;[x]
  5968  29 03                 AND   #$03                         ;[x]
  596A  8D 91 3F              STA   $3F91                        ;[x]
  596D  A9 03                 LDA   #$03                         ;[x]
  596F  20 EE E7              JSR   L00_E7EE                     ;[x]
  5972  FE 89 2F              INC   $2F89,X                      ;[x]
  5975  A9 38                 LDA   #$38                         ;[x]
  5977  9D C6 36              STA   $36C6,X                      ;[x]
  597A  A9 1D                 LDA   #$1D                         ;[x]
  597C  20 FC E3              JSR   L00_E3FC                     ;[x]
  597F  A9 03                 LDA   #$03                         ;[x]
  5981  9D 00 2A              STA   $2A00,X                      ;[x]
  5984  A9 0F                 LDA   #$0F                         ;[x]
  5986  9D 6D 2A              STA   $2A6D,X                      ;[x]
  5989  A9 AA                 LDA   #$AA                         ;[x]
  598B  9D AA 31              STA   $31AA,X                      ;[x]
  598E  80 03                 BRA   L0B_5993                     ;[x]

L0B_5990:
  5990  20 2B 4D              JSR   L0B_4D2B                     ;[x]
L0B_5993:
  5993  60                    RTS                                ;[x]

L0B_5994:
  5994  A9 1D                 LDA   #$1D                         ;[x]
  5996  9D 1C 2F              STA   $2F1C,X                      ;[x]
  5999  BD 38 34              LDA   $3438,X                      ;[x]
  599C  D0 1C                 BNE   L0B_59BA                     ;[x]
  599E  A5 9A                 LDA   <$9A                         ;[x]
  59A0  F0 04                 BEQ   L0B_59A6                     ;[x]
  59A2  C6 9A                 DEC   <$9A                         ;[x]
  59A4  80 10                 BRA   L0B_59B6                     ;[x]

L0B_59A6:
  59A6  20 AB E8              JSR   L00_E8AB                     ;[x]
  59A9  AD 8F 3F              LDA   $3F8F                        ;[x]
  59AC  29 0F                 AND   #$0F                         ;[x]
  59AE  F0 0B                 BEQ   L0B_59BB                     ;[x]
  59B0  3A                    DEC   A                            ;[x]
  59B1  F0 1A                 BEQ   L0B_59CD                     ;[x]
  59B3  3A                    DEC   A                            ;[x]
  59B4  F0 25                 BEQ   L0B_59DB                     ;[x]
L0B_59B6:
  59B6  62                    CLA                                ;[x]
L0B_59B7:
  59B7  9D 38 34              STA   $3438,X                      ;[x]
L0B_59BA:
  59BA  60                    RTS                                ;[x]

L0B_59BB:
  59BB  AD 38 34              LDA   $3438                        ;[x]
  59BE  0D 39 34              ORA   $3439                        ;[x]
  59C1  29 08                 AND   #$08                         ;[x]
  59C3  D0 F1                 BNE   L0B_59B6                     ;[x]
  59C5  A9 07                 LDA   #$07                         ;[x]
  59C7  85 9A                 STA   <$9A                         ;[x]
  59C9  A9 02                 LDA   #$02                         ;[x]
  59CB  80 EA                 BRA   L0B_59B7                     ;[x]

L0B_59CD:
  59CD  A5 A0                 LDA   <$A0                         ;[ ]
  59CF  29 10                 AND   #$10                         ;[ ]
  59D1  D0 E3                 BNE   L0B_59B6                     ;[ ]
  59D3  A9 07                 LDA   #$07                         ;[ ]
  59D5  85 9A                 STA   <$9A                         ;[ ]
  59D7  A9 03                 LDA   #$03                         ;[ ]
  59D9  80 DC                 BRA   L0B_59B7                     ;[ ]

L0B_59DB:
  59DB  A9 07                 LDA   #$07                         ;[x]
  59DD  85 9A                 STA   <$9A                         ;[x]
  59DF  A9 01                 LDA   #$01                         ;[x]
  59E1  80 D4                 BRA   L0B_59B7                     ;[x]

L0B_59E3:
  59E3  BD C6 36              LDA   $36C6,X                      ;[x]
  59E6  D0 03                 BNE   L0B_59EB                     ;[x]
  59E8  4C 2B 4D              JMP   L0B_4D2B                     ;[x]

L0B_59EB:
  59EB  DE C6 36              DEC   $36C6,X                      ;[x]
  59EE  C9 28                 CMP   #$28                         ;[x]
  59F0  D0 03                 BNE   L0B_59F5                     ;[x]
  59F2  9E AA 31              STZ   $31AA,X                      ;[x]
L0B_59F5:
  59F5  60                    RTS                                ;[x]

L0B_59F6:
  59F6  BD AF 2E              LDA   $2EAF,X                      ;[x]
  59F9  8D 91 3F              STA   $3F91                        ;[x]
  59FC  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  59FF  C9 0C                 CMP   #$0C                         ;[x]
  5A01  D0 03                 BNE   L0B_5A06                     ;[x]
  5A03  62                    CLA                                ;[x]
  5A04  80 02                 BRA   L0B_5A08                     ;[x]

L0B_5A06:
  5A06  A9 01                 LDA   #$01                         ;[x]
L0B_5A08:
  5A08  20 EE E7              JSR   L00_E7EE                     ;[x]
  5A0B  64 01                 STZ   <$01                         ;[x]
  5A0D  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  5A10  29 3E                 AND   #$3E                         ;[x]
  5A12  C9 38                 CMP   #$38                         ;[x]
  5A14  D0 04                 BNE   L0B_5A1A                     ;[x]
  5A16  A9 4E                 LDA   #$4E                         ;[ ]
  5A18  80 07                 BRA   L0B_5A21                     ;[ ]

L0B_5A1A:
  5A1A  BD F1 32              LDA   $32F1,X                      ;[x]
  5A1D  0A                    ASL   A                            ;[x]
  5A1E  62                    CLA                                ;[x]
  5A1F  2A                    ROL   A                            ;[x]
  5A20  1A                    INC   A                            ;[x]
L0B_5A21:
  5A21  85 02                 STA   <$02                         ;[x]
  5A23  3A                    DEC   A                            ;[x]
  5A24  F0 0B                 BEQ   L0B_5A31                     ;[x]
  5A26  BD 38 34              LDA   $3438,X                      ;[x]
  5A29  4A                    LSR   A                            ;[x]
  5A2A  4A                    LSR   A                            ;[x]
  5A2B  85 01                 STA   <$01                         ;[x]
  5A2D  A9 1C                 LDA   #$1C                         ;[x]
  5A2F  80 2A                 BRA   L0B_5A5B                     ;[x]

L0B_5A31:
  5A31  86 00                 STX   <$00                         ;[x]
  5A33  BD AF 2E              LDA   $2EAF,X                      ;[x]
  5A36  85 03                 STA   <$03                         ;[x]
  5A38  BD 12 35              LDA   $3512,X                      ;[x]
  5A3B  F0 1C                 BEQ   L0B_5A59                     ;[x]
  5A3D  3A                    DEC   A                            ;[x]
  5A3E  AA                    TAX                                ;[x]
  5A3F  DE 18 3C              DEC   $3C18,X                      ;[x]
  5A42  BD 18 3C              LDA   $3C18,X                      ;[x]
  5A45  D0 10                 BNE   L0B_5A57                     ;[x]
  5A47  BD 20 3C              LDA   $3C20,X                      ;[x]
  5A4A  F0 08                 BEQ   L0B_5A54                     ;[x]
  5A4C  A5 03                 LDA   <$03                         ;[x]
  5A4E  29 03                 AND   #$03                         ;[x]
  5A50  09 80                 ORA   #$80                         ;[x]
  5A52  85 01                 STA   <$01                         ;[x]
L0B_5A54:
  5A54  20 21 44              JSR   L0B_4421                     ;[x]
L0B_5A57:
  5A57  A6 00                 LDX   <$00                         ;[x]
L0B_5A59:
  5A59  A9 1B                 LDA   #$1B                         ;[x]
L0B_5A5B:
  5A5B  20 FC E3              JSR   L00_E3FC                     ;[x]
  5A5E  20 40 4D              JSR   L0B_4D40                     ;[x]
  5A61  A5 01                 LDA   <$01                         ;[x]
  5A63  9D 38 34              STA   $3438,X                      ;[x]
  5A66  A5 02                 LDA   <$02                         ;[x]
  5A68  9D 1C 2F              STA   $2F1C,X                      ;[x]
  5A6B  A9 03                 LDA   #$03                         ;[x]
  5A6D  9D 00 2A              STA   $2A00,X                      ;[x]
  5A70  20 4C 41              JSR   L0B_414C                     ;[x]
  5A73  60                    RTS                                ;[x]

  5A74  .db $20,$7F,$42,$20,$4C,$41,$BD,$EC,$35,$C9,$05,$D0,$03,$20,$2B,$4D
  5A84  .db $60,$A9,$1B,$20,$FC,$E3,$20,$40,$4D,$A9,$4D,$9D,$1C,$2F,$A9,$03
  5A94  .db $9D,$00,$2A,$20,$4C,$41,$60
L0B_5A9B:
  5A9B  A2 5A                 LDX   #$5A                         ;[x]
L0B_5A9D:
  5A9D  BD 1C 2F              LDA   $2F1C,X                      ;[x]
  5AA0  F0 02                 BEQ   L0B_5AA4                     ;[x]
  5AA2  44 06                 BSR   L0B_5AAA                     ;[x]
L0B_5AA4:
  5AA4  E8                    INX                                ;[x]
  5AA5  E0 60                 CPX   #$60                         ;[x]
  5AA7  D0 F4                 BNE   L0B_5A9D                     ;[x]
  5AA9  60                    RTS                                ;[x]

L0B_5AAA:
  5AAA  44 04                 BSR   L0B_5AB0                     ;[x]
  5AAC  20 C5 4C              JSR   L0B_4CC5                     ;[x]
  5AAF  60                    RTS                                ;[x]

L0B_5AB0:
  5AB0  BD 59 36              LDA   $3659,X                      ;[x]
  5AB3  D0 15                 BNE   L0B_5ACA                     ;[x]
  5AB5  A9 10                 LDA   #$10                         ;[x]
  5AB7  9D 59 36              STA   $3659,X                      ;[x]
  5ABA  BD EC 35              LDA   $35EC,X                      ;[x]
  5ABD  1A                    INC   A                            ;[x]
  5ABE  29 01                 AND   #$01                         ;[x]
  5AC0  9D EC 35              STA   $35EC,X                      ;[x]
  5AC3  A8                    TAY                                ;[x]
  5AC4  B9 CE 5A              LDA   $5ACE,Y                      ;[x]
  5AC7  9D 6D 2A              STA   $2A6D,X                      ;[x]
L0B_5ACA:
  5ACA  DE 59 36              DEC   $3659,X                      ;[x]
  5ACD  60                    RTS                                ;[x]

  5ACE  .db $01,$02,$6E,$5B,$6E,$5B,$79,$5B,$84,$5B,$89,$5B,$8E,$5B,$97,$5B
  5ADE  .db $9C,$5B,$A1,$5B,$A6,$5B,$AF,$5B,$BA,$5B,$D5,$5B,$D8,$5B,$DD,$5B
  5AEE  .db $E2,$5B,$EB,$5B,$F0,$5B,$03,$5C,$06,$5C,$09,$5C,$0E,$5C,$13,$5C
  5AFE  .db $28,$5C,$2D,$5C,$3A,$5C,$49,$5C,$4E,$5C,$57,$5C,$6E,$5B,$5C,$5C
  5B0E  .db $6B,$5C,$70,$5C,$75,$5C,$7A,$5C,$7F,$5C,$84,$5C,$8B,$5C,$90,$5C
  5B1E  .db $99,$5C,$A4,$5C,$A9,$5C,$AE,$5C,$B9,$5C,$C2,$5C,$CB,$5C,$D0,$5C
  5B2E  .db $D5,$5C,$DA,$5C,$E3,$5C,$EC,$5C,$F7,$5C,$08,$5D,$1B,$5D,$2C,$5D
  5B3E  .db $3B,$5D,$44,$5D,$4D,$5D,$5C,$5D,$61,$5D,$6E,$5D,$73,$5D,$82,$5D
  5B4E  .db $89,$5D,$8E,$5D,$93,$5D,$9E,$5D,$AF,$5D,$B4,$5D,$BD,$5D,$C4,$5D
  5B5E  .db $CD,$5D,$D0,$5D,$E1,$5D,$F2,$5D,$6E,$5B,$6E,$5B,$6E,$5B,$03,$5E
  5B6E  .db $08,$03,$08,$04,$08,$05,$08,$06,$08,$06,$00,$08,$07,$08,$08,$08
  5B7E  .db $09,$08,$0A,$08,$0A,$00,$0B,$01,$0B,$02,$00,$0A,$03,$0A,$04,$00
  5B8E  .db $08,$05,$08,$06,$08,$07,$08,$08,$00,$08,$09,$08,$0A,$00,$06,$0B
  5B9E  .db $06,$0C,$00,$08,$0D,$08,$0E,$00,$38,$0F,$0C,$10,$0C,$11,$20,$12
  5BAE  .db $00,$09,$13,$09,$14,$0A,$15,$09,$16,$09,$17,$00,$08,$18,$08,$19
  5BBE  .db $08,$1A,$08,$1B,$08,$1C,$08,$1D,$08,$1E,$08,$1F,$08,$20,$08,$21
  5BCE  .db $08,$22,$08,$23,$55,$24,$00,$01,$25,$00,$10,$26,$10,$27,$00,$10
  5BDE  .db $28,$10,$29,$00,$10,$2A,$10,$2B,$10,$2D,$10,$2E,$00,$01,$01,$01
  5BEE  .db $02,$00,$20,$03,$08,$04,$08,$05,$08,$06,$08,$07,$08,$08,$08,$09
  5BFE  .db $08,$0A,$08,$0B,$00,$01,$0C,$00,$01,$0D,$00,$0F,$0E,$0F,$0F,$00
  5C0E  .db $0D,$10,$0D,$11,$00,$04,$12,$04,$13,$04,$14,$04,$15,$04,$16,$04
  5C1E  .db $17,$04,$18,$04,$19,$04,$1A,$04,$1B,$00,$0A,$1C,$0A,$1D,$00,$10
  5C2E  .db $1E,$10,$1F,$20,$20,$10,$21,$10,$22,$20,$23,$00,$08,$24,$08,$25
  5C3E  .db $08,$26,$08,$27,$08,$28,$08,$29,$08,$2A,$00,$0D,$2B,$0D,$2C,$00
  5C4E  .db $50,$2D,$08,$2E,$08,$2F,$50,$30,$00,$04,$0E,$04,$0F,$00,$08,$01
  5C5E  .db $08,$02,$20,$04,$10,$03,$20,$04,$08,$05,$08,$06,$00,$10,$07,$10
  5C6E  .db $08,$00,$0A,$09,$0A,$0A,$00,$08,$0B,$08,$0C,$00,$10,$0D,$10,$0E
  5C7E  .db $00,$0F,$0F,$0F,$10,$00,$0A,$11,$0A,$12,$0A,$13,$00,$0C,$14,$0C
  5C8E  .db $15,$00,$0C,$16,$0C,$17,$0C,$18,$30,$19,$00,$08,$03,$08,$02,$0C
  5C9E  .db $01,$08,$02,$0C,$03,$00,$08,$04,$08,$05,$00,$10,$06,$10,$07,$00
  5CAE  .db $0B,$08,$0B,$09,$0B,$0A,$10,$0B,$10,$0C,$00,$08,$0D,$08,$0E,$08
  5CBE  .db $0F,$08,$10,$00,$0C,$11,$17,$12,$08,$13,$08,$14,$00,$08,$15,$08
  5CCE  .db $16,$00,$0B,$17,$40,$18,$00,$40,$19,$0B,$1A,$00,$04,$01,$04,$02
  5CDE  .db $04,$03,$04,$04,$00,$08,$05,$08,$06,$10,$07,$08,$06,$00,$04,$08
  5CEE  .db $10,$09,$08,$08,$10,$0A,$04,$08,$00,$04,$0C,$04,$0B,$04,$12,$04
  5CFE  .db $11,$04,$10,$04,$0F,$04,$0E,$04,$0D,$00,$08,$15,$10,$16,$10,$17
  5D0E  .db $10,$16,$10,$15,$10,$14,$10,$13,$10,$14,$08,$15,$00,$04,$18,$04
  5D1E  .db $19,$04,$1A,$04,$1B,$04,$1C,$04,$1D,$04,$1E,$04,$1F,$00,$04,$20
  5D2E  .db $04,$21,$04,$22,$04,$23,$30,$24,$04,$25,$04,$26,$00,$02,$27,$04
  5D3E  .db $28,$04,$29,$04,$29,$00,$06,$2A,$06,$2B,$06,$2C,$06,$2D,$00,$10
  5D4E  .db $2E,$0B,$2F,$0B,$30,$1B,$31,$1B,$32,$1B,$33,$1B,$34,$00,$20,$35
  5D5E  .db $1B,$36,$00,$08,$01,$08,$02,$08,$03,$08,$04,$08,$05,$08,$06,$00
  5D6E  .db $06,$07,$06,$08,$00,$10,$09,$10,$0A,$10,$0B,$10,$0C,$10,$0D,$10
  5D7E  .db $0E,$10,$0F,$00,$04,$10,$04,$11,$04,$45,$00,$04,$12,$04,$13,$00
  5D8E  .db $0A,$15,$0A,$14,$00,$08,$1E,$08,$1F,$08,$20,$08,$1F,$10,$21,$00
  5D9E  .db $08,$24,$08,$25,$08,$26,$08,$27,$08,$28,$08,$29,$08,$22,$08,$23
  5DAE  .db $00,$50,$2A,$0F,$2B,$00,$08,$2C,$08,$2D,$08,$2E,$08,$2F,$00,$08
  5DBE  .db $30,$08,$31,$20,$32,$00,$08,$33,$08,$34,$30,$35,$30,$36,$00,$01
  5DCE  .db $37,$00,$08,$1A,$08,$1B,$08,$1C,$08,$1D,$08,$16,$08,$17,$08,$18
  5DDE  .db $08,$19,$00,$0C,$3C,$0C,$3D,$0C,$3E,$0C,$3F,$10,$38,$0C,$39,$0C
  5DEE  .db $3A,$0C,$3B,$00,$0C,$42,$0C,$3D,$0C,$43,$0C,$3F,$0C,$40,$0C,$39
  5DFE  .db $0C,$41,$0C,$3B,$00,$08,$21,$08,$22,$08,$23,$08,$24,$08,$24,$00
  5E0E  .db $01,$03,$01,$FE,$0E,$00,$82,$20,$10,$18,$C1,$80,$30,$07,$C1,$80
  5E1E  .db $37,$03,$01,$FE,$38,$00,$82,$22,$50,$11,$C1,$88,$7C,$08,$C1,$80
  5E2E  .db $B0,$13,$C1,$80,$B2,$16,$C1,$8A,$B3,$03,$01,$FE,$B4,$00,$82,$20
  5E3E  .db $DA,$10,$C1,$88,$00,$2F,$C1,$8C,$20,$37,$C1,$84,$2F,$24,$01,$FE
  5E4E  .db $30,$20,$82,$22,$4C,$20,$43,$80,$4F,$21,$01,$FE,$50,$20,$82,$22
  5E5E  .db $58,$35,$C1,$88,$58,$2D,$C1,$80,$67,$20,$01,$FE,$68,$20,$82,$20
  5E6E  .db $68,$27,$C1,$84,$70,$2D,$C1,$8C,$7B,$23,$81,$00,$7C,$30,$0E,$00
  5E7E  .db $7C,$33,$0E,$01,$8C,$28,$84,$20,$90,$2B,$C1,$88,$98,$32,$C1,$84
  5E8E  .db $9B,$20,$01,$FE,$9C,$30,$84,$21,$AC,$27,$81,$01,$B8,$37,$81,$00
  5E9E  .db $B8,$34,$C1,$80,$C4,$20,$82,$22,$C8,$25,$C1,$80,$D2,$36,$0D,$00
  5EAE  .db $D7,$21,$01,$FE,$D8,$20,$83,$20,$E0,$32,$C1,$80,$E4,$2E,$0E,$00
  5EBE  .db $F0,$20,$85,$00,$00,$40,$85,$00,$07,$40,$01,$FE,$08,$40,$85,$01
  5ECE  .db $10,$40,$85,$01,$10,$43,$C1,$80,$20,$56,$81,$00,$28,$46,$81,$01
  5EDE  .db $30,$45,$81,$01,$30,$48,$C1,$80,$37,$40,$02,$FE,$38,$54,$81,$00
  5EEE  .db $48,$48,$84,$21,$58,$40,$0B,$00,$76,$40,$83,$21,$87,$40,$01,$FE
  5EFE  .db $88,$48,$84,$20,$90,$4A,$C1,$80,$94,$58,$C1,$82,$98,$48,$84,$21
  5F0E  .db $A4,$4E,$0D,$00,$A7,$40,$01,$FE,$A8,$40,$85,$00,$AC,$40,$85,$01
  5F1E  .db $BC,$54,$0E,$00,$BC,$56,$0D,$01,$BC,$58,$0E,$00,$BC,$5A,$0D,$01
  5F2E  .db $BC,$5C,$0E,$00,$BC,$40,$83,$21,$C7,$40,$01,$FE,$C8,$40,$83,$20
  5F3E  .db $D0,$40,$85,$00,$D8,$40,$85,$01,$E8,$40,$86,$20,$F8,$58,$C1,$84
  5F4E  .db $02,$60,$02,$FE,$03,$60,$82,$22,$0F,$60,$82,$21,$12,$64,$C1,$8C
  5F5E  .db $19,$60,$82,$23,$28,$75,$81,$00,$30,$65,$81,$01,$33,$60,$01,$FE
  5F6E  .db $34,$60,$83,$20,$38,$67,$87,$20,$40,$71,$87,$20,$48,$76,$0D,$00
  5F7E  .db $48,$62,$C1,$82,$50,$78,$C1,$88,$60,$60,$86,$20,$7A,$6F,$81,$00
  5F8E  .db $7C,$60,$0F,$01,$7D,$62,$02,$FE,$7E,$60,$82,$20,$7E,$60,$82,$22
  5F9E  .db $8C,$64,$84,$20,$9C,$76,$84,$21,$AC,$60,$85,$00,$AC,$60,$85,$01
  5FAE  .db $B0,$70,$C1,$80,$B2,$78,$C1,$80,$B3,$61,$01,$FE,$B4,$60,$82,$20
  5FBE  .db $B6,$6B,$C1,$80,$B7,$6F,$C1,$80,$B9,$7C,$C1,$88,$BC,$64,$C1,$80
  5FCE  .db $BF,$60,$01,$FE,$C0,$60,$82,$22,$D0,$63,$01,$FF,$D1,$60,$82,$23
  5FDE  .db $E0,$66,$C1,$82,$E0,$7A,$C1,$88,$E2,$60,$82,$21,$E4,$6E,$C1,$80
  5FEE  .db $F0,$7C,$0F,$00,$F2,$63,$01,$FF,$F3,$60,$82,$23,$FA,$7C,$0F,$00
  5FFE  .db $08,$84
