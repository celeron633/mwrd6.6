Attribute VB_Name = "MC3210"

'***********************    operate at88sc102    ************************
Declare Function srd_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function srd_102_hex Lib "mwic_32.dll" Alias "srd_102" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer

Declare Function swr_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_102_hex Lib "mwic_32.dll" Alias "swr_102" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer

Declare Function ser_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer) As Integer

Declare Function csc_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function rsc_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function wsc_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function rsct_102 Lib "mwic_32.dll" (ByVal icdev As Long, counter As Integer) As Integer

Declare Function cesc_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function resc_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function wesc_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function resct_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, counter%) As Integer

Declare Function clrpr_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer) As Integer
Declare Function clrrd_102 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer) As Integer

Declare Function fakefus_102 Lib "mwic_32.dll" (ByVal icdev As Long, mode%) As Integer
Declare Function blow_102 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function chk_102 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer



