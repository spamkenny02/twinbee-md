#include <genesis.h>
#include "music.h"
int main(bool hard){
    u16 f=0;
    SYS_disableInts(); VDP_setScreenWidth320(); SYS_enableInts();
    XGM2_loadDriver(TRUE); XGM2_load(mus_all);
    XGM2_playTrack(0);
    while(1){ f++;
      if(f==400){ XGM2_playTrack(1); }
      if(f==900){ XGM2_stop(); }
      if(f==910){ XGM2_playTrack(0); }
      SYS_doVBlankProcess(); }
    return 0;
}
