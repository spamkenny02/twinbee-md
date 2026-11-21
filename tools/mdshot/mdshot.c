// mdshot: frontal libretro headless minimal. usage: mdshot core.so rom script outdir
// script: "<frame> ramtrace <nom>" / "<frame> ramtraceoff" (RAM 68000 par frame), "<frame> keys <hexmask>" (bits = RETRO_DEVICE_ID_JOYPAD_*), "<frame> shot <nom>", "<frame> end"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <dlfcn.h>
struct retro_game_info { const char* path; const void* data; size_t size; const char* meta; };
static int fmt=0; static unsigned W,H; static uint8_t fb[1024*1024*3]; static int keys=0;
static bool env(unsigned cmd, void* d){ if(cmd==10){ fmt=*(int*)d; return true;} return false; }
static void video(const void* data, unsigned w, unsigned h, size_t pitch){ if(!data) return; W=w;H=h;
  for(unsigned y=0;y<h;y++) for(unsigned x=0;x<w;x++){ uint8_t* o=fb+(y*w+x)*3;
    if(fmt==2){ uint16_t p=((const uint16_t*)((const uint8_t*)data+y*pitch))[x]; o[0]=(p>>11)*255/31; o[1]=((p>>5)&63)*255/63; o[2]=(p&31)*255/31; }
    else if(fmt==1){ uint32_t p=((const uint32_t*)((const uint8_t*)data+y*pitch))[x]; o[0]=p>>16; o[1]=p>>8; o[2]=p; }
    else { uint16_t p=((const uint16_t*)((const uint8_t*)data+y*pitch))[x]; o[0]=((p>>10)&31)*255/31; o[1]=((p>>5)&31)*255/31; o[2]=(p&31)*255/31; } } }
static FILE* wavf=NULL; static void audio(int16_t l,int16_t r){ if(wavf){ int16_t b[2]={l,r}; fwrite(b,2,2,wavf);} } static size_t audiob(const int16_t* d,size_t n){ if(wavf) fwrite(d,4,n,wavf); return n;} static void poll(void){}
static int16_t input(unsigned port,unsigned dev,unsigned idx,unsigned id){ if(port==0&&dev==1){ if(id==256) return keys; return (keys>>id)&1; } return 0; }
int main(int c,char**v){ if(c<5) return 1; void* h=dlopen(v[1],RTLD_NOW); if(!h){fprintf(stderr,"%s\n",dlerror());return 1;}
#define S(n) dlsym(h,#n)
  ((void(*)(void*))S(retro_set_environment))(env); ((void(*)(void*))S(retro_set_video_refresh))(video);
  ((void(*)(void*))S(retro_set_audio_sample))(audio); ((void(*)(void*))S(retro_set_audio_sample_batch))(audiob);
  ((void(*)(void*))S(retro_set_input_poll))(poll); ((void(*)(void*))S(retro_set_input_state))(input);
  ((void(*)(void))S(retro_init))();
  FILE* f=fopen(v[2],"rb"); fseek(f,0,SEEK_END); long n=ftell(f); rewind(f); void* rom=malloc(n); fread(rom,1,n,f); fclose(f);
  struct retro_game_info gi={v[2],rom,n,NULL}; if(!((bool(*)(void*))S(retro_load_game))(&gi)){fprintf(stderr,"load failed\n");return 1;}
  void(*run)(void)=S(retro_run);
  int ef[4096],et[4096],ek[4096],ne=0,endf=600; char en[4096][64]; char line[256]; FILE* s=fopen(v[3],"r");
  while(fgets(line,256,s)){ int fr; char cmd[32],arg[64]=""; if(sscanf(line,"%d %31s %63s",&fr,cmd,arg)<2) continue;
    ef[ne]=fr; strcpy(en[ne],arg); if(!strcmp(cmd,"keys")){et[ne]=0;ek[ne]=strtol(arg,0,16);} else if(!strcmp(cmd,"shot")) et[ne]=1; else if(!strcmp(cmd,"ramtrace")) et[ne]=2; else if(!strcmp(cmd,"ramtraceoff")) et[ne]=3; else if(!strcmp(cmd,"wav")) et[ne]=4; else if(!strcmp(cmd,"wavoff")) et[ne]=5; else {endf=fr; continue;} ne++; }
  uint8_t* ram=((void*(*)(unsigned))S(retro_get_memory_data))(2); size_t rsz=((size_t(*)(unsigned))S(retro_get_memory_size))(2); FILE* rt=NULL;
  for(int fr=0;fr<=endf;fr++){ for(int i=0;i<ne;i++) if(ef[i]==fr&&et[i]==0) keys=ek[i];
    for(int i=0;i<ne;i++) if(ef[i]==fr){ if(et[i]==4){ char p[512]; snprintf(p,512,"%s/%s.pcm",v[4],en[i]); wavf=fopen(p,"wb"); } if(et[i]==5&&wavf){ fclose(wavf); wavf=NULL; } }
    run();
    for(int i=0;i<ne;i++) if(ef[i]==fr){ if(et[i]==2){ char p[512]; snprintf(p,512,"%s/%s.ramtrace",v[4],en[i]); rt=fopen(p,"wb"); } if(et[i]==3&&rt){ fclose(rt); rt=NULL; } }
    if(rt&&ram) fwrite(ram,1,rsz,rt);   // RAM 68000 complète (64 Ko) par frame
    for(int i=0;i<ne;i++) if(ef[i]==fr&&et[i]==1){ char p[512]; snprintf(p,512,"%s/%s.ppm",v[4],en[i]); FILE* o=fopen(p,"wb"); fprintf(o,"P6\n%u %u\n255\n",W,H); fwrite(fb,1,W*H*3,o); fclose(o);} }
  return 0; }
