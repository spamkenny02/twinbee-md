// pcedump: frontal headless Geargrafx - entrées scriptées, dumps VRAM/SAT/palette/WRAM, carte du code exécuté
#include <vector>
#include <string>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "geargrafx.h"
bool g_mcp_stdio_mode = false;
#include <vector>
extern std::vector<unsigned char> g_psg_log; extern bool g_psg_log_on; extern unsigned long long g_psg_cyc;
struct Ev { int frame; int type; int keys; std::string name; }; // type 0=keys 1=dump 2=end
static void wr(const std::string& p, const void* d, size_t n){ FILE* f=fopen(p.c_str(),"wb"); if(!f){perror(p.c_str());exit(1);} fwrite(d,1,n,f); fclose(f);}
int main(int argc,char**argv){
  if(argc<4){fprintf(stderr,"usage: pcedump rom script outdir\n");return 1;}
  std::string out=argv[3];
  std::vector<Ev> evs; int endf=600;
  FILE* s=fopen(argv[2],"r"); if(!s){perror("script");return 1;}
  char line[256];
  while(fgets(line,sizeof line,s)){
    int fr; char cmd[32], arg[128]="";
    if(line[0]=='#'||sscanf(line,"%d %31s %127s",&fr,cmd,arg)<2) continue;
    Ev e; e.frame=fr; e.keys=0; e.name=arg;
    if(!strcmp(cmd,"keys2")){e.type=14; e.keys=(int)strtol(arg,NULL,16);} else if(!strcmp(cmd,"keys")){e.type=0; e.keys=(int)strtol(arg,NULL,16);}
    else if(!strcmp(cmd,"dump")) e.type=1;
    else if(!strcmp(cmd,"end")){e.type=2; endf=fr;}
    else if(!strcmp(cmd,"poke")){e.type=3; unsigned a,v; sscanf(arg,"%x=%x",&a,&v); e.keys=(int)((a<<8)|v);}
    else if(!strcmp(cmd,"watch")){e.type=6; unsigned a,b=0,n; if(strchr(arg,'-')) sscanf(arg,"%x-%x:%u",&a,&b,&n); else sscanf(arg,"%x:%u",&a,&n); e.keys=(int)(a|(b<<16)); e.name=std::to_string(n);}   // pas à pas : journal des écritures RAM à <adr> pendant <n> instructions
    else if(!strcmp(cmd,"trace")) e.type=4;      // début de trace SAT+RAM par frame dans <nom>.trace
    else if(!strcmp(cmd,"traceoff")) e.type=5;
    else if(!strcmp(cmd,"psglog")) e.type=7;     // journal de l'état PSG à chaque frame dans <nom>.psg
    else if(!strcmp(cmd,"psgoff")) e.type=8;
    else if(!strcmp(cmd,"pcm")) e.type=10;          // enregistre l'audio PCE (s16 stéréo brut) dans <nom>.pcm
    else if(!strcmp(cmd,"pcmoff")) e.type=11;
    else if(!strcmp(cmd,"mute")){ e.type=12; e.keys=(int)strtol(arg,NULL,16); }   // masque des canaux PSG coupés (bit c = canal c)
    else if(!strcmp(cmd,"sndlog")){ e.type=13; e.keys=atoi(arg); }   // pas à pas sur <n> frames : journal des requêtes sonores (A à l'entrée de $E3FC)
    else if(!strcmp(cmd,"snd")){ e.type=9; e.keys=(int)strtol(arg,NULL,16); }   // appelle la routine de requête sonore $E3FC avec A=<id> (simule JSR)
    else continue;
    evs.push_back(e);
  }
  fclose(s);
  GeargrafxCore* core=new GeargrafxCore(); core->Init(NULL, GG_PIXEL_RGBA8888);
  if(!core->LoadMedia(argv[1])){fprintf(stderr,"load failed\n");return 1;} core->GetInput()->EnableTurboTap(true);
  static u8 fb[2048*512*4]; static s16 ab[65536]; int sc=0;
  GeargrafxCore::GG_Debug_Run dbg; memset(&dbg,0,sizeof dbg);
  int cur=0, cur2=0; FILE* tr=NULL; FILE* pl=NULL; FILE* pw=NULL; FILE* slf=NULL; int sndlog_until=0;
  for(int f=0;f<=endf;f++){
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==0){
      int k=evs[i].keys;
      for(int b=0;b<12;b++){ int m=1<<b; if((k&m)&&!(cur&m)) core->KeyPressed(GG_CONTROLLER_1,(GG_Keys)m); if(!(k&m)&&(cur&m)) core->KeyReleased(GG_CONTROLLER_1,(GG_Keys)m);} cur=k; }
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==14){ int k=evs[i].keys; for(int b=0;b<12;b++){ int m=1<<b; if((k&m)&&!(cur2&m)) core->KeyPressed(GG_CONTROLLER_2,(GG_Keys)m); if(!(k&m)&&(cur2&m)) core->KeyReleased(GG_CONTROLLER_2,(GG_Keys)m);} cur2=k; }
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==12){ HuC6280PSG::HuC6280PSG_State* ps=core->GetAudio()->GetPSG()->GetState(); for(int c=0;c<6;c++) ps->CHANNELS[c].mute=(evs[i].keys>>c)&1; }
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==9){
      HuC6280::HuC6280_State* st=core->GetHuC6280()->GetState(); u8* w=core->GetMemory()->GetWorkingRAM();
      u16 ret=(u16)(st->PC->GetValue()-1); u8 sp=st->S->GetValue();
      w[0x100+sp]=(u8)(ret>>8); sp--; w[0x100+sp]=(u8)ret; sp--; st->S->SetValue(sp); st->A->SetValue((u8)evs[i].keys); st->PC->SetValue(0xE3FC); }
    for(size_t i=0;i<evs.size();i++) if(evs[i].type==3 && evs[i].frame<=f) core->GetMemory()->GetWorkingRAM()[(evs[i].keys>>8)&0x1FFF]=(u8)evs[i].keys; // poke persistant en RAM
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==6){
      GeargrafxCore::GG_Debug_Run st; memset(&st,0,sizeof st); st.step_debugger=true;
      u8* w=core->GetMemory()->GetWorkingRAM(); int ad=evs[i].keys&0x1FFF; int hi=((evs[i].keys>>16)&0x1FFF); long n=atol(evs[i].name.c_str());
      FILE* wf=fopen((out+"/watch.txt").c_str(),"a"); u8 old=w[ad]; static u8 snap[0x2000]; memcpy(snap,w,0x2000);
      for(long k=0;k<n;k++){ u16 pc=core->GetHuC6280()->GetState()->PC->GetValue(); u8 bank=core->GetMemory()->GetMpr(pc>>13);
        core->RunToVBlank(fb,ab,&sc,&st,false);
        if(hi){ for(int q=ad;q<=hi;q++) if(w[q]!=snap[q]){ fprintf(wf,"f%d adr=%04X pc=%04X banque=%02X %02X->%02X\n",f,0x2000+q,pc,bank,snap[q],w[q]); snap[q]=w[q]; } continue; }
        if(w[ad]!=old){ u8 sp=core->GetHuC6280()->GetState()->S->GetValue();
          fprintf(wf,"f%d adr=%04X pc=%04X banque=%02X %02X->%02X pile:",f,0x2000+ad,pc,bank,old,w[ad]);
          for(int q=1;q<=10;q++) fprintf(wf," %02X",w[0x100+((sp+q)&0xFF)]);
          fprintf(wf," mpr:"); for(int q=2;q<8;q++) fprintf(wf," %02X",core->GetMemory()->GetMpr(q)); fprintf(wf,"\n"); old=w[ad]; } }
      fclose(wf);
    }
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==13){ sndlog_until=f+evs[i].keys; if(!slf) slf=fopen((out+"/sndlog.txt").c_str(),"w"); }
    if(slf && f<sndlog_until){
      GeargrafxCore::GG_Debug_Run st; memset(&st,0,sizeof st); st.step_debugger=true;
      bool tick=false;
      for(int k=0;k<400000 && !tick;k++){ u16 pc=core->GetHuC6280()->GetState()->PC->GetValue();
        if(pc==0xE3FC){ fprintf(slf,"%d %02X\n",f,core->GetHuC6280()->GetState()->A->GetValue()); }
        if(pc==0xE3E9 && k>100) tick=true;
        core->RunToVBlank(fb,ab,&sc,&st,false); }
    } else
    core->RunToVBlank(fb,ab,&sc,&dbg,true);
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f){ if(evs[i].type==10) pw=fopen((out+"/"+evs[i].name+".pcm").c_str(),"wb"); if(evs[i].type==11&&pw){fclose(pw);pw=NULL;} }
    if(pw) fwrite(ab,2,sc,pw);
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f){ if(evs[i].type==4){ tr=fopen((out+"/"+evs[i].name+".trace").c_str(),"wb"); } if(evs[i].type==5 && tr){ fclose(tr); tr=NULL; } }
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f){ if(evs[i].type==7){ pl=fopen((out+"/"+evs[i].name+".psg").c_str(),"wb"); g_psg_log_on=true; } if(evs[i].type==8&&pl){fclose(pl);pl=NULL;} }
    if(pl){ { u32 fr2=f; u32 cy=(u32)g_psg_cyc; u32 nb=(u32)g_psg_log.size()/6; fwrite(&fr2,4,1,pl); fwrite(&cy,4,1,pl); fwrite(&nb,4,1,pl); if(nb) fwrite(g_psg_log.data(),1,nb*6,pl); g_psg_log.clear(); } HuC6280PSG::HuC6280PSG_State* ps=core->GetAudio()->GetPSG()->GetState(); u32 fr=f; fwrite(&fr,4,1,pl); fwrite(ps->MAIN_AMPLITUDE,1,1,pl); u8 lf=*ps->LFO_CONTROL; fwrite(&lf,1,1,pl);
      for(int c=0;c<6;c++){ HuC6280PSG::HuC6280PSG_Channel* ch=&ps->CHANNELS[c]; u8 r[8]={(u8)ch->frequency,(u8)(ch->frequency>>8),ch->control,ch->vol_left,ch->vol_right,ch->noise_control,(u8)ch->dda,(u8)ch->dda_enabled}; fwrite(r,1,8,pl); fwrite(ch->wave_data,1,32,pl);} }
    if(tr){ u16 hdr[2]={(u16)f,(u16)cur}; fwrite(hdr,2,2,tr); fwrite(core->GetHuC6270_1()->GetSAT(),2,256,tr); fwrite(core->GetMemory()->GetWorkingRAM(),1,0x2000,tr); }
    for(size_t i=0;i<evs.size();i++) if(evs[i].frame==f && evs[i].type==1){
      std::string b=out+"/"+evs[i].name;
      GG_Runtime_Info ri; core->GetRuntimeInfo(ri);
      wr(b+".rgba",fb,(size_t)ri.screen_width*ri.screen_height*4);
      HuC6270* vdc=core->GetHuC6270_1();
      wr(b+".vram",vdc->GetVRAM(),0x8000*2);
      wr(b+".sat",vdc->GetSAT(),64*4*2);
      wr(b+".pal",core->GetHuC6260()->GetColorTable(),512*2);
      wr(b+".vdcreg",vdc->GetState()->R,20*2);
      wr(b+".wram",core->GetMemory()->GetWorkingRAM(),0x2000);
      FILE* m=fopen((b+".txt").c_str(),"w");
      fprintf(m,"frame %d\nwidth %d\nheight %d\nmpr",f,ri.screen_width,ri.screen_height);
      for(int i=0;i<8;i++) fprintf(m," %02X",core->GetMemory()->GetMpr(i));
      fprintf(m,"\n"); fclose(m);
    }
  }
  // carte du code exécuté : adresse physique, adresse logique vue, taille
  GG_Disassembler_Record** rec=core->GetMemory()->GetAllDisassemblerRecords();
  FILE* c=fopen((out+"/codemap.txt").c_str(),"w");
  for(int i=0;i<0x200000;i++) if(rec[i] && rec[i]->size>0)
    fprintf(c,"%06X %02X %d %s %s\n",i,rec[i]->bank,rec[i]->size,rec[i]->bytes,rec[i]->name);
  fclose(c);
  return 0;
}
