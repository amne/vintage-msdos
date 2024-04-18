#include "kfs.h"


void *test="This is no longer working I guess but if shut your computer down then u probably saw this: fuck your motherfucking asshole,u pityful excuse for a man!!!!!!!!!!";

void main()
{
initkfs(kfsb);
/*kfsb.pdisk=0;
kfsb.numfiles=0;
setkfslabel(kfsb,"KFSTEST");
kfsb.integrity='KN';
kfsb.start=sizeof(kfsb);
kfsb.length=sizeof(kfsb);
writekfsheader(kfsb,"test.kfs");/**/
clrscr();
readkfsheader(kfsb,"test.kfs");
printf("\nSignature: %X",kfsb.integrity);
printf("\nLabel: %s",&kfsb.label[0]);
printf("\nStart: %lu",kfsb.start);
printf("\nLength: %lu",kfsb.length);
printf("\nNumFiles: %lu",kfsb.numfiles);
printf("\nNext free space: %u\n",next_free_space(kfsb));/**/
/*create_file("test.kfs",kfsb,test,159);/**/
/*delete_file("test.kfs",kfsb,1);/**/
/*move_file("test.kfs",kfsb,0,20480);/**/
}