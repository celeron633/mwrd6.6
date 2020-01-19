VERSION 4.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4155
   ClientLeft      =   1545
   ClientTop       =   1500
   ClientWidth     =   6210
   Height          =   4560
   Left            =   1485
   LinkTopic       =   "Form1"
   ScaleHeight     =   4155
   ScaleWidth      =   6210
   Top             =   1155
   Width           =   6330
   Begin VB.CommandButton Command2 
      Caption         =   "Transfer"
      BeginProperty Font 
         name            =   "MS Sans Serif"
         charset         =   1
         weight          =   400
         size            =   9.75
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5040
      TabIndex        =   4
      Top             =   2160
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Reset"
      BeginProperty Font 
         name            =   "MS Sans Serif"
         charset         =   1
         weight          =   400
         size            =   9.75
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5040
      TabIndex        =   3
      Top             =   1320
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Height          =   3255
      Left            =   240
      TabIndex        =   0
      Top             =   600
      Width           =   4575
      Begin VB.ListBox List1 
         Height          =   2595
         ItemData        =   "CPU_16.frx":0000
         Left            =   240
         List            =   "CPU_16.frx":0002
         TabIndex        =   2
         Top             =   360
         Width           =   4095
      End
   End
   Begin VB.Label Label1 
      Caption         =   "CPU卡调用例范"
      BeginProperty Font 
         name            =   "MS Sans Serif"
         charset         =   1
         weight          =   400
         size            =   18
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C000C0&
      Height          =   375
      Left            =   1200
      TabIndex        =   1
      Top             =   120
      Width           =   2655
   End
End
Attribute VB_Name = "Form1"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Dim card_s As Integer
Dim i, port As Integer
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
wdata(8) = &H0       'bcc
For i = 0 To 7
    wdata(8) = wdata(i) Xor wdata(8)     'bcc calculation
Next i

st = cpu_protocol(icdev, 9, wdata(0), rdata(0))
If st <> 0 Then
    List1.AddItem ("Transfer error")
    Exit Sub
Else
    List1.AddItem ("Transfer OK")
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
    List1.AddItem ("hex_asc error")
End If

End Sub


Private Sub Form_Load()
port = 1
baud = 9600

'icdev = auto_init(&H378, 1)    '自动初始化并口

icdev = ic_init(port, baud)
If icdev < 0 Then
    List1.AddItem ("init error")
Else
    List1.AddItem ("init OK")
End If

st = get_status(icdev, card_s)
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


