/*  Please check card type according to the issuer-specified code.*/
/*测卡程序仅供参考，因为对102、1604、4442、4428等卡，都采用了厂商代码来
  作判断，但厂商代码不是唯一的。所以我们建议用户采用自己的系统标识来判别
  是否合法卡。*/



#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include "mwic.h"

#define ERR_CHECK         -0x85
#define OP_OK               0

#define CARD_24C01A	   1
#define CARD_24C02	   2
#define CARD_24C04	   3
#define CARD_4442      21
#define CARD_4428      31
#define CARD_4404      40
#define CARD_4406      41
#define CARD_102       51
#define CARD_1604      52
#define CARD_UNKNOW    0

int chk_up02(int icdev);
int chk_up04(int icdev);
int chk_up08(int icdev);

void main()
{
   int port=0;            /* init COM1 */
   int icdev;
   int st,status;

   clrscr();
   if((icdev=ic_init(port,9600l))<0)
     {printf("Init com err!%d\n",st);
      return;}
   printf("init com ok.\n");

   st=get_status(icdev,&status);
   if(st<0)
     {printf("Status err!,please insert card.\n"); return;}
   printf("get status ok.\n");

   st=chk_card(icdev);
   switch (st)
   {
      case  21: printf("sle4442 card.\n");break;
      case  31: printf("sle4428 card.\n");break;
      case  51: printf("at102  card.\n"); break;
      case  52: printf("at1604 card.\n"); break;
      case   0: printf("unknow card.\n"); break;
    }

}


int chk_card(int icdev)
{
	turn_off(icdev);
	if(chk_4404(icdev)==OP_OK) return CARD_4404;
	turn_off(icdev);
	if(chk_4406(icdev)==OP_OK) return CARD_4406;
	turn_off(icdev);
	if(chk_102(icdev)==OP_OK) return  CARD_102;
	turn_off(icdev);
	if(chk_1604(icdev)==OP_OK) return CARD_1604;
	turn_off(icdev);
	if(chk_4428(icdev)==OP_OK) return CARD_4428;
	turn_off(icdev);
	if(chk_4442(icdev)==OP_OK) return CARD_4442;
	turn_off(icdev);
	if(chk_24c04(icdev)==OP_OK) return CARD_24C04;
	turn_off(icdev);
	if(chk_24c02(icdev)==OP_OK) return CARD_24C02;
	turn_off(icdev);
	if(chk_24c01a(icdev)==OP_OK) return CARD_24C01A;
	turn_off(icdev);
	return CARD_UNKNOW;
}


int chk_4442(int icdev)
{	int i,st;
	unsigned char   data_buffer[8];
	//unsigned char   factory[]={0xa2,0x13,0x10,0x91,0x46,0x0b,0x81,0x15};
	unsigned char   factory[]={0x81,0x15};
	st=srd_4442(icdev,6,2,data_buffer);
	if(st!=OP_OK)	return(st);
	else
		for(i=0;i<2;i++)
			if(factory[i]!=data_buffer[i])	return ERR_CHECK;
	return(OP_OK);
}


int chk_4428(int icdev)
{	int i,st;
	unsigned char   data_buffer[4];
	unsigned char   factory[]={0x92,0x23,0x10,0x91};
	st=srd_4428(icdev,0,4,data_buffer);
	if(st!=OP_OK)	return(st);
	else
		for(i=0;i<4;i++)
			if(factory[i]!=data_buffer[i])	return(ERR_CHECK);
	return(OP_OK);
}


int chk_4404(int icdev)
{	int i,st;
	unsigned char   data_buffer[4];
	st=srd_4404(icdev,0,3,data_buffer);
	if(st!=OP_OK)	return(st);
	if(data_buffer[0]==0xb7&&data_buffer[1]==0xa0)
		return(OP_OK);
	if(data_buffer[0]==0x81 && data_buffer[1]==0x24)	return(OP_OK);
	return ERR_CHECK;
}

int chk_4406(int icdev)
{	int st,i;
	unsigned char   data_buffer[4];
	st=srd_4406(icdev,0,3,data_buffer);
	if(st!=OP_OK)	return(ERR_CHECK);
    if(data_buffer[0]==0x98&&data_buffer[1]==0x20&&data_buffer[2]==0xff)
		return OP_OK;
	if(data_buffer[2]==0x22)
		return(OP_OK);
	return(ERR_CHECK);
}

int chk_102(int icdev)
{
	int st;
	unsigned char temp0[3];
	unsigned char temp1[3]={0x0f,0x0f},temp2[3]={0x71,0x55};
	unsigned char temp3[2]={0x17,0xaa};
	st=srd_102(icdev,0,0,2,temp0);
	if(st!=OP_OK)	return(st);
	if((temp1[0]==temp0[0])&&(temp1[1]==temp0[1]))
		return OP_OK;
	if((temp2[0]==temp0[0])&&(temp2[1]==temp0[1]))
		return OP_OK;
	if((temp3[0]==temp0[0])&&(temp3[1]==temp0[1]))
		return OP_OK;
	return(ERR_CHECK);
}

int chk_1604(int icdev)
{       int i,st;
	unsigned char   temp1[]={0x31,0x3a};
	unsigned char   temp2[2];
	st=srd_1604(icdev,0,0,2,temp2);
	if(st!=OP_OK)	return(st);
	for(i=0;i<2;i++)
		if(temp1[i]!=temp2[i])	return(ERR_CHECK);
	return(OP_OK);
}

int chk_24c01a(int icdev)
{       int st;
	unsigned char   ch[1], ch1[1], ch2[3];
	st=srd_24c01a(icdev,127,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	ch1[0]=ch[0]+1;
	st=swr_24c01a(icdev,127,1,ch1);
	if(st!=OP_OK)
	{
		swr_24c01a(icdev,127,1,ch);
		return(ERR_CHECK);
	}
	st=srd_24c01a(icdev,127,1,ch2);
	if(st!=OP_OK)
	{
		swr_24c01a(icdev,127,1,ch);
		return(ERR_CHECK);
	}
	if(ch2[0]!=ch1[0])
	{
	    swr_24c01a(icdev,127,1,ch);
		return(ERR_CHECK);
	}
	st=swr_24c01a(icdev,127,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	if (chk_up02(icdev)==OP_OK) return(ERR_CHECK);
	return(OP_OK);
}

int chk_24c02(int icdev)
{
	int st;
	unsigned char   ch[2], ch1[2], ch2[3];
	st=srd_24c02(icdev,255,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	st=srd_24c02(icdev,127,1,ch1);
	if(st!=OP_OK)	return(ERR_CHECK);

	ch1[0]=ch1[0]+1;
	st=swr_24c02(icdev,255,1,ch1);
	if(st!=OP_OK)	
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
	st=srd_24c02(icdev,255,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}

	if(ch2[0]!=ch1[0])		
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
    st=srd_24c02(icdev,127,1,ch2);
	if(st!=OP_OK)
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
    if(ch2[0]==ch1[0])
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
	st=swr_24c02(icdev,255,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	if (chk_up04(icdev)==OP_OK) return(ERR_CHECK);
	return(OP_OK);
}
int chk_24c04(int icdev)
{       int st;
	unsigned char   ch[2], ch1[2], ch2[3];
	st=srd_24c04(icdev,511,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	st=srd_24c04(icdev,255,1,ch1);
	if(st!=OP_OK)	return(ERR_CHECK);

	ch1[0]=ch1[0]+1;
	st=swr_24c04(icdev,511,1,ch1);
	if(st!=OP_OK)	
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
	st=srd_24c04(icdev,511,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}

	if(ch2[0]!=ch1[0])		
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
    st=srd_24c04(icdev,255,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
    if(ch2[0]==ch1[0])
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
	st=swr_24c04(icdev,511,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	if (chk_up08(icdev)==OP_OK) return(ERR_CHECK);
	return(OP_OK);

}


int chk_up02(int icdev)
{
	int st;
	unsigned char   ch[2], ch1[2], ch2[3];
	st=srd_24c02(icdev,255,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	st=srd_24c02(icdev,127,1,ch1);
	if(st!=OP_OK)	return(ERR_CHECK);

	ch1[0]=ch1[0]+1;
	st=swr_24c02(icdev,255,1,ch1);
	if(st!=OP_OK)	
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
	st=srd_24c02(icdev,255,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}

	if(ch2[0]!=ch1[0])		
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
    st=srd_24c02(icdev,127,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
    if(ch2[0]==ch1[0])
	{
		swr_24c02(icdev,255,1,ch);
		return(ERR_CHECK);
	}
	st=swr_24c02(icdev,255,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	return(OP_OK);
}

int chk_up04(int icdev)
{       int st;
	unsigned char   ch[2], ch1[2], ch2[3];
	st=srd_24c04(icdev,511,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	st=srd_24c04(icdev,255,1,ch1);
	if(st!=OP_OK)	return(ERR_CHECK);

	ch1[0]=ch1[0]+1;
	st=swr_24c04(icdev,511,1,ch1);
	if(st!=OP_OK)	
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
	st=srd_24c04(icdev,511,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}

	if(ch2[0]!=ch1[0])		
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
    st=srd_24c04(icdev,255,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
    if(ch2[0]==ch1[0])
	{
		swr_24c04(icdev,511,1,ch);
		return(ERR_CHECK);
	}
	st=swr_24c04(icdev,511,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	return(OP_OK);

}

int chk_up08(int icdev)
{       int st;
	unsigned char   ch[2], ch1[2], ch2[3];
	st=srd_24c08(icdev,1023,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	st=srd_24c08(icdev,511,1,ch1);
	if(st!=OP_OK)	return(ERR_CHECK);

	ch1[0]=ch1[0]+1;
	st=swr_24c08(icdev,1023,1,ch1);
	if(st!=OP_OK)	
	{
		swr_24c08(icdev,1023,1,ch);
		return(ERR_CHECK);
	}
	st=srd_24c08(icdev,1023,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c08(icdev,1023,1,ch);
		return(ERR_CHECK);
	}

	if(ch2[0]!=ch1[0])		
	{
		swr_24c08(icdev,1023,1,ch);
		return(ERR_CHECK);
	}
    st=srd_24c08(icdev,511,1,ch2);
	if(st!=OP_OK)	
	{
		swr_24c08(icdev,1023,1,ch);
		return(ERR_CHECK);
	}
    if(ch2[0]==ch1[0])
	{
		swr_24c08(icdev,1023,1,ch);
		return(ERR_CHECK);
	}
	st=swr_24c08(icdev,1023,1,ch);
	if(st!=OP_OK)	return(ERR_CHECK);
	return(OP_OK);

}
