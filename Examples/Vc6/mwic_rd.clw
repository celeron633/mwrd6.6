; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CAboutDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "mwic_rd.h"

ClassCount=3
Class1=CMwic_rdApp
Class2=CMwic_rdDlg
Class3=CAboutDlg

ResourceCount=4
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDD_MWIC_RD_DIALOG
Resource4=IDR_MENU1

[CLS:CMwic_rdApp]
Type=0
HeaderFile=mwic_rd.h
ImplementationFile=mwic_rd.cpp
Filter=N

[CLS:CMwic_rdDlg]
Type=0
HeaderFile=mwic_rdDlg.h
ImplementationFile=mwic_rdDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=DES

[CLS:CAboutDlg]
Type=0
HeaderFile=mwic_rdDlg.h
ImplementationFile=mwic_rdDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_MWIC_RD_DIALOG]
Type=1
Class=CMwic_rdDlg
ControlCount=3
Control1=IDC_STATIC,static,1342177287
Control2=IDC_LIST1,listbox,1352728835
Control3=IDC_STATIC,static,1342308865

[MNU:IDR_MENU1]
Type=1
Class=CAboutDlg
Command1=ID_MENUITEMEXIT
Command2=ID_MENUITEMCONN
Command3=ID_MENUITEM24C01A
Command4=ID_MENUITEM24c02
Command5=ID_MENUITEM24c04
Command6=ID_MENUITEM24c16
Command7=ID_MENUITEM24c64
Command8=ID_MENUITEM4442
Command9=ID_MENUITEMcpu
Command10=DES
CommandCount=10

