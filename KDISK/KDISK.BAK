#include <io.h>
#include <bios.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <fcntl.h>
#include <string.h>
#include <iostream.h>
#include <sys\stat.h>

#define RESET 0
#define STATUS 1
#define READ 2
#define WRITE 3
#define VERIFY 4
#define FORMAT 5
#define SECTSIZE 512

#define part1offset 0x1be
#define part2offset 0x1ce
#define part3offset 0x1de
#define part4offset 0x1ee
#define syssignoffs 0x1fe


struct brutepartition
 {
 char bootind;
 char shead,ssect,scyl;
 char sysdescriptor;
 char ehead,esect,ecyl;
 long relsect;
 long numsect;
 };


struct softpartition
 {
 int bootind;
 long shead,ssect,scyl;
 int sysdescriptor;
 long ehead,esect,ecyl;
 long relsect;
 long numsect;
 char label[11];
 } soft[3];

struct mastermbr
 {
 char bootcode[0x1bd];
 brutepartition partition[3];
 unsigned int syssign;
 } mbr;





char *buff;

int nsects(int drive)
{
int status=0;
char *buf;
int nsectt[]={18,15,9},i=0;
buf=(char *)malloc(SECTSIZE);
biosdisk(RESET,drive,0,0,0,0,buf);
status=biosdisk(READ,drive,0,0,10,1,buf);
if (status==0x06) status=biosdisk(READ,drive,0,0,1,1,buf);
for(i=0;i<(sizeof(nsectt)/sizeof(int));++i)
 {
 biosdisk(RESET,drive,0,0,0,0,buf);
 status=biosdisk(READ,drive,0,0,nsectt[i],1,buf);
 if(status==0x06) status=biosdisk(READ,drive,0,0,nsectt[i],1,buf);
 if(status==0x00) break;
 }
free(buf);
return(nsectt[i]);
}


void fdtofile(int drive,char * filename)
{
char *buf=(char *)malloc(SECTSIZE);
int ns=0;
int fout=0,stat=0;
int sect=0,track=0,head=0;
float br=0,bw=0;
fout=open(filename,O_BINARY|O_CREAT|O_TRUNC|O_WRONLY);
if(fout>=0)
 {
stat=biosdisk(RESET,drive,0,0,0,0,buf);
if(!stat){
ns=nsects(drive);
while(track<80)
 {
for(sect=1;sect<=ns;sect++)
  {
  stat=biosdisk(READ,drive,head,track,sect,1,buf);
  if (stat!=0) exit(1);
  br+=512;
  clrscr();
  printf("Track: %d  Head: %d  Sector:  %d  (%d sectors/track)\n",track,head,sect,ns);
  printf("Bytes read from disk:     %f\n",br);
  _write(fout,buf,512);
  bw+=512;
  printf("Bytes written to file:    %f\n",bw);
  }
  head=head+1;
  if(!(head=head % 2)) {track++;}
  }
close(fout);
 } //sfarsit if(!stat)
} //sfarsit if(fout>=0)
free(buf);
}
void filetofd(int drive,char * filename)
{
char *buf;
int ns=0;
int fout=0,stat=0;
int sect=0,track=0,head=0;
float br=0,bw=0;
fout=open(filename,O_BINARY|O_RDONLY);
if(fout>=0)
 {
stat=biosdisk(RESET,drive,0,0,0,0,buf);
if(!stat){
ns=nsects(drive);
buf=(char *)malloc(SECTSIZE);
while(!eof(fout))
 {
for(sect=1;sect<=ns;sect++)
  {
  read(fout,buf,SECTSIZE);
  br+=SECTSIZE;
  clrscr();
  printf("Track: %d  Head: %d  Sector:  %d  (%d sectors/track)\n",track,head,sect,ns);
  printf("Bytes read from file:     %f\n",br);
  printf("Bytes written to disk:    %f\n",bw);
  stat=biosdisk(WRITE,drive,head,track,sect,1,buf);
  if (stat!=0) exit(1);
  bw+=SECTSIZE;
  }
  head=head+1;
  if(!(head=head % 2)) {track++;}

  }
close(fout); } //sfarsit if(!stat)
} //sfarsit if(fout>=0)
free(buf);
}


void readmbr(int drive)
{
char *cmbr=(char *)malloc(SECTSIZE);
biosdisk(RESET,drive,0,0,0,0,0L);
biosdisk(READ,drive,0,0,1,1,cmbr);
memcpy(&mbr.bootcode,&cmbr[0],0x1BD);///////////
memcpy(&mbr.partition[0],&cmbr[0x1BE],0x0F);////
memcpy(&mbr.partition[1],&cmbr[0x1CE],0x0F);////
memcpy(&mbr.partition[2],&cmbr[0x1DE],0x0F);////
memcpy(&mbr.partition[3],&cmbr[0x1EE],0x0F);////
memcpy(&mbr.syssign,&cmbr[0x1FE],0x02);/////////
biosdisk(RESET,drive,0,0,0,0,0L);
free(cmbr);
}
void btspart(int drive,brutepartition brute,softpartition &soft)
{
int bluh=0;
char *cfat=(char *)malloc(SECTSIZE);
soft.bootind=brute.bootind;
soft.shead=brute.shead;
//
soft.scyl=brute.ssect&(0xc0)<<2;
bluh=(brute.scyl&1)|(brute.scyl&2)|(brute.scyl&4)|(brute.scyl&8)|(brute.scyl&16)|(brute.scyl&32)|(brute.scyl&64)|(brute.scyl&128);
soft.scyl+=bluh;
//
soft.ssect=brute.ssect&(!(0xc0));
soft.sysdescriptor=brute.sysdescriptor;
soft.ehead=brute.ehead;
//
soft.ecyl=brute.esect&(0xc0)<<2;
bluh=(brute.ecyl&1)|(brute.ecyl&2)|(brute.ecyl&4)|(brute.ecyl&8)|(brute.ecyl&16)|(brute.ecyl&32)|(brute.ecyl&64)|(brute.ecyl&128);
soft.ecyl+=bluh;
//
soft.esect=brute.esect&(!(0xc0));
soft.relsect=brute.relsect;
soft.numsect=brute.numsect;
free(cfat);
}




int countparts()
{
int num=0;
while(mbr.partition[num].sysdescriptor) num++;
return num;
};


void showparttable(int drive)
{
readmbr(drive);
int numpart=countparts();
int i=0;
printf("Partition table (stripped from MBR):\n");
printf("ษออออหอออหออออออออออออหออออออออออหออออออออออหออออออออออป\n");
printf("บ ID บ A บ    Cyl     บ   Head   บ  S Sect  บ  Length  บ\n");
for(i=0;i<numpart;i++)
 {
printf("ฬออออฮอออฮออออออออออออฮออออออออออฮออออออออออฮออออออออออน\n");
printf("บ    บ   บ            บ          บ          บ          บ\n");
 }
printf("ศออออสอออสออออออออออออสออออออออออสออออออออออสออออออออออผ\n");
i=0;
for(i=0;i<numpart;i++)
 {
 btspart(drive,mbr.partition[i],soft[i]);
 gotoxy(4,5+i*2);cout<<soft[i].sysdescriptor;
 gotoxy(8,5+i*2);cout<<(soft[i].bootind!=0);
 gotoxy(12,5+i*2);cout<<soft[i].scyl<<", "<<soft[i].ecyl;
 gotoxy(25,5+i*2);cout<<soft[i].shead<<", "<<soft[i].ehead;
 gotoxy(36,5+i*2);cout<<soft[i].relsect;
 gotoxy(47,5+i*2);cout<<soft[i].numsect;
 }
gotoxy(1,5+(i+1)*2);
}


void mainmenu()
{
char ch=0;
char fn[128]="";
int drv=0;
int x=0,y=0;
showparttable(0x80);
printf("Main menu\n\n");
printf("1. Create image from FD\n");
printf("2. Dump image to FD\n");
printf("3. Exit\n");
x=wherex();
y=wherey();
while(ch!='3')
 {
 ch=getch();
 switch(ch)
  {
  case '1':
   {
   cout<<"File name:";cin>>fn;
   cout<<"Drive:";cin>>drv;
   if (drv<4) fdtofile(drv,fn); else cout<<"\nSupport for drives other than floppy-drives not supported yet";
   ch='3';
   break;
   }
  case '2':
   {
   cout<<"File name:";cin>>fn;
   cout<<"Drive:";cin>>drv;
   if (drv<4) filetofd(drv,fn); else cout<<"\nSupport for drives other than floppy-drives not supported yet";
   ch='3';
   break;
   }
  case '3': break;
  } //switch
 } //while
cout<<"\nThank you for using KDisk v0.1a";
}













void main()
{
clrscr();
mainmenu();
}