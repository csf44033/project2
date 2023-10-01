WindowProc proc
	local	holder:qword
	local	hWnd:qword
	local	lParam:qword
	local	message:qword
	local	wParam:qword
	Save_Registers
	MOV		hWnd, rcx
	MOV		message, rdx
	MOV		wParam, r8
	MOV		lParam, r9
	CMP		message, WM_CLOSE
	JNE		Ldefault
	XOR		rcx, rcx
	WinCall PostQuitMessage

	Ldefault:
	MOV		rcx, hwnd
	MOV		rdx, message
	Mov		r8, wParam
	MOV		r9, lParam
	WinCall	DefWindowProc
	Restore_Registers
	ret
WindowProc endp