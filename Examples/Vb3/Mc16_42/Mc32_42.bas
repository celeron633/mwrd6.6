'Attribute VB_Name = "MC3242"
'***********************    operate sle 4442    **************************
Declare Function srd_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function prd_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function pwr_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function chk_4442 Lib "mwic_16.dll" (ByVal icdev%) As Integer

Declare Function csc_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wsc_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsc_4442 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsct_4442 Lib "mwic_16.dll" (ByVal icdev%, counter As Integer) As Integer


