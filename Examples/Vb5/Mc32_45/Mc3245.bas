Attribute VB_Name = "MC3245"




Declare Function srd_45d041 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal page As Integer, ByVal offset As Integer, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function srd_45d041_hex Lib "mwic_32.dll" Alias "srd_45d041" (ByVal icdev As Long, ByVal page As Integer, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer


Declare Function swr_45d041 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal page As Integer, ByVal offset As Integer, ByVal le As Long, ByVal data_buffer$) As Integer
Declare Function swr_45d041_hex Lib "mwic_32.dll" Alias "swr_45d041" (ByVal icdev As Long, ByVal page As Integer, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer

Declare Function chk_45d041 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer


