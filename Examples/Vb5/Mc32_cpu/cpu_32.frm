VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4365
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6540
   LinkTopic       =   "Form1"
   ScaleHeight     =   4365
   ScaleWidth      =   6540
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Get Random"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5040
      TabIndex        =   3
      Top             =   2640
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "REST"
      Height          =   375
      Left            =   5040
      TabIndex        =   1
      Top             =   1680
      Width           =   1335
   End
   Begin VB.ListBox List1 
      ForeColor       =   &H00FF0000&
      Height          =   2790
      Left            =   480
      TabIndex        =   0
      Top             =   960
      Width           =   4095
   End
   Begin VB.Frame Frame1 
      Height          =   3375
      Left            =   240
      TabIndex        =   4
      Top             =   600
      Width           =   4575
   End
   Begin VB.Label Label1 
      Caption         =   "CPU卡调用例范"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   18
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C000C0&
      Height          =   375
      Left            =   1560
      TabIndex        =   2
      Top             =   120
      Width           =   2415
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim sta, i, port As Integer
Dim wdata(100) As Byte
Dim rdata(100) As Byte
Dim hexdata As String * 200

Private Sub Command1_Click()

List1.Refresh

st = cpu_reset(icdev, rdata(0))
If st <> 0 Then
    List1.AddItem ("Reset error")
    Exit Sub
Else
    List1.AddItem ("Reset OK")
End If

st = hex_asc(rdata(0), hexdata, 20)
If st = 0 Then
    List1.AddItem (hexdata)
Else
    List1.AddItem ("convert error")
End If


End Sub

Private Sub Command2_Click()

List1.Clear
List1.Refresh

wdata(0) = &H0        'nad
wdata(1) = &H40       'pcb
wdata(2) = &H5        'length
wdata(3) = &H0        'get random
wdata(4) = &H84
wdata(5) = &H0
wdata(6) = &H0
wdata(7) = &H8
wdata(8) = &H0        'bcc
For i = 0 To 7
    wdata(8) = wdata(i) Xor wdata(8)     'bcc calculation
Next i

st = cpu_protocol(icdev, 9, wdata(0), rdata(0))
If st <> 0 Then
    List1.AddItem ("Transfer error")
    Exit Sub
End If

st = hex_asc(rdata(0), hexdata, 13)
If st = 0 Then
    List1.AddItem ("return: " + hexdata)
    List1.AddItem ("nad: " + Left(hexdata, 2))
    List1.AddItem ("pcb: " + Mid(hexdata, 3, 2))
    List1.AddItem ("len: " + Mid(hexdata, 5, 2))
    List1.AddItem ("random: " + Mid(hexdata, 7, 16))
    List1.AddItem ("sw1sw2: " + Mid(hexdata, 23, 4))
Else
    List1.AddItem ("convert error")
End If

End Sub

Private Sub Form_Load()

port = 1
baud = 9600
'icdev = auto_init(&H378, 1)    '初始化并口
icdev = auto_init(port, baud)     '初始化串口2
If icdev < 0 Then
    List1.AddItem ("init error")
Else
    List1.AddItem ("init OK")
End If

st = get_status(icdev, sta)
If st = 0 Then
   List1.AddItem ("Status OK")
Else
   List1.AddItem ("Status Error")
   Exit Sub
End If

End Sub

Private Sub Form_Unload(Cancel As Integer)

st = ic_exit(ByVal icdev)
End

End Sub

