'Attribute VB_Name = "MC3210"

'***********************    operate at88sc102    ************************
Declare Function srd_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function ser_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal Offset As Integer, ByVal le As Integer) As Integer

Declare Function csc_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsc_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wsc_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsct_102 Lib "mwic_16.dll" (ByVal icdev%, counter As Integer) As Integer

Declare Function cesc_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function resc_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wesc_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function resct_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, counter%) As Integer

Declare Function clrpr_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer) As Integer
Declare Function clrrd_102 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer) As Integer

Declare Function fakefus_102 Lib "mwic_16.dll" (ByVal icdev%, mode%) As Integer
Declare Function psnl_102 Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function chk_102 Lib "mwic_16.dll" (ByVal icdev%) As Integer
 
'oprate 1604

Declare Function srd_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function swr_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal Offset As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function ser_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal Offset As Integer, ByVal le As Integer) As Integer

Declare Function csc_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsc_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wsc_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function rsct_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, counter As Integer) As Integer

Declare Function cesc_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function resc_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function wesc_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, ByVal le As Integer, ByVal data_buffer$) As Integer
Declare Function resct_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer, counter%) As Integer

Declare Function setpr_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer) As Integer
Declare Function setrd_1604 Lib "mwic_16.dll" (ByVal icdev%, ByVal zone As Integer) As Integer

Declare Function fakefus_1604 Lib "mwic_16.dll" (ByVal icdev%, mode%) As Integer
Declare Function psnl_1604 Lib "mwic_16.dll" (ByVal icdev%) As Integer
Declare Function chk_1604 Lib "mwic_16.dll" (ByVal icdev%) As Integer

