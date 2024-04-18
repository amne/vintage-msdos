#ifndef __KENC_H_
#define __KENC_H_
#include <math.h>
#include <string.h>
#include <stdlib.h>

#define magic_num  0x4E
#define magic_num2 0x4B
#define max_num    0x100
#define POLY 0x7812

typedef unsigned char byte;
typedef unsigned int word;
typedef unsigned long dword;




word crc16(char *data_p, word length)
{
unsigned char i;
unsigned int data;
unsigned int crc = 0xffff;
if (length == 0) return (~crc);
 do {
  for (i=0,data=(unsigned int)0xff & *data_p++;i<8;i++,data>>=1)
   {
   if ((crc & 0x0001) ^ (data & 0x0001))
      crc = (crc >> 1) ^ POLY;
      else  crc >>= 1;
   }
 } while (--length);
crc = ~crc;
data = crc;
crc = (crc << 8) | ((data >> 8) & 0xff);
return (crc);
}





void encdata(char *din,word leng,char *dout)
{
word i=0;
for(i=0;i<leng;i++)
 {
 (i%2)?dout[i]=din[i]+magic_num:dout[i]=din[i]+magic_num2;
 }
dout[leng]=0;
}

void decdata(char *din,word leng,char *dout)
{
word i=0;
for(i=0;i<leng;i++)
 {
 (i%2)?dout[i]=din[i]-magic_num:dout[i]=din[i]-magic_num2;
 }
dout[leng]=0;
}


void encdata2(char *din,word leng,char *dout)
{
word i=0;
char t;
for(i=0;i<leng;i++)
 {
 if(i==0) t=dout[i]=din[i]+magic_num;
  else t=dout[i]=din[i]+t;
 }
dout[leng]=0;
}

void decdata2(char *din,word leng,char *dout)
{
word i=0;
char t;
for(i=0;i<leng;i++)
 {
 if(i==0) dout[i]=(t=din[i])-magic_num;
  else {dout[i]=din[i]-t; t=din[i];}
 }
dout[leng]=0;
}


void keydata(char *din,word leng,char *key,char *dout)
{
word i=0,j=0,keylen=strlen(key),keycrc=crc16(key,keylen) & 0xFF;
char t1=0,t2=magic_num;
for(i=0;i<leng;i++)
 {
 t1=din[i];
 for(j=0;j<keylen;j++)
  {
  t1+=key[j];
  }
 dout[i]=t1+=t2+keycrc;
 t2=dout[i];
 }
dout[leng]=0;
}

void dekeydata(char *din,word leng,char *key,char *dout)
{
word i=0,j=0,keylen=strlen(key),keycrc=crc16(key,keylen) & 0xFF;
char t1=0,t2=magic_num;
t2=magic_num;
for(i=0;i<leng;i++)
 {
 t1=din[i];
 for(j=0;j<keylen;j++)
  {
  t1-=key[j];
  }
 dout[i]=t1-=(t2+keycrc);
 t2=din[i];
 }
dout[leng]=0;
}







#endif // __KENC_H_