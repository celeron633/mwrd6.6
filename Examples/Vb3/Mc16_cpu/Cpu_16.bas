Attribute VB_Name = "Module1"
Global baud As Long
Global icdev, st As Integer

Declare Function auto_init% Lib "mwic_16.dll" (ByVal port%, ByVal baud&)
Declare Function ic_init% Lib "mwic_16.dll" (ByVal port%, ByVal baud&)
Declare Function get_status% Lib "mwic_16.dll" (ByVal icdev%, card_s%)
Declare Function ic_exit% Lib "mwic_16.dll" (ByVal icdev%)
Declare Function chk_baud& Lib "mwic_16.dll" (ByVal port%)

Declare Function asc_hex% Lib "mwic_16.dll" (ByVal asc$, ByVal hex$, ByVal le&)
Declare Function hex_asc% Lib "mwic_16.dll" (ByRef hex As Byte, ByVal asc$, ByVal le&)
Declare Function asc_asc% Lib "mwic_16.dll" (ByVal sorc$, ByVal des$, ByVal le&)

Declare Function DES_Encrypt& Lib "mwic_16.dll" (ByVal key$, ByVal le%, ByVal sorc$, ByVal le%, ByRef ptrdest As Byte)
Declare Function DES_Decrypt% Lib "mwic_16.dll" (ByVal key$, ByVal le%, ByRef des As Byte, ByRef pretest As Byte)

Declare Function cpu_reset% Lib "mwic_16.dll" (ByVal icdev%, ByRef data_buffer As Byte)
Declare Function cpu_protocol% Lib "mwic_16.dll" (ByVal icdev%, ByVal le%, ByRef send_cmd As Byte, ByRef receive_data As Byte)
Declare Function set_baud Lib "mwic_16.dll" (ByVal icdev%, ByVal baud&) As Integer
Declare Function ic_encrypt Lib "mwic_16.dll" (ByVal key$, ByVal sourceh$, ByVal le%, ByVal ptrdest$) As Integer
Declare Function ic_decrypt Lib "mwic_16.dll" (ByVal key As String, ByVal length As String, ByVal snr As Integer, ByVal pretest As String) As Integer
Declare Function cmp_dvsc Lib "mwic_16.dll" (ByVal icdev%, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_dvsc Lib "mwic_16.dll" (ByVal icdev%, ByVal length As Long, ByRef data_buffer As Byte) As Integer
Declare Function swr_dvsc Lib "mwic_16.dll" (ByVal icdev%, ByVal length As Integer, ByRef data_buffer As Byte) As Integer
Declare Function setsc_md Lib "mwic_16.dll" (ByVal icdev%, ByVal mode As Integer) As Integer
Declare Function swr_eeprom Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer

Declare Function srd_ver Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function auto_pull Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function dv_beep Lib "mwic_16.dll" (ByVal icdev%, ByVal time%) As Integer
Declare Function swr_snr Lib "mwic_16.dll" (ByVal icdev%, ByVal length%, ByVal snr$) As Integer
Declare Function srd_snr Lib "mwic_16.dll" (ByVal icdev%, ByVal length%, ByRef snr As Byte) As Integer

