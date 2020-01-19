VERSION 5.00
Begin VB.Form MC32_45 
   Caption         =   "MC32_45"
   ClientHeight    =   3870
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5805
   LinkTopic       =   "Form1"
   ScaleHeight     =   3870
   ScaleWidth      =   5805
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command6 
      Caption         =   "45d041"
      Height          =   375
      Left            =   3600
      TabIndex        =   1
      Top             =   1920
      Width           =   1215
   End
   Begin VB.ListBox List1 
      Height          =   2400
      Left            =   360
      TabIndex        =   0
      Top             =   1080
      Width           =   2655
   End
   Begin VB.PictureBox Picture1 
      Height          =   2895
      Left            =   120
      ScaleHeight     =   2835
      ScaleWidth      =   5475
      TabIndex        =   2
      Top             =   840
      Width           =   5535
   End
   Begin VB.Label Label1 
      Caption         =   "45系列函数调用例程"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   1560
      TabIndex        =   3
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "MC32_45"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim page As Integer
Dim offset As Integer
Dim data1 As String * 16
Dim data2 As String * 16
Dim length As Integer
Dim ch(1) As Byte
Dim i As Integer
Dim databuff1(0) As Byte
Dim databuff2(0) As Byte
Dim ptrdest(16) As Byte
Dim ptrsource As String * 16

Private Sub Command6_Click()

st = turn_on(icdev)
st = chk_45d041(icdev)
If st = 0 Then
  List1.AddItem ("chk OK")
Else
  List1.AddItem ("chk error")
  Exit Sub
End If

'****************************读写卡*****************************

page = 0
offset = 0
length = 10
data1 = "0123456789"
st = swr_45d041(icdev, page, offset, length, data1)
If st = 0 Then
  List1.AddItem ("write OK")
Else
  List1.AddItem ("write error")
  Exit Sub
End If


st = srd_45d041(icdev, page, offset, length, data2)
If st = 0 Then
  List1.AddItem ("read OK")
  List1.AddItem (data2)
Else
  List1.AddItem ("read error")
  Exit Sub
End If
'****************************十六进制读写**************************

page = 0
offset = 40
length = 10
data1 = "abcdef0123456789"
st = asc_hex(data1, databuff1(0), 8)
If st = 0 Then
   List1.AddItem ("asc_hex ok")
   Else
   List1.AddItem ("asc_hex error")
   Exit Sub
   End If
   
st = swr_45d041_hex(icdev, page, offset, length, databuff1(0))
If st = 0 Then
  List1.AddItem ("write_hex OK")
Else
  List1.AddItem ("write_hex error")
  Exit Sub
End If


st = srd_45d041_hex(icdev, page, offset, length, databuff2(0))
If st = 0 Then
  st = hex_asc(databuff2(0), data2, 8)
  List1.AddItem ("read_hex OK")
  List1.AddItem (data2)
Else
  List1.AddItem ("read_hex error")
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

Private Sub Form_Load()

'icdev& = auto_init(1, 9600)

icdev& = ic_init(0, 9600)
If icdev& <= 0 Then
    List1.AddItem ("Init error!")
    Exit Sub
  Else
    List1.AddItem ("Init OK")
  End If
 
  
st = get_status(icdev, status)
If st = 0 Then
  List1.AddItem ("Status OK")
Else
  List1.AddItem ("Status Error")
  Exit Sub
End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
st = ic_exit(icdev)
End Sub

