#include "bigcrt.h"
#include <stdio.h>
#include <conio.h>
#include <time.h>

void main()
{
char *boo=(char *)malloc(120);
memset(boo,0,120);
init_video(crt132x25);
c_Y=1;
while(!kbhit())
 {
 randomize();
 sprintf(boo,"welcome%lu",time((long *)c_Y));
 kputs(3,1,boo);
 c_Y++;
 }
free(boo);
}