"""Modèle de l'ennemi de la vague 1 (routine $6181/$61DB de la banque $0C), validé contre la RAM PCE."""
ROM = '/mnt/user-data/uploads/f53489e7-Detana_TwinBee_Japan.pce'
_tab = list(open(ROM, 'rb').read()[0x1EB8:0x1EB8 + 32])
def _t16(i):
    i &= 31
    if (i & 15) == 0: return 0
    v = _tab[i]
    return v - 256 if i & 16 else v
def velocity(angle, speed):
    """$4111 : (cos, sin) de la table $FEB8 x vitesse, décalé de 4 bits -> 8.8 signé"""
    def comp(i):
        p = (_t16(i) * speed) & 0xFFFF; p = p - 0x10000 if p & 0x8000 else p
        return (p << 4) >> 8
    return comp(angle + 8), comp(angle)
_rom = open(ROM, 'rb').read()
_atan = list(_rom[0x0B * 0x2000 + 0xCD:0x0B * 0x2000 + 0xCD + 64]); _quad = list(_rom[0x0B * 0x2000 + 0x10D:0x0B * 0x2000 + 0x111])
def aim(ex, ey, tx, ty):
    """$4030 : angle (0..31) de l'objet (ex,ey) vers la cible (tx,ty) ; les soustractions de l'original ont une retenue de trop (-1)"""
    q = 0
    dy = ey - ty - 1
    if dy < 0: q = 1; dy = -dy
    dx = ex - tx - 1
    q = (q << 1) | (1 if dx < 0 else 0)
    if dx < 0: dx = -dx
    while (dy if dy >= dx else dx) >= 8: dy >>= 1; dx >>= 1
    a = _atan[dy * 8 + dx]
    if (q + 1) & 2: a = 8 - a
    return (a + _quad[q]) & 0xFF
class Enemy:
    """ennemi de type 5 ; flags = octet $3438 : bit 1 = arrive par la droite (virage inversé), bit 0 = part en visant le joueur"""
    def __init__(self, flags=0, player=(64, 159)):
        self.flags = flags; self.state = 1; self.timer = 0
        ex = 248 if flags & 2 else -8
        if flags & 1:
            a = aim(ex, 0, player[0], player[1])
            if flags & 2: a = a if a < 0x11 else 0x10
            else: a = a if a < 8 else 0
        else: a = 13 if flags & 2 else 3
        self.angle = a
        self.vx, self.vy = velocity(self.angle, 0x12)
        self.fx = (ex << 8) + self.vx; self.fy = self.vy      # déjà déplacé une fois à la frame d'apparition
    def step(self, player_obj_x):
        if self.state == 1:
            if abs(player_obj_x - (self.fx >> 8)) < 0x20: self.state = 2; self.timer = 0
        else:
            self.fy += 0x55
            if self.timer == 0:
                self.timer = 12; self.angle = (self.angle + (-1 if self.flags & 2 else 1)) & 31; self.vx, self.vy = velocity(self.angle, 0x20)
            self.timer -= 1
        self.fx += self.vx; self.fy += self.vy
    @property
    def pos(self): return self.fx >> 8, self.fy >> 8
