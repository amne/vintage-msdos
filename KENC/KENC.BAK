#include "kenc.h"
#include <stdio.h>
#include <conio.h>
#include <io.h>
#include <fcntl.h>

#define SET_INPUT    1
#define SET_OUTPUT   2
#define SET_METHOD   4

#define EXIT         6

int set_flags=0;
char *fnamein=(char *)malloc(256);
char *fnameout=(char *)malloc(256);
char *methname=(char *)malloc(256);
char *password=(char *)malloc(256);
int stat=0,filehin=0,filehout=0,statin=0,statout=0,method=0,decode=0;
long flen=0,btf=0,bf=0,btd=0,bd=0;

void initmenu()
{
clrscr();
set_flags=0;
memset(fnamein,0,256);
memset(fnameout,0,256);
memset(methname,0,256);
}
void prglogo()
{
textcolor(15);
puts("\n ษออออออออออออออออออออออออออออออออออออออออออออป");
puts(" บ      Khrys-TIAN Encoder/Decoder v0.3a      บ");
puts(" ศออออออออออออออออออออออออออออออออออออออออออออผ");
textcolor(7);
}
void mmenulogo()
{
textcolor(8);
cputs("\xD\xA ฺฤฤฤฤฤฤฤฤฤฤฤ"); textcolor(15);    cputs("ฟ"); textcolor(8);
cputs("\xD\xA ณ"); textcolor(7); cputs(" Main menu "); textcolor(15); cputs("ณ"); textcolor(8);
cputs("\xD\xA ภ"); textcolor(15);    cputs("ฤฤฤฤฤฤฤฤฤฤฤู\n");
textcolor(7);
}

void selectmethod()
{
int opt1=0;
do {
method=0;
decode=0;
clrscr();
prglogo();
puts(" Methods:"); puts("");
puts(" 1. Incriptare simpla");
puts(" 2. Decriptare simpla");
puts(" 3. Incriptare incrementala");
puts(" 4. Decriptare incrementala");
puts(" 5. Incriptare folosind cheie de criptare");
puts(" 6. Decriptare folosind cheie de decriptare");
opt1=getch()-48;
switch(opt1)
 {
 case 1:
  strcpy(methname," incriptare simpla");
  method=1; decode=0;
  break;
 case 2:
  strcpy(methname," decriptare simpla");
  method=1; decode=1;
  break;
 case 3:
  strcpy(methname," incriptare incrementala");
  method=2; decode=0;
  break;
 case 4:
  strcpy(methname," decriptare incrementala");
  method=2; decode=1;
  break;
 case 5:
  cputs(" Key:"); gets(password);
  strcpy(methname," incriptare cu cheie de criptare");
  method=3; decode=0;
  break;
 case 6:
  cputs(" Key:"); gets(password);
  strcpy(methname," incriptare cu cheie de criptare");
  method=3; decode=1;
  break;
 }
} while(method==0);
}


int start()
{
int doomed=0,ok=0;
char *buff=(char *)malloc(512);
char *encbuff=(char *)malloc(512);
flen=0;
bf=btf=bd=btd=0;
statin=statout=0;
filehin=fileno(fopen(fnamein,"rb"));
filehout=fileno(fopen(fnameout,"wb+"));
doomed=(filehin<=0)||(filehout<=0);
if(!doomed)
 {
 flen=filelength(filehin);
 do {
 btf=(flen-bf>512)?512:(flen-bf);
 statin=read(filehin,buff,btf);
 bf+=btf;
 btd=btf;
 if((statin<0)||((statin>0)&&(statin<btf))) doomed=1;
 if(!doomed)
  {
  switch(method)
   {
   case 1:
    if(decode) decdata(buff,btf,encbuff);
     else encdata(buff,btf,encbuff);
    break;
   case 2:
    if(decode) decdata2(buff,btf,encbuff);
     else encdata2(buff,btf,encbuff);
    break;
   case 3:
    if(decode) dekeydata(buff,btf,password,encbuff);
     else keydata(buff,btf,password,encbuff);
    break;
   }
  statout=write(filehout,encbuff,btd);
  bd+=btd;
  if((statout<0)||((statout>0)&&(statout<btd))) doomed=2;
  clrscr();
  if(decode) printf(" Decriptare"); else printf(" Incriptare");
  printf(" n curs folosind %s",methname);
  printf("\n Octeti cititi de pe disc: %lu/%lu",bf,flen);
  printf("\n Octeti scrisi pe disk:    %lu/%lu",bd,flen);
  printf("\n Buffer brut umplut cu %u octeti!",btf);
  printf("\n Buffer prelucrat umplut cu %u octeti!",btd);
  }
  ok=(!doomed)&&(bf<flen);
  } while(ok);
 }
free(buff);
free(encbuff);
return doomed;
}




void mainmenu()
{
char opt=0;
do {
clrscr();
textcolor(15);
prglogo();
mmenulogo();
puts("");
cputs(" 1. Fisierul de intrare:");textcolor(15);cputs(fnamein);textcolor(7);puts("");
cputs(" 2. Fisierul de iesire:");textcolor(15);cputs(fnameout);textcolor(7);puts("");
cputs (" 3. Metoda de criptare:");textcolor(15);cputs(methname);textcolor(7);puts("");
puts (" 4. Info");
puts (" 5. Start");
puts (" 6. Iesire");
opt=getch()-48;
switch(opt)
 {
 case 1:
  gotoxy(25,10);
  gets(fnamein);
  set_flags|=SET_INPUT;
  break;
 case 2:
  gotoxy(24,11);
  gets(fnameout);
  set_flags|=SET_OUTPUT;
  break;
 case 3:
  selectmethod();
  set_flags|=SET_METHOD;
  break;
 case 4:
  break;
 case 5:
  stat=start();
  opt=EXIT;
  break;
 }
} while(opt!=EXIT);
}


void main()
{
int i=0;
directvideo=1;
initmenu();
mainmenu();
}

void clearmem(void)
{
free(fnamein);
free(fnameout);
free(methname);
puts("");
puts(" Multumesc pentru ca folositi Khrys-TIAN Encoder/Decoder v0.3!!!");
}


#pragma exit clearmem