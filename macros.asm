AInclude macro filename
  align qword
  include filename
 endm 
Restore_Registers macro
	pop rbx
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	pop r8
	pop r9
	pop r10
	pop r11
	pop r12
	pop r13
	pop r14
	pop r15
endm
Save_Registers macro
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
endm
WinCall macro call_dest:req, argnames:vararg
	local               jump_1, lpointer, numArgs
	numArgs             = 0
	for                 argname, <argnames>
		numArgs           = numArgs + 1
	endm
	if numArgs lt 4
		numArgs = 4
	endif
	mov                 holder, rsp
	sub                 rsp, numArgs * 8
	test                rsp, 0Fh
	jz                  jump_1
	and                 rsp, 0FFFFFFFFFFFFFFF0h
	jump_1:
	lPointer            = 0
	for                 argname, <argnames>
		if                lPointer gt 24
			mov             rax, argname
			mov             [ rsp + lPointer ], rax
		elseif            lPointer eq 0
			mov             rcx, argname
		elseif            lPointer eq 8
			mov             rdx, argname
		elseif            lPointer eq 16
			mov             r8, argname
		elseif            lPointer eq 24
			mov             r9, argname
		endif
		lPointer          = lPointer + 8
	endm
	call                call_dest
	mov                 rsp, holder
endm  