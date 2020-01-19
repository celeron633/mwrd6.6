Attribute VB_Name = "MC3210"

'***********************    operate at88sc1604    ************************
Declare Function srd_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function srd_1604_hex Lib "mwic_32.dll" Alias "srd_1604" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer

Declare Function swr_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_1604_hex Lib "mwic_32.dll" Alias "swr_1604" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer

Declare Function ser_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal offset As Integer, ByVal le As Integer) As Integer

Declare Function csc_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function rsc_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function wsc_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function rsct_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, counter As Integer) As Integer

Declare Function cesc_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function resc_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function wesc_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
Declare Function resct_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer, counter%) As Integer

Declare Function clrpr_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer) As Integer
Declare Function clrrd_1604 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal zone As Integer) As Integer

Declare Function fakefus_1604 Lib "mwic_32.dll" (ByVal icdev As Long, mode%) As Integer
Declare Function blow_1604 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
Declare Function chk_1604 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer



