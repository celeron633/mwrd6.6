extern "C"
{
int FAR PASCAL _export ic_init(int com,long baud);
int FAR PASCAL _export auto_init(int port,long baud);   
int FAR PASCAL _export ic_exit(int icdev);
int FAR PASCAL _export srd_ver(int icdev, int len,unsigned char *data_buffer);
int FAR PASCAL _export set_baud(int icdev, long baud);
int FAR PASCAL _export cmp_dvsc(int icdev, int len,unsigned char *dta_buffer);
int FAR PASCAL _export srd_dvsc(int icdev, int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_dvsc(int icdev, int len,unsigned char *data_buffer);
int FAR PASCAL _export setsc_md(int icdev, int mode);
int FAR PASCAL _export turn_on(int icdev);
int FAR PASCAL _export turn_off(int icdev);
int FAR PASCAL _export auto_pull(int icdev);
int FAR PASCAL _export get_status(int icdev,int *state);
int FAR PASCAL _export dv_beep(int icdev, int time);
long FAR PASCAL _export chk_baud(int port);
int FAR PASCAL _export  chk_card(int icdev);
int FAR PASCAL _export swr_eeprom(int icdev, int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export srd_eeprom(int icdev, int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export srd_snr(int  icdev,int  len,unsigned char *data_buffer);
int FAR PASCAL _export val_read(int icdev,unsigned long *p_Value);
int FAR PASCAL _export val_inc(int icdev, unsigned long _Value);
int FAR PASCAL _export val_dec(int icdev, unsigned long _Value);
int FAR PASCAL _export val_set(int icdev, unsigned long _Value);
int FAR PASCAL _export ic_encrypt( char *key,char *ptrSource,unsigned int msgLen, char *ptrDest);
int FAR PASCAL _export ic_decrypt( char *key,char *ptrSource,unsigned int msgLen, char *ptrDest);
unsigned long FAR PASCAL _export  DES_Encrypt( unsigned char *Key,int KeyLen,
					   unsigned char *Source, unsigned long SrcLen,
					   unsigned char *result);
unsigned long FAR PASCAL _export  DES_Decrypt( unsigned char *Key,int KeyLen,
					   unsigned char *Source, unsigned long SrcLen,
					   unsigned char *result); int FAR PASCAL _export lib_ver(char *VerStr);
int FAR PASCAL _export asc_hex(unsigned char *asc, unsigned char *hex, long pair_len);
int FAR PASCAL _export hex_asc(unsigned char *hex,unsigned char *asc,long length);
int FAR PASCAL _export asc_asc(unsigned char *src,unsigned char *des,long len);

//**********************    operate sle 4404    **************************
int FAR PASCAL _export srd_4404(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_4404(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export csc_4404(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export wsc_4404(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsc_4404(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsct_4404(int icdev,int *counter);
int FAR PASCAL _export cesc_4404(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export wesc_4404(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export resc_4404(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export resct_4404(int icdev,int *counter);
int FAR PASCAL _export ser_4404(int icdev,int offset,int len);
int FAR PASCAL _export fakefus_4404(int icdev,int mode);
int FAR PASCAL _export psnl_4404(int icdev);
int FAR PASCAL _export clrpr_4404(int icdev);
int FAR PASCAL _export clrrd_4404(int icdev);
int FAR PASCAL _export chk_4404(int icdev);
//***********************    operate sle 4406    *************************
int FAR PASCAL _export srd_4406(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_4406(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export csc_4406(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export wsc_4406(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsc_4406(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsct_4406(int icdev,int *Counter);
int FAR PASCAL _export eswc_4406(int icdev,int offset);
int FAR PASCAL _export psnl_4406(int icdev);
int FAR PASCAL _export chk_4406(int icdev);
//***********************    operate at88sc102    ************************
int FAR PASCAL _export srd_102(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_102(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export ser_102(int icdev,int zone,int offset,int len);

int FAR PASCAL _export csc_102(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsc_102(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export wsc_102(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsct_102(int icdev,int *counter);

int FAR PASCAL _export cesc_102(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export resc_102(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export wesc_102(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export resct_102(int icdev,int zone,int *counter);

int FAR PASCAL _export clrpr_102(int icdev,int zone);
int FAR PASCAL _export clrrd_102(int icdev,int zone);

int FAR PASCAL _export fakefus_102(int icdev,int mode);
int FAR PASCAL _export psnl_102(int icdev);
int FAR PASCAL _export chk_102(int icdev);
//*********************    operate at88sc1604    **************************
int FAR PASCAL _export srd_1604(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_1604(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export ser_1604(int icdev,int zone,int offset,int len);

int FAR PASCAL _export csc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export wsc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsct_1604(int icdev,int zone,int *counter);

int FAR PASCAL _export cesc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export resc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export wesc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export resct_1604(int icdev,int zone,int *counter);

int FAR PASCAL _export clrpr_1604(int icdev,int zone);
int FAR PASCAL _export clrrd_1604(int icdev,int zone);

int FAR PASCAL _export fakefus_1604(int icdev,int mode);
int FAR PASCAL _export psnl_1604(int icdev);
int FAR PASCAL _export chk_1604(int icdev);

//*********************    operate at88sc1604b    **************************
int FAR PASCAL _export srd_1604b(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_1604b(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export ser_1604b(int icdev,int zone,int offset,int len);

int FAR PASCAL _export csc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export wsc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsct_1604b(int icdev,int zone,int *counter);

int FAR PASCAL _export cesc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export resc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export wesc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
int FAR PASCAL _export resct_1604b(int icdev,int zone,int *counter);

int FAR PASCAL _export clrpr_1604b(int icdev,int zone);
int FAR PASCAL _export clrrd_1604b(int icdev,int zone);

int FAR PASCAL _export fakefus_1604b(int icdev,int mode);
int FAR PASCAL _export psnl_1604b(int icdev);
int FAR PASCAL _export chk_1604b(int icdev);
//************************    operate at24c01a    ***************************
int FAR PASCAL _export swr_24c01a(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export srd_24c01a(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export chk_24c01a(int icdev);
//************************    operate at24c02    ***************************
int FAR PASCAL _export  swr_24c02(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  srd_24c02(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  chk_24c02(int icdev);
//************************    operate at24c04    ***************************
int FAR PASCAL _export  swr_24c04(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  srd_24c04(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  chk_24c04(int icdev);
//************************    operate at24c08    ***************************
int FAR PASCAL _export  swr_24c08(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  srd_24c08(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  chk_24c08(int icdev);
//************************    operate at24c16    ***************************
int FAR PASCAL _export  swr_24c16(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  srd_24c16(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  chk_24c16(int icdev);
//************************    operate at24c64    ***************************
int FAR PASCAL _export  swr_24c64(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  srd_24c64(int icdev, int offset, int len,unsigned char *data_buffer);
int FAR PASCAL _export  chk_24c64(int icdev);
//*************************** define end*****************************//
//***********************    operate sle 4418    *************************
int FAR PASCAL _export srd_4418(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_4418(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export rdwpb_4418(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export wrwpb_4418(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export pwr_4418(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export chk_4418(int icdev);
//***********************    operate sle 4428    *************************
int FAR PASCAL _export srd_4428(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export swr_4428(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export rdwpb_4428(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export wrwpb_4428(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export pwr_4428(int icdev,int offset,int len,unsigned char *data_buffer);
int FAR PASCAL _export csc_4428(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export wsc_4428(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsc_4428(int icdev,int len,unsigned char *data_buffer);
int FAR PASCAL _export rsct_4428(int icdev,int *counter);
int FAR PASCAL _export chk_4428(int icdev);
//***********************    operate sle 4442    **************************
int FAR PASCAL _export srd_4442(int icdev,int offset,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export swr_4442(int icdev,int offset,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export prd_4442(int icdev,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export pwr_4442(int icdev,int offset,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export csc_4442(int icdev,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export wsc_4442(int icdev,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export rsc_4442(int icdev,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export rsct_4442(int icdev,int *counter);
int FAR PASCAL _export chk_4442(int icdev);
//***********************    operate sle 4432    **************************
int FAR PASCAL _export srd_4432(int icdev,int offset,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export swr_4432(int icdev,int offset,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export prd_4432(int icdev,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export pwr_4432(int icdev,int offset,int len,
						   unsigned char *data_buffer);
int FAR PASCAL _export chk_4432(int icdev);

//***********************    operate at45d041    *************************
int FAR PASCAL _export srd_45d041(int  icdev,int  page,int  offset,long len,unsigned char *data_buffer);
int FAR PASCAL _export swr_45d041(int  icdev,int  page,int  offset,long len,unsigned char *data_buffer);
int FAR PASCAL _export chk_45d041(int  icdev);
//************************    operate at93c46a    ***************************
int FAR PASCAL _export swr_93c46a(int  icdev,int  offset, int  len,
							unsigned char *data_buffer);
int FAR PASCAL _export srd_93c46a(int  icdev,int  offset, int  len, 
							unsigned char *data_buffer);
int FAR PASCAL _export eral_93c46a(int  icdev);
int FAR PASCAL _export chk_93c46a(int  icdev);
//************************    operate at93c46    ***************************
int FAR PASCAL _export swr_93c46(int  icdev,int  offset, int  len, unsigned char *data_buffer);
int FAR PASCAL _export srd_93c46(int  icdev,int  offset, int  len, unsigned char *data_buffer);
int FAR PASCAL _export eral_93c46(int  icdev);
int FAR PASCAL _export chk_93c46(int  icdev);
//************************ operate cpu card **********************************
int FAR PASCAL _export cpu_reset(int icdev,unsigned char *data_buffer);
int FAR PASCAL _export cpu_protocol(int icdev,int len, unsigned char *send_cmd, unsigned char *receive_data);
int FAR PASCAL _export cpu_comres(int icdev,int len, unsigned char *send_cmd, unsigned char *receive_data);
}