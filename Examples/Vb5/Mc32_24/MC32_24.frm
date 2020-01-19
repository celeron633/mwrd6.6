VERSION 5.00
Begin VB.Form MC32_24 
   BackColor       =   &H00C0C0C0&
   Caption         =   "MC32_24"
   ClientHeight    =   3600
   ClientLeft      =   2100
   ClientTop       =   2040
   ClientWidth     =   6405
   LinkTopic       =   "Form1"
   ScaleHeight     =   3600
   ScaleWidth      =   6405
   Begin VB.CommandButton Command1 
      Caption         =   "24c02（asc_asc)"
      Height          =   495
      Left            =   3840
      TabIndex        =   4
      Top             =   1560
      Width           =   1695
   End
   Begin VB.CommandButton Command3 
      Caption         =   "24c04(byref)"
      Height          =   495
      Left            =   3840
      TabIndex        =   3
      Top             =   2205
      Width           =   1695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Exit"
      Height          =   495
      Left            =   3840
      TabIndex        =   2
      Top             =   2760
      Width           =   1695
   End
   Begin VB.CommandButton Command4 
      Caption         =   "24c01a"
      Height          =   495
      Left            =   3840
      TabIndex        =   1
      Top             =   960
      Width           =   1695
   End
   Begin VB.ListBox List1 
      Height          =   2010
      Left            =   360
      TabIndex        =   0
      Top             =   1080
      Width           =   3135
   End
   Begin VB.PictureBox Picture1 
      Height          =   2655
      Left            =   120
      ScaleHeight     =   2595
      ScaleWidth      =   5955
      TabIndex        =   5
      Top             =   840
      Width           =   6015
   End
   Begin VB.Label Label1 
      Caption         =   "24c函数调用例程"
      BeginProperty Font 
         Name            =   "隶书"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   495
      Left            =   1320
      TabIndex        =   6
      Top             =   120
      Width           =   3180
   End
End
Attribute VB_Name = "MC32_24"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Data1 As String * 10
Dim Data2 As String * 10
Dim data3(10) As Byte
Dim data4(10) As Byte
Dim str1 As String
Dim offset As Integer
Dim length As Integer
Dim status As Integer
Dim databuff1(7) As Byte
Dim databuff2(7) As Byte
Dim data5 As String * 16
Dim data6 As String * 16
Dim ptrdest(16) As Byte
Dim ptrsource As String * 16
Dim source As String * 48
Dim temp1(32), temp2(32) As Byte
Dim data7 As String * 64

Private Sub Command1_Click()
'*************测卡操作仅供参考*******************************
st = chk_24c02(icdev)
If st < 0 Then
    List1.AddItem ("chk card error")
    Exit Sub
Else
    List1.AddItem ("chk card ok")
End If
'*************以ASC方式进行读写操作**************************
offset = 128
length = 10
Data1 = "1234567890"
st = swr_24c02(icdev, offset, length, Data1)
If st < 0 Then
   List1.AddItem ("write error")
   Exit Sub
Else
   List1.AddItem ("write OK")
End If

st = srd_24c02(icdev, offset, length, Data2)
If st < 0 Then
   List1.AddItem ("read error")
   Exit Sub
Else
   List1.AddItem ("read OK")
End If
'************以十六进制方式进行读写****************************
offset = 50
length = 8
data5 = "abcdef0123456789"
st = asc_hex(data5, databuff1(0), 8)
If st < 0 Then
    List1.AddItem ("asc_hex error")
Else
    List1.AddItem ("asc_hex ok")
End If
    
st = swr_24c02_hex(icdev, offset, length, databuff1(0))
If st < 0 Then
  List1.AddItem ("write_hex error")
  Exit Sub
Else
  List1.AddItem ("write_hex ok")
End If


st = srd_24c02_hex(icdev, offset, length, databuff2(0))
If st < 0 Then
  List1.AddItem ("read_hex error")
  Exit Sub
Else
  st = hex_asc(databuff2(0), data6, 8)
  List1.AddItem ("read_hex OK")
  List1.AddItem (data6)
End If
'****************************DES算法********************
st = ic_encrypt("12345678", "明华技术开发中心", 16, ptrdest(0))
If st < 0 Then
    List1.AddItem ("ic_encrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_encrypt ok")
End If

st = ic_decrypt("12345678", ptrdest(0), 16, ptrsource)
If st < 0 Then
    List1.AddItem ("ic_decrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_decrypt ok")
    List1.AddItem (ptrsource)
End If
'**********************asc_asc用法举例************************************
source = "11223344556677889900aabbccddeeff"
st = asc_asc(source, temp1(0), 32)
st = swr_24c02_hex(icdev, 0, 32, temp1(0))
st = srd_24c02_hex(icdev, 0, 32, temp2(0))
If st < 0 Then
  List1.AddItem ("read_hex error")
  Exit Sub
Else
  st = hex_asc(temp2(0), data7, 64)
  List1.AddItem ("read_hex OK")
  List1.AddItem (data7)
End If
End Sub

Private Sub Command2_Click()
st = ic_exit(icdev)
Unload Me
End Sub
 
Private Sub Command3_Click()
st = chk_24c04(icdev)
If st < 0 Then
    List1.AddItem ("chk error")
    Exit Sub
Else
    List1.AddItem ("chk card ok")
End If
 
offset = 0
For length = 0 To 9
data3(length) = 200 + length
Next length
length = 10
'对于字符的ASC码大于128的字符串，要用byref传递方式,传递byte数组的第一个元素的地址
'下面函数通过byref传递方式,传递data3()数组的第一个元素data3(0)的地址
st = swr_24c04(icdev, offset, length, data3(0))
If st < 0 Then
  List1.AddItem ("write error")
  Exit Sub
Else
  List1.AddItem ("write ok")
End If
'下面函数通过byref传递方式,传递data4()数组的第一个元素data4(0)的地址
st = srd_24c04(icdev, offset, length, data4(0))
If st = 0 Then
  For length = 0 To 9
    List1.AddItem (data4(length))
  Next length
Else
  List1.AddItem ("read error")
  Exit Sub
End If
'****************************DES算法********************
st = ic_encrypt("12345678", "明华技术开发中心", 16, ptrdest(0))
If st < 0 Then
    List1.AddItem ("ic_encrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_encrypt ok")
End If

st = ic_decrypt("12345678", ptrdest(0), 16, ptrsource)
If st < 0 Then
    List1.AddItem ("ic_decrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_decrypt ok")
    List1.AddItem (ptrsource)
End If
'**********************************************************
End Sub

Private Sub Command4_Click()
'****************************测卡函数**********************
st = chk_24c01a(icdev)
If st < 0 Then
    List1.AddItem ("chk card error")
    Exit Sub
Else
    List1.AddItem ("chk card ok")
End If
'***************************读写函数************************
offset = 0
length = 10
Data1 = String$(10, "a")
st = swr_24c01a(icdev, offset, length, Data1)
If st < 0 Then
  List1.AddItem ("write error")
  Exit Sub
Else
  List1.AddItem ("write ok")
  
End If

st = srd_24c01a(icdev, offset, length, Data2)
If st < 0 Then
  List1.AddItem ("read error")
  Exit Sub
Else
  List1.AddItem ("read ok")
  List1.AddItem (Data2)
End If
'**************************十六进制读写*********************************
offset = 10
length = 8
data5 = "0123456789abcdef"
st = asc_hex(data5, databuff1(0), 8)
If st < 0 Then
    List1.AddItem ("asc_hex error")
    Exit Sub
Else
    List1.AddItem ("asc_hex ok")
End If
    
st = swr_24c01a_hex(icdev, offset, length, databuff1(0))
If st < 0 Then
  List1.AddItem ("write_hex error")
  Exit Sub
Else
  List1.AddItem ("write_hex ok")
End If


st = srd_24c01a_hex(icdev, offset, length, databuff2(0))
If st < 0 Then
  List1.AddItem ("read_hex error")
  Exit Sub
Else
  st = hex_asc(databuff2(0), data6, 8)
  List1.AddItem ("read_hex OK")
  List1.AddItem (data6)
End If
'****************************DES算法********************

st = ic_encrypt("12345678", "明华技术开发中心", 16, ptrdest(0))
If st < 0 Then
    List1.AddItem ("ic_encrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_encrypt ok")
End If

st = ic_decrypt("12345678", ptrdest(0), 16, ptrsource)
If st < 0 Then
    List1.AddItem ("ic_decrypt error")
    Exit Sub
Else
    
    List1.AddItem ("ic_decrypt ok")
    List1.AddItem (ptrsource)
End If

End Sub

 

Private Sub Form_Unload(Cancel As Integer)
  st = ic_exit(icdev)
  Unload Me
End Sub

Private Sub Form_Load()
'***************选择串口 COM1 波特率为9600******************
icdev = auto_init(0, 9600)
If icdev < 0 Then
    List1.AddItem ("Init error!")
    Exit Sub
Else
    List1.AddItem ("Init OK")
End If
'***************获取设备当前状态****************************
st = get_status(icdev, status)
If st < 0 Then
  List1.AddItem ("Status error")
  Exit Sub
Else
  List1.AddItem ("Status ok")
End If
 
End Sub

