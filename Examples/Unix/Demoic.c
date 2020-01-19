#include "stdio.h"
#include "mwic_ux.h"

main()
{
	int icdev,st,icReadLen,icWriteLen,icSCLen,icESCLen,icSCct,icESCct,number;
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
       
        dv_beep(icdev,30);

        memcpy(dvsc,"\xff\xff\xff",3);
        if(cmp_dvsc(icdev,3,dvsc)!=0)
        {
            printf("cmp_dvsc ERR\n");
            ic_exit(icdev);
            return;
        }
        printf("cmp_dvsc OK\n");

        if(srd_dvsc(icdev,3,dvsc)!=0)
        {
             printf("srd_dvsc ERR\n");
             ic_exit(icdev);
             return;
         }
         printf("dvsc(HEX) = %2X%2X%2X\n",dvsc[0],dvsc[1],dvsc[2]);
        
         
        printf("1---AT24C01A\n");
        printf("2---AT24C02 \n");
        printf("3---AT24C04 \n");
        printf("4---AT24C16 \n");
        printf("5---AT24C64 \n");
        printf("6---AT45D041\n");
        printf("7---SLE4442 \n");
        printf("8---SLE4428 \n");
        printf("9---AT1604  \n");
        scanf("%d",&number);

	switch(number)
	{
	
	case 1:
		printf("CARD_24C01A\n");
		icReadLen=128;
		icWriteLen=128;
		memset(icWrite,'1',icWriteLen);
		if(swr_24c01a(icdev,0, icReadLen, icWrite)!=0)
		{
			printf("swr_24c01a ERR\n");
			break;
		}
		printf("swr_24c01a OK\n");

		if(srd_24c01a(icdev,0, icReadLen, icRead)!=0)
		{
		    printf("swr_24c01a ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		break;	
	case 2:
		printf("CARD_24C02\n");
		icReadLen=256;
		icWriteLen=256;
		memset(icWrite,'2',icWriteLen);
		if(swr_24c02(icdev,0, icReadLen, icWrite)!=0)
		{
			printf("swr_24c02 ERR\n");
			break;
		}
		printf("swr_24c02 OK\n");

		if(srd_24c02(icdev,0, icReadLen, icRead)!=0)
		{
		    printf("swr_24c02 ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		break;	
	case 3:
		printf("CARD_24C04\n");
		icReadLen=512;
		icWriteLen=512;
		memset(icWrite,'4',icWriteLen);
		if(swr_24c04(icdev,0, icReadLen, icWrite)!=0)
		{
			printf("swr_24c04 ERR\n");
			break;
		}
		printf("swr_24c04 OK\n");

		if(srd_24c04(icdev,0, icReadLen, icRead)!=0)
		{
		    printf("srd_24c04 ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		break;	
	
	case 4:
		printf("CARD_24C16\n");
		icReadLen=180;
		icWriteLen=180;
		memset(icWrite,'A',icWriteLen);
		if(swr_24c16(icdev,0, icReadLen, icWrite)!=0)
		{
			printf("swr_24c16 ERR\n");
			break;
		}
		printf("swr_24c16 OK\n");

		if(srd_24c16(icdev,0, icReadLen, icRead)!=0)
		{
		    printf("srd_24c16 ERR\n");
			break;
		}      
                 
		printf("Read data: %s\n",icRead);
		break;	
	
	case 5:
		printf("CARD_24C64\n");
		icReadLen=180;
		icWriteLen=180;
		memset(icWrite,'C',icWriteLen);
		if((st=swr_24c64(icdev,0, icReadLen, icWrite))!=0)
		{
			printf("swr_24c64 ERR=%d\n",st);
			break;
		}
		printf("swr_24c64 OK\n");

		if(srd_24c64(icdev,0, icReadLen, icRead)!=0)
		{
		    printf("srd_24c64 ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		break;	

	case 6:
		printf("CARD_45D041\n");
		icReadLen=180;
		icWriteLen=180;
		memset(icWrite,'5',icWriteLen);
		if(swr_45d041(icdev,0,0,icReadLen, icWrite)!=0)
		{
			printf("swr_45d041 ERR\n");
			break;
		}
		printf("swr_45d041 OK\n");

		if(srd_45d041(icdev,0,0,icReadLen, icRead)!=0)
		{
		    printf("srd_45d041 ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		break;	

	case 7:
		printf("CARD_4442\n");
		icReadLen=256-32;
		icWriteLen=256-32;
                memcpy(icSC,"\xb6\x23\x07",3);
		if(csc_4442(icdev,3, icSC)!=0)
		{
			printf("csc_4442 ERR\n");
			break;
       		}
		else printf("csc_4442 OK\n");

		if(rsct_4442(icdev,&icSCct)!=0)
		{
		    printf("rec_4442 ERR\n");
			break;
		}
		else printf("rsct_4442 OK\n");
		printf("The counter is: %d\n",icSCct);

		memset(icWrite,'2',icWriteLen);
		if(swr_4442(icdev,32,icWriteLen,icWrite)!=0)
		{
			printf("swr_4442 ERR\n");
			break;
		}
                printf("swr_4442 OK\n");  
		if(srd_4442(icdev,32,icReadLen,icRead)!=0)
		{
			printf("srd_4442 ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		if(srd_4442(icdev,20,2,icRead)!=0)
		{
			printf("Read protected data ERR\n");
			break;
		}
		if(pwr_4442(icdev,20,2,icRead)!=0)
		{
			printf("pwr_4442 ERR\n");
			break;
		}
		printf("pwr_4442 OK\n");
		if(prd_4442(icdev,4,icRead)!=0)
		{
			printf("prd_4442 ERR\n");
			break;
		}
		printf("The protected flag is:");
		printf("%2X",icRead[0]); printf("%2X",icRead[1]);
		printf("%2X",icRead[2]); printf("%2X\n",icRead[3]);
		break;
	
	case 8:
		printf("CARD_4428\n");
		icReadLen=256;
		icWriteLen=256;
		icSC[0] = 0x67; 
                icSC[1] = 0xc6;
		if(csc_4428(icdev,2, icSC)!=0)
		{
			printf("csc_4428 ERR\n");
			break;
		}
		else printf("csc_4428 OK\n");
		if(rsct_4428(icdev,&icSCct)!=0)
		{
		    printf("rec_4428 ERR\n");
			break;
		}
		else printf("rsct_4428 OK\n");
		printf("The counter is: %d\n",icSCct);
		if(srd_4428(icdev,0,icReadLen,icRead)!=0)
		{
			printf("srd_4428 ERR\n");
			break;
		}
                printf("Read data: "); 
                for(st=0;st<icReadLen;st++)
                {
		     printf("%2x",icRead[st]);
                }
                printf("\n");
		memset(icWrite,'2',icWriteLen);
		if(rdwpb_4428(icdev,55,1,icRead)!=0)
		{
		     printf("rdwpb_4428 ERR\n");
			 break;
		}
		printf("rdwpb_4428 OK, ");
                printf("The data is:%2X ,",icRead[0]);
                printf("The proctected flag is:%2X\n",icRead[1]);
		if(swr_4428(icdev,55,1,icWrite)!=0)
		{
			if(icRead[1]!=0)
			{
			    printf("swr_4428 ERR\n");
			    break;
			}
			printf("The data has been protected\n");
		}
		else printf("swr_4428 OK\n");
		if(rdwpb_4428(icdev,65,2,icRead)!=0)
                              //icRead[0] is the data in card.
			      //icData[1] identify icData[1] protect flag 
                              //icRead[2] is the data in card.
			      //icData[3] identify icData[3] protect flag
		{		
		     printf("rdwpb_4428 ERR\n");	
			 break;
		}
		if(wrwpb_4428(icdev,65,1,icWrite)!=0)
		{
			if(icRead[1]!=0)
			{
			    printf("wrwpb_4428 ERR\n");
			    break;
			}
			printf("The data has been protected\n");
		}
		else printf("wrwpb_4428 OK\n");
		if(rdwpb_4428(icdev,75,1,icRead)!=0)
		{
		     printf("rdwpb_4428 ERR\n");
			 break;
		}
		if(pwr_4428(icdev,75,1,icRead)!=0)
		{
			printf("pwr_4428 ERR\n");
			break;
		}
		printf("pwr_4428 OK\n");
		break;
	
	
	case 9:
		printf("CARD_1604\n");
                icSC[0]=0xf0;
                icSC[1]=0xf0;
                if(csc_1604(icdev,0,2,icSC)!=0)
                {
                     printf("csc_1604 ERR in sector 0\n");
	             break;
                 }
                else printf("csc_1604 OK in sector 0\n");  

                if(rsct_1604(icdev,0,&icSCct)!=0)
                {
                     printf("rsct_1604 ERR in sector 0\n");
                     break;
                }
                printf("The Sector 0 SC counter is: %d\n",icSCct); 
 
                icSC[0]=0xff;icSC[1]=0xff;
                if(csc_1604(icdev,1,2,icSC)!=0)
                {
                     printf("csc_1604 ERR in sector 1\n");
			break;                    
		}
                else printf("csc_1604 OK in sector 1\n");  

                if(rsct_1604(icdev,1,&icSCct)!=0)
                {
                     printf("rsct_1604 ERR in sector 1\n");
                     break;
                }
                printf("The Sector 1 SC counter is: %d\n",icSCct);  

                icSC[0]=0xff;icSC[1]=0xff;
                if(cesc_1604(icdev,1,2,icSC)!=0)
                {
                     printf("cesc_1604 ERR in sector 1\n");
			break;
                 }
                else printf("cesc_1604 OK in sector 1\n");  

                if(resct_1604(icdev,1,&icSCct)!=0)
                {
                     printf("resct_1604 ERR in sector 1\n");
                     break;
                }
                printf("The Sector 1 ESC counter is: %d\n",icSCct);  

                if(ser_1604(icdev,1,0,20)!=0)
                {
                     printf("ser_1604 ERR in sector 1\n");
                     break;
                 }
                printf("ser_1604 OK in sector 1\n");  

                memset(icWrite,'A',20);
		icReadLen=20;
		icWriteLen=20;
		if((st=swr_1604(icdev,1,0, icWriteLen, icWrite))!=0)
		{
			printf("wr_1604 ERR=%d\n",st);
			break;
		}
		printf("swr_1604 OK\n");

		if(srd_1604(icdev,1,0, icReadLen, icRead)!=0)
		{
		    printf("srd_1604 ERR\n");
			break;
		}
		printf("Read data: %s\n",icRead);
		break;	
	
        default:
		break;
	}

       ic_exit(icdev);
       return;  
}
