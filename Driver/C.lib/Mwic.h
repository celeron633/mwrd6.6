/* MWIC.H */
//************************  general  *****************************//
extern int ic_init(int com,long baud);
extern int auto_init(int port,long baud);
extern int ic_exit(int icdev);
extern int chk_card(int icdev);
extern int srd_ver(int icdev, int len,unsigned char *data_buffer);
extern int set_baud(int icdev, long baud);
extern int cmp_dvsc(int icdev, int len,unsigned char *dta_buffer);
extern int srd_dvsc(int icdev, int len,unsigned char *data_buffer);
extern int swr_dvsc(int icdev, int len,unsigned char *data_buffer);
extern int setsc_md(int icdev, int mode);
extern int turn_on(int icdev);
extern int turn_off(int icdev);
extern int auto_pull(int icdev);
extern int get_status(int icdev,int *state);
extern int dv_beep(int icdev, int time);
extern long chk_baud(int port);
extern int swr_eeprom(int icdev, int offset,int len,unsigned char   *data_buffer);
extern int srd_eeprom(int icdev, int offset,int len,unsigned char   *data_buffer);
extern int srd_snr(int  icdev,int  len,unsigned char *data_buffer);
extern int val_read(int icdev,unsigned long *p_Value);
extern int val_inc(int icdev, unsigned long _Value);
extern int val_dec(int icdev, unsigned long _Value);
extern int val_set(int icdev, unsigned long _Value);
extern int ic_encrypt( char *key,char *ptrSource, unsigned int msgLen, char *ptrDest);
extern int ic_decrypt( char *key,char *ptrSource, unsigned int msgLen, char *ptrDest);
extern unsigned long DES_Encrypt( unsigned char *Key,int Keyen,unsigned char *Source, unsigned long SrcLen,unsigned char *result);
extern unsigned long DES_Decrypt( unsigned char *Key,int KeyLen,unsigned char *Source, unsigned long SrcLen,unsigned char *result);
//**********************    operate sle 4404    **************************
extern int srd_4404(int icdev,int offset,int len,unsigned char *data_buffer);
extern int swr_4404(int icdev,int offset,int len,unsigned char *data_buffer);
extern int csc_4404(int icdev,int len,unsigned char *data_buffer);
extern int wsc_4404(int icdev,int len,unsigned char *data_buffer);
extern int rsc_4404(int icdev,int len,unsigned char *data_buffer);
extern int rsct_4404(int icdev,int *counter);
extern int cesc_4404(int icdev,int len,unsigned char *data_buffer);
extern int wesc_4404(int icdev,int len,unsigned char *data_buffer);
extern int resc_4404(int icdev,int len,unsigned char *data_buffer);
extern int resct_4404(int icdev,int *counter);
extern int ser_4404(int icdev,int offset,int len);
extern int fakefus_4404(int icdev,int mode);
extern int psnl_4404(int icdev);
extern int clrpr_4404(int icdev);
extern int clrrd_4404(int icdev);
extern int chk_4404(int icdev);
//***********************    operate sle 4406    *************************
extern int srd_4406(int icdev,int offset,int len,unsigned char *data_buffer);
extern int swr_4406(int icdev,int offset,int len,unsigned char *data_buffer);
extern int csc_4406(int icdev,int len,unsigned char *data_buffer);
extern int wsc_4406(int icdev,int len,unsigned char *data_buffer);
extern int rsc_4406(int icdev,int len,unsigned char *data_buffer);
extern int rsct_4406(int icdev,int *Counter);
extern int eswc_4406(int icdev,int offset);
extern int psnl_4406(int icdev);
extern int chk_4406(int icdev);
//***********************    operate at88sc102    ************************
extern int srd_102(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
extern int swr_102(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
extern int ser_102(int icdev,int zone,int offset,int len);

extern int csc_102(int icdev,int len,unsigned char *data_buffer);
extern int rsc_102(int icdev,int len,unsigned char *data_buffer);
extern int wsc_102(int icdev,int len,unsigned char *data_buffer);
extern int rsct_102(int icdev,int *counter);

extern int cesc_102(int icdev,int zone,int len,unsigned char *data_buffer);
extern int resc_102(int icdev,int zone,int len,unsigned char *data_buffer);
extern int wesc_102(int icdev,int zone,int len,unsigned char *data_buffer);
extern int resct_102(int icdev,int zone,int *counter);

extern int clrpr_102(int icdev,int zone);
extern int clrrd_102(int icdev,int zone);

extern int fakefus_102(int icdev,int mode);
extern int psnl_102(int icdev);
extern int chk_102(int icdev);
//*********************    operate at88sc1604    **************************
extern int srd_1604(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
extern int swr_1604(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
extern int ser_1604(int icdev,int zone,int offset,int len);

extern int csc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
extern int rsc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
extern int wsc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
extern int rsct_1604(int icdev,int zone,int *counter);

extern int cesc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
extern int resc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
extern int wesc_1604(int icdev,int zone,int len,unsigned char *data_buffer);
extern int resct_1604(int icdev,int zone,int *counter);

extern int clrpr_1604(int icdev,int zone);
extern int clrrd_1604(int icdev,int zone);

extern int fakefus_1604(int icdev,int mode);
extern int psnl_1604(int icdev);
extern int chk_1604(int icdev);

//*********************    operate at88sc1604b    **************************
extern int srd_1604b(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
extern int swr_1604b(int icdev,int zone,int offset,int len,unsigned char *data_buffer);
extern int ser_1604b(int icdev,int zone,int offset,int len);

extern int csc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
extern int rsc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
extern int wsc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
extern int rsct_1604b(int icdev,int zone,int *counter);

extern int cesc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
extern int resc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
extern int wesc_1604b(int icdev,int zone,int len,unsigned char *data_buffer);
extern int resct_1604b(int icdev,int zone,int *counter);

extern int clrpr_1604b(int icdev,int zone);
extern int clrrd_1604b(int icdev,int zone);

extern int fakefus_1604b(int icdev,int mode);
extern int psnl_1604b(int icdev);
extern int chk_1604b(int icdev);
//************************    operate at24c01a    ***************************
extern int swr_24c01a(int icdev, int offset, int len,unsigned char *data_buffer);
extern int srd_24c01a(int icdev, int offset, int len,unsigned char *data_buffer);
extern int chk_24c01a(int icdev);
//************************    operate at24c02    ***************************
extern int  swr_24c02(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  srd_24c02(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  chk_24c02(int icdev);
//************************    operate at24c04    ***************************
extern int  swr_24c04(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  srd_24c04(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  chk_24c04(int icdev);
//************************    operate at24c08    ***************************
extern int  swr_24c08(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  srd_24c08(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  chk_24c08(int icdev);
//************************    operate at24c16    ***************************
extern int  swr_24c16(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  srd_24c16(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  chk_24c16(int icdev);
//************************    operate at24c64    ***************************
extern int  swr_24c64(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  srd_24c64(int icdev, int offset, int len,unsigned char *data_buffer);
extern int  chk_24c64(int icdev);
//***********************    operate sle 4418    *************************
extern int srd_4418(int icdev,int offset,int len,unsigned char *data_buffer);
extern int swr_4418(int icdev,int offset,int len,unsigned char *data_buffer);
extern int rdwpb_4418(int icdev,int offset,int len,unsigned char *data_buffer);
extern int wrwpb_4418(int icdev,int offset,int len,unsigned char *data_buffer);
extern int pwr_4418(int icdev,int offset,int len,unsigned char *data_buffer);
extern int chk_4418(int icdev);
//***********************    operate sle 4428    *************************
extern int srd_4428(int icdev,int offset,int len,unsigned char *data_buffer);
extern int swr_4428(int icdev,int offset,int len,unsigned char *data_buffer);
extern int rdwpb_4428(int icdev,int offset,int len,unsigned char *data_buffer);
extern int wrwpb_4428(int icdev,int offset,int len,unsigned char *data_buffer);
extern int pwr_4428(int icdev,int offset,int len,unsigned char *data_buffer);
extern int csc_4428(int icdev,int len,unsigned char *data_buffer);
extern int wsc_4428(int icdev,int len,unsigned char *data_buffer);
extern int rsc_4428(int icdev,int len,unsigned char *data_buffer);
extern int rsct_4428(int icdev,int *counter);
extern int chk_4428(int icdev);
//***********************    operate sle 4442    **************************
extern int srd_4442(int icdev,int offset,int len,unsigned char *data_buffer);	//READ SOME THING
extern int swr_4442(int icdev,int offset,int len,unsigned char *data_buffer);	//WRITE SOME THING
extern int prd_4442(int icdev,int len,unsigned char *data_buffer);
extern int pwr_4442(int icdev,int offset,int len,unsigned char *data_buffer);
extern int csc_4442(int icdev,int len,unsigned char *data_buffer);
extern int wsc_4442(int icdev,int len,unsigned char *data_buffer);
extern int rsc_4442(int icdev,int len,unsigned char *data_buffer);
extern int rsct_4442(int icdev,int *counter);
extern int chk_4442(int icdev);
//***********************    operate sle 4432    **************************
extern int srd_4432(int icdev,int offset,int len,unsigned char *data_buffer);
extern int swr_4432(int icdev,int offset,int len,unsigned char *data_buffer);
extern int prd_4432(int icdev,int len,unsigned char *data_buffer);
extern int pwr_4432(int icdev,int offset,int len,unsigned char *data_buffer);
extern int chk_4432(int icdev);

//***********************    operate at45d041    *************************
extern int srd_45d041(int  icdev,int  page,int  offset,long len,unsigned char *data_buffer);
extern int swr_45d041(int  icdev,int  page,int  offset,long len,unsigned char *data_buffer);
extern int chk_45d041(int  icdev);
//************************    operate at93c46a    ***************************
extern int swr_93c46a(int  icdev,int  offset, int  len,unsigned char *data_buffer);
extern int srd_93c46a(int  icdev,int  offset, int  len,unsigned char *data_buffer);
extern int eral_93c46a(int  icdev);
extern int chk_93c46a(int  icdev);
//************************    operate at93c46    ***************************
extern int swr_93c46(int  icdev,int  offset, int  len, unsigned char *data_buffer);
extern int srd_93c46(int  icdev,int  offset, int  len, unsigned char *data_buffer);
extern int eral_93c46(int  icdev);
extern int chk_93c46(int  icdev);
extern int lib_ver(char *VerStr);
//************************ cpu card ****************************************//
extern int cpu_reset(int icdev,unsigned char * receive_data);
extern int cpu_protocol(int icdev,int len,unsigned char *send_data,unsigned char * receive_data);
extern int cpu_comres(int icdev,int len,unsigned char *send_data,unsigned char * receive_data);
//**************************** end *************************************//
