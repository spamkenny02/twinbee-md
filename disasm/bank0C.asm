; Detana!! TwinBee (PCE) - banque $0C, vue en $6000-$7FFF
; 4371 octets de code (4223 exécutés en émulation)
; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique

  6000  .db $84,$20,$14,$96,$84,$21,$20,$9A,$81,$00,$2A,$86,$81,$01,$33,$83
  6010  .db $02,$FF,$34,$98,$81,$00,$38,$80,$83,$21,$3E,$96,$81,$01,$4B,$82
  6020  .db $01,$FF,$4C,$84,$84,$20,$54,$80,$85,$01,$60,$96,$84,$21,$67,$82
  6030  .db $01,$FF,$68,$80,$85,$00,$70,$96,$81,$00,$78,$87,$81,$01,$80,$80
  6040  .db $83,$20,$8F,$80,$01,$FE,$90,$80,$83,$21,$98,$8F,$C1,$8C,$A0,$92
  6050  .db $C1,$80,$A4,$8F,$81,$00,$AC,$8F,$81,$01,$B0,$80,$85,$00,$BC,$80
  6060  .db $82,$00,$C0,$9A,$C1,$82,$C6,$9C,$0F,$00,$C8,$80,$85,$01,$D1,$80
  6070  .db $02,$FE,$D2,$9A,$81,$00,$DE,$82,$81,$01,$E8,$9C,$81,$00,$F8,$80
  6080  .db $0B,$00,$10,$BC,$0F,$10,$18,$A0,$84,$21,$1A,$BC,$0F,$00,$24,$A0
  6090  .db $84,$20,$2F,$80,$02,$FE,$30,$A0,$82,$21,$38,$A0,$82,$23,$38,$A7
  60A0  .db $C1,$84,$40,$AF,$C1,$8C,$42,$B7,$C1,$84,$47,$A0,$01,$FE,$48,$A0
  60B0  .db $83,$21,$4C,$B2,$C1,$8C,$4F,$A0,$54,$D8,$50,$A0,$00,$81,$50,$A0
  60C0  .db $01,$82,$50,$A0,$02,$82,$50,$A0,$03,$82,$57,$A0,$01,$FE,$58,$A0
  60D0  .db $83,$20,$68,$A0,$83,$20,$68,$A0,$83,$21,$7F,$A0,$01,$FE,$80,$A0
  60E0  .db $84,$20,$90,$A0,$84,$21,$A8,$A0,$00,$FD,$B0,$A0,$83,$80,$B8,$A0
  60F0  .db $41,$80,$B8,$A0,$80,$80,$E8,$A0,$44,$80,$E8,$A0,$01,$40,$FF,$FF
L0C_6100:
  6100  BD 89 2F              LDA   $2F89,X                      ;[x]
  6103  3A                    DEC   A                            ;[x]
  6104  F0 7B                 BEQ   L0C_6181                     ;[x]
  6106  3A                    DEC   A                            ;[x]
  6107  D0 03                 BNE   L0C_610C                     ;[x]
  6109  4C DB 61              JMP   L0C_61DB                     ;[x]

L0C_610C:
  610C  A9 12                 LDA   #$12                         ;[x]
  610E  9D 7A 38              STA   $387A,X                      ;[x]
  6111  9E 8E 2C              STZ   $2C8E,X                      ;[x]
  6114  9E 21 2C              STZ   $2C21,X                      ;[x]
  6117  BD 38 34              LDA   $3438,X                      ;[x]
  611A  29 02                 AND   #$02                         ;[x]
  611C  F0 0F                 BEQ   L0C_612D                     ;[x]
  611E  A9 00                 LDA   #$00                         ;[x]
  6120  9D DA 2A              STA   $2ADA,X                      ;[x]
  6123  A9 F8                 LDA   #$F8                         ;[x]
  6125  9D 47 2B              STA   $2B47,X                      ;[x]
  6128  9E 68 2D              STZ   $2D68,X                      ;[x]
  612B  80 0F                 BRA   L0C_613C                     ;[x]

L0C_612D:
  612D  A9 FF                 LDA   #$FF                         ;[x]
  612F  9D DA 2A              STA   $2ADA,X                      ;[x]
  6132  A9 F8                 LDA   #$F8                         ;[x]
  6134  9D 47 2B              STA   $2B47,X                      ;[x]
  6137  A9 01                 LDA   #$01                         ;[x]
  6139  9D 68 2D              STA   $2D68,X                      ;[x]
L0C_613C:
  613C  BD 38 34              LDA   $3438,X                      ;[x]
  613F  29 01                 AND   #$01                         ;[x]
  6141  D0 03                 BNE   L0C_6146                     ;[x]
  6143  4C 69 61              JMP   L0C_6169                     ;[x]

L0C_6146:
  6146  20 11 42              JSR   L0B_4211                     ;[x]
  6149  30 1E                 BMI   L0C_6169                     ;[x]
  614B  A8                    TAY                                ;[x]
  614C  20 30 40              JSR   L0B_4030                     ;[x]
  614F  BD 38 34              LDA   $3438,X                      ;[x]
  6152  29 02                 AND   #$02                         ;[x]
  6154  D0 09                 BNE   L0C_615F                     ;[x]
  6156  A5 00                 LDA   <$00                         ;[x]
  6158  C9 08                 CMP   #$08                         ;[x]
  615A  90 19                 BCC   L0C_6175                     ;[x]
  615C  62                    CLA                                ;[ ]
  615D  80 16                 BRA   L0C_6175                     ;[ ]

L0C_615F:
  615F  A5 00                 LDA   <$00                         ;[x]
  6161  C9 11                 CMP   #$11                         ;[x]
  6163  90 10                 BCC   L0C_6175                     ;[x]
  6165  A9 10                 LDA   #$10                         ;[ ]
  6167  80 0C                 BRA   L0C_6175                     ;[ ]

L0C_6169:
  6169  BD 38 34              LDA   $3438,X                      ;[x]
  616C  29 02                 AND   #$02                         ;[x]
  616E  F0 02                 BEQ   L0C_6172                     ;[x]
  6170  A9 0A                 LDA   #$0A                         ;[x]
L0C_6172:
  6172  18                    CLC                                ;[x]
  6173  69 03                 ADC   #$03                         ;[x]
L0C_6175:
  6175  9D A0 37              STA   $37A0,X                      ;[x]
  6178  BC 7A 38              LDY   $387A,X                      ;[x]
  617B  20 11 41              JSR   L0B_4111                     ;[x]
  617E  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_6181:
  6181  20 19 69              JSR   L0C_6919                     ;[x]
  6184  C2                    CLY                                ;[x]
  6185  A5 86                 LDA   <$86                         ;[x]
  6187  29 01                 AND   #$01                         ;[x]
  6189  F0 1E                 BEQ   L0C_61A9                     ;[x]
  618B  38                    SEC                                ;[x]
  618C  B9 47 2B              LDA   $2B47,Y                      ;[x]
  618F  FD 47 2B              SBC   $2B47,X                      ;[x]
  6192  85 00                 STA   <$00                         ;[x]
  6194  B9 DA 2A              LDA   $2ADA,Y                      ;[x]
  6197  FD DA 2A              SBC   $2ADA,X                      ;[x]
  619A  85 01                 STA   <$01                         ;[x]
  619C  A5 00                 LDA   <$00                         ;[x]
  619E  06 01                 ASL   <$01                         ;[x]
  61A0  90 03                 BCC   L0C_61A5                     ;[x]
  61A2  49 FF                 EOR   #$FF                         ;[x]
  61A4  1A                    INC   A                            ;[x]
L0C_61A5:
  61A5  C9 20                 CMP   #$20                         ;[x]
  61A7  90 26                 BCC   L0C_61CF                     ;[x]
L0C_61A9:
  61A9  A0 01                 LDY   #$01                         ;[x]
  61AB  A5 86                 LDA   <$86                         ;[x]
  61AD  29 02                 AND   #$02                         ;[x]
  61AF  F0 29                 BEQ   L0C_61DA                     ;[x]
  61B1  38                    SEC                                ;[ ]
  61B2  B9 47 2B              LDA   $2B47,Y                      ;[ ]
  61B5  FD 47 2B              SBC   $2B47,X                      ;[ ]
  61B8  85 00                 STA   <$00                         ;[ ]
  61BA  B9 DA 2A              LDA   $2ADA,Y                      ;[ ]
  61BD  FD DA 2A              SBC   $2ADA,X                      ;[ ]
  61C0  85 01                 STA   <$01                         ;[ ]
  61C2  A5 00                 LDA   <$00                         ;[ ]
  61C4  06 01                 ASL   <$01                         ;[ ]
  61C6  90 03                 BCC   L0C_61CB                     ;[ ]
  61C8  49 FF                 EOR   #$FF                         ;[ ]
  61CA  1A                    INC   A                            ;[ ]
L0C_61CB:
  61CB  C9 20                 CMP   #$20                         ;[ ]
  61CD  B0 0B                 BCS   L0C_61DA                     ;[ ]
L0C_61CF:
  61CF  9E 0D 38              STZ   $380D,X                      ;[x]
  61D2  A9 20                 LDA   #$20                         ;[x]
  61D4  9D 7A 38              STA   $387A,X                      ;[x]
  61D7  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_61DA:
  61DA  60                    RTS                                ;[x]

L0C_61DB:
  61DB  20 19 69              JSR   L0C_6919                     ;[x]
  61DE  20 7F 42              JSR   L0B_427F                     ;[x]
  61E1  20 4C 41              JSR   L0B_414C                     ;[x]
  61E4  BD 0D 38              LDA   $380D,X                      ;[x]
  61E7  D0 21                 BNE   L0C_620A                     ;[x]
  61E9  A9 0C                 LDA   #$0C                         ;[x]
  61EB  9D 0D 38              STA   $380D,X                      ;[x]
  61EE  BD 38 34              LDA   $3438,X                      ;[x]
  61F1  29 02                 AND   #$02                         ;[x]
  61F3  F0 06                 BEQ   L0C_61FB                     ;[x]
  61F5  BD A0 37              LDA   $37A0,X                      ;[x]
  61F8  3A                    DEC   A                            ;[x]
  61F9  80 04                 BRA   L0C_61FF                     ;[x]

L0C_61FB:
  61FB  BD A0 37              LDA   $37A0,X                      ;[x]
  61FE  1A                    INC   A                            ;[x]
L0C_61FF:
  61FF  29 1F                 AND   #$1F                         ;[x]
  6201  9D A0 37              STA   $37A0,X                      ;[x]
  6204  BC 7A 38              LDY   $387A,X                      ;[x]
  6207  20 11 41              JSR   L0B_4111                     ;[x]
L0C_620A:
  620A  DE 0D 38              DEC   $380D,X                      ;[x]
  620D  60                    RTS                                ;[x]

  620E  BD 89 2F              LDA   $2F89,X                      ;[x]
  6211  D0 18                 BNE   L0C_622B                     ;[x]
  6213  BD 38 34              LDA   $3438,X                      ;[x]
  6216  29 01                 AND   #$01                         ;[x]
  6218  A8                    TAY                                ;[x]
  6219  20 1C 40              JSR   L0B_401C                     ;[x]
  621C  A5 8F                 LDA   <$8F                         ;[x]
  621E  4A                    LSR   A                            ;[x]
  621F  18                    CLC                                ;[x]
  6220  69 20                 ADC   #$20                         ;[x]
  6222  A8                    TAY                                ;[x]
  6223  A5 00                 LDA   <$00                         ;[x]
  6225  20 11 41              JSR   L0B_4111                     ;[x]
  6228  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_622B:
  622B  A9 01                 LDA   #$01                         ;[x]
  622D  20 15 69              JSR   L0C_6915                     ;[x]
  6230  20 4C 41              JSR   L0B_414C                     ;[x]
  6233  60                    RTS                                ;[x]

  6234  20 19 69              JSR   L0C_6919                     ;[x]
  6237  BD 89 2F              LDA   $2F89,X                      ;[x]
  623A  3A                    DEC   A                            ;[x]
  623B  F0 3F                 BEQ   L0C_627C                     ;[x]
  623D  3A                    DEC   A                            ;[x]
  623E  D0 03                 BNE   L0C_6243                     ;[x]
  6240  4C BC 62              JMP   L0C_62BC                     ;[x]

L0C_6243:
  6243  3A                    DEC   A                            ;[x]
  6244  D0 03                 BNE   L0C_6249                     ;[x]
  6246  4C 16 63              JMP   L0C_6316                     ;[x]

L0C_6249:
  6249  3A                    DEC   A                            ;[x]
  624A  D0 03                 BNE   L0C_624F                     ;[x]
  624C  4C 60 63              JMP   L0C_6360                     ;[x]

L0C_624F:
  624F  3A                    DEC   A                            ;[x]
  6250  D0 03                 BNE   L0C_6255                     ;[x]
  6252  4C 7A 63              JMP   L0C_637A                     ;[x]

L0C_6255:
  6255  A5 8F                 LDA   <$8F                         ;[x]
  6257  0A                    ASL   A                            ;[x]
  6258  69 80                 ADC   #$80                         ;[x]
  625A  9D AA 31              STA   $31AA,X                      ;[x]
  625D  A9 02                 LDA   #$02                         ;[x]
  625F  69 00                 ADC   #$00                         ;[x]
  6261  9D 3D 31              STA   $313D,X                      ;[x]
  6264  A9 D0                 LDA   #$D0                         ;[x]
  6266  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6269  BD 38 34              LDA   $3438,X                      ;[x]
  626C  29 01                 AND   #$01                         ;[x]
  626E  D0 04                 BNE   L0C_6274                     ;[x]
  6270  A9 30                 LDA   #$30                         ;[x]
  6272  80 02                 BRA   L0C_6276                     ;[x]

L0C_6274:
  6274  A9 C0                 LDA   #$C0                         ;[x]
L0C_6276:
  6276  9D 47 2B              STA   $2B47,X                      ;[x]
  6279  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_627C:
  627C  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  627F  18                    CLC                                ;[x]
  6280  69 50                 ADC   #$50                         ;[x]
  6282  85 06                 STA   <$06                         ;[x]
  6284  C9 CE                 CMP   #$CE                         ;[x]
  6286  B0 0F                 BCS   L0C_6297                     ;[x]
  6288  20 9B 41              JSR   L0B_419B                     ;[x]
  628B  09 00                 ORA   #$00                         ;[x]
  628D  30 2C                 BMI   L0C_62BB                     ;[x]
  628F  A8                    TAY                                ;[x]
  6290  B9 8E 2C              LDA   $2C8E,Y                      ;[x]
  6293  C5 06                 CMP   <$06                         ;[x]
  6295  B0 24                 BCS   L0C_62BB                     ;[x]
L0C_6297:
  6297  A9 F0                 LDA   #$F0                         ;[x]
  6299  9D 84 32              STA   $3284,X                      ;[x]
  629C  A9 12                 LDA   #$12                         ;[x]
  629E  85 02                 STA   <$02                         ;[x]
  62A0  BD 38 34              LDA   $3438,X                      ;[x]
  62A3  29 01                 AND   #$01                         ;[x]
  62A5  F0 07                 BEQ   L0C_62AE                     ;[x]
  62A7  A5 02                 LDA   <$02                         ;[x]
  62A9  49 FF                 EOR   #$FF                         ;[x]
  62AB  1A                    INC   A                            ;[x]
  62AC  85 02                 STA   <$02                         ;[x]
L0C_62AE:
  62AE  A5 02                 LDA   <$02                         ;[x]
  62B0  9D 17 32              STA   $3217,X                      ;[x]
  62B3  A9 18                 LDA   #$18                         ;[x]
  62B5  9D C6 36              STA   $36C6,X                      ;[x]
  62B8  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_62BB:
  62BB  60                    RTS                                ;[x]

L0C_62BC:
  62BC  20 4C 41              JSR   L0B_414C                     ;[x]
  62BF  DE C6 36              DEC   $36C6,X                      ;[x]
  62C2  D0 51                 BNE   L0C_6315                     ;[x]
  62C4  BD 63 30              LDA   $3063,X                      ;[x]
  62C7  9D A0 37              STA   $37A0,X                      ;[x]
  62CA  BD D0 30              LDA   $30D0,X                      ;[x]
  62CD  9D 0D 38              STA   $380D,X                      ;[x]
  62D0  BD 3D 31              LDA   $313D,X                      ;[x]
  62D3  85 00                 STA   <$00                         ;[x]
  62D5  BD AA 31              LDA   $31AA,X                      ;[x]
  62D8  85 01                 STA   <$01                         ;[x]
  62DA  A5 01                 LDA   <$01                         ;[x]
  62DC  49 FF                 EOR   #$FF                         ;[x]
  62DE  18                    CLC                                ;[x]
  62DF  69 01                 ADC   #$01                         ;[x]
  62E1  85 01                 STA   <$01                         ;[x]
  62E3  A5 00                 LDA   <$00                         ;[x]
  62E5  49 FF                 EOR   #$FF                         ;[x]
  62E7  69 00                 ADC   #$00                         ;[x]
  62E9  85 00                 STA   <$00                         ;[x]
  62EB  A5 00                 LDA   <$00                         ;[x]
  62ED  9D 7A 38              STA   $387A,X                      ;[x]
  62F0  A5 01                 LDA   <$01                         ;[x]
  62F2  9D E7 38              STA   $38E7,X                      ;[x]
  62F5  9E 17 32              STZ   $3217,X                      ;[x]
  62F8  9E 84 32              STZ   $3284,X                      ;[x]
  62FB  9E 63 30              STZ   $3063,X                      ;[x]
  62FE  9E D0 30              STZ   $30D0,X                      ;[x]
  6301  9E 3D 31              STZ   $313D,X                      ;[x]
  6304  9E AA 31              STZ   $31AA,X                      ;[x]
  6307  9E EC 35              STZ   $35EC,X                      ;[x]
  630A  20 4C 41              JSR   L0B_414C                     ;[x]
  630D  A9 60                 LDA   #$60                         ;[x]
  630F  9D C6 36              STA   $36C6,X                      ;[x]
  6312  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_6315:
  6315  60                    RTS                                ;[x]

L0C_6316:
  6316  DE C6 36              DEC   $36C6,X                      ;[x]
  6319  D0 44                 BNE   L0C_635F                     ;[x]
  631B  A9 18                 LDA   #$18                         ;[x]
  631D  9D C6 36              STA   $36C6,X                      ;[x]
  6320  BD A0 37              LDA   $37A0,X                      ;[x]
  6323  9D 63 30              STA   $3063,X                      ;[x]
  6326  BD 0D 38              LDA   $380D,X                      ;[x]
  6329  9D D0 30              STA   $30D0,X                      ;[x]
  632C  BD 7A 38              LDA   $387A,X                      ;[x]
  632F  9D 3D 31              STA   $313D,X                      ;[x]
  6332  BD E7 38              LDA   $38E7,X                      ;[x]
  6335  9D AA 31              STA   $31AA,X                      ;[x]
  6338  A9 10                 LDA   #$10                         ;[x]
  633A  85 02                 STA   <$02                         ;[x]
  633C  BD 38 34              LDA   $3438,X                      ;[x]
  633F  29 01                 AND   #$01                         ;[x]
  6341  D0 07                 BNE   L0C_634A                     ;[x]
  6343  A5 02                 LDA   <$02                         ;[x]
  6345  49 FF                 EOR   #$FF                         ;[x]
  6347  1A                    INC   A                            ;[x]
  6348  85 02                 STA   <$02                         ;[x]
L0C_634A:
  634A  A5 02                 LDA   <$02                         ;[x]
  634C  9D 17 32              STA   $3217,X                      ;[x]
  634F  A9 F0                 LDA   #$F0                         ;[x]
  6351  9D 84 32              STA   $3284,X                      ;[x]
  6354  FE 89 2F              INC   $2F89,X                      ;[x]
  6357  9E 59 36              STZ   $3659,X                      ;[x]
  635A  A9 01                 LDA   #$01                         ;[x]
  635C  9D EC 35              STA   $35EC,X                      ;[x]
L0C_635F:
  635F  60                    RTS                                ;[x]

L0C_6360:
  6360  20 19 69              JSR   L0C_6919                     ;[x]
  6363  20 4C 41              JSR   L0B_414C                     ;[x]
  6366  DE C6 36              DEC   $36C6,X                      ;[x]
  6369  D0 0F                 BNE   L0C_637A                     ;[x]
  636B  9E 17 32              STZ   $3217,X                      ;[x]
  636E  9E 84 32              STZ   $3284,X                      ;[x]
  6371  9E D0 30              STZ   $30D0,X                      ;[x]
  6374  9E 63 30              STZ   $3063,X                      ;[x]
  6377  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_637A:
  637A  60                    RTS                                ;[x]

  637B  BD 89 2F              LDA   $2F89,X                      ;[x]
  637E  3A                    DEC   A                            ;[x]
  637F  F0 4D                 BEQ   L0C_63CE                     ;[x]
  6381  3A                    DEC   A                            ;[x]
  6382  F0 7F                 BEQ   L0C_6403                     ;[x]
  6384  3A                    DEC   A                            ;[x]
  6385  D0 03                 BNE   L0C_638A                     ;[x]
  6387  4C 1A 64              JMP   L0C_641A                     ;[x]

L0C_638A:
  638A  3A                    DEC   A                            ;[x]
  638B  F0 76                 BEQ   L0C_6403                     ;[x]
  638D  3A                    DEC   A                            ;[x]
  638E  D0 03                 BNE   L0C_6393                     ;[x]
  6390  4C 64 64              JMP   L0C_6464                     ;[x]

L0C_6393:
  6393  A9 C8                 LDA   #$C8                         ;[x]
  6395  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6398  9E 21 2C              STZ   $2C21,X                      ;[x]
  639B  BD 38 34              LDA   $3438,X                      ;[x]
  639E  29 01                 AND   #$01                         ;[x]
  63A0  F0 0C                 BEQ   L0C_63AE                     ;[x]
  63A2  9E DA 2A              STZ   $2ADA,X                      ;[x]
  63A5  A9 F8                 LDA   #$F8                         ;[x]
  63A7  9D 47 2B              STA   $2B47,X                      ;[x]
  63AA  A9 17                 LDA   #$17                         ;[x]
  63AC  80 0C                 BRA   L0C_63BA                     ;[x]

L0C_63AE:
  63AE  A9 FF                 LDA   #$FF                         ;[x]
  63B0  9D DA 2A              STA   $2ADA,X                      ;[x]
  63B3  A9 F8                 LDA   #$F8                         ;[x]
  63B5  9D 47 2B              STA   $2B47,X                      ;[x]
  63B8  A9 19                 LDA   #$19                         ;[x]
L0C_63BA:
  63BA  9D A0 37              STA   $37A0,X                      ;[x]
  63BD  A9 07                 LDA   #$07                         ;[x]
  63BF  9D C6 36              STA   $36C6,X                      ;[x]
  63C2  FE 0D 38              INC   $380D,X                      ;[x]
  63C5  A9 30                 LDA   #$30                         ;[x]
  63C7  9D 33 37              STA   $3733,X                      ;[x]
  63CA  FE 89 2F              INC   $2F89,X                      ;[x]
  63CD  60                    RTS                                ;[x]

L0C_63CE:
  63CE  20 4C 41              JSR   L0B_414C                     ;[x]
  63D1  DE 0D 38              DEC   $380D,X                      ;[x]
  63D4  D0 23                 BNE   L0C_63F9                     ;[x]
  63D6  DE C6 36              DEC   $36C6,X                      ;[x]
  63D9  F0 1F                 BEQ   L0C_63FA                     ;[x]
  63DB  A9 07                 LDA   #$07                         ;[x]
  63DD  9D 0D 38              STA   $380D,X                      ;[x]
  63E0  BD 38 34              LDA   $3438,X                      ;[x]
  63E3  29 01                 AND   #$01                         ;[x]
  63E5  D0 05                 BNE   L0C_63EC                     ;[x]
  63E7  FE A0 37              INC   $37A0,X                      ;[x]
  63EA  80 03                 BRA   L0C_63EF                     ;[x]

L0C_63EC:
  63EC  DE A0 37              DEC   $37A0,X                      ;[x]
L0C_63EF:
  63EF  BD A0 37              LDA   $37A0,X                      ;[x]
  63F2  29 1F                 AND   #$1F                         ;[x]
  63F4  A0 26                 LDY   #$26                         ;[x]
  63F6  20 11 41              JSR   L0B_4111                     ;[x]
L0C_63F9:
  63F9  60                    RTS                                ;[x]

L0C_63FA:
  63FA  FE 89 2F              INC   $2F89,X                      ;[x]
  63FD  A9 1A                 LDA   #$1A                         ;[x]
  63FF  9D C6 36              STA   $36C6,X                      ;[x]
  6402  60                    RTS                                ;[x]

L0C_6403:
  6403  20 19 69              JSR   L0C_6919                     ;[x]
  6406  20 4C 41              JSR   L0B_414C                     ;[x]
  6409  DE C6 36              DEC   $36C6,X                      ;[x]
  640C  D0 0B                 BNE   L0C_6419                     ;[x]
  640E  FE 89 2F              INC   $2F89,X                      ;[x]
  6411  A9 3F                 LDA   #$3F                         ;[x]
  6413  9D C6 36              STA   $36C6,X                      ;[x]
  6416  FE 0D 38              INC   $380D,X                      ;[x]
L0C_6419:
  6419  60                    RTS                                ;[x]

L0C_641A:
  641A  20 19 69              JSR   L0C_6919                     ;[x]
  641D  20 4C 41              JSR   L0B_414C                     ;[x]
  6420  DE 0D 38              DEC   $380D,X                      ;[x]
  6423  D0 23                 BNE   L0C_6448                     ;[x]
  6425  DE C6 36              DEC   $36C6,X                      ;[x]
  6428  F0 1F                 BEQ   L0C_6449                     ;[x]
  642A  A9 05                 LDA   #$05                         ;[x]
  642C  9D 0D 38              STA   $380D,X                      ;[x]
  642F  BD 38 34              LDA   $3438,X                      ;[x]
  6432  29 01                 AND   #$01                         ;[x]
  6434  D0 05                 BNE   L0C_643B                     ;[x]
  6436  DE A0 37              DEC   $37A0,X                      ;[x]
  6439  80 03                 BRA   L0C_643E                     ;[x]

L0C_643B:
  643B  FE A0 37              INC   $37A0,X                      ;[x]
L0C_643E:
  643E  BD A0 37              LDA   $37A0,X                      ;[x]
  6441  29 1F                 AND   #$1F                         ;[x]
  6443  A0 26                 LDY   #$26                         ;[x]
  6445  20 11 41              JSR   L0B_4111                     ;[x]
L0C_6448:
  6448  60                    RTS                                ;[x]

L0C_6449:
  6449  FE 89 2F              INC   $2F89,X                      ;[x]
  644C  A9 1A                 LDA   #$1A                         ;[x]
  644E  9D C6 36              STA   $36C6,X                      ;[x]
  6451  60                    RTS                                ;[x]

  6452  .db $20,$19,$69,$20,$4C,$41,$DE,$C6,$36,$D0,$06,$FE,$89,$2F,$FE,$0D
  6462  .db $38,$60
L0C_6464:
  6464  20 4C 41              JSR   L0B_414C                     ;[x]
  6467  DE 0D 38              DEC   $380D,X                      ;[x]
  646A  D0 1E                 BNE   L0C_648A                     ;[x]
  646C  A9 07                 LDA   #$07                         ;[x]
  646E  9D 0D 38              STA   $380D,X                      ;[x]
  6471  BD 38 34              LDA   $3438,X                      ;[x]
  6474  29 01                 AND   #$01                         ;[x]
  6476  D0 05                 BNE   L0C_647D                     ;[x]
  6478  FE A0 37              INC   $37A0,X                      ;[x]
  647B  80 03                 BRA   L0C_6480                     ;[x]

L0C_647D:
  647D  DE A0 37              DEC   $37A0,X                      ;[x]
L0C_6480:
  6480  BD A0 37              LDA   $37A0,X                      ;[x]
  6483  29 1F                 AND   #$1F                         ;[x]
  6485  A0 26                 LDY   #$26                         ;[x]
  6487  20 11 41              JSR   L0B_4111                     ;[x]
L0C_648A:
  648A  60                    RTS                                ;[x]

  648B  A9 06                 LDA   #$06                         ;[x]
  648D  20 15 69              JSR   L0C_6915                     ;[x]
  6490  BD 89 2F              LDA   $2F89,X                      ;[x]
  6493  3A                    DEC   A                            ;[x]
  6494  F0 2A                 BEQ   L0C_64C0                     ;[x]
  6496  3A                    DEC   A                            ;[x]
  6497  F0 51                 BEQ   L0C_64EA                     ;[x]
  6499  3A                    DEC   A                            ;[x]
  649A  D0 03                 BNE   L0C_649F                     ;[x]
  649C  4C 2C 65              JMP   L0C_652C                     ;[x]

L0C_649F:
  649F  BD 38 34              LDA   $3438,X                      ;[x]
  64A2  29 01                 AND   #$01                         ;[x]
  64A4  D0 07                 BNE   L0C_64AD                     ;[x]
  64A6  DE DA 2A              DEC   $2ADA,X                      ;[x]
  64A9  A9 03                 LDA   #$03                         ;[x]
  64AB  80 02                 BRA   L0C_64AF                     ;[x]

L0C_64AD:
  64AD  A9 0D                 LDA   #$0D                         ;[x]
L0C_64AF:
  64AF  9D A0 37              STA   $37A0,X                      ;[x]
  64B2  A0 24                 LDY   #$24                         ;[x]
  64B4  20 11 41              JSR   L0B_4111                     ;[x]
  64B7  A9 F8                 LDA   #$F8                         ;[x]
  64B9  9D 47 2B              STA   $2B47,X                      ;[x]
  64BC  FE 89 2F              INC   $2F89,X                      ;[x]
  64BF  60                    RTS                                ;[x]

L0C_64C0:
  64C0  20 9B 41              JSR   L0B_419B                     ;[x]
  64C3  85 00                 STA   <$00                         ;[x]
  64C5  05 00                 ORA   <$00                         ;[x]
  64C7  10 01                 BPL   L0C_64CA                     ;[x]
  64C9  62                    CLA                                ;[x]
L0C_64CA:
  64CA  A8                    TAY                                ;[x]
  64CB  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  64CE  18                    CLC                                ;[x]
  64CF  69 60                 ADC   #$60                         ;[x]
  64D1  85 00                 STA   <$00                         ;[x]
  64D3  BD 21 2C              LDA   $2C21,X                      ;[x]
  64D6  69 00                 ADC   #$00                         ;[x]
  64D8  D0 07                 BNE   L0C_64E1                     ;[x]
  64DA  B9 8E 2C              LDA   $2C8E,Y                      ;[x]
  64DD  C5 00                 CMP   <$00                         ;[x]
  64DF  B0 08                 BCS   L0C_64E9                     ;[x]
L0C_64E1:
  64E1  A9 03                 LDA   #$03                         ;[x]
  64E3  9D 0D 38              STA   $380D,X                      ;[x]
  64E6  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_64E9:
  64E9  60                    RTS                                ;[x]

L0C_64EA:
  64EA  BD 0D 38              LDA   $380D,X                      ;[x]
  64ED  D0 3A                 BNE   L0C_6529                     ;[x]
  64EF  A9 03                 LDA   #$03                         ;[x]
  64F1  9D 0D 38              STA   $380D,X                      ;[x]
  64F4  BD 38 34              LDA   $3438,X                      ;[x]
  64F7  29 01                 AND   #$01                         ;[x]
  64F9  D0 0F                 BNE   L0C_650A                     ;[x]
  64FB  BD A0 37              LDA   $37A0,X                      ;[x]
  64FE  1A                    INC   A                            ;[x]
  64FF  29 1F                 AND   #$1F                         ;[x]
  6501  9D A0 37              STA   $37A0,X                      ;[x]
  6504  C9 13                 CMP   #$13                         ;[x]
  6506  F0 0F                 BEQ   L0C_6517                     ;[x]
  6508  80 10                 BRA   L0C_651A                     ;[x]

L0C_650A:
  650A  BD A0 37              LDA   $37A0,X                      ;[x]
  650D  3A                    DEC   A                            ;[x]
  650E  29 1F                 AND   #$1F                         ;[x]
  6510  9D A0 37              STA   $37A0,X                      ;[x]
  6513  C9 1D                 CMP   #$1D                         ;[x]
  6515  D0 03                 BNE   L0C_651A                     ;[x]
L0C_6517:
  6517  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_651A:
  651A  49 01                 EOR   #$01                         ;[x]
  651C  29 01                 AND   #$01                         ;[x]
  651E  20 7F 41              JSR   L0B_417F                     ;[x]
  6521  BD A0 37              LDA   $37A0,X                      ;[x]
  6524  A0 24                 LDY   #$24                         ;[x]
  6526  20 11 41              JSR   L0B_4111                     ;[x]
L0C_6529:
  6529  DE 0D 38              DEC   $380D,X                      ;[x]
L0C_652C:
  652C  60                    RTS                                ;[x]

  652D  BD 89 2F              LDA   $2F89,X                      ;[x]
  6530  20 A2 E7              JSR   L00_E7A2                     ;[x]
  6533  .db $3B,$65,$53,$65,$8A,$65,$E0,$65
L0C_653B:
  653B  A9 00                 LDA   #$00                         ;[x]
  653D  9D 21 2C              STA   $2C21,X                      ;[x]
  6540  A9 E0                 LDA   #$E0                         ;[x]
  6542  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6545  A9 FF                 LDA   #$FF                         ;[x]
  6547  9D 3D 31              STA   $313D,X                      ;[x]
  654A  A9 00                 LDA   #$00                         ;[x]
  654C  9D AA 31              STA   $31AA,X                      ;[x]
  654F  FE 89 2F              INC   $2F89,X                      ;[x]
  6552  60                    RTS                                ;[x]

  6553  20 E1 65              JSR   L0C_65E1                     ;[x]
  6556  FE C6 36              INC   $36C6,X                      ;[x]
  6559  BD C6 36              LDA   $36C6,X                      ;[x]
  655C  C9 C0                 CMP   #$C0                         ;[x]
  655E  90 29                 BCC   L0C_6589                     ;[x]
  6560  FE 89 2F              INC   $2F89,X                      ;[x]
  6563  9E 0D 38              STZ   $380D,X                      ;[x]
  6566  20 E1 65              JSR   L0C_65E1                     ;[x]
  6569  A9 08                 LDA   #$08                         ;[x]
  656B  9D 84 32              STA   $3284,X                      ;[x]
  656E  BD 47 2B              LDA   $2B47,X                      ;[x]
  6571  C9 78                 CMP   #$78                         ;[x]
  6573  10 07                 BPL   L0C_657C                     ;[x]
  6575  9E 38 34              STZ   $3438,X                      ;[x]
  6578  A9 12                 LDA   #$12                         ;[x]
  657A  80 07                 BRA   L0C_6583                     ;[x]

L0C_657C:
  657C  A9 01                 LDA   #$01                         ;[x]
  657E  9D 38 34              STA   $3438,X                      ;[x]
  6581  A9 EE                 LDA   #$EE                         ;[x]
L0C_6583:
  6583  9D 17 32              STA   $3217,X                      ;[x]
  6586  9E A0 37              STZ   $37A0,X                      ;[x]
L0C_6589:
  6589  60                    RTS                                ;[x]

  658A  FE A0 37              INC   $37A0,X                      ;[x]
  658D  BD A0 37              LDA   $37A0,X                      ;[x]
  6590  C9 0D                 CMP   #$0D                         ;[x]
  6592  F0 0C                 BEQ   L0C_65A0                     ;[x]
  6594  C9 1A                 CMP   #$1A                         ;[x]
  6596  F0 08                 BEQ   L0C_65A0                     ;[x]
  6598  C9 26                 CMP   #$26                         ;[x]
  659A  F0 04                 BEQ   L0C_65A0                     ;[x]
  659C  C9 33                 CMP   #$33                         ;[x]
  659E  D0 09                 BNE   L0C_65A9                     ;[x]
L0C_65A0:
  65A0  BD EC 35              LDA   $35EC,X                      ;[x]
  65A3  20 7F 41              JSR   L0B_417F                     ;[x]
  65A6  FE EC 35              INC   $35EC,X                      ;[x]
L0C_65A9:
  65A9  BD 3D 31              LDA   $313D,X                      ;[x]
  65AC  D0 0E                 BNE   L0C_65BC                     ;[x]
  65AE  BD AA 31              LDA   $31AA,X                      ;[x]
  65B1  D0 09                 BNE   L0C_65BC                     ;[x]
  65B3  BD 17 32              LDA   $3217,X                      ;[x]
  65B6  49 FF                 EOR   #$FF                         ;[x]
  65B8  1A                    INC   A                            ;[x]
  65B9  9D 17 32              STA   $3217,X                      ;[x]
L0C_65BC:
  65BC  BD 3D 31              LDA   $313D,X                      ;[x]
  65BF  C9 01                 CMP   #$01                         ;[x]
  65C1  D0 13                 BNE   L0C_65D6                     ;[x]
  65C3  9E 84 32              STZ   $3284,X                      ;[x]
  65C6  9E 17 32              STZ   $3217,X                      ;[x]
  65C9  A9 02                 LDA   #$02                         ;[x]
  65CB  9D 3D 31              STA   $313D,X                      ;[x]
  65CE  A9 01                 LDA   #$01                         ;[x]
  65D0  9D F1 32              STA   $32F1,X                      ;[x]
  65D3  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_65D6:
  65D6  BD 38 34              LDA   $3438,X                      ;[x]
  65D9  29 01                 AND   #$01                         ;[x]
  65DB  F0 03                 BEQ   L0C_65E0                     ;[x]
  65DD  20 7F 42              JSR   L0B_427F                     ;[x]
L0C_65E0:
  65E0  60                    RTS                                ;[x]

L0C_65E1:
  65E1  BD 7A 38              LDA   $387A,X                      ;[x]
  65E4  D0 17                 BNE   L0C_65FD                     ;[x]
  65E6  FE 0D 38              INC   $380D,X                      ;[x]
  65E9  BD 0D 38              LDA   $380D,X                      ;[x]
  65EC  29 04                 AND   #$04                         ;[x]
  65EE  D0 04                 BNE   L0C_65F4                     ;[x]
  65F0  A9 28                 LDA   #$28                         ;[x]
  65F2  80 02                 BRA   L0C_65F6                     ;[x]

L0C_65F4:
  65F4  A9 29                 LDA   #$29                         ;[x]
L0C_65F6:
  65F6  DA                    PHX                                ;[x]
  65F7  A2 04                 LDX   #$04                         ;[x]
  65F9  20 D5 E8              JSR   L00_E8D5                     ;[x]
  65FC  FA                    PLX                                ;[x]
L0C_65FD:
  65FD  60                    RTS                                ;[x]

  65FE  A9 06                 LDA   #$06                         ;[x]
  6600  20 15 69              JSR   L0C_6915                     ;[x]
  6603  BD 89 2F              LDA   $2F89,X                      ;[x]
  6606  3A                    DEC   A                            ;[x]
  6607  F0 3F                 BEQ   L0C_6648                     ;[x]
  6609  3A                    DEC   A                            ;[x]
  660A  F0 50                 BEQ   L0C_665C                     ;[x]
  660C  3A                    DEC   A                            ;[x]
  660D  D0 03                 BNE   L0C_6612                     ;[x]
  660F  4C 84 66              JMP   L0C_6684                     ;[x]

L0C_6612:
  6612  3A                    DEC   A                            ;[x]
  6613  D0 03                 BNE   L0C_6618                     ;[x]
  6615  4C C4 66              JMP   L0C_66C4                     ;[x]

L0C_6618:
  6618  A9 F8                 LDA   #$F8                         ;[x]
  661A  9D 8E 2C              STA   $2C8E,X                      ;[x]
  661D  BD 38 34              LDA   $3438,X                      ;[x]
  6620  29 01                 AND   #$01                         ;[x]
  6622  D0 06                 BNE   L0C_662A                     ;[x]
  6624  A9 18                 LDA   #$18                         ;[x]
  6626  A0 01                 LDY   #$01                         ;[x]
  6628  80 04                 BRA   L0C_662E                     ;[x]

L0C_662A:
  662A  A9 D8                 LDA   #$D8                         ;[x]
  662C  A0 FF                 LDY   #$FF                         ;[x]
L0C_662E:
  662E  9D 47 2B              STA   $2B47,X                      ;[x]
  6631  98                    TYA                                ;[x]
  6632  9D 63 30              STA   $3063,X                      ;[x]
  6635  A9 01                 LDA   #$01                         ;[x]
  6637  9D 3D 31              STA   $313D,X                      ;[x]
  663A  A9 20                 LDA   #$20                         ;[x]
  663C  9D AA 31              STA   $31AA,X                      ;[x]
  663F  A9 FD                 LDA   #$FD                         ;[x]
  6641  9D 84 32              STA   $3284,X                      ;[x]
  6644  FE 89 2F              INC   $2F89,X                      ;[x]
  6647  60                    RTS                                ;[x]

L0C_6648:
  6648  20 4C 41              JSR   L0B_414C                     ;[x]
  664B  BD 47 2B              LDA   $2B47,X                      ;[x]
  664E  C9 78                 CMP   #$78                         ;[x]
  6650  D0 09                 BNE   L0C_665B                     ;[x]
  6652  FE 89 2F              INC   $2F89,X                      ;[x]
  6655  9E 84 32              STZ   $3284,X                      ;[x]
  6658  9E 63 30              STZ   $3063,X                      ;[x]
L0C_665B:
  665B  60                    RTS                                ;[x]

L0C_665C:
  665C  FE C6 36              INC   $36C6,X                      ;[x]
  665F  BD C6 36              LDA   $36C6,X                      ;[x]
  6662  C9 60                 CMP   #$60                         ;[x]
  6664  D0 1D                 BNE   L0C_6683                     ;[x]
  6666  FE 89 2F              INC   $2F89,X                      ;[x]
  6669  BD 38 34              LDA   $3438,X                      ;[x]
  666C  29 01                 AND   #$01                         ;[x]
  666E  D0 04                 BNE   L0C_6674                     ;[x]
  6670  A9 02                 LDA   #$02                         ;[x]
  6672  80 02                 BRA   L0C_6676                     ;[x]

L0C_6674:
  6674  A9 0E                 LDA   #$0E                         ;[x]
L0C_6676:
  6676  9D A0 37              STA   $37A0,X                      ;[x]
L0C_6679:
  6679  A0 1C                 LDY   #$1C                         ;[x]
  667B  20 11 41              JSR   L0B_4111                     ;[x]
  667E  A9 10                 LDA   #$10                         ;[x]
  6680  9D 0D 38              STA   $380D,X                      ;[x]
L0C_6683:
  6683  60                    RTS                                ;[x]

L0C_6684:
  6684  BD 0D 38              LDA   $380D,X                      ;[x]
  6687  D0 1C                 BNE   L0C_66A5                     ;[x]
  6689  A9 10                 LDA   #$10                         ;[x]
  668B  9D 0D 38              STA   $380D,X                      ;[x]
  668E  BD 38 34              LDA   $3438,X                      ;[x]
  6691  29 01                 AND   #$01                         ;[x]
  6693  D0 05                 BNE   L0C_669A                     ;[x]
  6695  FE A0 37              INC   $37A0,X                      ;[x]
  6698  80 03                 BRA   L0C_669D                     ;[x]

L0C_669A:
  669A  DE A0 37              DEC   $37A0,X                      ;[x]
L0C_669D:
  669D  BD A0 37              LDA   $37A0,X                      ;[x]
  66A0  A0 1C                 LDY   #$1C                         ;[x]
  66A2  20 11 41              JSR   L0B_4111                     ;[x]
L0C_66A5:
  66A5  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  66A8  C9 D0                 CMP   #$D0                         ;[x]
  66AA  90 15                 BCC   L0C_66C1                     ;[x]
  66AC  FE 89 2F              INC   $2F89,X                      ;[x]
  66AF  BD 38 34              LDA   $3438,X                      ;[x]
  66B2  49 01                 EOR   #$01                         ;[x]
  66B4  29 01                 AND   #$01                         ;[x]
  66B6  A8                    TAY                                ;[x]
  66B7  20 1C 40              JSR   L0B_401C                     ;[x]
  66BA  A5 00                 LDA   <$00                         ;[x]
  66BC  A0 40                 LDY   #$40                         ;[x]
  66BE  20 11 41              JSR   L0B_4111                     ;[x]
L0C_66C1:
  66C1  DE 0D 38              DEC   $380D,X                      ;[x]
L0C_66C4:
  66C4  60                    RTS                                ;[x]

  66C5  BD 89 2F              LDA   $2F89,X                      ;[x]
  66C8  20 A2 E7              JSR   L00_E7A2                     ;[x]
  66CB  D9 66 06              CMP   $0666,Y                      ;[ ]
  66CE  67 24                 RMB6  <$24                         ;[ ]
  66D0  67 62                 RMB6  <$62                         ;[ ]
  66D2  67 88                 RMB6  <$88                         ;[ ]
  66D4  67 B1                 RMB6  <$B1                         ;[ ]
  66D6  67 F6                 RMB6  <$F6                         ;[ ]
  66D8  67 A9                 RMB6  <$A9                         ;[ ]
  66DA  70 9D                 BVS   L0C_6679                     ;[ ]
  66DC  47 2B                 RMB4  <$2B                         ;[ ]
  66DE  BD 38 34              LDA   $3438,X                      ;[x]
  66E1  F0 09                 BEQ   L0C_66EC                     ;[x]
  66E3  A9 20                 LDA   #$20                         ;[ ]
  66E5  18                    CLC                                ;[ ]
  66E6  7D 47 2B              ADC   $2B47,X                      ;[ ]
  66E9  9D 47 2B              STA   $2B47,X                      ;[ ]
L0C_66EC:
  66EC  A9 02                 LDA   #$02                         ;[x]
  66EE  9D 3D 31              STA   $313D,X                      ;[x]
  66F1  A9 00                 LDA   #$00                         ;[x]
  66F3  9D AA 31              STA   $31AA,X                      ;[x]
  66F6  DA                    PHX                                ;[x]
  66F7  A9 24                 LDA   #$24                         ;[x]
  66F9  9D 7A 38              STA   $387A,X                      ;[x]
  66FC  A2 04                 LDX   #$04                         ;[x]
  66FE  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6701  FA                    PLX                                ;[x]
  6702  FE 89 2F              INC   $2F89,X                      ;[x]
  6705  60                    RTS                                ;[x]

  6706  BD 21 2C              LDA   $2C21,X                      ;[x]
  6709  D0 18                 BNE   L0C_6723                     ;[x]
  670B  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  670E  C9 50                 CMP   #$50                         ;[x]
  6710  90 11                 BCC   L0C_6723                     ;[x]
  6712  9E 3D 31              STZ   $313D,X                      ;[x]
  6715  9E AA 31              STZ   $31AA,X                      ;[x]
  6718  A9 06                 LDA   #$06                         ;[x]
  671A  9D A0 37              STA   $37A0,X                      ;[x]
  671D  9E 0D 38              STZ   $380D,X                      ;[x]
  6720  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_6723:
  6723  60                    RTS                                ;[x]

  6724  BD A0 37              LDA   $37A0,X                      ;[x]
  6727  D0 35                 BNE   L0C_675E                     ;[x]
  6729  A9 06                 LDA   #$06                         ;[x]
  672B  9D A0 37              STA   $37A0,X                      ;[x]
  672E  A9 0C                 LDA   #$0C                         ;[x]
  6730  85 0A                 STA   <$0A                         ;[x]
  6732  BD 38 34              LDA   $3438,X                      ;[x]
  6735  0A                    ASL   A                            ;[x]
  6736  0A                    ASL   A                            ;[x]
  6737  0A                    ASL   A                            ;[x]
  6738  0A                    ASL   A                            ;[x]
  6739  0A                    ASL   A                            ;[x]
  673A  18                    CLC                                ;[x]
  673B  7D 0D 38              ADC   $380D,X                      ;[x]
  673E  85 0B                 STA   <$0B                         ;[x]
  6740  86 B2                 STX   <$B2                         ;[x]
  6742  20 37 43              JSR   L0B_4337                     ;[x]
  6745  A6 B2                 LDX   <$B2                         ;[x]
  6747  FE 0D 38              INC   $380D,X                      ;[x]
  674A  BD 0D 38              LDA   $380D,X                      ;[x]
  674D  C9 0C                 CMP   #$0C                         ;[x]
  674F  D0 0D                 BNE   L0C_675E                     ;[x]
  6751  A9 12                 LDA   #$12                         ;[x]
  6753  9D A0 37              STA   $37A0,X                      ;[x]
  6756  A9 10                 LDA   #$10                         ;[x]
  6758  9D 0D 38              STA   $380D,X                      ;[x]
  675B  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_675E:
  675E  DE A0 37              DEC   $37A0,X                      ;[x]
  6761  60                    RTS                                ;[x]

  6762  BD A0 37              LDA   $37A0,X                      ;[x]
  6765  D0 1D                 BNE   L0C_6784                     ;[x]
  6767  A9 06                 LDA   #$06                         ;[x]
  6769  9D A0 37              STA   $37A0,X                      ;[x]
  676C  FE EC 35              INC   $35EC,X                      ;[x]
  676F  BD EC 35              LDA   $35EC,X                      ;[x]
  6772  20 7F 41              JSR   L0B_417F                     ;[x]
  6775  BD EC 35              LDA   $35EC,X                      ;[x]
  6778  C9 0C                 CMP   #$0C                         ;[x]
  677A  D0 08                 BNE   L0C_6784                     ;[x]
  677C  A9 08                 LDA   #$08                         ;[x]
  677E  9D A0 37              STA   $37A0,X                      ;[x]
  6781  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_6784:
  6784  DE A0 37              DEC   $37A0,X                      ;[x]
  6787  60                    RTS                                ;[x]

  6788  BD A0 37              LDA   $37A0,X                      ;[x]
  678B  D0 12                 BNE   L0C_679F                     ;[x]
  678D  FE 7A 38              INC   $387A,X                      ;[x]
  6790  BD 7A 38              LDA   $387A,X                      ;[x]
  6793  C9 28                 CMP   #$28                         ;[x]
  6795  D0 0C                 BNE   L0C_67A3                     ;[x]
  6797  FE 89 2F              INC   $2F89,X                      ;[x]
  679A  A9 08                 LDA   #$08                         ;[x]
  679C  9D A0 37              STA   $37A0,X                      ;[x]
L0C_679F:
  679F  DE A0 37              DEC   $37A0,X                      ;[x]
  67A2  60                    RTS                                ;[x]

L0C_67A3:
  67A3  DA                    PHX                                ;[x]
  67A4  A2 04                 LDX   #$04                         ;[x]
  67A6  20 D5 E8              JSR   L00_E8D5                     ;[x]
  67A9  FA                    PLX                                ;[x]
  67AA  A9 08                 LDA   #$08                         ;[x]
  67AC  9D A0 37              STA   $37A0,X                      ;[x]
  67AF  80 EE                 BRA   L0C_679F                     ;[x]

  67B1  BD A0 37              LDA   $37A0,X                      ;[x]
  67B4  D0 3C                 BNE   L0C_67F2                     ;[x]
  67B6  A9 08                 LDA   #$08                         ;[x]
  67B8  9D A0 37              STA   $37A0,X                      ;[x]
  67BB  DE EC 35              DEC   $35EC,X                      ;[x]
  67BE  BD EC 35              LDA   $35EC,X                      ;[x]
  67C1  20 7F 41              JSR   L0B_417F                     ;[x]
  67C4  A9 0C                 LDA   #$0C                         ;[x]
  67C6  85 0A                 STA   <$0A                         ;[x]
  67C8  BD 38 34              LDA   $3438,X                      ;[x]
  67CB  0A                    ASL   A                            ;[x]
  67CC  0A                    ASL   A                            ;[x]
  67CD  0A                    ASL   A                            ;[x]
  67CE  0A                    ASL   A                            ;[x]
  67CF  0A                    ASL   A                            ;[x]
  67D0  18                    CLC                                ;[x]
  67D1  7D 0D 38              ADC   $380D,X                      ;[x]
  67D4  85 0B                 STA   <$0B                         ;[x]
  67D6  86 B2                 STX   <$B2                         ;[x]
  67D8  20 37 43              JSR   L0B_4337                     ;[x]
  67DB  A6 B2                 LDX   <$B2                         ;[x]
  67DD  FE 0D 38              INC   $380D,X                      ;[x]
  67E0  BD EC 35              LDA   $35EC,X                      ;[x]
  67E3  D0 0D                 BNE   L0C_67F2                     ;[x]
  67E5  A9 FE                 LDA   #$FE                         ;[x]
  67E7  9D 3D 31              STA   $313D,X                      ;[x]
  67EA  A9 01                 LDA   #$01                         ;[x]
  67EC  9D F1 32              STA   $32F1,X                      ;[x]
  67EF  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_67F2:
  67F2  DE A0 37              DEC   $37A0,X                      ;[x]
  67F5  60                    RTS                                ;[x]

  67F6  60                    RTS                                ;[x]

  67F7  BD 89 2F              LDA   $2F89,X                      ;[x]
  67FA  3A                    DEC   A                            ;[x]
  67FB  D0 03                 BNE   L0C_6800                     ;[x]
  67FD  4C 9B 68              JMP   L0C_689B                     ;[x]

L0C_6800:
  6800  3A                    DEC   A                            ;[x]
  6801  D0 03                 BNE   L0C_6806                     ;[x]
  6803  4C A8 68              JMP   L0C_68A8                     ;[x]

L0C_6806:
  6806  BD 38 34              LDA   $3438,X                      ;[x]
  6809  89 10                 BIT   #$10                         ;[x]
  680B  D0 4C                 BNE   L0C_6859                     ;[x]
  680D  29 0F                 AND   #$0F                         ;[x]
  680F  0A                    ASL   A                            ;[x]
  6810  0A                    ASL   A                            ;[x]
  6811  0A                    ASL   A                            ;[x]
  6812  A8                    TAY                                ;[x]
  6813  B9 A9 68              LDA   $68A9,Y                      ;[x]
  6816  9D DA 2A              STA   $2ADA,X                      ;[x]
  6819  C8                    INY                                ;[x]
  681A  B9 A9 68              LDA   $68A9,Y                      ;[x]
  681D  9D 47 2B              STA   $2B47,X                      ;[x]
  6820  C8                    INY                                ;[x]
  6821  B9 A9 68              LDA   $68A9,Y                      ;[x]
  6824  9D 21 2C              STA   $2C21,X                      ;[x]
  6827  C8                    INY                                ;[x]
  6828  B9 A9 68              LDA   $68A9,Y                      ;[x]
  682B  9D 8E 2C              STA   $2C8E,X                      ;[x]
  682E  C8                    INY                                ;[x]
  682F  B9 A9 68              LDA   $68A9,Y                      ;[x]
  6832  9D 63 30              STA   $3063,X                      ;[x]
  6835  C8                    INY                                ;[x]
  6836  B9 A9 68              LDA   $68A9,Y                      ;[x]
  6839  9D D0 30              STA   $30D0,X                      ;[x]
  683C  C8                    INY                                ;[x]
  683D  B9 A9 68              LDA   $68A9,Y                      ;[x]
  6840  9D 3D 31              STA   $313D,X                      ;[x]
  6843  C8                    INY                                ;[x]
  6844  B9 A9 68              LDA   $68A9,Y                      ;[x]
  6847  9D AA 31              STA   $31AA,X                      ;[x]
  684A  A9 80                 LDA   #$80                         ;[x]
  684C  9D 9B 3A              STA   $3A9B,X                      ;[x]
  684F  9E F1 32              STZ   $32F1,X                      ;[x]
  6852  A9 55                 LDA   #$55                         ;[x]
  6854  9D 33 37              STA   $3733,X                      ;[x]
  6857  80 26                 BRA   L0C_687F                     ;[x]

L0C_6859:
  6859  29 0F                 AND   #$0F                         ;[x]
  685B  A8                    TAY                                ;[x]
  685C  B9 09 69              LDA   $6909,Y                      ;[x]
  685F  85 00                 STA   <$00                         ;[x]
  6861  A5 8F                 LDA   <$8F                         ;[x]
  6863  18                    CLC                                ;[x]
  6864  69 20                 ADC   #$20                         ;[x]
  6866  A8                    TAY                                ;[x]
  6867  A5 00                 LDA   <$00                         ;[x]
  6869  20 11 41              JSR   L0B_4111                     ;[x]
  686C  9E DA 2A              STZ   $2ADA,X                      ;[x]
  686F  9E 21 2C              STZ   $2C21,X                      ;[x]
  6872  A9 70                 LDA   #$70                         ;[x]
  6874  9D 47 2B              STA   $2B47,X                      ;[x]
  6877  A9 58                 LDA   #$58                         ;[x]
  6879  9D 8E 2C              STA   $2C8E,X                      ;[x]
  687C  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_687F:
  687F  BD 38 34              LDA   $3438,X                      ;[x]
  6882  29 20                 AND   #$20                         ;[x]
  6884  18                    CLC                                ;[x]
  6885  7D 47 2B              ADC   $2B47,X                      ;[x]
  6888  9D 47 2B              STA   $2B47,X                      ;[x]
  688B  62                    CLA                                ;[x]
  688C  7D DA 2A              ADC   $2ADA,X                      ;[x]
  688F  9D DA 2A              STA   $2ADA,X                      ;[x]
  6892  FE 89 2F              INC   $2F89,X                      ;[x]
  6895  A9 50                 LDA   #$50                         ;[x]
  6897  9D A0 37              STA   $37A0,X                      ;[x]
  689A  60                    RTS                                ;[x]

L0C_689B:
  689B  BD A0 37              LDA   $37A0,X                      ;[x]
  689E  D0 04                 BNE   L0C_68A4                     ;[x]
  68A0  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  68A3  60                    RTS                                ;[x]

L0C_68A4:
  68A4  DE A0 37              DEC   $37A0,X                      ;[x]
  68A7  60                    RTS                                ;[x]

L0C_68A8:
  68A8  60                    RTS                                ;[x]

  68A9  .db $FF,$C8,$00,$00,$02,$00,$01,$00,$01,$18,$00,$A8,$FE,$00,$FF,$00
  68B9  .db $00,$70,$00,$F8,$00,$00,$FE,$00,$FF,$C8,$00,$80,$02,$00,$FF,$80
  68C9  .db $00,$C8,$FF,$B0,$FF,$00,$02,$00,$00,$70,$01,$00,$00,$00,$FE,$00
  68D9  .db $FF,$C8,$00,$00,$02,$00,$01,$00,$01,$18,$01,$00,$FE,$00,$FE,$00
  68E9  .db $00,$18,$01,$00,$01,$00,$FE,$00,$FF,$C0,$00,$58,$02,$00,$00,$00
  68F9  .db $00,$98,$01,$08,$FF,$80,$FE,$00,$01,$20,$00,$58,$FE,$00,$00,$00
  6909  .db $1C,$08,$0F,$04,$0A,$16,$0C,$06,$08,$1C,$0F,$1F
L0C_6915:
  6915  C5 8F                 CMP   <$8F                         ;[x]
  6917  B0 45                 BCS   L0C_695E                     ;[x]
L0C_6919:
  6919  8A                    TXA                                ;[x]
  691A  29 01                 AND   #$01                         ;[x]
  691C  85 00                 STA   <$00                         ;[x]
  691E  A5 83                 LDA   <$83                         ;[x]
  6920  29 01                 AND   #$01                         ;[x]
  6922  C5 00                 CMP   <$00                         ;[x]
  6924  D0 38                 BNE   L0C_695E                     ;[x]
  6926  A5 B1                 LDA   <$B1                         ;[x]
  6928  85 00                 STA   <$00                         ;[x]
  692A  62                    CLA                                ;[x]
L0C_692B:
  692B  C6 00                 DEC   <$00                         ;[x]
  692D  30 05                 BMI   L0C_6934                     ;[x]
  692F  18                    CLC                                ;[x]
  6930  69 18                 ADC   #$18                         ;[x]
  6932  80 F7                 BRA   L0C_692B                     ;[x]

L0C_6934:
  6934  85 01                 STA   <$01                         ;[x]
  6936  BD C1 39              LDA   $39C1,X                      ;[x]
  6939  F0 23                 BEQ   L0C_695E                     ;[x]
  693B  18                    CLC                                ;[x]
  693C  65 8F                 ADC   <$8F                         ;[x]
  693E  3A                    DEC   A                            ;[x]
  693F  C9 18                 CMP   #$18                         ;[x]
  6941  90 02                 BCC   L0C_6945                     ;[x]
  6943  A9 17                 LDA   #$17                         ;[ ]
L0C_6945:
  6945  18                    CLC                                ;[x]
  6946  65 01                 ADC   <$01                         ;[x]
  6948  A8                    TAY                                ;[x]
  6949  B9 5F 69              LDA   $695F,Y                      ;[x]
  694C  85 00                 STA   <$00                         ;[x]
  694E  FE 2E 3A              INC   $3A2E,X                      ;[x]
  6951  BD 2E 3A              LDA   $3A2E,X                      ;[x]
  6954  C5 00                 CMP   <$00                         ;[x]
  6956  90 06                 BCC   L0C_695E                     ;[x]
  6958  20 4C 44              JSR   L0B_444C                     ;[x]
  695B  9E 2E 3A              STZ   $3A2E,X                      ;[x]
L0C_695E:
  695E  60                    RTS                                ;[x]

  695F  .db $FF,$F0,$E0,$D0,$C0,$B0,$A0,$90,$80,$70,$60,$50,$40,$38,$30,$2C
  696F  .db $28,$24,$20,$1E,$1C,$1A,$18,$16,$FF,$FF,$FF,$FF,$C0,$A0,$80,$60
  697F  .db $48,$3C,$34,$30,$2C,$28,$24,$20,$1C,$1A,$18,$17,$16,$15,$14,$13
  698F  .db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$38,$30,$2C,$28,$24,$20,$1E,$1C
  699F  .db $18,$16,$15,$14,$13,$12,$11,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  69AF  .db $FF,$FF,$FF,$FF,$28,$24,$20,$18,$14,$12,$10,$0E,$0D,$0C,$0B,$0A
L0C_69BF:
  69BF  A2 42                 LDX   #$42                         ;[x]
  69C1  BD 89 2F              LDA   $2F89,X                      ;[x]
  69C4  C9 06                 CMP   #$06                         ;[x]
  69C6  B0 17                 BCS   L0C_69DF                     ;[x]
  69C8  BD 59 36              LDA   $3659,X                      ;[x]
  69CB  D0 12                 BNE   L0C_69DF                     ;[x]
  69CD  A9 01                 LDA   #$01                         ;[x]
  69CF  9D 59 36              STA   $3659,X                      ;[x]
  69D2  BD EC 35              LDA   $35EC,X                      ;[x]
  69D5  A8                    TAY                                ;[x]
  69D6  B9 F3 69              LDA   $69F3,Y                      ;[x]
  69D9  9D 89 2F              STA   $2F89,X                      ;[x]
  69DC  FE EC 35              INC   $35EC,X                      ;[x]
L0C_69DF:
  69DF  BD 89 2F              LDA   $2F89,X                      ;[x]
  69E2  20 A2 E7              JSR   L00_E7A2                     ;[x]
  69E5  4E 6A E4              LSR   $E46A                        ;[ ]
  69E8  6A                    ROR   A                            ;[ ]
  69E9  01 6B                 ORA   (<$6B,X)                     ;[ ]
  69EB  65 6B                 ADC   <$6B                         ;[ ]
  69ED  .db $DB,$6B,$52,$6C,$66,$6C,$00,$01,$02,$05,$04,$04,$05,$03,$05,$04
  69FD  .db $04,$04,$04,$04,$04,$05,$03,$05,$04,$04,$04,$04,$04,$04,$05,$03
  6A0D  .db $05,$04,$04,$04,$04,$04,$04,$05,$03,$05,$04,$04,$04,$04,$04,$04
  6A1D  .db $05,$03,$05,$04,$04,$04,$04,$04,$04,$05,$03,$05,$04,$04,$04,$04
  6A2D  .db $04,$04,$05,$03,$05,$04,$04,$04,$04,$04,$04,$05,$03,$05,$04,$04
  6A3D  .db $04,$04,$04,$04,$05,$03,$05,$04,$04,$04,$04,$04,$05,$03,$03,$05
  6A4D  .db $06
L0C_6A4E:
  6A4E  A2 42                 LDX   #$42                         ;[x]
  6A50  9E 3D 31              STZ   $313D,X                      ;[x]
  6A53  A9 55                 LDA   #$55                         ;[x]
  6A55  9D AA 31              STA   $31AA,X                      ;[x]
  6A58  C2                    CLY                                ;[x]
L0C_6A59:
  6A59  B9 B7 6A              LDA   $6AB7,Y                      ;[x]
  6A5C  9D 47 2B              STA   $2B47,X                      ;[x]
  6A5F  C8                    INY                                ;[x]
  6A60  B9 B7 6A              LDA   $6AB7,Y                      ;[x]
  6A63  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6A66  C8                    INY                                ;[x]
  6A67  B9 B7 6A              LDA   $6AB7,Y                      ;[x]
  6A6A  9D F1 32              STA   $32F1,X                      ;[x]
  6A6D  C8                    INY                                ;[x]
  6A6E  B9 B7 6A              LDA   $6AB7,Y                      ;[x]
  6A71  9D 5E 33              STA   $335E,X                      ;[x]
  6A74  C8                    INY                                ;[x]
  6A75  B9 B7 6A              LDA   $6AB7,Y                      ;[x]
  6A78  9D CB 33              STA   $33CB,X                      ;[x]
  6A7B  C8                    INY                                ;[x]
  6A7C  A9 FF                 LDA   #$FF                         ;[x]
  6A7E  9D 21 2C              STA   $2C21,X                      ;[x]
  6A81  A5 B6                 LDA   <$B6                         ;[x]
  6A83  9D FB 2C              STA   $2CFB,X                      ;[x]
  6A86  E8                    INX                                ;[x]
  6A87  E0 4B                 CPX   #$4B                         ;[x]
  6A89  D0 CE                 BNE   L0C_6A59                     ;[x]
  6A8B  A2 4A                 LDX   #$4A                         ;[x]
  6A8D  A9 02                 LDA   #$02                         ;[x]
  6A8F  9D 00 2A              STA   $2A00,X                      ;[x]
  6A92  A9 01                 LDA   #$01                         ;[x]
  6A94  9D 6D 2A              STA   $2A6D,X                      ;[x]
  6A97  A2 04                 LDX   #$04                         ;[x]
  6A99  A9 06                 LDA   #$06                         ;[x]
  6A9B  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6A9E  A9 20                 LDA   #$20                         ;[x]
  6AA0  8D 13 32              STA   $3213                        ;[x]
  6AA3  8D 14 32              STA   $3214                        ;[x]
  6AA6  8D 15 32              STA   $3215                        ;[x]
  6AA9  A9 20                 LDA   #$20                         ;[x]
  6AAB  8D EC 31              STA   $31EC                        ;[x]
  6AAE  9C 7F 31              STZ   $317F                        ;[x]
  6AB1  9C 9B 36              STZ   $369B                        ;[x]
  6AB4  4C 26 6D              JMP   L0C_6D26                     ;[x]

  6AB7  .db $78,$C4,$0A,$50,$17,$78,$D8,$0A,$08,$09,$A7,$EC,$0A,$06,$0A,$49
  6AC7  .db $EC,$0A,$06,$0A,$17,$CE,$0A,$0A,$09,$17,$E0,$0A,$0A,$09,$D9,$CE
  6AD7  .db $0A,$0A,$09,$D9,$E0,$0A,$0A,$09,$78,$C8,$00,$00,$00
L0C_6AE4:
  6AE4  AD 70 3B              LDA   $3B70                        ;[x]
  6AE7  D0 15                 BNE   L0C_6AFE                     ;[x]
  6AE9  AD 71 3B              LDA   $3B71                        ;[x]
  6AEC  C9 05                 CMP   #$05                         ;[x]
  6AEE  B0 0E                 BCS   L0C_6AFE                     ;[x]
  6AF0  A9 01                 LDA   #$01                         ;[x]
  6AF2  8D 7A 3B              STA   $3B7A                        ;[x]
  6AF5  9C 9B 36              STZ   $369B                        ;[x]
  6AF8  9C 9C 36              STZ   $369C                        ;[x]
  6AFB  9C 2F 36              STZ   $362F                        ;[x]
L0C_6AFE:
  6AFE  4C 26 6D              JMP   L0C_6D26                     ;[x]

  6B01  AD 9C 36              LDA   $369C                        ;[x]
  6B04  D0 59                 BNE   L0C_6B5F                     ;[x]
  6B06  AD 2F 36              LDA   $362F                        ;[x]
  6B09  18                    CLC                                ;[x]
  6B0A  69 0D                 ADC   #$0D                         ;[x]
  6B0C  A2 04                 LDX   #$04                         ;[x]
  6B0E  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6B11  8D 85 2E              STA   $2E85                        ;[x]
  6B14  EE 2F 36              INC   $362F                        ;[x]
  6B17  AD 2F 36              LDA   $362F                        ;[x]
  6B1A  C9 03                 CMP   #$03                         ;[x]
  6B1C  D0 3C                 BNE   L0C_6B5A                     ;[x]
  6B1E  9C 9B 36              STZ   $369B                        ;[x]
  6B21  A9 09                 LDA   #$09                         ;[x]
  6B23  8D 34 33              STA   $3334                        ;[x]
  6B26  8D 35 33              STA   $3335                        ;[x]
  6B29  8D 36 33              STA   $3336                        ;[x]
  6B2C  A9 13                 LDA   #$13                         ;[x]
  6B2E  8D E8 34              STA   $34E8                        ;[x]
  6B31  A9 09                 LDA   #$09                         ;[x]
  6B33  8D E9 34              STA   $34E9                        ;[x]
  6B36  8D EA 34              STA   $34EA                        ;[x]
  6B39  A9 07                 LDA   #$07                         ;[x]
  6B3B  8D 86 2E              STA   $2E86                        ;[x]
  6B3E  A9 0A                 LDA   #$0A                         ;[x]
  6B40  8D 87 2E              STA   $2E87                        ;[x]
  6B43  AD 72 3B              LDA   $3B72                        ;[x]
  6B46  8D E2 37              STA   $37E2                        ;[x]
  6B49  9C 9C 36              STZ   $369C                        ;[x]
  6B4C  9C A3 36              STZ   $36A3                        ;[x]
  6B4F  9C 36 36              STZ   $3636                        ;[x]
  6B52  A9 50                 LDA   #$50                         ;[x]
  6B54  8D 9D 36              STA   $369D                        ;[x]
  6B57  4C 26 6D              JMP   L0C_6D26                     ;[x]

L0C_6B5A:
  6B5A  A9 3C                 LDA   #$3C                         ;[x]
  6B5C  8D 9C 36              STA   $369C                        ;[x]
L0C_6B5F:
  6B5F  CE 9C 36              DEC   $369C                        ;[x]
  6B62  4C 26 6D              JMP   L0C_6D26                     ;[x]

  6B65  AD A3 36              LDA   $36A3                        ;[x]
  6B68  D0 38                 BNE   L0C_6BA2                     ;[x]
  6B6A  A9 10                 LDA   #$10                         ;[x]
  6B6C  8D A3 36              STA   $36A3                        ;[x]
  6B6F  AD 36 36              LDA   $3636                        ;[x]
  6B72  C9 15                 CMP   #$15                         ;[x]
  6B74  F0 32                 BEQ   L0C_6BA8                     ;[x]
  6B76  C9 14                 CMP   #$14                         ;[x]
  6B78  D0 1B                 BNE   L0C_6B95                     ;[x]
  6B7A  A2 42                 LDX   #$42                         ;[x]
L0C_6B7C:
  6B7C  20 B5 6B              JSR   L0C_6BB5                     ;[x]
  6B7F  E8                    INX                                ;[x]
  6B80  E0 4C                 CPX   #$4C                         ;[x]
  6B82  D0 F8                 BNE   L0C_6B7C                     ;[x]
  6B84  AD BA 3D              LDA   $3DBA                        ;[x]
  6B87  38                    SEC                                ;[x]
  6B88  E9 11                 SBC   #$11                         ;[x]
  6B8A  8D BA 3D              STA   $3DBA                        ;[x]
  6B8D  AD BC 3D              LDA   $3DBC                        ;[x]
  6B90  E9 00                 SBC   #$00                         ;[x]
  6B92  8D BC 3D              STA   $3DBC                        ;[x]
L0C_6B95:
  6B95  AD 36 36              LDA   $3636                        ;[x]
  6B98  A8                    TAY                                ;[x]
  6B99  B9 C6 6B              LDA   $6BC6,Y                      ;[x]
  6B9C  8D B7 2A              STA   $2AB7                        ;[x]
  6B9F  EE 36 36              INC   $3636                        ;[x]
L0C_6BA2:
  6BA2  CE A3 36              DEC   $36A3                        ;[x]
  6BA5  4C 26 6D              JMP   L0C_6D26                     ;[x]

L0C_6BA8:
  6BA8  9C 9B 36              STZ   $369B                        ;[x]
  6BAB  9C 9C 36              STZ   $369C                        ;[x]
  6BAE  9C A3 36              STZ   $36A3                        ;[x]
  6BB1  9C 36 36              STZ   $3636                        ;[x]
  6BB4  60                    RTS                                ;[x]

L0C_6BB5:
  6BB5  18                    CLC                                ;[x]
  6BB6  A9 11                 LDA   #$11                         ;[x]
  6BB8  7D 8E 2C              ADC   $2C8E,X                      ;[x]
  6BBB  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6BBE  62                    CLA                                ;[x]
  6BBF  7D 21 2C              ADC   $2C21,X                      ;[x]
  6BC2  9D 21 2C              STA   $2C21,X                      ;[x]
  6BC5  60                    RTS                                ;[x]

  6BC6  .db $02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11
  6BD6  .db $12,$13,$14,$15,$01
L0C_6BDB:
  6BDB  AD A3 36              LDA   $36A3                        ;[x]
  6BDE  D0 38                 BNE   L0C_6C18                     ;[x]
  6BE0  A9 02                 LDA   #$02                         ;[x]
  6BE2  8D A3 36              STA   $36A3                        ;[x]
  6BE5  AD 36 36              LDA   $3636                        ;[x]
  6BE8  C9 15                 CMP   #$15                         ;[x]
  6BEA  F0 32                 BEQ   L0C_6C1E                     ;[x]
  6BEC  C9 00                 CMP   #$00                         ;[x]
  6BEE  D0 1B                 BNE   L0C_6C0B                     ;[x]
  6BF0  A2 42                 LDX   #$42                         ;[x]
L0C_6BF2:
  6BF2  20 2B 6C              JSR   L0C_6C2B                     ;[x]
  6BF5  E8                    INX                                ;[x]
  6BF6  E0 4C                 CPX   #$4C                         ;[x]
  6BF8  D0 F8                 BNE   L0C_6BF2                     ;[x]
  6BFA  AD BA 3D              LDA   $3DBA                        ;[x]
  6BFD  18                    CLC                                ;[x]
  6BFE  69 11                 ADC   #$11                         ;[x]
  6C00  8D BA 3D              STA   $3DBA                        ;[x]
  6C03  AD BC 3D              LDA   $3DBC                        ;[x]
  6C06  69 00                 ADC   #$00                         ;[x]
  6C08  8D BC 3D              STA   $3DBC                        ;[x]
L0C_6C0B:
  6C0B  AD 36 36              LDA   $3636                        ;[x]
  6C0E  A8                    TAY                                ;[x]
  6C0F  B9 3D 6C              LDA   $6C3D,Y                      ;[x]
  6C12  8D B7 2A              STA   $2AB7                        ;[x]
  6C15  EE 36 36              INC   $3636                        ;[x]
L0C_6C18:
  6C18  CE A3 36              DEC   $36A3                        ;[x]
  6C1B  4C 26 6D              JMP   L0C_6D26                     ;[x]

L0C_6C1E:
  6C1E  9C 9B 36              STZ   $369B                        ;[x]
  6C21  9C 9C 36              STZ   $369C                        ;[x]
  6C24  9C A3 36              STZ   $36A3                        ;[x]
  6C27  9C 36 36              STZ   $3636                        ;[x]
  6C2A  60                    RTS                                ;[x]

L0C_6C2B:
  6C2B  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  6C2E  38                    SEC                                ;[x]
  6C2F  E9 11                 SBC   #$11                         ;[x]
  6C31  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6C34  BD 21 2C              LDA   $2C21,X                      ;[x]
  6C37  E9 00                 SBC   #$00                         ;[x]
  6C39  9D 21 2C              STA   $2C21,X                      ;[x]
  6C3C  60                    RTS                                ;[x]

  6C3D  .db $15,$14,$13,$12,$11,$10,$0F,$0E,$0D,$0C,$0B,$0A,$09,$08,$07,$06
  6C4D  .db $05,$04,$03,$02,$01
L0C_6C52:
  6C52  AD 9C 36              LDA   $369C                        ;[x]
  6C55  C9 20                 CMP   #$20                         ;[x]
  6C57  D0 07                 BNE   L0C_6C60                     ;[x]
  6C59  9C 9B 36              STZ   $369B                        ;[x]
  6C5C  9C 9C 36              STZ   $369C                        ;[x]
  6C5F  60                    RTS                                ;[x]

L0C_6C60:
  6C60  EE 9C 36              INC   $369C                        ;[x]
  6C63  4C 26 6D              JMP   L0C_6D26                     ;[x]

  6C66  AD 38 30              LDA   $3038                        ;[x]
  6C69  3A                    DEC   A                            ;[x]
  6C6A  F0 62                 BEQ   L0C_6CCE                     ;[x]
  6C6C  3A                    DEC   A                            ;[x]
  6C6D  D0 03                 BNE   L0C_6C72                     ;[x]
  6C6F  4C E6 6C              JMP   L0C_6CE6                     ;[x]

L0C_6C72:
  6C72  A9 15                 LDA   #$15                         ;[x]
  6C74  A2 04                 LDX   #$04                         ;[x]
  6C76  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6C79  20 4A 49              JSR   L0B_494A                     ;[x]
  6C7C  A2 43                 LDX   #$43                         ;[x]
L0C_6C7E:
  6C7E  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  6C81  E8                    INX                                ;[x]
  6C82  E0 54                 CPX   #$54                         ;[x]
  6C84  D0 F8                 BNE   L0C_6C7E                     ;[x]
  6C86  9C 2E 3A              STZ   $3A2E                        ;[x]
  6C89  9C 2F 3A              STZ   $3A2F                        ;[x]
  6C8C  C2                    CLY                                ;[x]
  6C8D  A2 43                 LDX   #$43                         ;[x]
L0C_6C8F:
  6C8F  B9 03 6D              LDA   $6D03,Y                      ;[x]
  6C92  9D 47 2B              STA   $2B47,X                      ;[x]
  6C95  C8                    INY                                ;[x]
  6C96  B9 03 6D              LDA   $6D03,Y                      ;[x]
  6C99  18                    CLC                                ;[x]
  6C9A  6D D0 2C              ADC   $2CD0                        ;[x]
  6C9D  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6CA0  EE 2E 36              INC   $362E                        ;[x]
  6CA3  C8                    INY                                ;[x]
  6CA4  FE 1C 2F              INC   $2F1C,X                      ;[x]
  6CA7  A9 03                 LDA   #$03                         ;[x]
  6CA9  9D 00 2A              STA   $2A00,X                      ;[x]
  6CAC  A9 10                 LDA   #$10                         ;[x]
  6CAE  9D 6D 2A              STA   $2A6D,X                      ;[x]
  6CB1  A9 08                 LDA   #$08                         ;[x]
  6CB3  9D 7F 35              STA   $357F,X                      ;[x]
  6CB6  9D 33 37              STA   $3733,X                      ;[x]
  6CB9  E8                    INX                                ;[x]
  6CBA  E0 47                 CPX   #$47                         ;[x]
  6CBC  D0 D1                 BNE   L0C_6C8F                     ;[x]
  6CBE  9C 83 26              STZ   $2683                        ;[x]
  6CC1  9C 84 26              STZ   $2684                        ;[x]
  6CC4  A9 36                 LDA   #$36                         ;[x]
  6CC6  A2 04                 LDX   #$04                         ;[x]
  6CC8  20 65 F0              JSR   L00_F065                     ;[x]
  6CCB  EE 38 30              INC   $3038                        ;[x]
L0C_6CCE:
  6CCE  A9 47                 LDA   #$47                         ;[x]
  6CD0  85 02                 STA   <$02                         ;[x]
  6CD2  A9 42                 LDA   #$42                         ;[x]
  6CD4  85 03                 STA   <$03                         ;[x]
  6CD6  20 70 48              JSR   L0B_4870                     ;[x]
  6CD9  09 00                 ORA   #$00                         ;[x]
  6CDB  D0 03                 BNE   L0C_6CE0                     ;[x]
  6CDD  44 11                 BSR   L0C_6CF0                     ;[x]
  6CDF  60                    RTS                                ;[x]

L0C_6CE0:
  6CE0  EE 38 30              INC   $3038                        ;[x]
  6CE3  9C 08 37              STZ   $3708                        ;[x]
L0C_6CE6:
  6CE6  CE 08 37              DEC   $3708                        ;[x]
  6CE9  D0 02                 BNE   L0C_6CED                     ;[x]
  6CEB  E6 80                 INC   <$80                         ;[x]
L0C_6CED:
  6CED  44 01                 BSR   L0C_6CF0                     ;[x]
  6CEF  60                    RTS                                ;[x]

L0C_6CF0:
  6CF0  A2 43                 LDX   #$43                         ;[x]
L0C_6CF2:
  6CF2  20 07 49              JSR   L0B_4907                     ;[x]
  6CF5  E8                    INX                                ;[x]
  6CF6  E0 47                 CPX   #$47                         ;[x]
  6CF8  D0 F8                 BNE   L0C_6CF2                     ;[x]
L0C_6CFA:
  6CFA  20 2A 49              JSR   L0B_492A                     ;[x]
  6CFD  E8                    INX                                ;[x]
  6CFE  E0 4B                 CPX   #$4B                         ;[x]
  6D00  D0 F8                 BNE   L0C_6CFA                     ;[x]
  6D02  60                    RTS                                ;[x]

  6D03  .db $30,$10,$48,$00,$A8,$00,$C0,$10
L0C_6D0B:
  6D0B  AD EC 31              LDA   $31EC                        ;[x]
  6D0E  18                    CLC                                ;[x]
  6D0F  7D FB 2C              ADC   $2CFB,X                      ;[x]
  6D12  9D FB 2C              STA   $2CFB,X                      ;[x]
  6D15  AD 7F 31              LDA   $317F                        ;[x]
  6D18  7D 8E 2C              ADC   $2C8E,X                      ;[x]
  6D1B  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6D1E  62                    CLA                                ;[x]
  6D1F  7D 21 2C              ADC   $2C21,X                      ;[x]
  6D22  9D 21 2C              STA   $2C21,X                      ;[x]
  6D25  60                    RTS                                ;[x]

L0C_6D26:
  6D26  A2 42                 LDX   #$42                         ;[x]
L0C_6D28:
  6D28  20 0B 6D              JSR   L0C_6D0B                     ;[x]
  6D2B  E8                    INX                                ;[x]
  6D2C  E0 4C                 CPX   #$4C                         ;[x]
  6D2E  D0 F8                 BNE   L0C_6D28                     ;[x]
  6D30  AD CB 2F              LDA   $2FCB                        ;[x]
  6D33  C9 02                 CMP   #$02                         ;[x]
  6D35  B0 03                 BCS   L0C_6D3A                     ;[x]
  6D37  4C 06 6F              JMP   L0C_6F06                     ;[x]

L0C_6D3A:
  6D3A  AD E2 37              LDA   $37E2                        ;[x]
  6D3D  38                    SEC                                ;[x]
  6D3E  ED EC 31              SBC   $31EC                        ;[x]
  6D41  8D E2 37              STA   $37E2                        ;[x]
  6D44  AD BA 3D              LDA   $3DBA                        ;[x]
  6D47  ED 7F 31              SBC   $317F                        ;[x]
  6D4A  8D BA 3D              STA   $3DBA                        ;[x]
  6D4D  AD BC 3D              LDA   $3DBC                        ;[x]
  6D50  E9 00                 SBC   #$00                         ;[x]
  6D52  8D BC 3D              STA   $3DBC                        ;[x]
  6D55  AD A4 36              LDA   $36A4                        ;[x]
  6D58  F0 03                 BEQ   L0C_6D5D                     ;[x]
  6D5A  4C DA 6D              JMP   L0C_6DDA                     ;[x]

L0C_6D5D:
  6D5D  EE D4 2F              INC   $2FD4                        ;[x]
  6D60  AD D4 2F              LDA   $2FD4                        ;[x]
  6D63  29 03                 AND   #$03                         ;[x]
  6D65  8D D4 2F              STA   $2FD4                        ;[x]
  6D68  C9 03                 CMP   #$03                         ;[x]
  6D6A  D0 0B                 BNE   L0C_6D77                     ;[x]
  6D6C  9C DC 2F              STZ   $2FDC                        ;[x]
  6D6F  9C 3F 36              STZ   $363F                        ;[x]
  6D72  A9 01                 LDA   #$01                         ;[x]
  6D74  8D 6F 2F              STA   $2F6F                        ;[x]
L0C_6D77:
  6D77  A8                    TAY                                ;[x]
  6D78  B9 12 6F              LDA   $6F12,Y                      ;[x]
  6D7B  8D A4 36              STA   $36A4                        ;[x]
  6D7E  9C 83 34              STZ   $3483                        ;[x]
  6D81  9C 37 36              STZ   $3637                        ;[x]
  6D84  98                    TYA                                ;[x]
  6D85  0A                    ASL   A                            ;[x]
  6D86  0A                    ASL   A                            ;[x]
  6D87  0A                    ASL   A                            ;[x]
  6D88  0A                    ASL   A                            ;[x]
  6D89  A8                    TAY                                ;[x]
  6D8A  9C 00 00              STZ   VDC_AR                       ;[x]
  6D8D  A9 CE                 LDA   #$CE                         ;[x]
  6D8F  8D 02 00              STA   VDC_DATA_L                   ;[x]
  6D92  A9 01                 LDA   #$01                         ;[x]
  6D94  8D 03 00              STA   VDC_DATA_H                   ;[x]
  6D97  A9 02                 LDA   #$02                         ;[x]
  6D99  8D 00 00              STA   VDC_AR                       ;[x]
  6D9C  A9 04                 LDA   #$04                         ;[x]
  6D9E  85 00                 STA   <$00                         ;[x]
L0C_6DA0:
  6DA0  B9 18 6F              LDA   $6F18,Y                      ;[x]
  6DA3  8D 02 00              STA   VDC_DATA_L                   ;[x]
  6DA6  C8                    INY                                ;[x]
  6DA7  B9 18 6F              LDA   $6F18,Y                      ;[x]
  6DAA  8D 03 00              STA   VDC_DATA_H                   ;[x]
  6DAD  C8                    INY                                ;[x]
  6DAE  C6 00                 DEC   <$00                         ;[x]
  6DB0  D0 EE                 BNE   L0C_6DA0                     ;[x]
  6DB2  9C 00 00              STZ   VDC_AR                       ;[x]
  6DB5  A9 0E                 LDA   #$0E                         ;[x]
  6DB7  8D 02 00              STA   VDC_DATA_L                   ;[x]
  6DBA  A9 02                 LDA   #$02                         ;[x]
  6DBC  8D 03 00              STA   VDC_DATA_H                   ;[x]
  6DBF  A9 02                 LDA   #$02                         ;[x]
  6DC1  8D 00 00              STA   VDC_AR                       ;[x]
  6DC4  A9 04                 LDA   #$04                         ;[x]
  6DC6  85 00                 STA   <$00                         ;[x]
L0C_6DC8:
  6DC8  B9 18 6F              LDA   $6F18,Y                      ;[x]
  6DCB  8D 02 00              STA   VDC_DATA_L                   ;[x]
  6DCE  C8                    INY                                ;[x]
  6DCF  B9 18 6F              LDA   $6F18,Y                      ;[x]
  6DD2  8D 03 00              STA   VDC_DATA_H                   ;[x]
  6DD5  C8                    INY                                ;[x]
  6DD6  C6 00                 DEC   <$00                         ;[x]
  6DD8  D0 EE                 BNE   L0C_6DC8                     ;[x]
L0C_6DDA:
  6DDA  CE A4 36              DEC   $36A4                        ;[x]
  6DDD  AD D4 2F              LDA   $2FD4                        ;[x]
  6DE0  C9 02                 CMP   #$02                         ;[x]
  6DE2  D0 51                 BNE   L0C_6E35                     ;[x]
  6DE4  EE 83 34              INC   $3483                        ;[x]
  6DE7  A5 8F                 LDA   <$8F                         ;[x]
  6DE9  89 F0                 BIT   #$F0                         ;[x]
  6DEB  F0 02                 BEQ   L0C_6DEF                     ;[x]
  6DED  A9 10                 LDA   #$10                         ;[ ]
L0C_6DEF:
  6DEF  85 00                 STA   <$00                         ;[x]
  6DF1  A5 9E                 LDA   <$9E                         ;[x]
  6DF3  D0 06                 BNE   L0C_6DFB                     ;[x]
  6DF5  A5 B1                 LDA   <$B1                         ;[x]
  6DF7  C9 03                 CMP   #$03                         ;[x]
  6DF9  D0 1F                 BNE   L0C_6E1A                     ;[x]
L0C_6DFB:
  6DFB  A9 60                 LDA   #$60                         ;[ ]
  6DFD  CD 83 34              CMP   $3483                        ;[ ]
  6E00  B0 16                 BCS   L0C_6E18                     ;[ ]
  6E02  9C 83 34              STZ   $3483                        ;[ ]
  6E05  A5 8F                 LDA   <$8F                         ;[ ]
  6E07  69 18                 ADC   #$18                         ;[ ]
  6E09  85 0D                 STA   <$0D                         ;[ ]
  6E0B  A9 02                 LDA   #$02                         ;[ ]
  6E0D  85 0C                 STA   <$0C                         ;[ ]
  6E0F  A9 01                 LDA   #$01                         ;[ ]
  6E11  85 0E                 STA   <$0E                         ;[ ]
  6E13  A2 43                 LDX   #$43                         ;[ ]
  6E15  20 70 49              JSR   L0B_4970                     ;[ ]
L0C_6E18:
  6E18  80 1B                 BRA   L0C_6E35                     ;[ ]

L0C_6E1A:
  6E1A  AD CD 2F              LDA   $2FCD                        ;[x]
  6E1D  18                    CLC                                ;[x]
  6E1E  6D CE 2F              ADC   $2FCE                        ;[x]
  6E21  A8                    TAY                                ;[x]
  6E22  B9 15 6F              LDA   $6F15,Y                      ;[x]
  6E25  38                    SEC                                ;[x]
  6E26  E5 00                 SBC   <$00                         ;[x]
  6E28  CD 83 34              CMP   $3483                        ;[x]
  6E2B  B0 08                 BCS   L0C_6E35                     ;[x]
  6E2D  9C 83 34              STZ   $3483                        ;[x]
  6E30  A2 43                 LDX   #$43                         ;[x]
  6E32  20 4C 44              JSR   L0B_444C                     ;[x]
L0C_6E35:
  6E35  AD CB 2F              LDA   $2FCB                        ;[x]
  6E38  C9 03                 CMP   #$03                         ;[x]
  6E3A  B0 03                 BCS   L0C_6E3F                     ;[x]
  6E3C  4C 06 6F              JMP   L0C_6F06                     ;[x]

L0C_6E3F:
  6E3F  A2 43                 LDX   #$43                         ;[x]
L0C_6E41:
  6E41  BD F1 32              LDA   $32F1,X                      ;[x]
  6E44  29 40                 AND   #$40                         ;[x]
  6E46  F0 7F                 BEQ   L0C_6EC7                     ;[x]
  6E48  BD A5 34              LDA   $34A5,X                      ;[x]
  6E4B  10 3B                 BPL   L0C_6E88                     ;[x]
  6E4D  E0 43                 CPX   #$43                         ;[x]
  6E4F  D0 25                 BNE   L0C_6E76                     ;[x]
  6E51  A9 06                 LDA   #$06                         ;[x]
  6E53  8D CB 2F              STA   $2FCB                        ;[x]
  6E56  DA                    PHX                                ;[x]
  6E57  AD 86 2E              LDA   $2E86                        ;[x]
  6E5A  A2 06                 LDX   #$06                         ;[x]
  6E5C  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6E5F  AD 87 2E              LDA   $2E87                        ;[x]
  6E62  A2 07                 LDX   #$07                         ;[x]
  6E64  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6E67  BD AF 2E              LDA   $2EAF,X                      ;[x]
  6E6A  8D 91 3F              STA   $3F91                        ;[x]
  6E6D  A9 08                 LDA   #$08                         ;[x]
  6E6F  20 EE E7              JSR   L00_E7EE                     ;[x]
  6E72  FA                    PLX                                ;[x]
  6E73  60                    RTS                                ;[x]

  6E74  .db $80,$51
L0C_6E76:
  6E76  A9 35                 LDA   #$35                         ;[x]
  6E78  20 FC E3              JSR   L00_E3FC                     ;[x]
  6E7B  FE 89 2F              INC   $2F89,X                      ;[x]
  6E7E  A9 0A                 LDA   #$0A                         ;[x]
  6E80  9D F1 32              STA   $32F1,X                      ;[x]
  6E83  9D 7A 38              STA   $387A,X                      ;[x]
  6E86  80 5D                 BRA   L0C_6EE5                     ;[x]

L0C_6E88:
  6E88  E0 43                 CPX   #$43                         ;[x]
  6E8A  D0 2C                 BNE   L0C_6EB8                     ;[x]
  6E8C  BD A5 34              LDA   $34A5,X                      ;[x]
  6E8F  C9 07                 CMP   #$07                         ;[x]
  6E91  B0 0E                 BCS   L0C_6EA1                     ;[x]
  6E93  A9 09                 LDA   #$09                         ;[x]
  6E95  8D 86 2E              STA   $2E86                        ;[x]
  6E98  A9 0C                 LDA   #$0C                         ;[x]
  6E9A  8D 87 2E              STA   $2E87                        ;[x]
  6E9D  A9 11                 LDA   #$11                         ;[x]
  6E9F  80 10                 BRA   L0C_6EB1                     ;[x]

L0C_6EA1:
  6EA1  C9 0C                 CMP   #$0C                         ;[x]
  6EA3  B0 13                 BCS   L0C_6EB8                     ;[x]
  6EA5  A9 08                 LDA   #$08                         ;[x]
  6EA7  8D 86 2E              STA   $2E86                        ;[x]
  6EAA  A9 0B                 LDA   #$0B                         ;[x]
  6EAC  8D 87 2E              STA   $2E87                        ;[x]
  6EAF  A9 10                 LDA   #$10                         ;[x]
L0C_6EB1:
  6EB1  DA                    PHX                                ;[x]
  6EB2  A2 04                 LDX   #$04                         ;[x]
  6EB4  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6EB7  FA                    PLX                                ;[x]
L0C_6EB8:
  6EB8  A9 1F                 LDA   #$1F                         ;[x]
  6EBA  20 FC E3              JSR   L00_E3FC                     ;[x]
  6EBD  A9 08                 LDA   #$08                         ;[x]
  6EBF  9D 33 37              STA   $3733,X                      ;[x]
  6EC2  A9 0A                 LDA   #$0A                         ;[x]
  6EC4  9D F1 32              STA   $32F1,X                      ;[x]
L0C_6EC7:
  6EC7  BD 7A 38              LDA   $387A,X                      ;[x]
  6ECA  D0 19                 BNE   L0C_6EE5                     ;[x]
  6ECC  BD 33 37              LDA   $3733,X                      ;[x]
  6ECF  F0 0F                 BEQ   L0C_6EE0                     ;[x]
  6ED1  DE 33 37              DEC   $3733,X                      ;[x]
  6ED4  A5 32                 LDA   <$32                         ;[x]
  6ED6  29 01                 AND   #$01                         ;[x]
  6ED8  D0 0B                 BNE   L0C_6EE5                     ;[x]
  6EDA  8A                    TXA                                ;[x]
  6EDB  38                    SEC                                ;[x]
  6EDC  E9 31                 SBC   #$31                         ;[x]
  6EDE  80 08                 BRA   L0C_6EE8                     ;[x]

L0C_6EE0:
  6EE0  A9 09                 LDA   #$09                         ;[x]
  6EE2  9D F1 32              STA   $32F1,X                      ;[x]
L0C_6EE5:
  6EE5  BD 42 2E              LDA   $2E42,X                      ;[x]
L0C_6EE8:
  6EE8  85 00                 STA   <$00                         ;[x]
  6EEA  DA                    PHX                                ;[x]
  6EEB  8A                    TXA                                ;[x]
  6EEC  38                    SEC                                ;[x]
  6EED  E9 3E                 SBC   #$3E                         ;[x]
  6EEF  AA                    TAX                                ;[x]
  6EF0  A5 00                 LDA   <$00                         ;[x]
  6EF2  20 D5 E8              JSR   L00_E8D5                     ;[x]
  6EF5  FA                    PLX                                ;[x]
  6EF6  E8                    INX                                ;[x]
  6EF7  E0 46                 CPX   #$46                         ;[x]
  6EF9  B0 03                 BCS   L0C_6EFE                     ;[x]
  6EFB  4C 41 6E              JMP   L0C_6E41                     ;[x]

L0C_6EFE:
  6EFE  A2 44                 LDX   #$44                         ;[x]
  6F00  44 46                 BSR   L0C_6F48                     ;[x]
  6F02  A2 45                 LDX   #$45                         ;[x]
  6F04  44 42                 BSR   L0C_6F48                     ;[x]
L0C_6F06:
  6F06  AD 6F 2F              LDA   $2F6F                        ;[x]
  6F09  F0 03                 BEQ   L0C_6F0E                     ;[x]
  6F0B  4C BA 70              JMP   L0C_70BA                     ;[x]

L0C_6F0E:
  6F0E  EE EB 37              INC   $37EB                        ;[x]
  6F11  60                    RTS                                ;[x]

  6F12  .db $A0,$30,$A0,$A4,$30,$18,$F6,$E2,$F7,$E2,$46,$E3,$45,$E3,$10,$E1
  6F22  .db $10,$E1,$10,$E1,$10,$E1,$F8,$E2,$F9,$E2,$48,$E3,$47,$E3,$FA,$E2
  6F32  .db $FB,$E2,$4A,$E3,$49,$E3,$FC,$E2,$FD,$E2,$4C,$E3,$4B,$E3,$FE,$E2
  6F42  .db $10,$E1,$10,$E1,$4D,$E3
L0C_6F48:
  6F48  BD 89 2F              LDA   $2F89,X                      ;[x]
  6F4B  D0 25                 BNE   L0C_6F72                     ;[x]
  6F4D  BD 59 36              LDA   $3659,X                      ;[x]
  6F50  D0 1C                 BNE   L0C_6F6E                     ;[x]
  6F52  A9 A0                 LDA   #$A0                         ;[x]
  6F54  38                    SEC                                ;[x]
  6F55  E5 8F                 SBC   <$8F                         ;[x]
  6F57  9D 59 36              STA   $3659,X                      ;[x]
  6F5A  8A                    TXA                                ;[x]
  6F5B  29 01                 AND   #$01                         ;[x]
  6F5D  49 01                 EOR   #$01                         ;[x]
  6F5F  0A                    ASL   A                            ;[x]
  6F60  0A                    ASL   A                            ;[x]
  6F61  18                    CLC                                ;[x]
  6F62  69 06                 ADC   #$06                         ;[x]
  6F64  85 0C                 STA   <$0C                         ;[x]
  6F66  BD 89 2F              LDA   $2F89,X                      ;[x]
  6F69  D0 03                 BNE   L0C_6F6E                     ;[x]
  6F6B  20 4B 70              JSR   L0C_704B                     ;[x]
L0C_6F6E:
  6F6E  DE 59 36              DEC   $3659,X                      ;[x]
  6F71  60                    RTS                                ;[x]

L0C_6F72:
  6F72  BD F6 2F              LDA   $2FF6,X                      ;[x]
  6F75  3A                    DEC   A                            ;[x]
  6F76  F0 24                 BEQ   L0C_6F9C                     ;[x]
  6F78  3A                    DEC   A                            ;[x]
  6F79  D0 03                 BNE   L0C_6F7E                     ;[x]
  6F7B  4C 4A 70              JMP   L0C_704A                     ;[x]

L0C_6F7E:
  6F7E  A9 0A                 LDA   #$0A                         ;[x]
  6F80  9D F1 32              STA   $32F1,X                      ;[x]
  6F83  DA                    PHX                                ;[x]
  6F84  8A                    TXA                                ;[x]
  6F85  18                    CLC                                ;[x]
  6F86  69 0D                 ADC   #$0D                         ;[x]
  6F88  AA                    TAX                                ;[x]
  6F89  A9 03                 LDA   #$03                         ;[x]
  6F8B  9D 00 2A              STA   $2A00,X                      ;[x]
  6F8E  A9 03                 LDA   #$03                         ;[x]
  6F90  9D 6D 2A              STA   $2A6D,X                      ;[x]
  6F93  A9 04                 LDA   #$04                         ;[x]
  6F95  9D 59 36              STA   $3659,X                      ;[x]
  6F98  FA                    PLX                                ;[x]
  6F99  FE F6 2F              INC   $2FF6,X                      ;[x]
L0C_6F9C:
  6F9C  BD DA 2A              LDA   $2ADA,X                      ;[x]
  6F9F  85 00                 STA   <$00                         ;[x]
  6FA1  BD 47 2B              LDA   $2B47,X                      ;[x]
  6FA4  85 01                 STA   <$01                         ;[x]
  6FA6  BD 21 2C              LDA   $2C21,X                      ;[x]
  6FA9  85 02                 STA   <$02                         ;[x]
  6FAB  BD 8E 2C              LDA   $2C8E,X                      ;[x]
  6FAE  85 03                 STA   <$03                         ;[x]
  6FB0  DA                    PHX                                ;[x]
  6FB1  8A                    TXA                                ;[x]
  6FB2  18                    CLC                                ;[x]
  6FB3  69 0D                 ADC   #$0D                         ;[x]
  6FB5  AA                    TAX                                ;[x]
  6FB6  A5 00                 LDA   <$00                         ;[x]
  6FB8  9D DA 2A              STA   $2ADA,X                      ;[x]
  6FBB  A5 01                 LDA   <$01                         ;[x]
  6FBD  9D 47 2B              STA   $2B47,X                      ;[x]
  6FC0  A5 02                 LDA   <$02                         ;[x]
  6FC2  9D 21 2C              STA   $2C21,X                      ;[x]
  6FC5  A5 03                 LDA   <$03                         ;[x]
  6FC7  9D 8E 2C              STA   $2C8E,X                      ;[x]
  6FCA  BD 59 36              LDA   $3659,X                      ;[x]
  6FCD  D0 77                 BNE   L0C_7046                     ;[x]
  6FCF  A9 04                 LDA   #$04                         ;[x]
  6FD1  9D 59 36              STA   $3659,X                      ;[x]
  6FD4  FE 6D 2A              INC   $2A6D,X                      ;[x]
  6FD7  BD 6D 2A              LDA   $2A6D,X                      ;[x]
  6FDA  C9 05                 CMP   #$05                         ;[x]
  6FDC  D0 57                 BNE   L0C_7035                     ;[x]
  6FDE  8A                    TXA                                ;[x]
  6FDF  C9 52                 CMP   #$52                         ;[x]
  6FE1  F0 0B                 BEQ   L0C_6FEE                     ;[x]
  6FE3  A9 94                 LDA   #$94                         ;[x]
  6FE5  85 00                 STA   <$00                         ;[x]
  6FE7  A9 01                 LDA   #$01                         ;[x]
  6FE9  85 01                 STA   <$01                         ;[x]
  6FEB  C2                    CLY                                ;[x]
  6FEC  80 0A                 BRA   L0C_6FF8                     ;[x]

L0C_6FEE:
  6FEE  A9 88                 LDA   #$88                         ;[x]
  6FF0  85 00                 STA   <$00                         ;[x]
  6FF2  A9 01                 LDA   #$01                         ;[x]
  6FF4  85 01                 STA   <$01                         ;[x]
  6FF6  A0 28                 LDY   #$28                         ;[x]
L0C_6FF8:
  6FF8  A9 05                 LDA   #$05                         ;[x]
  6FFA  85 02                 STA   <$02                         ;[x]
L0C_6FFC:
  6FFC  9C 00 00              STZ   VDC_AR                       ;[x]
  6FFF  A5 00                 LDA   <$00                         ;[x]
  7001  8D 02 00              STA   VDC_DATA_L                   ;[x]
  7004  A5 01                 LDA   <$01                         ;[x]
  7006  8D 03 00              STA   VDC_DATA_H                   ;[x]
  7009  A9 04                 LDA   #$04                         ;[x]
  700B  85 03                 STA   <$03                         ;[x]
  700D  A9 02                 LDA   #$02                         ;[x]
  700F  8D 00 00              STA   VDC_AR                       ;[x]
L0C_7012:
  7012  B9 6A 70              LDA   $706A,Y                      ;[x]
  7015  8D 02 00              STA   VDC_DATA_L                   ;[x]
  7018  C8                    INY                                ;[x]
  7019  B9 6A 70              LDA   $706A,Y                      ;[x]
  701C  8D 03 00              STA   VDC_DATA_H                   ;[x]
  701F  C8                    INY                                ;[x]
  7020  C6 03                 DEC   <$03                         ;[x]
  7022  D0 EE                 BNE   L0C_7012                     ;[x]
  7024  A5 00                 LDA   <$00                         ;[x]
  7026  18                    CLC                                ;[x]
  7027  69 40                 ADC   #$40                         ;[x]
  7029  85 00                 STA   <$00                         ;[x]
  702B  A5 01                 LDA   <$01                         ;[x]
  702D  69 00                 ADC   #$00                         ;[x]
  702F  85 01                 STA   <$01                         ;[x]
  7031  C6 02                 DEC   <$02                         ;[x]
  7033  D0 C7                 BNE   L0C_6FFC                     ;[x]
L0C_7035:
  7035  C9 07                 CMP   #$07                         ;[x]
  7037  D0 0D                 BNE   L0C_7046                     ;[x]
  7039  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  703C  FA                    PLX                                ;[x]
  703D  FE F6 2F              INC   $2FF6,X                      ;[x]
  7040  A9 01                 LDA   #$01                         ;[x]
  7042  9D 7A 38              STA   $387A,X                      ;[x]
  7045  60                    RTS                                ;[x]

L0C_7046:
  7046  DE 59 36              DEC   $3659,X                      ;[x]
  7049  FA                    PLX                                ;[x]
L0C_704A:
  704A  60                    RTS                                ;[x]

L0C_704B:
  704B  C6 0C                 DEC   <$0C                         ;[x]
  704D  C6 0C                 DEC   <$0C                         ;[x]
  704F  A9 03                 LDA   #$03                         ;[x]
  7051  9D C6 36              STA   $36C6,X                      ;[x]
L0C_7054:
  7054  A5 8F                 LDA   <$8F                         ;[x]
  7056  69 18                 ADC   #$18                         ;[x]
  7058  85 0D                 STA   <$0D                         ;[x]
  705A  20 5C 44              JSR   L0B_445C                     ;[x]
  705D  E6 0C                 INC   <$0C                         ;[x]
  705F  E6 0C                 INC   <$0C                         ;[x]
  7061  DE C6 36              DEC   $36C6,X                      ;[x]
  7064  BD C6 36              LDA   $36C6,X                      ;[x]
  7067  D0 EB                 BNE   L0C_7054                     ;[x]
  7069  60                    RTS                                ;[x]

  706A  .db $50,$D3,$5E,$D3,$10,$D1,$10,$D1,$62,$D3,$61,$D3,$60,$D3,$5F,$D3
  707A  .db $10,$D1,$65,$D3,$64,$D3,$63,$D3,$69,$D3,$68,$D3,$67,$D3,$66,$D3
  708A  .db $10,$D1,$6B,$D3,$6A,$D3,$10,$D1,$10,$C1,$10,$C1,$0F,$C3,$01,$C3
  709A  .db $10,$C3,$11,$C3,$12,$C3,$13,$C3,$14,$C3,$15,$C3,$16,$C3,$10,$C1
  70AA  .db $17,$C3,$18,$C3,$19,$C3,$1A,$C3,$10,$C1,$1B,$C3,$1C,$C3,$10,$C1
L0C_70BA:
  70BA  A2 53                 LDX   #$53                         ;[x]
  70BC  BD 89 2F              LDA   $2F89,X                      ;[x]
  70BF  3A                    DEC   A                            ;[x]
  70C0  F0 57                 BEQ   L0C_7119                     ;[x]
  70C2  3A                    DEC   A                            ;[x]
  70C3  D0 03                 BNE   L0C_70C8                     ;[x]
  70C5  4C 56 71              JMP   L0C_7156                     ;[x]

L0C_70C8:
  70C8  AD 3E 2D              LDA   $2D3E                        ;[x]
  70CB  9D FB 2C              STA   $2CFB,X                      ;[x]
  70CE  AD D1 2C              LDA   $2CD1                        ;[x]
  70D1  9D 8E 2C              STA   $2C8E,X                      ;[x]
  70D4  AD 64 2C              LDA   $2C64                        ;[x]
  70D7  9D 21 2C              STA   $2C21,X                      ;[x]
  70DA  AD F7 2B              LDA   $2BF7                        ;[x]
  70DD  9D B4 2B              STA   $2BB4,X                      ;[x]
  70E0  AD 8A 2B              LDA   $2B8A                        ;[x]
  70E3  9D 47 2B              STA   $2B47,X                      ;[x]
  70E6  AD 1D 2B              LDA   $2B1D                        ;[x]
  70E9  9D DA 2A              STA   $2ADA,X                      ;[x]
  70EC  A5 32                 LDA   <$32                         ;[x]
  70EE  29 01                 AND   #$01                         ;[x]
  70F0  A8                    TAY                                ;[x]
  70F1  20 1C 40              JSR   L0B_401C                     ;[x]
  70F4  A5 00                 LDA   <$00                         ;[x]
  70F6  A0 0F                 LDY   #$0F                         ;[x]
  70F8  20 11 41              JSR   L0B_4111                     ;[x]
  70FB  A9 F0                 LDA   #$F0                         ;[x]
  70FD  9D A0 37              STA   $37A0,X                      ;[x]
  7100  9E 0D 38              STZ   $380D,X                      ;[x]
  7103  A9 02                 LDA   #$02                         ;[x]
  7105  9D 00 2A              STA   $2A00,X                      ;[x]
  7108  A9 07                 LDA   #$07                         ;[x]
  710A  9D F1 32              STA   $32F1,X                      ;[x]
  710D  A9 08                 LDA   #$08                         ;[x]
  710F  9D 5E 33              STA   $335E,X                      ;[x]
  7112  9D CB 33              STA   $33CB,X                      ;[x]
  7115  FE 89 2F              INC   $2F89,X                      ;[x]
  7118  60                    RTS                                ;[x]

L0C_7119:
  7119  BD F1 32              LDA   $32F1,X                      ;[x]
  711C  29 40                 AND   #$40                         ;[x]
  711E  F0 12                 BEQ   L0C_7132                     ;[x]
  7120  9E F1 32              STZ   $32F1,X                      ;[x]
  7123  BD AF 2E              LDA   $2EAF,X                      ;[x]
  7126  1A                    INC   A                            ;[x]
  7127  9D 7F 35              STA   $357F,X                      ;[x]
  712A  A9 F0                 LDA   #$F0                         ;[x]
  712C  9D A0 37              STA   $37A0,X                      ;[x]
  712F  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_7132:
  7132  BD A0 37              LDA   $37A0,X                      ;[x]
  7135  F0 1B                 BEQ   L0C_7152                     ;[x]
  7137  C9 04                 CMP   #$04                         ;[x]
  7139  90 0D                 BCC   L0C_7148                     ;[x]
  713B  29 07                 AND   #$07                         ;[x]
  713D  D0 02                 BNE   L0C_7141                     ;[x]
  713F  44 50                 BSR   L0C_7191                     ;[x]
L0C_7141:
  7141  DE A0 37              DEC   $37A0,X                      ;[x]
  7144  20 C5 4C              JSR   L0B_4CC5                     ;[x]
  7147  60                    RTS                                ;[x]

L0C_7148:
  7148  A0 06                 LDY   #$06                         ;[x]
  714A  B9 AB 71              LDA   $71AB,Y                      ;[x]
  714D  9D 6D 2A              STA   $2A6D,X                      ;[x]
  7150  80 EF                 BRA   L0C_7141                     ;[x]

L0C_7152:
  7152  20 2B 4D              JSR   L0B_4D2B                     ;[x]
  7155  60                    RTS                                ;[x]

L0C_7156:
  7156  BD A0 37              LDA   $37A0,X                      ;[x]
  7159  F0 F7                 BEQ   L0C_7152                     ;[x]
  715B  C9 04                 CMP   #$04                         ;[x]
  715D  90 E9                 BCC   L0C_7148                     ;[x]
  715F  BD 7F 35              LDA   $357F,X                      ;[x]
  7162  25 86                 AND   <$86                         ;[x]
  7164  D0 07                 BNE   L0C_716D                     ;[x]
  7166  A9 04                 LDA   #$04                         ;[ ]
  7168  9D A0 37              STA   $37A0,X                      ;[ ]
  716B  80 DB                 BRA   L0C_7148                     ;[ ]

L0C_716D:
  716D  BD A0 37              LDA   $37A0,X                      ;[x]
  7170  29 07                 AND   #$07                         ;[x]
  7172  D0 02                 BNE   L0C_7176                     ;[x]
  7174  44 1B                 BSR   L0C_7191                     ;[x]
L0C_7176:
  7176  BD 7F 35              LDA   $357F,X                      ;[x]
  7179  3A                    DEC   A                            ;[x]
  717A  A8                    TAY                                ;[x]
  717B  B9 47 2B              LDA   $2B47,Y                      ;[x]
  717E  9D 47 2B              STA   $2B47,X                      ;[x]
  7181  B9 8E 2C              LDA   $2C8E,Y                      ;[x]
  7184  9D 8E 2C              STA   $2C8E,X                      ;[x]
  7187  9E DA 2A              STZ   $2ADA,X                      ;[x]
  718A  9E 21 2C              STZ   $2C21,X                      ;[x]
  718D  DE A0 37              DEC   $37A0,X                      ;[x]
  7190  60                    RTS                                ;[x]

L0C_7191:
  7191  BD EC 35              LDA   $35EC,X                      ;[x]
  7194  A8                    TAY                                ;[x]
  7195  B9 AB 71              LDA   $71AB,Y                      ;[x]
  7198  9D 6D 2A              STA   $2A6D,X                      ;[x]
  719B  FE EC 35              INC   $35EC,X                      ;[x]
  719E  BD EC 35              LDA   $35EC,X                      ;[x]
  71A1  C9 06                 CMP   #$06                         ;[x]
  71A3  D0 05                 BNE   L0C_71AA                     ;[x]
  71A5  A9 03                 LDA   #$03                         ;[x]
  71A7  9D EC 35              STA   $35EC,X                      ;[x]
L0C_71AA:
  71AA  60                    RTS                                ;[x]

  71AB  .db $16,$17,$18,$19,$1A,$1B,$1C,$01,$0E,$C1,$80,$03,$02,$01,$FE,$04
  71BB  .db $07,$88,$20,$06,$10,$C1,$88,$08,$05,$C1,$8A,$0E,$07,$C1,$80,$0F
  71CB  .db $03,$01,$FE,$10,$07,$88,$20,$20,$07,$C1,$80,$24,$0F,$C1,$80,$2C
  71DB  .db $05,$14,$00,$48,$07,$88,$20,$58,$07,$88,$20,$60,$1B,$14,$00,$68
  71EB  .db $17,$8A,$20,$72,$12,$14,$01,$78,$07,$8A,$20,$7B,$00,$01,$FE,$7C
  71FB  .db $04,$14,$00,$87,$00,$01,$FE,$88,$0F,$8A,$20,$92,$15,$14,$00,$96
  720B  .db $07,$C1,$84,$97,$00,$01,$FE,$98,$0D,$17,$00,$98,$03,$14,$00,$9E
  721B  .db $10,$C1,$8C,$9F,$00,$01,$FE,$A0,$14,$17,$00,$A8,$0F,$8D,$20,$B3
  722B  .db $0D,$14,$00,$B8,$07,$8D,$20,$C8,$17,$8D,$20,$D4,$0F,$8D,$20,$D7
  723B  .db $03,$14,$00,$D8,$00,$03,$FE,$D9,$0C,$14,$01,$DB,$0B,$14,$01,$DB
  724B  .db $05,$14,$00,$DB,$0E,$14,$00,$DC,$05,$17,$00,$DC,$02,$14,$00,$CF
  725B  .db $01,$01,$FE,$E0,$03,$88,$20,$00,$25,$8B,$00,$0C,$3B,$8B,$00,$14
  726B  .db $25,$14,$00,$1C,$2F,$8C,$00,$24,$37,$8C,$00,$26,$37,$18,$00,$2A
  727B  .db $27,$18,$00,$2C,$27,$88,$20,$3B,$20,$01,$FE,$3C,$27,$8C,$00,$40
  728B  .db $23,$88,$20,$4A,$37,$C1,$84,$4B,$20,$01,$FE,$4C,$2D,$88,$20,$4F
  729B  .db $20,$02,$FE,$50,$35,$18,$00,$54,$2F,$18,$00,$55,$30,$C1,$8C,$55
  72AB  .db $3C,$14,$00,$5F,$20,$01,$FE,$60,$2D,$89,$20,$70,$2D,$89,$20,$80
  72BB  .db $32,$89,$20,$80,$3D,$14,$00,$90,$20,$01,$FE,$90,$39,$14,$01,$90
  72CB  .db $33,$14,$00,$90,$2F,$17,$00,$93,$21,$01,$FE,$94,$2A,$89,$20,$98
  72DB  .db $37,$17,$00,$A0,$27,$17,$00,$A8,$2F,$8A,$20,$AF,$20,$02,$FE,$B0
  72EB  .db $27,$8A,$20,$B8,$37,$8A,$20,$C4,$21,$88,$20,$D0,$25,$88,$20,$DC
  72FB  .db $27,$88,$20,$E8,$2B,$14,$00,$E8,$24,$14,$00,$E8,$2F,$17,$01,$E8
  730B  .db $3C,$17,$03,$F0,$27,$C1,$80,$F8,$37,$C1,$8A,$F8,$35,$8D,$20,$08
  731B  .db $49,$8D,$20,$18,$55,$8D,$20,$1A,$4F,$C1,$80,$1A,$57,$C1,$88,$1C
  732B  .db $42,$01,$FE,$1C,$57,$8A,$20,$1E,$4B,$C1,$80,$20,$47,$17,$00,$20
  733B  .db $45,$C1,$80,$22,$47,$C1,$80,$22,$50,$C1,$88,$30,$40,$19,$08,$31
  734B  .db $40,$19,$0F,$32,$5E,$19,$1B,$33,$5E,$19,$15,$34,$40,$19,$0A,$35
  735B  .db $40,$19,$0F,$36,$5F,$19,$16,$37,$5E,$19,$1C,$38,$40,$19,$0D,$39
  736B  .db $40,$19,$0F,$3A,$5D,$19,$17,$3B,$5D,$19,$15,$3C,$41,$19,$0D,$3D
  737B  .db $40,$19,$0A,$3E,$5E,$19,$1F,$3F,$5D,$19,$1A,$48,$40,$19,$07,$50
  738B  .db $5E,$19,$17,$58,$55,$8A,$20,$60,$4B,$8A,$20,$68,$50,$89,$20,$78
  739B  .db $54,$89,$20,$88,$48,$89,$20,$8C,$55,$14,$00,$8D,$5C,$14,$00,$94
  73AB  .db $48,$18,$00,$94,$51,$18,$00,$9C,$47,$C1,$80,$9C,$50,$C1,$8A,$A0
  73BB  .db $43,$88,$20,$C2,$59,$14,$10,$C6,$40,$8E,$00,$CF,$41,$01,$FE,$D0
  73CB  .db $57,$14,$00,$D8,$40,$8E,$00,$DF,$43,$01,$FE,$E0,$47,$88,$00,$E8
  73DB  .db $45,$C1,$82,$E8,$58,$C1,$80,$E9,$40,$01,$FE,$EA,$40,$8E,$00,$EC
  73EB  .db $4F,$C1,$82,$EE,$4B,$C1,$88,$F0,$4F,$C1,$88,$F4,$58,$C1,$8A,$F5
  73FB  .db $42,$01,$FE,$F6,$40,$8E,$00,$08,$6D,$88,$20,$0A,$75,$88,$20,$18
  740B  .db $6F,$C1,$84,$1E,$62,$14,$00,$1F,$60,$02,$FE,$20,$75,$88,$20,$30
  741B  .db $6D,$88,$20,$34,$65,$C1,$8C,$38,$75,$C1,$84,$40,$72,$C1,$8C,$47
  742B  .db $40,$01,$FE,$48,$67,$88,$20,$50,$6F,$C1,$80,$57,$60,$02,$FE,$58
  743B  .db $7B,$17,$01,$58,$65,$17,$03,$70,$6F,$12,$00,$74,$6A,$12,$00,$74
  744B  .db $74,$12,$00,$76,$6F,$12,$00,$78,$63,$12,$00,$78,$7B,$12,$00,$7C
  745B  .db $6F,$12,$00,$7E,$68,$12,$00,$82,$6A,$12,$00,$82,$74,$12,$00,$84
  746B  .db $63,$12,$00,$86,$68,$12,$00,$86,$77,$12,$00,$88,$6C,$12,$00,$88
  747B  .db $72,$12,$00,$8A,$63,$12,$00,$8A,$7B,$12,$00,$8B,$6F,$12,$00,$8B
  748B  .db $7E,$12,$00,$8B,$63,$01,$FF,$8C,$60,$10,$00,$8D,$68,$12,$00,$90
  749B  .db $60,$00,$83,$90,$60,$02,$83,$90,$63,$02,$FF,$90,$60,$10,$01,$94
  74AB  .db $60,$10,$00,$A0,$60,$01,$83,$A0,$60,$03,$83,$A4,$6F,$13,$00,$A8
  74BB  .db $6A,$13,$00,$A8,$74,$13,$00,$AA,$6F,$13,$00,$AC,$63,$13,$00,$AC
  74CB  .db $7B,$13,$00,$B0,$6F,$13,$00,$B2,$68,$13,$00,$B6,$6A,$13,$00,$B6
  74DB  .db $74,$13,$00,$B8,$63,$13,$00,$BA,$68,$13,$00,$BA,$77,$13,$00,$BC
  74EB  .db $6C,$13,$00,$BC,$72,$13,$00,$BE,$63,$13,$00,$BE,$7B,$13,$00,$BF
  74FB  .db $6F,$13,$00,$BF,$7E,$13,$00,$C0,$60,$45,$80,$C1,$68,$13,$00,$C1
  750B  .db $60,$64,$97,$C8,$60,$83,$80,$CC,$60,$00,$FD,$D8,$60,$80,$80,$E0
  751B  .db $60,$02,$40,$FF,$FF
L0C_7520:
  7520  BD 89 2F              LDA   $2F89,X                      ;[x]
  7523  3A                    DEC   A                            ;[x]
  7524  F0 1C                 BEQ   L0C_7542                     ;[x]
  7526  3A                    DEC   A                            ;[x]
  7527  F0 3E                 BEQ   L0C_7567                     ;[x]
  7529  3A                    DEC   A                            ;[x]
  752A  D0 03                 BNE   L0C_752F                     ;[x]
  752C  4C F0 75              JMP   L0C_75F0                     ;[ ]

L0C_752F:
  752F  A9 20                 LDA   #$20                         ;[x]
  7531  9D 8E 2C              STA   $2C8E,X                      ;[x]
  7534  9E 21 2C              STZ   $2C21,X                      ;[x]
  7537  A9 1F                 LDA   #$1F                         ;[x]
  7539  9D C6 36              STA   $36C6,X                      ;[x]
  753C  9E 59 36              STZ   $3659,X                      ;[x]
  753F  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_7542:
  7542  20 7F 42              JSR   L0B_427F                     ;[x]
  7545  BD C6 36              LDA   $36C6,X                      ;[x]
  7548  F0 07                 BEQ   L0C_7551                     ;[x]
  754A  29 10                 AND   #$10                         ;[x]
  754C  D0 15                 BNE   L0C_7563                     ;[x]
  754E  4C ED 75              JMP   L0C_75ED                     ;[x]

L0C_7551:
  7551  A9 08                 LDA   #$08                         ;[x]
  7553  A0 14                 LDY   #$14                         ;[x]
  7555  20 11 41              JSR   L0B_4111                     ;[x]
  7558  A9 19                 LDA   #$19                         ;[x]
  755A  9D C6 36              STA   $36C6,X                      ;[x]
  755D  FE 89 2F              INC   $2F89,X                      ;[x]
  7560  FE F1 32              INC   $32F1,X                      ;[x]
L0C_7563:
  7563  DE C6 36              DEC   $36C6,X                      ;[x]
  7566  60                    RTS                                ;[x]

L0C_7567:
  7567  20 7F 42              JSR   L0B_427F                     ;[x]
  756A  BD C6 36              LDA   $36C6,X                      ;[x]
  756D  F0 03                 BEQ   L0C_7572                     ;[x]
  756F  4C ED 75              JMP   L0C_75ED                     ;[x]

L0C_7572:
  7572  FE 0D 38              INC   $380D,X                      ;[x]
  7575  20 AB E8              JSR   L00_E8AB                     ;[x]
  7578  AD 8F 3F              LDA   $3F8F                        ;[x]
  757B  29 07                 AND   #$07                         ;[x]
  757D  18                    CLC                                ;[x]
  757E  69 10                 ADC   #$10                         ;[x]
  7580  9D C6 36              STA   $36C6,X                      ;[x]
  7583  20 AB E8              JSR   L00_E8AB                     ;[x]
  7586  AD 90 3F              LDA   $3F90                        ;[x]
  7589  29 01                 AND   #$01                         ;[x]
  758B  D0 1B                 BNE   L0C_75A8                     ;[x]
  758D  AD 90 3F              LDA   $3F90                        ;[x]
  7590  0A                    ASL   A                            ;[x]
  7591  62                    CLA                                ;[x]
  7592  2A                    ROL   A                            ;[x]
  7593  A8                    TAY                                ;[x]
  7594  1A                    INC   A                            ;[x]
  7595  25 86                 AND   <$86                         ;[x]
  7597  F0 0F                 BEQ   L0C_75A8                     ;[x]
  7599  20 1C 40              JSR   L0B_401C                     ;[x]
  759C  A5 00                 LDA   <$00                         ;[x]
  759E  38                    SEC                                ;[x]
  759F  E9 02                 SBC   #$02                         ;[x]
  75A1  29 18                 AND   #$18                         ;[x]
  75A3  9D A0 37              STA   $37A0,X                      ;[x]
  75A6  80 0A                 BRA   L0C_75B2                     ;[x]

L0C_75A8:
  75A8  AD 8F 3F              LDA   $3F8F                        ;[x]
  75AB  29 07                 AND   #$07                         ;[x]
  75AD  0A                    ASL   A                            ;[x]
  75AE  0A                    ASL   A                            ;[x]
  75AF  9D A0 37              STA   $37A0,X                      ;[x]
L0C_75B2:
  75B2  C9 08                 CMP   #$08                         ;[x]
  75B4  D0 04                 BNE   L0C_75BA                     ;[x]
  75B6  A9 01                 LDA   #$01                         ;[x]
  75B8  80 1A                 BRA   L0C_75D4                     ;[x]

L0C_75BA:
  75BA  C9 18                 CMP   #$18                         ;[x]
  75BC  D0 04                 BNE   L0C_75C2                     ;[x]
  75BE  A9 05                 LDA   #$05                         ;[x]
  75C0  80 12                 BRA   L0C_75D4                     ;[x]

L0C_75C2:
  75C2  A9 03                 LDA   #$03                         ;[x]
  75C4  BD A0 37              LDA   $37A0,X                      ;[x]
  75C7  18                    CLC                                ;[x]
  75C8  69 08                 ADC   #$08                         ;[x]
  75CA  29 10                 AND   #$10                         ;[x]
  75CC  D0 04                 BNE   L0C_75D2                     ;[x]
  75CE  A9 07                 LDA   #$07                         ;[x]
  75D0  80 02                 BRA   L0C_75D4                     ;[x]

L0C_75D2:
  75D2  A9 03                 LDA   #$03                         ;[x]
L0C_75D4:
  75D4  9D EC 35              STA   $35EC,X                      ;[x]
  75D7  A5 8F                 LDA   <$8F                         ;[x]
  75D9  4A                    LSR   A                            ;[x]
  75DA  69 14                 ADC   #$14                         ;[x]
  75DC  A8                    TAY                                ;[x]
  75DD  BD A0 37              LDA   $37A0,X                      ;[x]
  75E0  20 11 41              JSR   L0B_4111                     ;[x]
  75E3  BD 0D 38              LDA   $380D,X                      ;[x]
  75E6  C9 20                 CMP   #$20                         ;[x]
  75E8  D0 03                 BNE   L0C_75ED                     ;[x]
  75EA  FE 89 2F              INC   $2F89,X                      ;[ ]
L0C_75ED:
  75ED  DE C6 36              DEC   $36C6,X                      ;[x]
L0C_75F0:
  75F0  BD 59 36              LDA   $3659,X                      ;[x]
  75F3  D0 14                 BNE   L0C_7609                     ;[x]
  75F5  A9 04                 LDA   #$04                         ;[x]
  75F7  9D 59 36              STA   $3659,X                      ;[x]
  75FA  FE 7A 38              INC   $387A,X                      ;[x]
  75FD  BD 7A 38              LDA   $387A,X                      ;[x]
  7600  29 01                 AND   #$01                         ;[x]
  7602  18                    CLC                                ;[x]
  7603  7D EC 35              ADC   $35EC,X                      ;[x]
  7606  20 7F 41              JSR   L0B_417F                     ;[x]
L0C_7609:
  7609  DE 59 36              DEC   $3659,X                      ;[x]
  760C  60                    RTS                                ;[x]

  760D  BD 89 2F              LDA   $2F89,X                      ;[x]
  7610  D0 1C                 BNE   L0C_762E                     ;[x]
  7612  A9 C0                 LDA   #$C0                         ;[x]
  7614  9D AA 31              STA   $31AA,X                      ;[x]
  7617  A9 00                 LDA   #$00                         ;[x]
  7619  9D 3D 31              STA   $313D,X                      ;[x]
  761C  A9 80                 LDA   #$80                         ;[x]
  761E  9D D0 30              STA   $30D0,X                      ;[x]
  7621  A9 04                 LDA   #$04                         ;[x]
  7623  9D 63 30              STA   $3063,X                      ;[x]
  7626  A9 30                 LDA   #$30                         ;[x]
  7628  9D 17 32              STA   $3217,X                      ;[x]
  762B  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_762E:
  762E  A9 0C                 LDA   #$0C                         ;[x]
  7630  20 15 69              JSR   L0C_6915                     ;[x]
  7633  20 4C 41              JSR   L0B_414C                     ;[x]
  7636  BD D0 30              LDA   $30D0,X                      ;[x]
  7639  85 00                 STA   <$00                         ;[x]
  763B  BD 63 30              LDA   $3063,X                      ;[x]
  763E  85 01                 STA   <$01                         ;[x]
  7640  10 11                 BPL   L0C_7653                     ;[x]
  7642  A5 00                 LDA   <$00                         ;[x]
  7644  49 FF                 EOR   #$FF                         ;[x]
  7646  18                    CLC                                ;[x]
  7647  69 01                 ADC   #$01                         ;[x]
  7649  85 00                 STA   <$00                         ;[x]
  764B  A5 01                 LDA   <$01                         ;[x]
  764D  49 FF                 EOR   #$FF                         ;[x]
  764F  69 00                 ADC   #$00                         ;[x]
  7651  85 01                 STA   <$01                         ;[x]
L0C_7653:
  7653  A5 01                 LDA   <$01                         ;[x]
  7655  C9 04                 CMP   #$04                         ;[x]
  7657  90 11                 BCC   L0C_766A                     ;[x]
  7659  D0 06                 BNE   L0C_7661                     ;[x]
  765B  A5 00                 LDA   <$00                         ;[x]
  765D  C9 80                 CMP   #$80                         ;[x]
  765F  90 09                 BCC   L0C_766A                     ;[x]
L0C_7661:
  7661  BD 17 32              LDA   $3217,X                      ;[x]
  7664  49 FF                 EOR   #$FF                         ;[x]
  7666  1A                    INC   A                            ;[x]
  7667  9D 17 32              STA   $3217,X                      ;[x]
L0C_766A:
  766A  60                    RTS                                ;[x]

  766B  BD 89 2F              LDA   $2F89,X                      ;[x]
  766E  D0 24                 BNE   L0C_7694                     ;[x]
  7670  A9 80                 LDA   #$80                         ;[x]
  7672  9D AA 31              STA   $31AA,X                      ;[x]
  7675  A9 01                 LDA   #$01                         ;[x]
  7677  9D 3D 31              STA   $313D,X                      ;[x]
  767A  A9 00                 LDA   #$00                         ;[x]
  767C  9D D0 30              STA   $30D0,X                      ;[x]
  767F  A9 01                 LDA   #$01                         ;[x]
  7681  9D 63 30              STA   $3063,X                      ;[x]
  7684  A9 10                 LDA   #$10                         ;[x]
  7686  9D 17 32              STA   $3217,X                      ;[x]
  7689  9D A0 37              STA   $37A0,X                      ;[x]
  768C  A9 01                 LDA   #$01                         ;[x]
  768E  9D A5 34              STA   $34A5,X                      ;[x]
  7691  FE 89 2F              INC   $2F89,X                      ;[x]
L0C_7694:
  7694  20 19 69              JSR   L0C_6919                     ;[x]
  7697  20 4C 41              JSR   L0B_414C                     ;[x]
  769A  BD 17 32              LDA   $3217,X                      ;[x]
  769D  F0 2B                 BEQ   L0C_76CA                     ;[x]
  769F  BD D0 30              LDA   $30D0,X                      ;[x]
  76A2  85 00                 STA   <$00                         ;[x]
  76A4  BD 63 30              LDA   $3063,X                      ;[x]
  76A7  85 01                 STA   <$01                         ;[x]
  76A9  10 11                 BPL   L0C_76BC                     ;[x]
  76AB  A5 00                 LDA   <$00                         ;[x]
  76AD  49 FF                 EOR   #$FF                         ;[x]
  76AF  18                    CLC                                ;[x]
  76B0  69 01                 ADC   #$01                         ;[x]
  76B2  85 00                 STA   <$00                         ;[x]
  76B4  A5 01                 LDA   <$01                         ;[x]
  76B6  49 FF                 EOR   #$FF                         ;[x]
  76B8  69 00                 ADC   #$00                         ;[x]
  76BA  85 01                 STA   <$01                         ;[x]
L0C_76BC:
  76BC  A5 01                 LDA   <$01                         ;[x]
  76BE  C9 01                 CMP   #$01                         ;[x]
  76C0  90 59                 BCC   L0C_771B                     ;[x]
  76C2  D0 06                 BNE   L0C_76CA                     ;[x]
  76C4  A5 00                 LDA   <$00                         ;[x]
  76C6  C9 00                 CMP   #$00                         ;[x]
  76C8  90 51                 BCC   L0C_771B                     ;[x]
L0C_76CA:
  76CA  BD 38 34              LDA   $3438,X                      ;[x]
  76CD  29 01                 AND   #$01                         ;[x]
  76CF  F0 39                 BEQ   L0C_770A                     ;[x]
  76D1  DE C6 36              DEC   $36C6,X                      ;[x]
  76D4  F0 34                 BEQ   L0C_770A                     ;[x]
  76D6  9E 17 32              STZ   $3217,X                      ;[x]
  76D9  BD 21 2C              LDA   $2C21,X                      ;[x]
  76DC  D0 2C                 BNE   L0C_770A                     ;[x]
  76DE  BD 38 34              LDA   $3438,X                      ;[x]
  76E1  4A                    LSR   A                            ;[x]
  76E2  29 01                 AND   #$01                         ;[x]
  76E4  A8                    TAY                                ;[x]
  76E5  1A                    INC   A                            ;[x]
  76E6  25 86                 AND   <$86                         ;[x]
  76E8  D0 09                 BNE   L0C_76F3                     ;[x]
  76EA  98                    TYA                                ;[x]
  76EB  49 01                 EOR   #$01                         ;[x]
  76ED  A8                    TAY                                ;[x]
  76EE  1A                    INC   A                            ;[x]
  76EF  25 86                 AND   <$86                         ;[x]
  76F1  F0 17                 BEQ   L0C_770A                     ;[x]
L0C_76F3:
  76F3  BD 63 30              LDA   $3063,X                      ;[x]
  76F6  30 0A                 BMI   L0C_7702                     ;[x]
  76F8  BD 47 2B              LDA   $2B47,X                      ;[x]
  76FB  D9 47 2B              CMP   $2B47,Y                      ;[x]
  76FE  B0 0A                 BCS   L0C_770A                     ;[x]
  7700  80 19                 BRA   L0C_771B                     ;[x]

L0C_7702:
  7702  B9 47 2B              LDA   $2B47,Y                      ;[x]
  7705  DD 47 2B              CMP   $2B47,X                      ;[x]
  7708  90 11                 BCC   L0C_771B                     ;[x]
L0C_770A:
  770A  BD A0 37              LDA   $37A0,X                      ;[x]
  770D  49 FF                 EOR   #$FF                         ;[x]
  770F  1A                    INC   A                            ;[x]
  7710  9D 17 32              STA   $3217,X                      ;[x]
  7713  9D A0 37              STA   $37A0,X                      ;[x]
  7716  A9 30                 LDA   #$30                         ;[x]
  7718  9D C6 36              STA   $36C6,X                      ;[x]
L0C_771B:
  771B  60                    RTS                                ;[x]

  771C  BD 89 2F              LDA   $2F89,X                      ;[x]
  771F  D0 50                 BNE   L0C_7771                     ;[x]
  7721  A9 00                 LDA   #$00                         ;[x]
  7723  9D AA 31              STA   $31AA,X                      ;[x]
  7726  A9 01                 LDA   #$01                         ;[x]
  7728  9D 3D 31              STA   $313D,X                      ;[x]
  772B  BD 38 34              LDA   $3438,X                      ;[x]
  772E  0A                    ASL   A                            ;[x]
  772F  0A                    ASL   A                            ;[x]
  7730  A8                    TAY                                ;[x]
  7731  B9 5D 77              LDA   $775D,Y                      ;[x]
  7734  9D 63 30              STA   $3063,X                      ;[x]
  7737  C8                    INY                                ;[x]
  7738  B9 5D 77              LDA   $775D,Y                      ;[x]
  773B  9D D0 30              STA   $30D0,X                      ;[x]
  773E  C8                    INY                                ;[x]
  773F  B9 5D 77              LDA   $775D,Y                      ;[x]
  7742  18                    CLC                                ;[x]
  7743  7D 47 2B              ADC   $2B47,X                      ;[x]
  7746  9D 47 2B              STA   $2B47,X                      ;[x]
  7749  C8                    INY                                ;[x]
  774A  B9 5D 77              LDA   $775D,Y                      ;[x]
  774D  7D DA 2A              ADC   $2ADA,X                      ;[x]
  7750  9D DA 2A              STA   $2ADA,X                      ;[x]
  7753  A9 18                 LDA   #$18                         ;[x]
  7755  9D C6 36              STA   $36C6,X                      ;[x]
  7758  FE 89 2F              INC   $2F89,X                      ;[x]
  775B  80 14                 BRA   L0C_7771                     ;[x]

  775D  .db $00,$00,$00,$00,$00,$C0,$10,$00,$01,$80,$20,$00,$FF,$40,$F0,$FF
  776D  .db $FE,$80,$E0,$FF
L0C_7771:
  7771  20 19 69              JSR   L0C_6919                     ;[x]
  7774  20 4C 41              JSR   L0B_414C                     ;[x]
  7777  BD C6 36              LDA   $36C6,X                      ;[x]
  777A  D0 2A                 BNE   L0C_77A6                     ;[x]
  777C  A9 18                 LDA   #$18                         ;[x]
  777E  9D C6 36              STA   $36C6,X                      ;[x]
  7781  BD 63 30              LDA   $3063,X                      ;[x]
  7784  85 00                 STA   <$00                         ;[x]
  7786  BD D0 30              LDA   $30D0,X                      ;[x]
  7789  85 01                 STA   <$01                         ;[x]
  778B  A5 01                 LDA   <$01                         ;[x]
  778D  49 FF                 EOR   #$FF                         ;[x]
  778F  18                    CLC                                ;[x]
  7790  69 01                 ADC   #$01                         ;[x]
  7792  85 01                 STA   <$01                         ;[x]
  7794  A5 00                 LDA   <$00                         ;[x]
  7796  49 FF                 EOR   #$FF                         ;[x]
  7798  69 00                 ADC   #$00                         ;[x]
  779A  85 00                 STA   <$00                         ;[x]
  779C  A5 00                 LDA   <$00                         ;[x]
  779E  9D 63 30              STA   $3063,X                      ;[x]
  77A1  A5 01                 LDA   <$01                         ;[x]
  77A3  9D D0 30              STA   $30D0,X                      ;[x]
L0C_77A6:
  77A6  DE C6 36              DEC   $36C6,X                      ;[x]
  77A9  60                    RTS                                ;[x]

  77AA  .db $BD,$89,$2F,$F0,$0E,$A9,$01,$20,$15,$69,$BD,$89,$2F,$3A,$F0,$25
  77BA  .db $4C,$5D,$78,$A9,$00,$9D,$D0,$30,$A9,$02,$9D,$63,$30,$A9,$00,$9D
  77CA  .db $AA,$31,$A9,$01,$9D,$3D,$31,$A9,$E0,$9D,$84,$32,$A9,$1F,$9D,$C6
  77DA  .db $36,$FE,$89,$2F,$60,$20,$7F,$42,$BD,$AA,$31,$85,$00,$BD,$3D,$31
  77EA  .db $85,$01,$10,$11,$A5,$00,$49,$FF,$18,$69,$01,$85,$00,$A5,$01,$49
  77FA  .db $FF,$69,$00,$85,$01,$A5,$01,$C9,$01,$90,$11,$D0,$06,$A5,$00,$C9
  780A  .db $00,$90,$09,$BD,$84,$32,$49,$FF,$1A,$9D,$84,$32,$BD,$C6,$36,$F0
  781A  .db $0E,$29,$10,$D0,$38,$20,$AB,$E8,$AD,$8F,$3F,$29,$1F,$D0,$2E,$FE
  782A  .db $89,$2F,$BD,$3D,$31,$9D,$A0,$37,$BD,$AA,$31,$9D,$0D,$38,$BD,$84
  783A  .db $32,$9D,$7A,$38,$9E,$63,$30,$9E,$D0,$30,$9E,$3D,$31,$9E,$AA,$31
  784A  .db $9E,$84,$32,$A9,$40,$9D,$C6,$36,$A9,$04,$9D,$EC,$35,$DE,$C6,$36
  785A  .db $44,$62,$60,$20,$7F,$42,$BD,$C6,$36,$D0,$53,$BD,$47,$2B,$C9,$48
  786A  .db $90,$0E,$C9,$A8,$B0,$19,$20,$AB,$E8,$AD,$90,$3F,$29,$01,$D0,$0F
  787A  .db $A9,$00,$9D,$D0,$30,$A9,$02,$9D,$63,$30,$9E,$EC,$35,$80,$0F,$A9
  788A  .db $00,$9D,$D0,$30,$A9,$FF,$9D,$63,$30,$A9,$02,$9D,$EC,$35,$BD,$A0
  789A  .db $37,$9D,$3D,$31,$BD,$0D,$38,$9D,$AA,$31,$BD,$7A,$38,$9D,$84,$32
  78AA  .db $A9,$1F,$9D,$C6,$36,$BD,$EC,$35,$20,$7F,$41,$DE,$89,$2F,$DE,$C6
  78BA  .db $36,$44,$01,$60,$BD,$59,$36,$D0,$10,$A9,$08,$9D,$59,$36,$BD,$EC
  78CA  .db $35,$49,$01,$9D,$EC,$35,$20,$7F,$41,$DE,$59,$36,$60,$BD,$89,$2F
  78DA  .db $D0,$4C,$BD,$38,$34,$F0,$15,$29,$01,$49,$01,$0A,$0A,$0A,$9D,$A0
  78EA  .db $37,$18,$69,$0C,$29,$0F,$9D,$0D,$38,$20,$7D,$79,$BD,$38,$34,$0A
  78FA  .db $A8,$B9,$1E,$79,$18,$7D,$B4,$2B,$9D,$B4,$2B,$C8,$B9,$1E,$79,$7D
  790A  .db $47,$2B,$9D,$47,$2B,$A9,$06,$9D,$C6,$36,$A9,$D8,$9D,$7A,$38,$FE
  791A  .db $89,$2F,$80,$0A,$00,$00,$B8,$C3,$24,$1E,$DC,$E1,$48,$3C,$A9,$01
  792A  .db $20,$15,$69,$20,$05,$7A,$20,$4C,$41,$BD,$7A,$38,$F0,$0A,$DE,$7A
  793A  .db $38,$A9,$80,$9D,$9B,$3A,$80,$03,$9E,$9B,$3A,$BD,$38,$34,$F0,$2F
  794A  .db $BD,$C6,$36,$D0,$2A,$A9,$0C,$9D,$C6,$36,$FE,$A0,$37,$BD,$A0,$37
  795A  .db $29,$0F,$9D,$A0,$37,$FE,$0D,$38,$BD,$0D,$38,$29,$0F,$9D,$0D,$38
  796A  .db $A8,$B9,$F5,$79,$85,$00,$C8,$B9,$F5,$79,$85,$01,$20,$7D,$79,$DE
  797A  .db $C6,$36,$60,$BD,$0D,$38,$29,$07,$0A,$A8,$B9,$F5,$79,$85,$00,$C8
  798A  .db $B9,$F5,$79,$85,$01,$BD,$A0,$37,$29,$07,$0A,$A8,$B9,$F5,$79,$85
  799A  .db $02,$C8,$B9,$F5,$79,$85,$03,$BD,$38,$34,$29,$02,$F0,$08,$46,$00
  79AA  .db $66,$01,$46,$02,$66,$03,$BD,$0D,$38,$29,$08,$F0,$11,$A5,$01,$49
  79BA  .db $FF,$18,$69,$01,$85,$01,$A5,$00,$49,$FF,$69,$00,$85,$00,$BD,$A0
  79CA  .db $37,$29,$08,$F0,$11,$A5,$03,$49,$FF,$18,$69,$01,$85,$03,$A5,$02
  79DA  .db $49,$FF,$69,$00,$85,$02,$A5,$00,$9D,$3D,$31,$A5,$01,$9D,$AA,$31
  79EA  .db $A5,$02,$9D,$63,$30,$A5,$03,$9D,$D0,$30,$60,$00,$00,$00,$C3,$01
  79FA  .db $6A,$01,$D9,$02,$00,$01,$D9,$01,$6A,$00,$C3,$BD,$FB,$2C,$18,$69
  7A0A  .db $80,$9D,$FB,$2C,$BD,$8E,$2C,$69,$00,$9D,$8E,$2C,$BD,$21,$2C,$69
  7A1A  .db $00,$9D,$21,$2C,$60,$BD,$89,$2F,$3A,$F0,$64,$3A,$F0,$7F,$BD,$38
  7A2A  .db $34,$4A,$4A,$29,$03,$1A,$64,$00,$4A,$66,$00,$9D,$3D,$31,$A5,$00
  7A3A  .db $9D,$AA,$31,$BD,$38,$34,$29,$03,$9D,$63,$30,$A9,$40,$9D,$D0,$30
  7A4A  .db $BD,$38,$34,$29,$10,$F0,$25,$BD,$63,$30,$85,$00,$BD,$D0,$30,$85
  7A5A  .db $01,$A5,$01,$49,$FF,$18,$69,$01,$85,$01,$A5,$00,$49,$FF,$69,$00
  7A6A  .db $85,$00,$A5,$00,$9D,$63,$30,$A5,$01,$9D,$D0,$30,$9E,$21,$2C,$A9
  7A7A  .db $10,$9D,$8E,$2C,$9E,$FB,$2C,$A9,$20,$9D,$C6,$36,$FE,$89,$2F,$20
  7A8A  .db $4C,$41,$BD,$C6,$36,$D0,$12,$FE,$89,$2F,$9E,$63,$30,$9E,$D0,$30
  7A9A  .db $9E,$3D,$31,$9E,$AA,$31,$FE,$F1,$32,$DE,$C6,$36,$60,$20,$19,$69
  7AAA  .db $20,$7F,$42,$20,$4C,$41,$BD,$EC,$35,$C9,$01,$D0,$0A,$A9,$03,$20
  7ABA  .db $7F,$41,$A9,$04,$9D,$EC,$35,$60,$BD,$89,$2F,$D0,$0B,$9E,$21,$2C
  7ACA  .db $A9,$FF,$9D,$3D,$31,$FE,$89,$2F,$60,$BD,$89,$2F,$D0,$16,$BD,$38
  7ADA  .db $34,$29,$01,$A8,$20,$1C,$40,$A5,$8F,$69,$40,$A8,$A5,$00,$20,$11
  7AEA  .db $41,$FE,$89,$2F,$60,$20,$19,$69,$BD,$89,$2F,$3A,$F0,$39,$3A,$F0
  7AFA  .db $64,$20,$9B,$41,$09,$00,$30,$12,$A8,$B9,$8E,$2C,$38,$E9,$30,$9D
  7B0A  .db $8E,$2C,$62,$E9,$00,$9D,$21,$2C,$80,$06,$9E,$8E,$2C,$9E,$21,$2C
  7B1A  .db $BD,$38,$34,$29,$01,$3A,$9D,$DA,$2A,$A9,$F8,$9D,$47,$2B,$FE,$89
  7B2A  .db $2F,$A9,$20,$9D,$C6,$36,$60,$20,$7F,$42,$BD,$C6,$36,$D0,$22,$BD
  7B3A  .db $38,$34,$29,$01,$F0,$09,$A9,$01,$20,$7F,$41,$A9,$FF,$80,$02,$A9
  7B4A  .db $01,$9D,$63,$30,$A9,$FE,$9D,$3D,$31,$A9,$20,$9D,$84,$32,$FE,$89
  7B5A  .db $2F,$DE,$C6,$36,$60,$BD,$AA,$31,$D0,$1B,$BD,$3D,$31,$C9,$02,$D0
  7B6A  .db $14,$9E,$63,$30,$9E,$D0,$30,$9E,$3D,$31,$9E,$AA,$31,$9E,$84,$32
  7B7A  .db $DE,$89,$2F,$80,$AC,$60,$BD,$89,$2F,$3A,$F0,$7C,$3A,$D0,$03,$4C
  7B8A  .db $12,$7C,$3A,$D0,$03,$4C,$43,$7C,$3A,$D0,$03,$4C,$81,$7C,$3A,$D0
  7B9A  .db $03,$4C,$9A,$7C,$BD,$38,$34,$29,$01,$D0,$17,$A9,$FF,$9D,$DA,$2A
  7BAA  .db $A9,$F0,$9D,$47,$2B,$A9,$03,$9D,$EC,$35,$20,$7F,$41,$FE,$EC,$35
  7BBA  .db $80,$08,$A9,$01,$9D,$DA,$2A,$9E,$47,$2B,$BD,$38,$34,$29,$02,$D0
  7BCA  .db $0A,$9E,$21,$2C,$A9,$D0,$9D,$8E,$2C,$80,$05,$A9,$D0,$9D,$8E,$2C
  7BDA  .db $BD,$38,$34,$29,$03,$A8,$B9,$BB,$7C,$9D,$A0,$37,$A0,$20,$20,$11
  7BEA  .db $41,$A9,$30,$9D,$33,$37,$A9,$30,$9D,$C6,$36,$A9,$01,$9D,$A5,$34
  7BFA  .db $A9,$80,$9D,$9B,$3A,$FE,$89,$2F,$BD,$C6,$36,$D0,$07,$9E,$59,$36
  7C0A  .db $FE,$89,$2F,$60,$DE,$C6,$36,$60,$BD,$59,$36,$D0,$28,$A9,$03,$9D
  7C1A  .db $59,$36,$BD,$A0,$37,$1A,$29,$1F,$9D,$A0,$37,$A0,$20,$20,$11,$41
  7C2A  .db $FE,$C6,$36,$BD,$C6,$36,$C9,$20,$D0,$0B,$FE,$89,$2F,$9E,$9B,$3A
  7C3A  .db $A9,$33,$9D,$C6,$36,$DE,$59,$36,$60,$20,$19,$69,$BD,$38,$34,$29
  7C4A  .db $03,$A8,$B9,$BF,$7C,$DD,$8E,$2C,$D0,$06,$9E,$3D,$31,$9E,$AA,$31
  7C5A  .db $DE,$C6,$36,$D0,$21,$FE,$89,$2F,$9E,$63,$30,$9E,$D0,$30,$9E,$3D
  7C6A  .db $31,$9E,$AA,$31,$9E,$EC,$35,$9E,$59,$36,$BD,$38,$34,$29,$03,$A8
  7C7A  .db $B9,$C3,$7C,$9D,$C6,$36,$60,$20,$19,$69,$20,$7F,$42,$20,$A0,$7C
  7C8A  .db $DE,$C6,$36,$D0,$0A,$FE,$89,$2F,$A9,$18,$A0,$20,$20,$11,$41,$60
  7C9A  .db $20,$19,$69,$44,$01,$60,$BD,$59,$36,$D0,$12,$BD,$EC,$35,$1A,$29
  7CAA  .db $01,$9D,$EC,$35,$1A,$20,$7F,$41,$A9,$08,$9D,$59,$36,$DE,$59,$36
  7CBA  .db $60,$1C,$14,$04,$0C,$69,$59,$49,$38,$70,$60,$50,$40,$BD,$89,$2F
  7CCA  .db $D0,$28,$A9,$00,$9D,$AA,$31,$A9,$01,$9D,$3D,$31,$A9,$00,$9D,$D0
  7CDA  .db $30,$A9,$02,$9D,$63,$30,$A9,$10,$9D,$17,$32,$A9,$03,$9D,$A5,$34
  7CEA  .db $A5,$B1,$D0,$03,$DE,$A5,$34,$FE,$89,$2F,$20,$19,$69,$20,$4C,$41
  7CFA  .db $BD,$D0,$30,$85,$00,$BD,$63,$30,$85,$01,$10,$11,$A5,$00,$49,$FF
  7D0A  .db $18,$69,$01,$85,$00,$A5,$01,$49,$FF,$69,$00,$85,$01,$A5,$01,$C9
  7D1A  .db $02,$90,$11,$D0,$06,$A5,$00,$C9,$00,$90,$09,$BD,$17,$32,$49,$FF
  7D2A  .db $1A,$9D,$17,$32,$60
L0C_7D2F:
  7D2F  20 32 8B              JSR   $8B32                        ;[ ]
  7D32  AD D1 2F              LDA   $2FD1                        ;[ ]
  7D35  20 A2 E7              JSR   L00_E7A2                     ;[ ]
  7D38  52 7D                 EOR   (<$7D)                       ;[ ]
  7D3A  3A                    DEC   A                            ;[ ]
  7D3B  7E 05 81              ROR   $8105,X                      ;[ ]
  7D3E  D2 81                 CMP   (<$81)                       ;[ ]
  7D40  97 82                 SMB1  <$82                         ;[ ]
  7D42  79 83 F2              ADC   $F283,Y                      ;[ ]
  7D45  83 8E 84              TST   #$8E,<$84                    ;[ ]
  7D48  C0 84                 CPY   #$84                         ;[ ]
  7D4A  .db $7B,$85,$DF,$85,$86,$86,$F5,$87,$A2,$48,$9E,$3D,$31,$A9,$80,$9D
  7D5A  .db $AA,$31,$C2,$9E,$DA,$2A,$A9,$FF,$9D,$21,$2C,$9D,$FB,$2C,$9D,$B4
  7D6A  .db $2B,$B9,$C9,$7D,$9D,$47,$2B,$C8,$B9,$C9,$7D,$9D,$8E,$2C,$C8,$B9
  7D7A  .db $C9,$7D,$9D,$F1,$32,$C8,$B9,$C9,$7D,$9D,$5E,$33,$C8,$B9,$C9,$7D
  7D8A  .db $9D,$CB,$33,$C8,$E8,$E0,$5D,$D0,$CA,$A2,$04,$A9,$1D,$20,$D5,$E8
  7D9A  .db $A2,$4D,$C2,$B9,$32,$7E,$9D,$C6,$36,$A9,$01,$9D,$1C,$2F,$A9,$04
  7DAA  .db $9D,$A5,$34,$C8,$E8,$E0,$55,$D0,$EA,$A9,$08,$8D,$EC,$37,$EE,$D1
  7DBA  .db $2F,$9C,$3E,$30,$A9,$00,$8D,$80,$34,$A9,$03,$8D,$0E,$37,$60,$78
  7DCA  .db $78,$02,$50,$28,$78,$34,$02,$40,$0C,$78,$1A,$02,$20,$0E,$78,$00
  7DDA  .db $02,$08,$16,$78,$BC,$00,$3E,$1C,$48,$C9,$01,$08,$07,$60,$C9,$01
  7DEA  .db $08,$07,$90,$C9,$01,$08,$07,$A8,$C9,$01,$08,$07,$48,$B1,$01,$08
  7DFA  .db $07,$60,$B1,$01,$08,$07,$90,$B1,$01,$08,$07,$A8,$B1,$01,$08,$07
  7E0A  .db $48,$D0,$00,$00,$00,$60,$D0,$00,$00,$00,$90,$D0,$00,$00,$00,$A8
  7E1A  .db $D0,$00,$00,$00,$48,$B8,$00,$00,$00,$60,$B8,$00,$00,$00,$90,$B8
  7E2A  .db $00,$00,$00,$A8,$B8,$00,$00,$00,$10,$50,$30,$70,$50,$50,$50,$50
  7E3A  .db $AD,$3E,$30,$D0,$18,$64,$00,$20,$68,$7F,$A5,$00,$D0,$07,$AD,$34
  7E4A  .db $36,$C9,$02,$D0,$08,$EE,$3E,$30,$A9,$80,$8D,$A1,$36,$20,$7C,$89
  7E5A  .db $AD,$5A,$35,$D0,$24,$AD,$70,$3B,$D0,$5D,$AD,$71,$3B,$C9,$05,$B0
  7E6A  .db $56,$A9,$01,$8D,$7A,$3B,$8D,$5A,$35,$9C,$AB,$30,$A9,$40,$8D,$18
  7E7A  .db $31,$9C,$F2,$31,$9C,$85,$31,$80,$3B,$AD,$C7,$35,$C9,$03,$B0,$0A
  7E8A  .db $69,$09,$A2,$04,$20,$65,$F0,$EE,$C7,$35,$AD,$AB,$30,$10,$09,$AD
  7E9A  .db $8F,$2B,$C9,$50,$90,$09,$80,$1C,$AD,$8F,$2B,$C9,$A0,$90,$15,$AD
  7EAA  .db $18,$31,$49,$FF,$18,$69,$01,$8D,$18,$31,$AD,$AB,$30,$49,$FF,$69
  7EBA  .db $00,$8D,$AB,$30,$20,$E9,$8A,$A2,$48,$A9,$15,$20,$96,$8A,$20,$86
  7ECA  .db $7F,$20,$FB,$7F,$AD,$3E,$30,$C9,$01,$F0,$05,$C9,$02,$F0,$10,$60
  7EDA  .db $AD,$3E,$30,$AD,$A1,$36,$D0,$03,$EE,$3E,$30,$CE,$A1,$36,$60,$EE
  7EEA  .db $A1,$36,$C2,$A2,$58,$B9,$5C,$7F,$18,$6D,$A1,$36,$85,$00,$62,$69
  7EFA  .db $00,$85,$01,$AD,$FC,$2B,$9D,$B4,$2B,$AD,$8F,$2B,$18,$65,$00,$9D
  7F0A  .db $47,$2B,$AD,$22,$2B,$65,$01,$9D,$DA,$2A,$C8,$B9,$5C,$7F,$85,$00
  7F1A  .db $62,$69,$00,$85,$01,$A5,$00,$10,$02,$C6,$01,$AD,$43,$2D,$9D,$FB
  7F2A  .db $2C,$AD,$D6,$2C,$18,$65,$00,$9D,$8E,$2C,$AD,$69,$2C,$65,$01,$9D
  7F3A  .db $21,$2C,$C8,$A9,$05,$9D,$00,$2A,$A9,$06,$9D,$6D,$2A,$A9,$02,$9D
  7F4A  .db $1C,$2F,$E8,$E0,$5E,$D0,$9E,$AD,$A1,$36,$C9,$10,$D0,$03,$4C,$4C
  7F5A  .db $80,$60,$49,$28,$4C,$18,$4E,$08,$4E,$F8,$4D,$E8,$4A,$D8,$AD,$80
  7F6A  .db $34,$38,$E9,$01,$8D,$80,$34,$AD,$0E,$37,$E9,$00,$8D,$0E,$37,$AD
  7F7A  .db $0E,$37,$D0,$07,$AD,$80,$34,$D0,$02,$E6,$00,$60,$A2,$5D,$BD,$1C
  7F8A  .db $2F,$F0,$68,$BD,$89,$2F,$D0,$3E,$BD,$3F,$2B,$9D,$47,$2B,$BD,$D2
  7F9A  .db $2A,$9D,$DA,$2A,$BD,$86,$2C,$9D,$8E,$2C,$BD,$19,$2C,$9D,$21,$2C
  7FAA  .db $A9,$02,$9D,$3D,$31,$A9,$00,$9D,$AA,$31,$A9,$06,$9D,$F1,$32,$A9
  7FBA  .db $04,$9D,$5E,$33,$A9,$04,$9D,$CB,$33,$A9,$08,$9D,$59,$36,$A9,$01
  7FCA  .db $9D,$9B,$3A,$FE,$89,$2F,$BD,$59,$36,$D0,$0D,$A9,$08,$9D,$59,$36
  7FDA  .db $BD,$6D,$2A,$49,$01,$9D,$6D,$2A,$BD,$9B,$3A,$F0,$08,$BD,$21,$2C
  7FEA  .db $D0,$03,$9E,$9B,$3A,$20,$C5,$4C,$DE,$59,$36,$E8,$E0,$65,$D0,$8E
  7FFA  .db $60,$A2,$55,$BD,$1C,$2F
