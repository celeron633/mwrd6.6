Attribute VB_Name = "MC3242"
'***********************    operate sle 4442    **************************
Declare Function srd_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function srd_4442_hex Lib "mwic_32.dll" Alias "srd_4442" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer

Declare Function swr_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_4442_hex Lib "mwic_32.dll" Alias "swr_4442" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer

Declare Function prd_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function pwr_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function chk_4442 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer

Declare Function csc_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function wsc_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function rsc_4442 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function rsct_4442 Lib "mwic_32.dll" (ByVal icdev As Long, counter As Integer) As Integer

Declare Function asc_hex Lib "mwic_32.dll" (ByVal asc$, ByRef hex As Byte, ByVal le&) As Integer
Declare Function hex_asc Lib "mwic_32.dll" (ByRef hex As Byte, ByVal asc$, ByVal le&) As Integer
Declare Function asc_asc% Lib "mwic_32.dll" (ByVal sorc$, ByRef des As Byte, ByVal le&)

Declare Function ic_encrypt Lib "mwic_32.dll" (ByVal key As String, ByVal ptrsource As String, ByVal le As Integer, ByRef ptrdest As Byte) As Integer
Declare Function ic_decrypt Lib "mwic_32.dll" (ByVal key As String, ByRef ptrdest As Byte, ByVal le As Integer, ByVal ptrsource As String) As Integer


