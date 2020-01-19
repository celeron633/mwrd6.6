// mwic_rd.h : main header file for the MWIC_RD application
//

#if !defined(AFX_MWIC_RD_H__3EED0306_6AC8_11D3_83BC_0000F74D6E2B__INCLUDED_)
#define AFX_MWIC_RD_H__3EED0306_6AC8_11D3_83BC_0000F74D6E2B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CMwic_rdApp:
// See mwic_rd.cpp for the implementation of this class
//

class CMwic_rdApp : public CWinApp
{
public:
	CMwic_rdApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMwic_rdApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CMwic_rdApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MWIC_RD_H__3EED0306_6AC8_11D3_83BC_0000F74D6E2B__INCLUDED_)
