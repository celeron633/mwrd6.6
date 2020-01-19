VERSION 5.00
Begin VB.Form MC32_42 
   Caption         =   "Form1"
   ClientHeight    =   3810
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5760
   LinkTopic       =   "Form1"
   ScaleHeight     =   3810
   ScaleWidth      =   5760
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command6 
      Caption         =   "4442"
      Height          =   375
      Left            =   3840
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
      Caption         =   "42系列函数调用例程"
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
      Height          =   495
      Left            =   1560
      TabIndex        =   3
      Top             =   120
      Width           =   3495
   End
End
Attribute VB_Name = "MC32_42"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Data1 As String * 16
Dim Data2 As String * 16
Dim databuff1(7) As Byte
Dim databuff2(7) As Byte
Dim offset As Integer
Dim length As Integer
Dim status As Integer
Dim password(2) As Byte
Dim proval As String * 8
Dim counter As Integer
Dim oldpass As String
Dim ptrdest(16) As Byte
Dim ptrsource As String * 16
Private Sub Command6_Click()

'****************************测4442卡****************************
st = chk_4442(icdev)
If st < 0 Then
    List1.AddItem ("chk card error")
    Exit Sub
Else
    List1.AddItem ("chk card ok")
End If

'******************************校验密码****************************
'password(0) = &HB6
'password(1) = &H23
'password(2) = &H7
oldpass = "b62307"
st = asc_hex(oldpass, password(0), 3)
If st < 0 Then
    List1.AddItem ("asc_hex error")
    Exit Sub
Else
    List1.AddItem ("asc_hex ok")
End If


st = csc_4442(icdev, 3, password(0))
If st < 0 Then
    List1.AddItem ("csc error")
    Exit Sub
Else
    List1.AddItem ("csc  ok")
End If

'***********************读出卡密码***************************
st = rsc_4442(icdev, 3, password(0))
 
If st < 0 Then
    List1.AddItem ("rsc error")
    Exit Sub
Else
    List1.AddItem ("rsc  ok")
End If
'**********************改写密码******************************

password(0) = &HB6
password(1) = &H23
password(2) = &H7
'st = wsc_4442(icdev, 3, password(0))
If st < 0 Then
    List1.AddItem ("wsc error")
Else
    List1.AddItem ("wsc ok")
End If
'*********************读出密码错误计数器**********************
st = rsct_4442(icdev, counter)
If st < 0 Then
    List1.AddItem ("rsct  error")
    Exit Sub
Else
    List1.AddItem ("rsct Ok")
    List1.AddItem (Str(counter))
End If

'**********************读写卡 *******************************
offset = 40
length = 10
Data1 = "1234567890"
st = swr_4442(icdev, offset, length, Data1)
If st < 0 Then
  List1.AddItem ("write error")
  Exit Sub
Else
  List1.AddItem ("write OK")
End If

st = srd_4442(icdev, offset, length, Data2)
If st < 0 Then
  List1.AddItem ("read error")
  Exit Sub
Else
  List1.AddItem ("read OK")
  List1.AddItem (Data2)
End If

'**********************读写保护区******************************
proval = "6"
'st = pwr_4442(icdev, 30, 1, proval)
If st < 0 Then
  List1.AddItem ("pwr error")
  Exit Sub
Else
  List1.AddItem ("pwr OK")
  List1.AddItem (proval)
End If

st = prd_4442(icdev, 4, proval)
If st < 0 Then
  List1.AddItem ("prd error")
  Exit Sub
Else
  List1.AddItem ("prd OK")
End If
'*******************十六进制读写******************************

offset = 56
length = 8
Data1 = "abcdef0123456789"
st = asc_hex(Data1, databuff1(0), 8)
If st < 0 Then
    List1.AddItem ("asc_hex error")
Else
    List1.AddItem ("asc_hex ok")
End If
    
st = swr_4442_hex(icdev, offset, length, databuff1(0))
If st < 0 Then
  List1.AddItem ("write error")
  Exit Sub
Else
  List1.AddItem ("write ok")
End If


st = srd_4442_hex(icdev, offset, length, databuff2(0))
If st < 0 Then
  List1.AddItem ("read error")
  Exit Sub
Else
  st = hex_asc(databuff2(0), Data2, 8)
  List1.AddItem ("read OK")
  List1.AddItem (Data2)
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

icdev = auto_init(0, 9600)
If icdev < 0 Then
    List1.AddItem ("Init error!")
    Exit Sub
Else
    List1.AddItem ("Init OK")
End If
  
st = get_status(icdev, status)
If st < 0 Then
  List1.AddItem ("Status error")
  Exit Sub
Else
  List1.AddItem ("Status ok")
End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
  
 st = ic_exit(icdev)
 
End Sub

