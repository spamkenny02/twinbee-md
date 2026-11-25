#include <genesis.h>
#include "music.h"
int main(bool hard)
{
    SYS_disableInts(); VDP_setScreenWidth320(); SYS_enableInts();
    XGM2_loadDriver(TRUE); XGM2_load(mus_all);
    XGM2_setLoopNumber(-1);
    XGM2_playTrack(0);
    while (TRUE) SYS_doVBlankProcess();
    return 0;
}
