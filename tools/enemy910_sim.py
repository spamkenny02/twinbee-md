"""Modèles des ennemis de type 9 (soucoupes, $65FE) et 10 (petits vaisseaux en formation, $652D), banque $0C."""
import sys; sys.path.insert(0, 'tools'); import enemy_sim
def s8(v): v &= 255; return v - 256 if v > 127 else v
def s16(v): v &= 0xFFFF; return v - 0x10000 if v & 0x8000 else v
class Enemy9:
    ANIM = [(56, 15), (12, 16), (12, 17), (32, 18)]
    def __init__(s, flags):
        s.fl = flags & 1; s.state = 0; s.x = 0; s.y = -8 << 8; s.vx = s.vy = s.ax = s.ay = 0
        s.c36 = 0; s.c38 = 0; s.ang = 0; s.an = 15; s.cnt = 55; s.idx = 1
    def step(s, player):
        st = s.state
        if st == 0:
            s.y = (-8 << 8) | (s.y & 0xFF)
            if s.fl: s.x = (216 << 8) | (s.x & 0xFF); s.vx = -256
            else: s.x = (24 << 8) | (s.x & 0xFF); s.vx = 256
            s.vy = 0x120; s.ay = -3; s.state = 1
        elif st == 1:
            s.animate()
            if ((s.x >> 8) & 255) == 0x78: s.state = 2; s.ay = 0; s.vx = 0
        elif st == 2:
            s.c36 += 1
            if s.c36 == 0x60:
                s.state = 3; s.ang = 0x0E if s.fl else 2
                s.vx, s.vy = enemy_sim.velocity(s.ang, 0x1C); s.c38 = 0x10
        elif st == 3:
            if s.c38 == 0:
                s.c38 = 0x10; s.ang = (s.ang - 1) & 31 if s.fl else (s.ang + 1) & 31
                s.vx, s.vy = enemy_sim.velocity(s.ang, 0x1C)
            if ((s.y >> 8) & 255) >= 0xD0:
                s.state = 4; a = enemy_sim.aim(s.x >> 8, s.y >> 8, player[0], player[1]); s.vx, s.vy = enemy_sim.velocity(a, 0x40)
            s.c38 -= 1
        s.vx += s.ax; s.vy += s.ay; s.x += s.vx; s.y += s.vy
    def animate(s):
        if s.cnt == 0:
            d, a = s.ANIM[s.idx % 4]; s.cnt = d; s.an = a; s.idx += 1
        s.cnt -= 1
class Enemy10:
    def __init__(s, x, fl):
        s.x = x << 8; s.y = 0; s.fl = fl; s.state = 0; s.vx = s.vy = s.ax = s.ay = 0; s.c36 = 0; s.c37 = 0; s.an = 19; s.idx = 1
    def step(s):
        st = s.state
        if st == 0:
            s.y = 224 << 8; s.vy = -256; s.state = 1
        elif st == 1:
            s.c36 += 1
            if s.c36 >= 0xC0:
                s.state = 2; s.ay = 8
                if ((s.x >> 8) & 255) - 0x78 & 0x80: s.fl = 0; s.ax = 0x12
                else: s.fl = 1; s.ax = -0x12
                s.c37 = 0
        elif st == 2:
            s.c37 += 1
            if s.c37 in (0x0D, 0x1A, 0x26, 0x33): s.an = 19 + s.idx; s.idx += 1
            if s.vx == 0 and False: pass
            if s.vy == 0: s.ax = -s.ax
            if (s.vy >> 8) == 1: s.ax = s.ay = 0; s.vy = (s.vy & 0xFF) | 0x200; s.state = 3
            if s.fl & 1: s.y += 0x55
        s.vx += s.ax; s.vy += s.ay; s.x += s.vx; s.y += s.vy
