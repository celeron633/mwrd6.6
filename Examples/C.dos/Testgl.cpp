/* create a project file include this program and mwicl.lib,then build all */
/* This sample test IC_DEVICE. */
#include "mwic.h"
#include "string.h"
#include "conio.h"
#include "stdio.h"
void main()
{
        int port=0;               /* init COM1 */
	int icdev;
	int st;
	clrscr();

        if((icdev=ic_init(port,9600l))<0)printf("init com err!");
	//********************************************************//
	printf("test function ---get_status()!\n\n");
	int cardsta;
	st=get_status(icdev,&cardsta);
	if(st!=0){
	   printf(" no connect IC_device!\n");
	   getchar();
	   return;
	}
	if(cardsta==0)
	   printf("IC_devic no card !\n");
	else
	   printf("IC_devic have card !\n");
	getchar();
	//********************************************************//
	printf("test function ---beep() !\n\n");
	st=dv_beep(icdev,10);
	if(st!=0){
	printf("beep err!\n");
	getchar();
	return;
	}
	printf("beep ok!\n");
	getchar();

	//********************************************************//
	printf("test function ---swr_dvsc() !\n\n");
	unsigned char *passbuffer="csy";
	st=swr_dvsc(icdev,3,passbuffer);
	if(st!=0){
	printf("write dev_pass err!\n");
	getchar();
	return;
	}
	printf(" Write dev_pass ok,Don,t lost it !!!\n");
	getchar();
	//********************************************************//
	printf("test function ---srd_dvsc() !\n\n");
	unsigned char readpassbuffer[4];
	st=srd_dvsc(icdev,3,readpassbuffer);
	if(st!=0){
	printf("read dev_pass err!\n");
	getchar();
	return;
	}
	readpassbuffer[3]='\0';
	printf(" Read dev_pass ok,The string is \"%s\",Don't lost it !\n",readpassbuffer);
	getchar();
	//********************************************************//
	printf("test function ---cmp_dvsc() !\n\n");
	unsigned char *cmppassbuffer="csy";
	st=cmp_dvsc(icdev,3,cmppassbuffer);
	if(st!=0){
	printf("cmp dev_pass err!\n");
	getchar();
	return;
	}
	printf(" cmp dev_pass ok!\n");
	getchar();
	//********************************************************//
	printf("test function ---setsc_md() !\n\n");
	st=setsc_md(icdev,1);
	if(st!=0){
	printf("set dev_pass mode err!\n");
	getchar();
	return;
	}
	printf(" set dev_pass mode is OFF !\n");
	getchar();
	//********************************************************//
	printf("test function ---turn_off() !\n\n");
	st=turn_off(icdev);
	if(st!=0){
	printf("turn off err!\n");
	getchar();
	return;
	}
	printf(" trun off ok!\n");
	getchar();
	//********************************************************//
	printf("test function ---turn_on() !\n\n");
	st=turn_on(icdev);
	if(st!=0){
	printf("turn on err!\n");
	getchar();
	return;
	}
	printf(" trun on ok!\n");
	getchar();
	//********************************************************//

	printf("test function ---auto_pull() !\n\n");
	st=auto_pull(icdev);
	if(st!=0){
	printf("pull card err!\n");
	getchar();
	return;
	}
	printf(" pull card ok!\n");
	getchar();


	//********************************************************//
	dv_beep(icdev,30);
	printf("press any key return !\n");
	getchar();
}
