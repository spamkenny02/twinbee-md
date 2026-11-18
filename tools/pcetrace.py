"""Lecture des traces pcedump (.trace) : frame, touches, SAT (64x4), RAM (8 Ko) par frame."""
import numpy as np
REC = 4 + 512 + 8192
def load(path):
    d = np.memmap(path, np.uint8, 'r').reshape(-1, REC)
    hdr = np.array(d[:, :4]).view('<u2'); sat = np.array(d[:, 4:516]).view('<u2').reshape(-1, 64, 4).astype(np.int32)
    return hdr[:, 0].astype(int), hdr[:, 1].astype(int), sat, d[:, 516:]
def sprites(sat_t):
    """liste (x_ecran, y_ecran, pattern, palette, hflip, w, h, index) des sprites non vides d'une frame"""
    o = []
    for i in range(64):
        y, x, pat, at = sat_t[i]
        if pat == 0 and at == 0: continue
        cgy = (at >> 12) & 3
        o.append((int((x & 0x3FF) - 32), int((y & 0x3FF) - 64), int((pat >> 1) & 0x3FF), int(at & 15), bool(at & 0x800), 32 if at & 0x100 else 16, [16, 32, 64, 64][cgy], i))
    return o
