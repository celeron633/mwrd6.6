'Attribute VB_Name = "MC3228"

'***********************    operate sle 4418    *************************
Declare Function srd_4418 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_4418 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rdwpb_4418 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wrwpb_4418 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function pwr_4418 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function chk_4418 Lib "mwic_16.dll" (ByVal icdev%) As Integer

'***********************    operate sle 4428    *************************
Declare Function srd_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function swr_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rdwpb_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function wrwpb_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function pwr_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal offset%, ByVal le%, ByVal data_buffer$) As Integer
Declare Function chk_4428 Lib "mwic_16.dll" (ByVal icdev%) As Integer

Declare Function csc_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wsc_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsc_4428 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsct_4428 Lib "mwic_16.dll" (ByVal icdev%, counter As Integer) As Integer

