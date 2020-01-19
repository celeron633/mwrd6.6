'Attribute VB_Name = "MC3293"
'operate 93c46
Declare Function srd_93c46 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_93c46 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function chk_93c46 Lib "mwic_16.dll" (ByVal icdev%) As Integer

