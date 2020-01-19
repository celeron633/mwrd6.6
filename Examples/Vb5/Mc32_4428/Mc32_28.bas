Attribute VB_Name = "MC3228"

'***********************    operate sle 4418    *************************
Declare Function srd_4418 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function swr_4418 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function rdwpb_4418 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function wrwpb_4418 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function pwr_4418 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function chk_4418 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer

'***********************    operate sle 4428    *************************
Declare Function srd_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function srd_4428_hex Lib "mwic_32.dll" Alias "srd_4428" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer

Declare Function swr_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function swr_4428_hex Lib "mwic_32.dll" Alias "swr_4428" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer

Declare Function rdwpb_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function wrwpb_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function pwr_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Long, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function chk_4428 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer

Declare Function csc_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Long, ByRef data_buffer As Byte) As Integer
Declare Function wsc_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Long, ByRef data_buffer As Byte) As Integer
Declare Function rsc_4428 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal le As Long, ByRef data_buffer As Byte) As Integer
Declare Function rsct_4428 Lib "mwic_32.dll" (ByVal icdev As Long, counter As Integer) As Integer

