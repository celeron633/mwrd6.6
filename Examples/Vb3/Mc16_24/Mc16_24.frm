VERSION 4.00
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H00E0E0E0&
   Caption         =   "Form1"
   ClientHeight    =   4020
   ClientLeft      =   1320
   ClientTop       =   1605
   ClientWidth     =   5925
   BeginProperty Font 
      name            =   "MS Sans Serif"
      charset         =   1
      weight          =   700
      size            =   8.25
      underline       =   0   'False
      italic          =   0   'False
      strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Height          =   4425
   Left            =   1260
   LinkTopic       =   "Form1"
   ScaleHeight     =   4020
   ScaleWidth      =   5925
   Top             =   1260
   Width           =   6045
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   495
      Left            =   4560
      TabIndex        =   3
      Top             =   2640
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "24c01a"
      Height          =   375
      Left            =   4560
      TabIndex        =   1
      Top             =   1800
      Width           =   1215
   End
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      Height          =   2370
      Left            =   360
      TabIndex        =   0
      Top             =   1200
      Width           =   3855
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "24系列函数调用例程"
      BeginProperty Font 
         name            =   "MS Sans Serif"
         charset         =   1
         weight          =   700
         size            =   18
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   1080
      TabIndex        =   2
      Top             =   360
      Width           =   3615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Dim Data1 As String * 10
Dim data2 As String * 10
Dim Offset As Integer
Dim length As Integer
Dim status As Integer

 

Private Sub Command1_Click()




st = chk_24c01a(icdev)
If st = 0 Then
    List1.AddItem ("chk Ok")
Else
    List1.AddItem ("chk card error")
End If
 
Offset = 0
length = 10
Data1 = Chr(233) + Chr(221) + "12345678"
st = swr_24c01a(icdev, Offset, length, Data1)
If st = 0 Then
  List1.AddItem ("write OK")
Else
  List1.AddItem ("write error")
  Exit Sub
End If

st = srd_24c01a(icdev, Offset, length, data2)
If st = 0 Then
  List1.AddItem ("read OK")
  List1.AddItem (data2)
Else
  List1.AddItem ("read error")
  Exit Sub
End If

End Sub

Private Sub Command2_Click()

Dim cmdlen As Long
Dim datainlen As Long
Dim dataoutlen As Long
Dim cmd, temp As String * 50
Dim mydata As String * 200
Dim dataIN As String * 100
Dim dataOut(200) As Byte
Dim i As Integer
Dim Handle As Long

Handle = -1
    cmd = "System,Info"
    cmdlen = Len(cmd)
    st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)

    cmd = "System,Create"
    cmdlen = Len(cmd)
    st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
   
    cmd = "Device,List"
    cmdlen = Len(cmd)
    st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
    
    cmd = "Device,Select,-1"
    cmdlen = Len(cmd)
    st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
    
    cmd = "Card,Info,Type"
    cmdlen = Len(cmd)
    st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
    
    i = 0
    Do While i < 100
    List1.Clear
    List1.Refresh
    
        i = i + 1
        cmd = "Card,T0TX"
        cmdlen = Len(cmd)
        dataIN = Chr(&H0) + Chr(&HD6) + Chr(&H83) + Chr(&H0) + Chr(&H18) + Chr(&H30) + Chr(&H31) + Chr(&H32) + Chr(&H33) + Chr(&H34) + Chr(&H35) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H30) + Chr(&H31) + Chr(&H32) + Chr(&H35) + Chr(&H35) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H55) + Chr(&H50) + Chr(&H30)
        datainlen = 29
        st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
        If st <> 0 Then
            List1.AddItem ("Updata Error:" + Str(st))
            GoTo MYEnd
        End If
        
        If (dataOut(0) <> &H90 Or dataOut(1) <> &H0) Then
             List1.AddItem ("WS:" + Str(Hex(dataOut(0))) + Str(Hex(dataOut(1))))
             GoTo MYEnd
        End If
        
        'mydata = Mid(dataIN, 5, 24)
        List1.AddItem (" time:" + Str(i))
       ' List1.AddItem ("WSw1Sw2:" + Str$(Hex(dataOut(0))) + Str$(Hex(dataOut(1))))
        List1.AddItem ("WS:" + Str(dataOut(0)) + Str(dataOut(1)))
        
        dataOut(0) = &HFF
        dataOut(1) = &HFF
        dataOut(2) = &HFF
        dataOut(3) = &HFF
        dataOut(4) = &HFF
        dataOut(5) = &HFF
        cmd = "Card,APDU"
        cmdlen = Len(cmd)
        dataIN = Chr(&H0) + Chr(&HB0) + Chr(&H83) + Chr(&H0) + Chr(&H18)
        datainlen = 5
        st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
        If st <> 0 Then
            List1.AddItem (" Read error:" + Str(st))
            GoTo MYEnd
        End If
        
        If (dataOut(0) <> &H90 Or dataOut(1) <> &H0) Then
             List1.AddItem ("RS:" + Str(dataOut(0)) + Str(dataOut(1)))
             GoTo MYEnd
        End If
     
        List1.AddItem ("RS:" + Str(dataOut(0)) + Str(dataOut(1))) '+ Str(dataOut(2)) + Str(dataOut(3)) + Str(dataOut(4)) + Str(dataOut(5)))
        'List1.AddItem ("RS:" + Str(Hex(dataOut(0))) + Str(Hex(dataOut(1))))
    
   Loop
    
MYEnd:
       cmd = "System,Destroy,Handle"
       cmdlen = Len(cmd)
       st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)

   Exit Sub

   i = 0
   Do While i < 100
   
        i = i + 1
        cmd = "Card,T0TX"
        cmdlen = Len(cmd)
        dataIN = Chr(&H80) + Chr(&HE8) + Chr(&H1) + Chr(&H0) + Chr(&H18) + Chr(&H4) + Chr(&H1) + Chr(&H0) + Chr(&H9) + Chr(&HF) + Chr(&H0) + Chr(&HF) + Chr(&HFF) + Chr(&H11) + Chr(&H22) + Chr(&H33) + Chr(&H44) + Chr(&H55) + Chr(&H66) + Chr(&H77) + Chr(&H88) + Chr(&H88) + Chr(&H77) + Chr(&H66) + Chr(&H55) + Chr(&H44) + Chr(&H33) + Chr(&H22) + Chr(&H99)
        dataoutlen = 10
        datainlen = 29
        st = SCardComand(Handle, cmd, cmdlen, dataIN, datainlen, dataOut(0), dataoutlen)
        If st <> 0 Then
            List1.AddItem ("Error:" + Str(st))
           ' Exit Sub
        End If
        
        List1.AddItem (" time:" + Str(i))
        List1.AddItem ("WS:" + Str(Hex(dataOut(0))) + Str(Hex(dataOut(1))))
        
        If (dataOut(0) <> &H90 Or dataOut(1) <> &H0) Then
             List1.AddItem ("WS:" + Str(Hex(dataOut(0))) + Str(Hex(dataOut(1))))
             Exit Sub
        End If
        
   Loop

End Sub


Private Sub Form_Load()
'icdev = ic_init(1, 9600)
'If icdev <= 0 Then
    List1.AddItem ("Init error!")
   ' Exit Sub '
 ' Else
    List1.AddItem ("Init OK")
 ' End If
  
'st = get_status(icdev, status)
If st = 0 Then
  List1.AddItem ("Status OK")
Else
  List1.AddItem ("Status Error")
  'Exit Sub '
End If
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
'st = ic_exit(icdev)
End
End Sub

