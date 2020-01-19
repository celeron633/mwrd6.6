Attribute VB_Name = "MC32Gl"

Public icdev As Long
Public st As Integer

Declare Function auto_init& Lib "mwic_32.dll" (ByVal port%, ByVal baud&)
Declare Function srd_eeprom% Lib "mwic_32.dll" (ByVal icdev&, ByVal offset%, ByVal length%, ByVal data_buffer$)
Declare Function swr_eeprom% Lib "mwic_32.dll" (ByVal icdev&, ByVal offset%, ByVal length%, ByVal data_buffer$)
Declare Function asc_hex% Lib "mwic_32.dll" (ByVal asc$, ByRef hex As Byte, ByVal le&)
Declare Function hex_asc% Lib "mwic_32.dll" (ByRef hex As Byte, ByVal asc$, ByVal le&)
Declare Function asc_asc% Lib "mwic_32.dll" (ByVal sorc$, ByRef des As Byte, ByVal le&)
'Declare Function DES_Encrypt& Lib "mwic_32.dll" (ByVal key$, ByVal le%, ByVal sorc$, ByVal le%, ByRef ptrdest As Byte)
'Declare Function DES_Decrypt% Lib "mwic_32.dll" (ByVal key$, ByVal le%, ByRef des As Byte, ByRef pretest As Byte)

Declare Function ic_init Lib "mwic_32.dll" (ByVal port%, ByVal baud As Long) As Long
Declare Function get_status Lib "mwic_32.dll" (ByVal icdev As Long, card_S As Integer) As Integer
Declare Function set_baud Lib "mwic_32.dll" (ByVal icdev As Long, ByVal baud As Long) As Integer
Declare Function ic_encrypt Lib "mwic_32.dll" (ByVal key$, ByVal source$, ByVal le%, ByRef ptrdest As Byte) As Integer
Declare Function ic_decrypt Lib "mwic_32.dll" (ByVal key$, ByRef sourcr As Byte, ByVal le%, ByVal ptrdest$) As Integer

Declare Function cmp_dvsc Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Integer, ByRef data_buffer As Byte) As Integer
Declare Function srd_dvsc Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Long, ByRef data_buffer As Byte) As Integer
Declare Function swr_dvsc Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Integer, ByRef data_buffer As Byte) As Integer
Declare Function setsc_md Lib "mwic_32.dll" (ByVal icdev As Long, ByVal mode As Integer) As Integer

Declare Function turn_on Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function turn_off Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function srd_ver Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function auto_pull Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function dv_beep Lib "mwic_32.dll" (ByVal icdev As Long, ByVal time As Integer) As Integer
Declare Function ic_exit% Lib "mwic_32.dll" (ByVal icdev As Long)
Declare Function srd_snr Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Integer, ByVal snr As String) As Integer


