#ifndef __BIGCRT_H_
#define __BIGCRT_H_
#include <dos.h>
#include <string.h>
#include <stdlib.h>

typedef unsigned int word;
typedef unsigned char byte;
typedef unsigned long dword;

#define crt40x25  0x1
#define crt80x25  0x3
#define crt132x25 0x19
#define crt132x50 0x1a

word max_X=0,max_Y=0;
word c_X=0,c_Y=0;

void set_mode(byte mode)
{
switch(mode)
 {
 case crt40x25:
 case crt80x25:
 case crt132x25:
 case crt132x50:
  asm {
  mov ah,0x00
  mov al,mode
  int 0x10
  }
 }
}


void init_video(byte mode)
{
switch(mode)
 {
 case crt40x25:
  set_mode(mode);
  max_X=40;
  max_Y=25;
  break;
 case crt80x25:
  set_mode(mode);
  max_X=80;
  max_Y=25;
  break;
 case crt132x25:
  set_mode(mode);
  max_X=132;
  max_Y=25;
  break;
 case crt132x50:
  set_mode(mode);
  max_X=132;
  max_Y=50;
  break;
 }
}

void clip_coords(byte &x,byte &y)
{
if(y>max_Y) y%=max_Y;
if(x>max_X) x%=max_X;
}

void kputc(byte x,byte y,char c)
{
pokeb(0xb800,((y-1)*max_X+x-1)*2,c);
}

void kputs(byte x,byte y,char *s)
{
word i=0,j=0,k=0,slen=strlen(s);
clip_coords(x,y);
i=x;
j=y;
do {
 if(i>max_X-1) { i=0; j++;}
 if(j>max_Y) j=max_Y;
 kputc(i,j,s[k]); k++; i++;
 } while(k<slen);
}



#endif // __BIGCRT_H_