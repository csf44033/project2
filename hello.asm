;libraries
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib
INCLUDELIB d2d1.lib

.DATA
	include macros.asm
	Ainclude strings.asm
	Ainclude variables.asm
	Ainclude wincons.asm
	Ainclude externals.asm
	Ainclude vTable.asm
	Ainclude structuredefs.asm
	Ainclude structures.asm
	Ainclude riid.asm
	Ainclude methods.asm
.CODE
	Start PROC
		;-----------------------------------------------------------------------------------------------------------------------
		; Save non-volatile registers
		PUSH r12
		PUSH r13
		PUSH r14
		push r15
		PUSH rdi
		PUSH rsi
		PUSH rbx
		PUSH rbp
		PUSH rsp
		;-----------------------------------------------------------------------------------------------------------------------
		; Register class
		XOR		rcx, rcx				; hInstance
		CALL	GetModuleHandle			; call
		MOV		wnd_hInst, rax			; set
		XOR		rcx, rcx				; hInstance
		MOV		rdx, IDI_APPLICATION	; lpIconName
		CALL	LoadIconA				; call
		MOV		wnd_hIcon, rax			; set
		XOR		rcx, rcx				; hInstance
		MOV		rdx, IDI_APPLICATION	; lpCursorName
		CALL	LoadCursorA				; call
		MOV		wnd_hCursor, rax		; set
		LEA		rcx, wc					; *lpWndClass
		CALL	RegisterClassA			; call
		;-----------------------------------------------------------------------------------------------------------------------
		; Set `window_rect`
		MOV		window_rect.right, client_width		; Set `window_rect.right` to `client_width`
		MOV		window_rect.bottom, client_height	; Set `window_rect.bottom` to `client_height`
		LEA		rcx, window_rect					; lpRect
		MOV		rdx, main_style						; dwStyle
		XOR		r8, r8								; bMenu
		CALL	AdjustWindowRect					; call
		MOV		eax, window_rect.left				; Get left
		SUB		window_rect.right, eax				; Add left and right
		MOV		window_rect.left, 0					; Set left to `0`
		MOV		eax, window_rect.top				; Get top
		SUB		window_rect.bottom, eax				; Add top and bottom
		MOV		window_rect.top, 0					; Set top to `0`
		;-----------------------------------------------------------------------------------------------------------------------
		; Set `work_rect`
		MOV		rcx, spi_getworkarea	; uiAction
		XOR		rdx, rdx				; uiParam
		LEA		r8, work_rect			; pvParam
		XOR		r9, r9					; fWinIni
		CALL	SystemParametersInfo	; call
		;-----------------------------------------------------------------------------------------------------------------------
		XOR		rcx, rcx				; dwExStyle
		LEA		rdx, CLASS_NAME			; lpClassName
		LEA		r8, main_winname		; lpWindowName
		MOV		r9, main_style			; dwStyle
		PUSH	0						; lpParam
		PUSH	wnd_hInst				; hInstance
		PUSH	0						; hMenu
		PUSH	0						; hWndParent
		XOR		rax, rax
		MOV		eax, window_rect.bottom
		PUSH	rax						; nHeight
		XOR		rax, rax
		MOV		eax, window_rect.right
		PUSH	rax						; nWidth
		XOR		rax, rax
		MOV		eax, work_rect.bottom
		SUB		eax, window_rect.bottom
		SHR		rax, 1
		PUSH	rax						; Y
		XOR		rax, rax 
		MOV		eax, work_rect.right 
		SUB		eax, window_rect.right 
		SHR		rax, 1
		PUSH	rax						; X
		CALL CreateWindowEx				; call

		;WinCall GetLastError
		;-------------------
		;MOV		rcx, rax
		;MOV		rdx, sw_show
		;WinCall	ShowWindow
		;-------------------

		;-----[Create Factory]-----
		;MOV rcx, D2D1_FACTORY_TYPE_SINGLE_THREADED  ; param1 INT
		;XOR rcx, rcx
		;LEA rdx, IID_ID2D1Factory					; param2 *RIID
		;XOR r8, r8									; param3 void
		;LEA r9, d2d1Factory							; param4 *d2dFactory
		;WinCall D2D1CreateFactory

		;-----[get client rect]-----
		;MOV rcx, Main_Handle
		;LEA rdx, client_rect
		;XOR r8, r8
		;XOR r9, r9
		;WinCall GetClientRect

		;MOV rax, Main_Handle
		;MOV hwnd_render_target_properties.hwnd, rax
		;XOR rax, rax
		;MOV eax, client_rect.right
		;MOV hwnd_render_target_properties.pixelSize._width, eax
		;MOV eax, client_rect.bottom
		;MOV hwnd_render_target_properties.pixelSize._height, eax

		;-----[get desktop dpi]-----
		;MOV rcx, d2d1Factory
		;MOV rbx, [rcx]
		;LEA rdx, render_target_properties.dpiX
		;LEA r8, render_target_properties.dpiY
		;XOR r9, r9
		;WinCall ID2D1Factory_GetDesktopDpi

		; ----- ID2D1Factory::CreateHwndRenderTarget -----
		; [in]  D2D1_RENDER_TARGET_PROPERTIES      *renderTargetProperties
		; [in]  D2D1_HWND_RENDER_TARGET_PROPERTIES *hwndRenderTargetProperties
		; [out] ID2D1HwndRenderTarget              **hwndRenderTarget
		;MOV rcx, d2d1Factory
		;MOV rbx, [rcx]
		;LEA rdx, render_target_properties
		;LEA r8, hwnd_render_target_properties
		;LEA r9, ID2D1HwndRenderTarget
		;WinCall ID2D1Factory_CreateHwndRenderTarget
		;
		; ----- ID2D1RenderTarget::CreateSolidColorBrush -----
		; [in]  const D2D1_COLOR_F & color,
		; [out] ID2D1SolidColorBrush **solidColorBrush
		;MOV rcx, ID2D1HwndRenderTarget
		;MOV rbx, [rcx]
		;LEA rdx, color_black
		;LEA r8, Black_Brush
		;XOR r9, r9
		;WinCall ID2D1RenderTarget_CreateSolidColorBrush
		;MOV rax, ID2D1HwndRenderTarget
		;xor rcx, rcx
		;WinCall ExitProcess
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
	Start ENDP
END