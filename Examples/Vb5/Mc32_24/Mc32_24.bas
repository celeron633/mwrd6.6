Attribute VB_Name = "MC3224"
'************************    operate at24c01a    ***************************
Declare Function swr_24c01a Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c01a Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c01a Lib "mwic_32.dll" (ByVal icdev As Long) As Integer

Declare Function srd_24c01a_hex Lib "mwic_32.dll" Alias "srd_24c01a" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer
Declare Function swr_24c01a_hex Lib "mwic_32.dll" Alias "swr_24c01a" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
'************************    operate at24c02    ***************************
Declare Function swr_24c02 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c02 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c02 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer

Declare Function srd_24c02_hex Lib "mwic_32.dll" Alias "srd_24c02" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buff As Byte) As Integer
Declare Function swr_24c02_hex Lib "mwic_32.dll" Alias "swr_24c02" (ByVal icdev As Long, ByVal offset As Integer, ByVal le As Integer, ByRef data_buffer As Byte) As Integer
'************************    operate at24c04    ***************************
'************************    通过 byref 传递参数**********************************
Declare Function swr_24c04 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByRef data_buffer As Byte) As Integer
Declare Function srd_24c04 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByRef data_buffer As Byte) As Integer
Declare Function chk_24c04 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
'************************    operate at24c08    ***************************
Declare Function swr_24c08 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c08 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c08 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
'************************    operate at24c16    ***************************
Declare Function swr_24c16 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c16 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c16 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
'************************    operate at24c64    ***************************
Declare Function swr_24c64 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function srd_24c64 Lib "mwic_32.dll" (ByVal icdev As Long, ByVal offset As Integer, ByVal length As Integer, ByVal data_buffer$) As Integer
Declare Function chk_24c64 Lib "mwic_32.dll" (ByVal icdev As Long) As Integer
 
