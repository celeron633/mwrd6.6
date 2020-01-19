Attribute VB_Name = "MC32Gl"

Public icdev As Long
Public st As Integer

Declare Function auto_init Lib "mwic_32.dll" (ByVal port%, ByVal baud As Long) As Long

Declare Function ic_init Lib "mwic_32.dll" (ByVal port%, ByVal baud As Long) As Long
Declare Function get_status Lib "mwic_32.dll" (ByVal icdev As Long, card_S As Integer) As Integer
Declare Function set_baud Lib "mwic_32.dll" (ByVal icdev As Long, ByVal baud As Long) As Integer

Declare Function cmp_dvsc Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_dvsc Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Long, ByVal data_buffer$) As Integer
Declare Function swr_dvsc Lib "mwic_32.dll" (ByVal icdev As Long, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function setsc_md Lib "mwic_32.dll" (ByVal icdev As Long, ByVal mode As Integer) As Integer
 
Declare Function turn_on Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function turn_off Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function srd_ver Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function auto_pull Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function dv_beep Lib "mwic_32.dll" (ByVal icdev As Long, ByVal time As Integer) As Integer
Declare Function ic_exit% Lib "mwic_32.dll" (ByVal icdev As Long)

Declare Function asc_hex Lib "mwic_32.dll" (ByVal asc$, ByRef hex As Byte, ByVal le&) As Integer
Declare Function hex_asc Lib "mwic_32.dll" (ByRef hex As Byte, ByVal asc$, ByVal le&) As Integer
Declare Function asc_asc% Lib "mwic_32.dll" (ByVal sorc$, ByRef des As Byte, ByVal le&)

Declare Function ic_encrypt Lib "mwic_32.dll" (ByVal key As String, ByVal ptrsource As String, ByVal le As Integer, ByRef ptrdest As Byte) As Integer
Declare Function ic_decrypt Lib "mwic_32.dll" (ByVal key As String, ByRef ptrdest As Byte, ByVal le As Integer, ByVal ptrsource As String) As Integer

