'Attribute VB_Name = "MC3224"
'************************    operate at24c01    ***************************
Declare Function swr_24c01a Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c01a Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c01a Lib "mwic_16.dll" (ByVal icdev%) As Integer
'************************    operate at24c02    ***************************
Declare Function swr_24c02 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c02 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c02 Lib "mwic_16.dll" (ByVal icdev%) As Integer
'************************    operate at24c04    ***************************
Declare Function swr_24c04 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c04 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c04 Lib "mwic_16.dll" (ByVal icdev%) As Integer
'************************    operate at24c08    ***************************
Declare Function swr_24c08 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c08 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c08 Lib "mwic_16.dll" (ByVal icdev%) As Integer
'************************    operate at24c16    ***************************
Declare Function swr_24c16 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c16 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c16 Lib "mwic_16.dll" (ByVal icdev%) As Integer
'************************    operate at24c64    ***************************
Declare Function swr_24c64 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c64 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c64 Lib "mwic_16.dll" (ByVal icdev%) As Integer


