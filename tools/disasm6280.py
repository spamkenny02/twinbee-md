#!/usr/bin/env python3
"""Désassembleur HuC6280 pour HuCard, guidé par la carte de code exécuté (pcedump codemap.txt)
puis complété par suivi de flux statique.
usage: disasm6280.py rom.pce outdir codemap1.txt [codemap2.txt ...]"""
import sys, os, re, collections

T = """
00 BRK imp|01 ORA izx|02 SXY imp|03 ST0 imm|04 TSB zp|05 ORA zp|06 ASL zp|07 RMB0 zp|08 PHP imp|09 ORA imm|0A ASL acc|0C TSB abs|0D ORA abs|0E ASL abs|0F BBR0 zprel
10 BPL rel|11 ORA izy|12 ORA izp|13 ST1 imm|14 TRB zp|15 ORA zpx|16 ASL zpx|17 RMB1 zp|18 CLC imp|19 ORA aby|1A INC acc|1C TRB abs|1D ORA abx|1E ASL abx|1F BBR1 zprel
20 JSR abs|21 AND izx|22 SAX imp|23 ST2 imm|24 BIT zp|25 AND zp|26 ROL zp|27 RMB2 zp|28 PLP imp|29 AND imm|2A ROL acc|2C BIT abs|2D AND abs|2E ROL abs|2F BBR2 zprel
30 BMI rel|31 AND izy|32 AND izp|34 BIT zpx|35 AND zpx|36 ROL zpx|37 RMB3 zp|38 SEC imp|39 AND aby|3A DEC acc|3C BIT abx|3D AND abx|3E ROL abx|3F BBR3 zprel
40 RTI imp|41 EOR izx|42 SAY imp|43 TMA imm|44 BSR rel|45 EOR zp|46 LSR zp|47 RMB4 zp|48 PHA imp|49 EOR imm|4A LSR acc|4C JMP abs|4D EOR abs|4E LSR abs|4F BBR4 zprel
50 BVC rel|51 EOR izy|52 EOR izp|53 TAM imm|54 CSL imp|55 EOR zpx|56 LSR zpx|57 RMB5 zp|58 CLI imp|59 EOR aby|5A PHY imp|5D EOR abx|5E LSR abx|5F BBR5 zprel
60 RTS imp|61 ADC izx|62 CLA imp|64 STZ zp|65 ADC zp|66 ROR zp|67 RMB6 zp|68 PLA imp|69 ADC imm|6A ROR acc|6C JMP ind|6D ADC abs|6E ROR abs|6F BBR6 zprel
70 BVS rel|71 ADC izy|72 ADC izp|73 TII blk|74 STZ zpx|75 ADC zpx|76 ROR zpx|77 RMB7 zp|78 SEI imp|79 ADC aby|7A PLY imp|7C JMP iax|7D ADC abx|7E ROR abx|7F BBR7 zprel
80 BRA rel|81 STA izx|82 CLX imp|83 TST immzp|84 STY zp|85 STA zp|86 STX zp|87 SMB0 zp|88 DEY imp|89 BIT imm|8A TXA imp|8C STY abs|8D STA abs|8E STX abs|8F BBS0 zprel
90 BCC rel|91 STA izy|92 STA izp|93 TST immabs|94 STY zpx|95 STA zpx|96 STX zpy|97 SMB1 zp|98 TYA imp|99 STA aby|9A TXS imp|9C STZ abs|9D STA abx|9E STZ abx|9F BBS1 zprel
A0 LDY imm|A1 LDA izx|A2 LDX imm|A3 TST immzpx|A4 LDY zp|A5 LDA zp|A6 LDX zp|A7 SMB2 zp|A8 TAY imp|A9 LDA imm|AA TAX imp|AC LDY abs|AD LDA abs|AE LDX abs|AF BBS2 zprel
B0 BCS rel|B1 LDA izy|B2 LDA izp|B3 TST immabx|B4 LDY zpx|B5 LDA zpx|B6 LDX zpy|B7 SMB3 zp|B8 CLV imp|B9 LDA aby|BA TSX imp|BC LDY abx|BD LDA abx|BE LDX aby|BF BBS3 zprel
C0 CPY imm|C1 CMP izx|C2 CLY imp|C3 TDD blk|C4 CPY zp|C5 CMP zp|C6 DEC zp|C7 SMB4 zp|C8 INY imp|C9 CMP imm|CA DEX imp|CC CPY abs|CD CMP abs|CE DEC abs|CF BBS4 zprel
D0 BNE rel|D1 CMP izy|D2 CMP izp|D3 TIN blk|D4 CSH imp|D5 CMP zpx|D6 DEC zpx|D7 SMB5 zp|D8 CLD imp|D9 CMP aby|DA PHX imp|DD CMP abx|DE DEC abx|DF BBS5 zprel
E0 CPX imm|E1 SBC izx|E3 TIA blk|E4 CPX zp|E5 SBC zp|E6 INC zp|E7 SMB6 zp|E8 INX imp|E9 SBC imm|EA NOP imp|EC CPX abs|ED SBC abs|EE INC abs|EF BBS6 zprel
F0 BEQ rel|F1 SBC izy|F2 SBC izp|F3 TAI blk|F4 SET imp|F5 SBC zpx|F6 INC zpx|F7 SMB7 zp|F8 SED imp|F9 SBC aby|FA PLX imp|FD SBC abx|FE INC abx|FF BBS7 zprel
"""
OPS = {}
for e in T.replace('\n', '|').split('|'):
    if e.strip():
        h, m, mode = e.split(); OPS[int(h, 16)] = (m, mode)
LEN = dict(imp=1, acc=1, imm=2, zp=2, zpx=2, zpy=2, abs=3, abx=3, aby=3, ind=3, iax=3, izx=2, izy=2, izp=2,
           rel=2, zprel=3, blk=7, immzp=3, immzpx=3, immabs=4, immabx=4)
HW = {0x0000: 'VDC_AR', 0x0002: 'VDC_DATA_L', 0x0003: 'VDC_DATA_H', 0x0400: 'VCE_CR', 0x0402: 'VCE_ADDR_L',
      0x0403: 'VCE_ADDR_H', 0x0404: 'VCE_DATA_L', 0x0405: 'VCE_DATA_H', 0x0800: 'PSG_CH', 0x0801: 'PSG_VOL',
      0x0802: 'PSG_FREQ_L', 0x0803: 'PSG_FREQ_H', 0x0804: 'PSG_CTRL', 0x0805: 'PSG_PAN', 0x0806: 'PSG_WAVE',
      0x0807: 'PSG_NOISE', 0x0808: 'PSG_LFO_F', 0x0809: 'PSG_LFO_C', 0x0C00: 'TIMER_CNT', 0x0C01: 'TIMER_CTRL',
      0x1000: 'JOYPAD', 0x1402: 'IRQ_MASK', 0x1403: 'IRQ_STATUS'}

def main():
    rom = open(sys.argv[1], 'rb').read(); out = sys.argv[2]; os.makedirs(out, exist_ok=True)
    nb = len(rom) // 0x2000
    executed = {}
    for cm in sys.argv[3:]:
        for l in open(cm):
            p = l.split(None, 2); a = int(p[0], 16)
            if a < len(rom):
                executed[a] = re.sub(r'\{.\}', '', l.rstrip('\n').split('  ', 1)[-1])
    # emplacement logique (slot MPR) de chaque banque, déduit des branchements relatifs exécutés
    votes = collections.defaultdict(collections.Counter)
    for a, t in executed.items():
        m = re.match(r'(BRA|BNE|BEQ|BCC|BCS|BPL|BMI|BVC|BVS|BSR)\s+\$([0-9A-F]{4})', t)
        if m and OPS.get(rom[a], ('', ''))[1] == 'rel':
            tgt = int(m.group(2), 16); rel = rom[a + 1] - 256 if rom[a + 1] > 127 else rom[a + 1]
            src = (tgt - rel - 2) & 0xFFFF
            if (src & 0x1FFF) == (a & 0x1FFF): votes[a >> 13][src >> 13] += 1
    slot = {b: v.most_common(1)[0][0] for b, v in votes.items()}
    multi = {b: dict(v) for b, v in votes.items() if len(v) > 1}
    def log(a): return (slot[a >> 13] << 13) | (a & 0x1FFF)
    # résolution dynamique (banque source, slot cible) -> banque cible, d'après les JSR/JMP exécutés
    xmap = collections.defaultdict(collections.Counter)
    byoff = collections.defaultdict(set)
    for a in executed: byoff[a & 0x1FFF].add(a >> 13)
    for a in executed:
        if rom[a] in (0x20, 0x4C):
            t = rom[a + 1] | rom[a + 2] << 8; s = t >> 13
            if s < 2: continue
            c = [b for b in byoff[t & 0x1FFF] if slot.get(b) == s]
            if len(c) == 1: xmap[(a >> 13, s)][c[0]] += 1
    def resolve(a, t):
        s = t >> 13; b = a >> 13
        if slot.get(b) == s: return (b << 13) | (t & 0x1FFF)
        c = xmap.get((b, s))
        if c and len(c) == 1: return (list(c)[0] << 13) | (t & 0x1FFF)
        if s == 7: return t & 0x1FFF      # banque 0 fixe en $E000
        return None
    # suivi de flux
    code = {}; labels = collections.defaultdict(set); unresolved = collections.Counter(); itabs = []
    work = list(executed)
    while work:
        a = work.pop()
        if a in code or a >= len(rom) or (a >> 13) not in slot: continue
        op = rom[a]
        if op not in OPS: continue
        m, mode = OPS[op]; n = LEN[mode]
        if (a & 0x1FFF) + n > 0x2000: continue
        code[a] = n; nxt = []
        if mode in ('rel', 'zprel'):
            d = rom[a + n - 1]; d = d - 256 if d > 127 else d
            t = (a & ~0x1FFF) | ((a + n + d) & 0x1FFF); labels[t].add(a); nxt.append(t)
            if m != 'BRA': nxt.append(a + n)
        elif m in ('JSR', 'JMP') and mode == 'abs':
            t = rom[a + 1] | rom[a + 2] << 8; r = resolve(a, t)
            if r is not None and r < len(rom): labels[r].add(a); nxt.append(r)
            elif t >= 0x4000: unresolved[(a >> 13, t)] += 1
            if m == 'JSR': nxt.append(a + n)
        elif m == 'JMP':
            itabs.append(a)
        elif m in ('RTS', 'RTI', 'BRK'):
            pass
        else:
            nxt.append(a + n)
        work += nxt
    # sortie
    def lab(p): return 'L%02X_%04X' % (p >> 13, log(p)) if (p >> 13) in slot else 'P%06X' % p
    def operand(a, m, mode):
        b = rom[a + 1:a + 7]
        w = lambda i: b[i] | b[i + 1] << 8
        def A(t):
            if t in HW: return HW[t]
            if m in ('JSR', 'JMP'):
                r = resolve(a, t)
                if r is not None and r in code: return lab(r)
            return '$%04X' % t
        if mode in ('imp',): return ''
        if mode == 'acc': return 'A'
        if mode == 'imm': return '#$%02X' % b[0]
        if mode == 'zp': return '<$%02X' % b[0]
        if mode == 'zpx': return '<$%02X,X' % b[0]
        if mode == 'zpy': return '<$%02X,Y' % b[0]
        if mode == 'abs': return A(w(0))
        if mode == 'abx': return A(w(0)) + ',X'
        if mode == 'aby': return A(w(0)) + ',Y'
        if mode == 'ind': return '(%s)' % A(w(0))
        if mode == 'iax': return '(%s,X)' % A(w(0))
        if mode == 'izx': return '(<$%02X,X)' % b[0]
        if mode == 'izy': return '(<$%02X),Y' % b[0]
        if mode == 'izp': return '(<$%02X)' % b[0]
        if mode == 'rel':
            d = b[0] - 256 if b[0] > 127 else b[0]; return lab((a & ~0x1FFF) | ((a + 2 + d) & 0x1FFF))
        if mode == 'zprel':
            d = b[1] - 256 if b[1] > 127 else b[1]; return '<$%02X,%s' % (b[0], lab((a & ~0x1FFF) | ((a + 3 + d) & 0x1FFF)))
        if mode == 'blk': return '$%04X,$%04X,$%04X' % (w(0), w(2), w(4))
        if mode == 'immzp': return '#$%02X,<$%02X' % (b[0], b[1])
        if mode == 'immzpx': return '#$%02X,<$%02X,X' % (b[0], b[1])
        if mode == 'immabs': return '#$%02X,%s' % (b[0], A(w(1)))
        if mode == 'immabx': return '#$%02X,%s,X' % (b[0], A(w(1)))
    stats = []
    for b in range(nb):
        base = b << 13; cb = sum(n for a, n in code.items() if a >> 13 == b)
        eb = sum(LEN[OPS[rom[a]][1]] for a in executed if a >> 13 == b and rom[a] in OPS)
        stats.append((b, slot.get(b), eb, cb))
        if not cb: continue
        org = slot[b] << 13
        with open('%s/bank%02X.asm' % (out, b), 'w') as f:
            f.write('; Detana!! TwinBee (PCE) - banque $%02X, vue en $%04X-$%04X\n; %d octets de code (%d exécutés en émulation)\n; [x] = instruction réellement exécutée, [ ] = trouvée par suivi de flux statique\n\n' % (b, org, org + 0x1FFF, cb, eb))
            a = base; prev_end = -1
            while a < base + 0x2000:
                if a in code:
                    n = code[a]; m, mode = OPS[rom[a]]
                    if a in labels or prev_end != a:
                        f.write('%s:\n' % lab(a))
                    f.write('  %04X  %-21s %-5s %-28s ;%s\n' % (log(a), ' '.join('%02X' % x for x in rom[a:a + n]), m, operand(a, m, mode), '[x]' if a in executed else '[ ]'))
                    if m in ('RTS', 'RTI', 'JMP', 'BRA'): f.write('\n')
                    a += n; prev_end = a
                else:
                    e = a
                    while e < base + 0x2000 and e not in code and e - a < 16 and (e == a or e not in labels): e += 1
                    f.write('  %04X  .db %s\n' % (log(a), ','.join('$%02X' % x for x in rom[a:e])))
                    a = e
    with open(out + '/summary.txt', 'w') as f:
        f.write('banque slot  octets_exécutés  octets_code_total\n')
        for b, s, eb, cb in stats:
            if cb or eb: f.write('  %02X    %s    %6d  %6d\n' % (b, s, eb, cb))
        f.write('\ntotal code: %d octets (%d exécutés)\n' % (sum(s[3] for s in stats), sum(s[2] for s in stats)))
        f.write('banques vues sur plusieurs slots: %s\n' % multi)
        f.write('\nrésolution inter-banques observée (banque source, slot) -> banque cible:\n')
        for k in sorted(xmap): f.write('  %02X slot %d -> %s\n' % (k[0], k[1], {('%02X' % x): c for x, c in xmap[k].items()}))
        f.write('\nsauts indirects (tables de saut à traiter à la main): %d\n' % len(itabs))
        for a in sorted(itabs): f.write('  %s  %s\n' % (lab(a), executed.get(a, OPS[rom[a]][0])))
        f.write('\nappels non résolus (banque cible inconnue): %d\n' % len(unresolved))
        for (b, t), c in sorted(unresolved.items()): f.write('  depuis banque %02X vers $%04X (x%d)\n' % (b, t, c))
    print(open(out + '/summary.txt').read()[:3500])

main()
