#include "stdio.h"
#include "mwic_ux.h"

extern int  ic_encrypt( char *key,char *ptrSource, unsigned int msgLen, char *ptrDest);
extern ic_decrypt( char *key,char *ptrSource, unsigned int msgLen, char *ptrDest);
extern cpu_reset(int icdev,unsigned char *receive_data);
extern cpu_protocol(int icdev,int len, unsigned char *send_data,unsigned char *receive_data);


void main()
{
	int icdev,st,icReadLen,icWriteLen,icSCLen,icESCLen,icSCct,icESCct;
	unsigned char CardType[20],icState[20],icSC[20],icESC[20];
	unsigned char ricSCct[20],ricESCct[20],dvsc[10];
	unsigned char icRead[2000],icWrite[2000];
        long baud;        
        
        ic_encrypt("1234567812345678","abcdefghijklmnopqrst",16,(char *)icRead);
        printf("ic_encrypt: %s\n",(char *)icRead);

        ic_decrypt("1234567812345678",(char *)icRead,16,(char *)icWrite);
        printf("ic_decrypt: %s\n",(char *)icWrite);
     

	if((icdev=auto_init("star500x",9600))<0)
	{
	     printf("auto_init ERR %d\n",icdev);
       	     return;
	}

        memset(icRead,0xff,200);
        if(cpu_reset(icdev,icRead)!=0)
        {
             printf("cpu_reset err\n");
             ic_exit(icdev);
        }
        printf("\nReset:   ");
        for(st=0;st<200;st++)
        {
            if((icRead[st]==0xff)&&(icRead[st+1]==0xff)&&(icRead[st+2]==0xff))
                break;
            printf("%02X",icRead[st]);
        }
        printf("\n");
       
//get random
        icWrite[0]=0x00;    //nad
        icWrite[1]=0x40;    //pcb
        icWrite[2]=5;       //len
        icWrite[3]=0x00;
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
            ic_exit(icdev);
            return;
       }  
       printf("nad:  %02X\n",icRead[0]); 
       printf("pcb:  %02X\n",icRead[1]);
       printf("len:  %d\n",icRead[2]);
       printf("SW1SW2:  %02X%02X\n",icRead[icRead[2]+1],icRead[icRead[2]+2]);
       printf("Data:  ");
       for(st=0;st<icRead[2]-2;st++)
           printf("%02X",icRead[st+3]);
       ic_exit(icdev);
       printf("\n");
       return;  

}


