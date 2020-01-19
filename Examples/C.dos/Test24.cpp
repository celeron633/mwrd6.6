/* 
/* This sample test AT24 CARD */
#include "mwic.h"
#include "string.h"
#include "stdio.h"
#include "conio.h"
void main()
{
	int port=0;            /* init COM1 */
	int icdev;
	int st;
	int getsel;
	int times=0;
	clrscr();
	if((icdev=ic_init(port,9600L))<0)printf("init com err!");
	printf("1. test 24c01a card \n");
	printf("2. test 24c02 card \n");
	printf("3. test 24c04 card \n");
	printf("4. test 24c08 card \n");
	printf("5. test 24c016 card \n");
	printf("6. test 24c064 card \n");
	printf("please input chose:");
	scanf("%d",&getsel);
	switch(getsel){
	case 1:
	//********************************************************//
	printf("test function ---chk_24c01a()!\n\n");
	st=chk_24c01a(icdev);
	if(st!=0){
	   dv_beep(icdev,10);
	   printf(" It is not 24c01a__card!\n");
	   getchar();
	   break;
	}
	printf(" It is  24c01a__card!\n");
	getchar();

	//********************************************************//
	printf("test function ---swr_24c01a() !\n\n");
	unsigned char ch1[128], ch2[128];
	int i;
	for(i=0;i<128;i++)
		{
		ch1[i]='N';
		}
		while(!kbhit())
		{
		st=swr_24c01a(icdev,0,128,ch1);
		if(st!=0)
		  {printf("write wrong=%d",st);return;}
		st=srd_24c01a(icdev,0,128,ch2);
		if(st!=0)
		  {printf("read wrong=%d",st);return;}
		for(i=0;i<128;i++)
			if(ch1[i]!=ch2[i])
		       {printf("jaoyan wrong"); return;}
		printf("Ok_%d",times++);
		}
		break;
	case 2:
	//********************************************************//
	printf("test function ---chk_24c02()!\n\n");
	st=chk_24c02(icdev);
	if(st!=0){
	   dv_beep(icdev,10);
	   printf(" It is not 24c02__card!\n");
	   getchar();
	   break;
	}
	printf(" It is  24c02__card!\n");
	getchar();
	//********************************************************//
	printf("test function ---swr_24c02() !\n\n");
	unsigned char ch1_02[256], ch2_02[256];
	for(i=0;i<256;i++)
		{
		ch1_02[i]='N';
		}
		while(!kbhit())
		{
		st=swr_24c02(icdev,0,256,ch1_02);
		if(st!=0)
		  {printf("write wrong=%d",st);return;}
		st=srd_24c02(icdev,0,256,ch2_02);
		if(st!=0)
		  {printf("read wrong=%d",st);return;}
		for(i=0;i<256;i++)
			if(ch1_02[i]!=ch2_02[i])
		       {printf("jaoyan wrong"); return;}
		printf("Ok_%d",times++);
		}
	break;
	case 3:
	//********************************************************//
	printf("test function ---chk_24c04()!\n\n");
	st=chk_24c04(icdev);
	if(st!=0){
	   dv_beep(icdev,10);
	   printf(" It is not 24c04__card!\n");
	   getchar();
	   break;
	}
	printf(" It is  24c04__card!\n");
	getchar();
	//********************************************************//
	printf("test function ---swr_24c04() !\n\n");
	unsigned char ch1_04[512], ch2_04[512];
	for(i=0;i<512;i++)
		{
		ch1_04[i]='N';
		}
		while(!kbhit())
		{
		st=swr_24c04(icdev,0,512,ch1_04);
		if(st!=0)
		  {printf("write wrong=%d",st);return;}
		st=srd_24c04(icdev,0,512,ch2_04);
		if(st!=0)
		  {printf("read wrong=%d",st);return;}
		for(i=0;i<512;i++)
			if(ch1_04[i]!=ch2_04[i])
		       {printf("jaoyan wrong"); return;}
		printf("Ok_%d",times++);
		}

	break;
	case 4:
	//********************************************************//
	printf("test function ---chk_24c08()!\n\n");
	st=chk_24c08(icdev);
	if(st!=0){
	   dv_beep(icdev,10);
	   printf(" It is not 24c08__card!\n");
	   getchar();
	   break;
	}
	printf(" It is  24c08__card!\n");
	getchar();
	//********************************************************//
	printf("test function ---swr_24c08() !\n\n");
	unsigned char ch1_08[1024], ch2_08[1024];
	for(i=0;i<1024;i++)
		{
		ch1_08[i]='N';
		}
		while(!kbhit())
		{
		st=swr_24c08(icdev,0,1024,ch1_08);
		if(st!=0)
		  {printf("write wrong=%d",st);return;}
		st=srd_24c08(icdev,0,1024,ch2_08);
		if(st!=0)
		  {printf("read wrong=%d",st);return;}
		for(i=0;i<1024;i++)
			if(ch1_08[i]!=ch2_08[i])
		       {printf("jaoyan wrong"); return;}
		printf("Ok_%d",times++);
		}

	break;
	case 5:
	//********************************************************//
	printf("test function ---chk_24c16()!\n\n");
	st=chk_24c16(icdev);
	if(st!=0){
	   dv_beep(icdev,10);
	   printf(" It is not 24c16__card!\n");
	   getchar();
	   break;
	}
	printf(" It is  24c16__card!\n");
	getchar();
	//********************************************************//
	printf("test function ---swr_24c16() !\n\n");
	unsigned char ch1_16[2048], ch2_16[2048];
	for(i=0;i<2048;i++)
		{
		ch1_16[i]='N';
		}
		while(!kbhit())
		{
		st=swr_24c16(icdev,0,2048,ch1_16);
		if(st!=0)
		  {printf("write wrong=%d",st);return;}
		st=srd_24c16(icdev,0,2048,ch2_16);
		if(st!=0)
		  {printf("read wrong=%d",st);return;}
		for(i=0;i<2048;i++)
			if(ch1_16[i]!=ch2_16[i])
		       {printf("jaoyan wrong"); return;}
		printf("Ok_%d",times++);
		}

	break;
	case 6:
	//********************************************************//
	printf("test function ---chk_24c64()!\n\n");
	st=chk_24c64(icdev);
	if(st!=0){
	   dv_beep(icdev,10);
	   printf(" It is not 24c64__card!\n");
	   getchar();
	   break;
	}
	printf(" It is  24c64__card!\n");
	getchar();
	//********************************************************//
	printf("test function ---swr_24c64() !\n\n");
	unsigned char ch1_64[8192], ch2_64[8192];
	for(i=0;i<8192;i++)
		{
		ch1_64[i]='N';
		}
		while(!kbhit())
		{
		st=swr_24c64(icdev,0,8192,ch1_64);
		if(st!=0)
		  {printf("write wrong=%d",st);return;}
		st=srd_24c64(icdev,0,8192,ch2_64);
		if(st!=0)
		  {printf("read wrong=%d",st);return;}
		for(i=0;i<8192;i++)
			if(ch1_64[i]!=ch2_64[i])
		       {printf("jaoyan wrong"); return;}
		printf("Ok_%d",times++);
		}
      break;
    }

 //***********************************************************//
       getchar();
       auto_pull(icdev);
       return;


}
