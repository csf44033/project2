WindowProc proc
	local	hWnd:qword
	local	message:dword
	local	wParam:qword
	local	lParam:qword
	PUSH r12
	PUSH r13
	PUSH r14
	push r15
	PUSH rdi
	PUSH rsi
	PUSH rbx
	PUSH rbp
	PUSH rsp
	CALL	DefWindowProc
	POP r12
	POP r13
	POP r14
	POP r15
	POP rdi
	POP rsi
	POP rbx
	POP rbp
	POP rsp
	ret
WindowProc endp