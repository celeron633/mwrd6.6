Attribute VB_Name = "MC16_GL"

Global icdev%, st&
'comm function

Declare Function ic_init Lib "mwic_16.dll" (ByVal icdev%, ByVal baud&) As Integer
Declare Function ic_exit Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function get_status Lib "mwic_16.dll" (ByVal icdev%, card_S%) As Integer
Declare Function set_baud Lib "mwic_16.dll" (ByVal icdev%, ByVal baud&) As Integer

Declare Function cmp_dvsc Lib "mwic_16.dll" (ByVal icdev%, ByVal length%, ByVal data_buffer$) As Integer
Declare Function srd_dvsc Lib "mwic_16.dll" (ByVal icdev%, ByVal length%, ByVal data_buffer$) As Integer
Declare Function swr_dvsc Lib "mwic_16.dll" (ByVal icdev%, ByVal length%, ByVal data_buffer$) As Integer
Declare Function setsc_md Lib "mwic_16.dll" (ByVal icdev%, ByVal mode%) As Integer
 
Declare Function turn_on Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function turn_off Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function srd_ver Lib "mwic_16.dll" (ByVal icdev%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function auto_pull Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function dv_beep Lib "mwic_16.dll" (ByVal icdev%, ByVal time1%) As Integer

Declare Function SCardComand Lib "c:\windows\SCARD.DLL" (Handle&, ByVal cmd$, cmdlen&, ByVal dataIN$, datainlen&, ByRef dataOut As Byte, dataoutlen&) As Long



