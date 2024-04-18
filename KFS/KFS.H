#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <dos.h>
#include <bios.h>
#include <io.h>
#include <errno.h>
#include <fcntl.h>
#include <ctype.h>
#include <string.h>
#include <mem.h>
#include <sys\stat.h>

typedef unsigned char byte;
typedef signed char shortint;
typedef unsigned int word;
typedef unsigned long dword;

#define MAXFILENUM 2550

struct kfsheader
 {
 byte    pdisk;
 dword   numfiles;
 char label[11];
 word integrity;
 dword start;
 dword length;
 dword fileaddr[MAXFILENUM][2];
 byte reserved[54];
 } kfsb;

struct fileheader
 {
 word signature;
 dword filenum;
 char fname[256];
 char owner[64];
 char group[64];
 char access[16];
 dword length;
 char reserved[102];
 };




void initkfs(kfsheader &kfsh)
{
memset(&kfsh,0,sizeof(kfsh));
memset(&kfsh.fileaddr,0,sizeof(kfsh.fileaddr));
}
void initfh(fileheader &fh)
{
memset(&fh,0,sizeof(fh));
}

void setkfslabel(kfsheader &kfsh,char *label)
{
memcpy(&kfsh.label[0],label,strlen(label)>10?10:strlen(label));
memset(&kfsh.label[10],0,1);
}




void writekfsheader(kfsheader kfsh,char *filename)
{
int fileh=0;
int stat=0,doomed=0;
void *pkfs;
dword btd=0,bd=0,kfslen=sizeof(kfsh);
fileh=open(filename,O_BINARY|O_CREAT|O_WRONLY);
if (fileh>0)
 {
 pkfs=&kfsh;
 lseek(fileh,0,0);
 do {
 btd=(kfslen-bd>512)?512:(kfslen-bd);
 stat=_write(fileh,pkfs,btd);
 pkfs=&pkfs+btd;
 bd+=btd;
 if(doomed=((stat<0)||((stat>0)&&(stat!=btd))))
  {
  fprintf(stderr,"\nwritekfsheader() :: Error occured while dumping KFS Header to disk! (# %d)\n",stat);
  if(errno==EACCES) fprintf(stderr,"\n writekfsheader() :: Access denied!!! (# %d)\n",errno);
  if(errno==EBADF) fprintf(stderr,"\n writekfsheader() :: Invalid file handle!!! (# %d)\n",errno);
  }
 } while((bd<kfslen)&&(!doomed));
 fprintf(stderr,"\nwritekfsheader() :: Bytes dumped to disk: %u",bd);
 fprintf(stderr,"\nwritekfsheader() :: Bytes queued: %u",kfslen);
 close(fileh);
 } else fprintf(stderr,"\nwritekfsheader() :: Error while opening KFS Volume!\n"); //(if (fileh>0))
}


void readkfsheader(kfsheader &kfshh,char *filename)
{
int fileh=0;
int stat=0,doomed=0;
int btd=0,bd=0;
int kfslen=sizeof(kfsheader);
void *pkfs,*buf;
struct kfsheader kfsh;
initkfs(kfsh);
initkfs(kfshh);
fileh=open(filename,O_RDONLY);
if(fileh>0)
 {
 buf=&kfsh;
 pkfs=&kfsh;
 do {
 btd=(kfslen-bd>512)?512:(kfslen-bd);
 stat=read(fileh,buf,btd);
 buf=&buf+btd;
 bd+=btd;
 if(doomed=((stat<0)||((stat>0)&&(stat!=btd))))
  {
  fprintf(stderr,"\nreadkfsheader() :: Error occured while feeding KFS Header from disk! (# %d)\n",stat);
  if(errno==EACCES) fprintf(stderr,"\nreadkfsheader() :: Access denied!!! (# %d)\n",errno);
  if(errno==EBADF) fprintf(stderr,"\nreadkfsheader() :: Invalid file handle!!! (# %d)\n",errno);
  }
 } while((bd<kfslen)&&(!doomed));
 fprintf(stderr,"\nreadkfsheader() :: Bytes dumped from disk: %u",bd);
 fprintf(stderr,"\nreadkfsheader() :: Bytes queued: %u",kfslen);
 close(fileh);
 kfshh=*(kfsheader *)pkfs;
 } else fprintf(stderr,"\nreadkfsheader() :: Error while opening KFS Volume!\n"); //(if (fileh>0))
}




void setfilename(fileheader &fh,char *fname)
{
memcpy(&fh.fname[0],fname,strlen(fname)>254?254:strlen(fname));
memset(&fh.fname[255],0,1);
}
void setfileowner(fileheader &fh,char *owner)
{
memcpy(&fh.owner[0],owner,strlen(owner)>62?62:strlen(owner));
memset(&fh.owner[63],0,1);
}
void setfilegroup(fileheader &fh,char *group)
{
memcpy(&fh.group[0],group,strlen(group)>62?62:strlen(group));
memset(&fh.group[63],0,1);
}
setfileaccess(fileheader &fh,char *main,char *owner,char *group,char *user)
{
memcpy(&fh.access[0],main,strlen(main)>1?1:strlen(main));
memcpy(&fh.access[1],owner,strlen(owner)>4?4:strlen(owner));
memcpy(&fh.access[5],group,strlen(group)>4?4:strlen(group));
memcpy(&fh.access[9],user,strlen(user)>4?4:strlen(user));
memset(&fh.access[13],0,3);
}


dword next_free_filenum(kfsheader kfsh)
{
dword fn=0;
if(kfsh.integrity==0x4e4b)
 {
 if(kfsh.numfiles==MAXFILENUM) return MAXFILENUM+1;
 while(kfsh.fileaddr[fn][0]!=0) fn++;
 return fn;
 } else {fprintf(stderr,"\nnext_free_filenum() :: Invalid KFS Volume! Run check_kfs!\n");} //if(validkfs)
} /**************** END ***********************/
dword max_file_num(kfsheader kfsh)
{
dword max=0;
if(kfsh.integrity==0x4e4b)
 { max=MAXFILENUM;
 while(kfsh.fileaddr[max]==0) max--;
 return max;
 } else {fprintf(stderr,"\nmax_filenum() :: Invalid KFS Volume! Run check_kfs!\n");} //if(validkfs)
} /**************** END ***********************/
dword next_free_space(kfsheader kfsh)
{
dword max=0,maxi=0,fmax=max_file_num(kfsh);
dword i=1;
max=kfsh.fileaddr[0][0];
maxi=0;
if(kfsh.integrity==0x4e4b)
 {
 for(i=1;i<fmax;i++)
  {
  if(max<kfsh.fileaddr[i][0]) {max=kfsh.fileaddr[i][0];maxi=i;}
  }
 if(max==0) max=kfsh.start; else max+=kfsh.fileaddr[maxi][1];
 if(max==0) {fprintf(stderr,"\nnext_free_space() :: Invalid KFS Volume! Run check_kfs!\n");}
 return max;
 } else {fprintf(stderr,"\nnext_free_space() :: Invalid KFS Volume! Run check_kfs!\n");} //if(validkfs)
} /**************** END ***********************/




dword add_file_entry(kfsheader &kfsh,dword filenum)
{
if(kfsh.integrity==0x4e4b)
 {
 if((kfsh.fileaddr[filenum][0]==0)&&(kfsh.fileaddr[filenum][1]==0))
  {
  kfsh.fileaddr[filenum][0]=next_free_space(kfsh);
  kfsh.fileaddr[filenum][1]=0;
  return filenum;
  } else {fprintf(stderr,"\nadd_file_entry() :: File slot occupied!\n"); return 0xf000;} //if(slottaken)
 } else {fprintf(stderr,"\nadd_file_entry() :: Invalid KFS Volume! Run check_kfs!\n");return 0xf001;} //if(validkfs)
}


void create_file(char *kfsvol,kfsheader &kfsh,void *buff,dword buflen)
{
int stat=0;
int fileh=0,doomed=0;
int kfslen=sizeof(kfsh);
int btd=0,bd=0;
struct fileheader fh;
void *pfh;
pfh=&fh;
if(kfsh.integrity==0x4e4b)
 {
 initfh(fh);
 fh.filenum=next_free_filenum(kfsh);
 if(fh.filenum!=MAXFILENUM+1)
  {
  stat=add_file_entry(kfsh,fh.filenum);
  if(stat!=0xf000)
   {
   setfilename(fh,"test.fil");
   setfileowner(fh,"root");
   setfilegroup(fh,"root");
   setfileaccess(fh,"","rwx","rwx","r");
   fh.length=buflen;
   fh.signature='KN';
   kfsh.fileaddr[fh.filenum][1]=buflen+sizeof(fh);
   kfsh.numfiles++;
   writekfsheader(kfsh,kfsvol);
   fileh=open(kfsvol,O_BINARY|O_CREAT|O_RDWR);
   if(fileh>0)
    {
    lseek(fileh,kfsh.fileaddr[fh.filenum][0],0);
    stat=_write(fileh,pfh,sizeof(fh));
    if(doomed=((stat<0)||((stat>0)&&(stat!=sizeof(fh)))))
     {fprintf(stderr,"\ncreate_file() :: Error occured while dumping file header to disk!\n");}
    if(!doomed)
     {
     doomed=0;
     do {
     btd=(buflen-bd>512)?512:(buflen-bd);
     stat=_write(fileh,buff,btd);
     if(doomed=((stat<0)||((stat>0)&&(stat!=btd))))
      {fprintf(stderr,"\ncreate_file() :: Error occured while dumping file content to disk!\n");}
     buff=&buff+btd;
     bd+=btd;
     } while((bd<buflen)&&(!doomed));
     fprintf(stderr,"\n create_file() :: Bytes dumped to disk: %u",bd);
     fprintf(stderr,"\n create_file() :: Bytes queued: %u",buflen);
     }
    close(fileh);
    } else {fprintf(stderr,"\ncreate_file() :: Error while opening KFS Volume\n");} //if(fileh>0)
   } else {fprintf(stderr,"\ncreate_file() :: File slot occupied\n");} //if(eroarelaaddentry)
  } else {fprintf(stderr,"\ncreate_file() :: Max file number available reached! Create new KFS Volume!!!\n");} //if(maisuntsloturi)
 } else {fprintf(stderr,"\ncreate_file() :: Invalid KFS Volume! Run check_kfs!\n");} //if(validkfs)
}



void delete_file(char *kfsvol,kfsheader &kfsh,dword filenum)
{
int stat=0;
int fileh=0,doomed=0;
dword kfslen=sizeof(kfsheader);
dword faddr=0,flen=0;
dword btd=0,bd=0;
void *pbuf=malloc(512);
memset(pbuf,0,512);
if(kfsh.integrity==0x4e4b)
 {
 faddr=kfsh.fileaddr[filenum][0];
 flen=kfsh.fileaddr[filenum][1];
 if(faddr&&flen)
  {
  kfsh.fileaddr[filenum][0]=0;
  kfsh.fileaddr[filenum][1]=0;
  kfsh.numfiles--;
  writekfsheader(kfsh,kfsvol);
  fileh=open(kfsvol,O_BINARY|O_RDWR);
  if(fileh>0)
   {
   lseek(fileh,faddr,0);
   do {
   btd=(flen-bd>512)?512:(flen-bd);
   stat=_write(fileh,pbuf,btd);
   if(doomed=((stat<0)||((stat>0)&&(stat!=btd))))
    {fprintf(stderr,"\ncreate_file() :: Error occured while dumping file content to disk!\n");}
   bd+=btd;
   } while((bd<flen)&&(!doomed));
   fprintf(stderr,"\ndelete_file() :: Bytes dumped to disk: %u",bd);
   fprintf(stderr,"\ndelete_file() :: Bytes queued: %u",flen);
   close(fileh);
   } else {fprintf(stderr,"\ndelete_file() :: Error while opening KFS Volume!\n");}//if(fileh>0)
  } else {fprintf(stderr,"\ndelete_file() :: Invalid file address or length for file #:%lu",filenum);} //if(faddr&&flen)
 } else {fprintf(stderr,"\ndelete_file() :: Invalid KFS Volume! Run check_kfs!\n");} //if(validkfs)
free(pbuf);
}

dword check_dest(kfsheader kfsh,dword topos,dword filenum)
{
dword i=0;
dword fmax=max_file_num(kfsh);
dword doomed=0;
if(topos<sizeof(kfsheader)) return 0x0001;
while(i<fmax)
 {
 if(i!=filenum)
  {
  if((topos<=kfsh.fileaddr[i][0])&&(topos+kfsh.fileaddr[filenum][1]>=kfsh.fileaddr[i][0]))
   return 0x0f03;
  if((topos>=kfsh.fileaddr[i][0])&&(topos<=kfsh.fileaddr[i][1]))
   return 0x0f04;
  }
 i++;
 }
return 0x0000;
}


void move_file(char *kfsvol,kfsheader kfsh,dword filenum,dword topos)
{
int stat=0;
int fileh=0,doomed=0;
dword kfslen=sizeof(kfsheader);
int faddr=0,flen=0;
int btf=0,bf=0;
int btd=0,bd=0;
void *pbuf;
if(kfsh.integrity==0x4e4b)
 {
 faddr=kfsh.fileaddr[filenum][0];
 flen=kfsh.fileaddr[filenum][1];
 if(faddr&&flen)
  {
  if(topos!=faddr) {
  if(!(stat=check_dest(kfsh,topos,filenum)))
   {
   kfsh.fileaddr[filenum][0]=topos;
   kfsh.fileaddr[filenum][1]=flen;
   writekfsheader(kfsh,kfsvol);
   fileh=open(kfsvol,O_BINARY|O_RDWR);
   if(fileh>0)
    {
    pbuf=malloc(512);
    do {
    memset(pbuf,0,512);
    btf=(flen-bf>512)?512:(flen-bf);
    lseek(fileh,(topos<faddr)?faddr+bf:(faddr+flen-bf-btf),0);
    stat=_read(fileh,pbuf,btf);
    if(doomed=((stat<0)||((stat>0)&&(stat!=btf)))){fprintf(stderr,"\nmove_file() :: Error occured while dumping file content to disk!\n");}
    bf+=stat;
    if(!doomed){
    btd=btf;
    lseek(fileh,(topos<faddr)?topos+bd:(topos+flen-bd-btd),0);
    stat=_write(fileh,pbuf,btd);
    if(doomed=((stat<0)||((stat>0)&&(stat!=btd)))){fprintf(stderr,"\nmove_file() :: Error occured while dumping file content to disk!\n");}
    bd+=stat;}
    } while((bd<flen)&&(!doomed));
    fprintf(stderr,"\nmove_file() :: Bytes fed from disk: %u",bf);
    fprintf(stderr,"\nmove_file() :: Bytes dumped to disk: %u",bd);
    fprintf(stderr,"\nmove_file() :: Bytes queued: %u",flen);
    free(pbuf);
    close(fileh);
   } else {fprintf(stderr,"\nmove_file() :: Error while opening KFS Volume!\n");}//if(fileh>0)
  } else {  // de la if(check_dest(...))
     if(stat==0x0001) fprintf(stderr,"\nmove_file() :: Cannot move a file over the system area!\n");
     if(stat==0x0f03) fprintf(stderr,"\nmove_file() :: Cannot move a file over an existing file!\n");
     if(stat==0x0f04) fprintf(stderr,"\nmove_file() :: Cannot move a file over an existing file!\n");
     }
  } else {fprintf(stderr,"\nmove_file() :: Cannot move a file over itself!\n");} //if(topos<faddr)
  } else {fprintf(stderr,"\nmove_file() :: Invalid file address or length for file #:%lu",filenum);} //if(faddr&&flen)
 } else {fprintf(stderr,"\nmove_file() :: Invalid KFS Volume! Run check_kfs!\n");} //if(validkfs)
}