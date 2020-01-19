VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3810
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5745
   LinkTopic       =   "Form1"
   ScaleHeight     =   3810
   ScaleWidth      =   5745
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox List1 
      Height          =   2400
      Left            =   360
      TabIndex        =   0
      Top             =   960
      Width           =   2655
   End
   Begin VB.PictureBox Picture1 
      Height          =   2895
      Left            =   120
      ScaleHeight     =   2835
      ScaleWidth      =   5475
      TabIndex        =   1
      Top             =   720
      Width           =   5535
      Begin VB.CommandButton Command1 
         Caption         =   "93c46"
         Height          =   375
         Left            =   3480
         TabIndex        =   2
         Top             =   1080
         Width           =   1215
      End
   End
   Begin VB.Label Label1 
      Caption         =   "06系列函数调用例程"
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
      Left            =   1320
      TabIndex        =   3
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim offset As Integer
Dim data1 As String * 10
Dim data2 As String * 10
'Dim data1 As String * 10
Dim length As Integer
Dim ch As String * 10
Dim databuff1(7) As Byte
Dim databuff2(7) As Byte
Dim data3 As String * 16
Dim data4 As String * 16
Dim ptrdest(16) As Byte
Dim ptrsource As String * 16
Private Sub Command1_Click()
'*************************测卡函数**********************
st = chk_93c46(icdev)
If st = 0 Then
  List1.AddItem ("chk OK")
Else
  List1.AddItem ("chk error")
  Exit Sub
End If
'***********************读写卡操作**********************
 
offset = 30
length = 10
data1 = String(10, "a")
st = swr_93c46(icdev, offset, length, data1)
If st = 0 Then
  List1.AddItem ("write OK")
Else
  List1.AddItem ("write error")
  Exit Sub
End If

st = srd_93c46(icdev, offset, length, data2)
If st = 0 Then
  List1.AddItem ("read OK")
  List1.AddItem (data2)
Else
  List1.AddItem ("read error")
  Exit Sub
End If

'*******************十六进制读写******************************

offset = 56
length = 8
data3 = "abcdef0123456789"
st = asc_hex(data3, databuff1(0), 8)
If st < 0 Then
    List1.AddItem ("asc_hex error")
Else
    List1.AddItem ("asc_hex ok")
End If
    
st = swr_93c46_hex(icdev, offset, length, databuff1(0))
If st < 0 Then
  List1.AddItem ("write_hex error")
  Exit Sub
Else
  List1.AddItem ("write_hex ok")
End If


st = srd_93c46_hex(icdev, offset, length, databuff2(0))
If st < 0 Then
  List1.AddItem ("read_hex error")
  Exit Sub
Else
  st = hex_asc(databuff2(0), data4, 8)
  List1.AddItem ("read_hex OK")
  List1.AddItem (data4)
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

'icdev& = ic_init(1, 9600)
icdev& = auto_init(0, 9600)
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

