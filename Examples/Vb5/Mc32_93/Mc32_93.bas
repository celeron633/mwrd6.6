Attribute VB_Name = "MC3293"
'operate 93c46
Declare Function srd_93c46 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function srd_93c46_hex Lib "mwic_32.dll" Alias "srd_93c46" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer

Declare Function swr_93c46 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_93c46_hex Lib "mwic_32.dll" Alias "swr_93c46" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer

Declare Function chk_93c46 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer


