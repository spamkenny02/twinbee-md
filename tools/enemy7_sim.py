"""Modèle de l'ennemi de type 7 (routine $6234 de la banque $0C), validé contre la RAM PCE."""
def s8(v): v &= 255; return v - 256 if v > 127 else v
class Enemy7:
    def __init__(self, flags, diff=4, order=0):
        self.flags = flags; self.state = 1; self.order = order
        self.x = (0xC0 if flags & 1 else 0x30) << 8; self.y = (0xD0 - 256) << 8
        self.vx = 0; self.vy = 0x200 + (diff * 2 + 0x80); self.ax = self.ay = 0; self.cnt = 0; self.sv = (0, 0)
        self.step(159, first=True)
    def step(self, player_y, first=False):
        if not first or True:
            pass
        st = self.state
        if first: pass
        else: self.handler(player_y)
        self.integrate()
    def handler(self, player_y):
        s = self.state
        if s == 1:
            y6 = ((self.y >> 8) + 0x50) & 255
            if y6 >= 0xCE or not (player_y >= y6): self.go2()
        elif s == 2:
            self.cnt -= 1
            if self.cnt == 0:
                self.sv = (self.vx, -self.vy); self.vx = self.vy = self.ax = self.ay = 0; self.cnt = 0x60; self.state = 3
        elif s == 3:
            self.cnt -= 1
            if self.cnt == 0:
                self.vx, self.vy = self.sv; self.cnt = 0x18
                self.ax = 0x10 if self.flags & 1 else -0x10; self.ay = -0x10; self.state = 4
        elif s == 4:
            self.cnt -= 1
            if self.cnt == 0: self.ax = self.ay = 0; self.vx = 0; self.state = 5
    def go2(self):
        self.ay = -0x10; self.ax = -0x12 if self.flags & 1 else 0x12; self.cnt = 0x18; self.state = 2
    def integrate(self):
        self.vx += self.ax; self.vy += self.ay
        self.x += self.vx; self.y += self.vy
    @property
    def pos(self): return self.x >> 8, self.y >> 8
