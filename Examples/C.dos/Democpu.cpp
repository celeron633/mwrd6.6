#include "stdio.h"
#include "string.h"
#include "mem.h"

extern int ic_init(int port,long baud);
extern int cpu_reset(int icdev,unsigned char *receive_data);
extern int cpu_protocol(int icdev,int len, unsigned char *send_data,unsigned char *receive_data);

main()
{
	int icdev,st,port;
	unsigned char icRead[200],icWrite[200];
	long baud;

		 port=1;
		 baud=9600;
		 if((icdev=ic_init(port,baud))<0)
		 {
				printf("ic_init ERR %d\n",icdev);
				return 1;
		 }

			memset(icRead,0xff,200);

		  if(cpu_reset(icdev,icRead)!=0)
        {
             printf("cpu_reset err\n");
        }
		  printf("\n\nReset:   ");

		  for(st=0;st<200;st++)
        {
			  if((icRead[st]==0xff)&&(icRead[st+1]==0xff)&&(icRead[st+2]==0xff))
			       break;
				printf("%02X",icRead[st]);
        }
		  printf("\n\n");
       
        icWrite[0]=0x00;    //nad
        icWrite[1]=0x40;    //pcb
		  icWrite[2]=5;       //len
		  icWrite[3]=0x00;    //get random
		  icWrite[4]=0x84;
        icWrite[5]=0x00;
        icWrite[6]=0x00;
		  icWrite[7]=0x08;
        icWrite[8]=0x00;     // init bcc
        for(st=0;st<8;st++)
				 icWrite[8]=icWrite[8]^icWrite[st];
       if(cpu_protocol(icdev,9,icWrite,icRead)!=0)
       {
            printf("transfer err/n");
            return 1;
       }  
		 printf("nad:  %02X\n",icRead[0]);
       printf("pcb:  %02X\n",icRead[1]);
       printf("len:  %d\n",icRead[2]);
		 printf("SW1SW2:  %02X%02X\n",icRead[icRead[2]+1],icRead[icRead[2]+2]);
		 printf("Data:  ");

		 for(st=0;st<icRead[2]-2;st++)
			  printf("%02X",icRead[st+3]);
			  printf("\n");

		return 1;
}
