VERSION 5.00
Begin VB.Form MC32_Gl 
   Caption         =   "MC32_GL"
   ClientHeight    =   3960
   ClientLeft      =   2100
   ClientTop       =   1830
   ClientWidth     =   5610
   LinkTopic       =   "Form1"
   ScaleHeight     =   3960
   ScaleWidth      =   5610
   Begin VB.CommandButton Command4 
      Caption         =   "&Exit"
      Height          =   375
      Left            =   3840
      TabIndex        =   3
      Top             =   3240
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Assist"
      Height          =   375
      Left            =   3870
      TabIndex        =   2
      Top             =   1935
      Width           =   1215
   End
   Begin VB.CommandButton Init 
      Caption         =   "&Init"
      Height          =   375
      Left            =   3840
      TabIndex        =   1
      Top             =   1320
      Width           =   1215
   End
   Begin VB.ListBox List1 
      Height          =   2400
      Left            =   240
      TabIndex        =   0
      Top             =   1200
      Width           =   2655
   End
   Begin VB.PictureBox Picture1 
      Height          =   2895
      Left            =   0
      ScaleHeight     =   2835
      ScaleWidth      =   5475
      TabIndex        =   4
      Top             =   960
      Width           =   5535
      Begin VB.CommandButton Command1 
         Caption         =   "&Password"
         Height          =   375
         Left            =   3840
         TabIndex        =   5
         Top             =   1560
         Width           =   1215
      End
   End
   Begin VB.Label Label1 
      Caption         =   "通用函数调用例程"
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
      Left            =   1440
      TabIndex        =   6
      Top             =   240
      Width           =   3135
   End
End
Attribute VB_Name = "MC32_Gl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim data1 As String * 64
Dim data2 As String * 64
Dim source As String * 16
Dim ptrdest(16) As Byte
Dim ver As String * 10
Dim password(3) As Byte
Dim mypass(3) As Byte
Dim offset As Integer
Dim length As Integer
Dim Value As Long
Dim status As Integer
Dim baud As Long
Dim snr As String * 16

Private Sub Command1_Click()
'setsc_md(icdev,mode)设置读写器模式
'mode 模式(0 读写器密码设置生效，1 读写器密码设置无效)
st = setsc_md(icdev&, 1)
If st <> 0 Then
  List1.AddItem ("set mode error")
  Exit Sub
Else
  List1.AddItem ("set mode OK")
End If

length = 3
password(0) = &HFF
password(1) = &HFF
password(2) = &HFF
st = cmp_dvsc(icdev&, length, password(0))
If st <> 0 Then
  List1.AddItem ("cmp password error")
  Exit Sub
Else
  List1.AddItem ("cmp password OK")
End If

st = srd_dvsc(icdev&, 3, mypass(0))
If st <> 0 Then
  List1.AddItem ("read password error")
  Exit Sub
Else
  List1.AddItem ("read password OK")
End If

st = swr_dvsc(icdev&, length%, password(0))
If st <> 0 Then
  List1.AddItem ("write password error")
  Exit Sub
Else
  List1.AddItem ("write password OK")
End If
 
End Sub
 
Private Sub Command3_Click()

st = ic_encrypt("12345678", "abcdefghabcdefgh", 16, ptrdest(0))
If st < 0 Then
    List1.AddItem ("ic_encrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_encrypt ok")
End If

st = ic_decrypt("12345678", ptrdest(0), 16, source)
If st < 0 Then
    List1.AddItem ("ic_decrypt error")
    Exit Sub
Else
    List1.AddItem ("ic_decrypt ok")
    List1.AddItem ("source:" + source)
End If

offset = 10           'offset: 0--383
le = 9                'le    : 1--384
data1 = "MWRD_1999"

st = swr_eeprom(icdev, offset, le, data1)
If st <> 0 Then
    List1.AddItem ("swr_eeprom error")
Else
    List1.AddItem ("swr_eeprom OK")
End If

st = srd_eeprom(icdev, offset, le, data2)
If st <> 0 Then
    List1.AddItem ("srd_eeprom error")
Else
    List1.AddItem ("srd_eeprom OK")
End If

st = srd_snr(icdev, 16, snr)
If st <> 0 Then
  List1.AddItem ("read snr error")
  Exit Sub
Else
  List1.AddItem ("read snr OK")
End If

length = 10
st = srd_ver(icdev&, length%, data1$)
If st <> 0 Then
  List1.AddItem ("read ver error")
  Exit Sub
Else
  List1.AddItem ("read ver OK")
End If

st = turn_off(icdev&)
If st% <> 0 Then
  List1.AddItem ("turn_off error")
  Exit Sub
Else
  List1.AddItem ("turen off OK")
End If

st = auto_pull(ByVal icdev&)
If st <> 0 Then
  List1.AddItem ("auto pull errer")
  Exit Sub
Else
  List1.AddItem ("auto pull OK")
End If

st = dv_beep(ByVal icdev&, 10)
If st <> 0 Then
  List1.AddItem ("dv_beep errer")
  Exit Sub
Else
  List1.AddItem ("dv_beep OK")
End If


End Sub

Private Sub Command4_Click()
st% = ic_exit(icdev&)
Unload Me
End Sub

Private Sub Form_Load()
Command1.Enabled = False
Command3.Enabled = False
Command4.Enabled = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
st% = ic_exit(icdev&)
End Sub

Private Sub Init_Click()

'baud 设置PC通信波特率,为9600~115200皆可，缺省9600

icdev = auto_init(0, 9600)
'icdev = ic_init(0, 9600)
If icdev& <= 0 Then
    List1.AddItem ("Initialize error!")
    Exit Sub
  Else
    List1.AddItem ("Initialize OK")
 End If
 
st = get_status(icdev&, status%)
If st% = 0 Then
   List1.AddItem ("status OK")
   If status <> 1 Then
     List1.AddItem ("no card")
   End If
Else
  List1.AddItem ("status error")
  Exit Sub
End If

Init.Enabled = False
Command1.Enabled = True
Command3.Enabled = True
Command4.Enabled = True

End Sub
