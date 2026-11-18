"""Modèle de l'ennemi de type 6 (routine $637B, banque $0C)."""
import sys; sys.path.insert(0, 'tools'); import enemy_sim
V = [enemy_sim.velocity(a, 38) for a in range(32)]
class Enemy6:
    def __init__(s, flags):
        s.f = flags & 1; s.state = 1
        s.x = (248 if s.f else -8) << 8; s.y = 200 << 8
        s.ang = 0x17 if s.f else 0x19; s.c36 = 7; s.c38 = 1; s.vx = s.vy = 0
    def step(s):
        st = s.state
        if st in (1, 3, 5):
            s.c38 -= 1
            if s.c38 == 0:
                s.c38 = 5 if st == 3 else 7
                s.c36 -= 1
                if s.c36 == 0:
                    s.state = st + 1; s.c36 = 26 if st != 4 else 63; s.c38 = 0 if st == 1 else 1
                else:
                    d = -1 if (st != 3) == bool(s.f) else 1       # f=1: états 1,5 -1 ; état 3 +1 ; f=0 inverse
                    s.ang = (s.ang + d) & 31; s.vx, s.vy = V[s.ang]
        elif st in (2, 4):
            s.c36 -= 1
            if s.c36 == 0:
                s.state = st + 1; s.c36 = 63 if st == 2 else 63; s.c38 = 1
                if st == 2: s.c36 = 63
        s.x += s.vx; s.y += s.vy
