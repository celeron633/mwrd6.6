// mwic_rdDlg.h : header file
//

#if !defined(AFX_MWIC_RDDLG_H__3EED0308_6AC8_11D3_83BC_0000F74D6E2B__INCLUDED_)
#define AFX_MWIC_RDDLG_H__3EED0308_6AC8_11D3_83BC_0000F74D6E2B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CMwic_rdDlg dialog

class CMwic_rdDlg : public CDialog
{
// Construction
public:
	CMwic_rdDlg(CWnd* pParent = NULL);	// standard constructor
    ~CMwic_rdDlg();
// Dialog Data
	HANDLE icdev;
	int st, i ,l ,offset, lenth;
	unsigned short port;
	unsigned long baud;
	unsigned char icWrite[200],icRead[200],key[50],data1[50],data2[50];
	char c3[200],keya[50];
	unsigned char c1[100];
	unsigned char proval;	
	char source[50],destin[50];
	_int16 counter;
	_int16 status;

	//{{AFX_DATA(CMwic_rdDlg)
	enum { IDD = IDD_MWIC_RD_DIALOG };
	CListBox	m_list;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMwic_rdDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CMwic_rdDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnMenuitemexit();
	afx_msg void OnMenuitem24c01a();
	afx_msg void OnMENUITEM24c02();
	afx_msg void OnMENUITEM24c04();
	afx_msg void OnMENUITEM24c16();
	afx_msg void OnMENUITEM24c64();
	afx_msg void OnMenuitemconn();
	afx_msg void OnMenuitem4442();
	afx_msg void OnMENUITEMcpu();
	afx_msg void OnMENUITEMencypt();
	afx_msg void OnDES();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MWIC_RDDLG_H__3EED0308_6AC8_11D3_83BC_0000F74D6E2B__INCLUDED_)
