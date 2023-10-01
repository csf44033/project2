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
		LOCAL holder : qword
		Save_Registers

		;---------------------------
		; Define handles for WC
		; 1) Set `wnd_hInst`
		; 2) Set `wnd_hIcon`
		; 3) Set `wnd_hCursor`
		; 4) Register WC
		;---------------------------
		; Step 1
		XOR		rcx, rcx				; hInstance
		WinCall	GetModuleHandle			; call
		MOV		wnd_hInst, rax			; set
		; Step 2
		XOR		rcx, rcx				; hInstance
		MOV		rdx, IDI_APPLICATION	; lpIconName
		WinCall LoadIconA				; call
		MOV		wnd_hIcon, rax			; set
		; Step 3
		XOR		rcx, rcx				; hInstance
		MOV		rdx, IDI_APPLICATION	; lpCursorName
		WinCall LoadCursorA				; call
		MOV		wnd_hCursor, rax		; set
		; Step 4
		LEA		rcx, wc					; *lpWndClass
		WinCall	RegisterClass			; call
		;---------------------------

		;----------------------------------------
		; 1) Define `window_rect`
		; 2) Calculate size
		; 3) Set edges to zero
		;----------------------------------------
		; Step 1
		MOV		window_rect.right, client_width		; Set `window_rect.right` to `client_width`
		MOV		window_rect.bottom, client_height	; Set `window_rect.bottom` to `client_height`
		; Step 2
		LEA		rcx, window_rect					; lpRect
		MOV		rdx, main_style						; dwStyle
		XOR		r8, r8								; bMenu
		WinCall	AdjustWindowRect					; call
		; Step 3
		MOV		eax, window_rect.left				; Get left
		SUB		window_rect.right, eax				; Add left and right
		MOV		window_rect.left, 0					; Set left to `0`
		MOV		eax, window_rect.top				; Get top
		SUB		window_rect.bottom, eax				; Add top and bottom
		MOV		window_rect.top, 0					; Set top to `0`
		;----------------------------------------

		;---------------------------
		; Define `work_rect`
		;---------------------------
		MOV		rcx, spi_getworkarea	; uiAction
		XOR		rdx, rdx				; uiParam
		LEA		r8, work_rect			; pvParam
		XOR		r9, r9					; fWinIni
		WinCall	SystemParametersInfo	; call
		;---------------------------

		;-------------------------------------------------------------------------
		; Create window
		;-------------------------------------------------------------------------
		XOR		rcx, rcx															; dwExStyle
		LEA		rdx, CLASS_NAME														; lpClassName
		LEA		r8, main_winname													; lpWindowName
		MOV		r9, main_style														; dwStyle
		XOR		rbx, rbx															; 
		MOV		ebx, work_rect.right												; 
		SUB		ebx, window_rect.right												; 
		SHR		rbx, 1																; X
		XOR		r15, r15															;
		MOV		r15d, work_rect.bottom												;
		SUB		r15d, window_rect.bottom											;
		SHR		r15, 1																; Y
		XOR		r12, r12															;
		MOV		r12d, window_rect.right												; nWidth
		XOR		r13, r13															;
		MOV		r13d, window_rect.bottom											; nHeight
		mov		r14, wnd_hInst														; hInstance
		WinCall CreateWindowEx, rcx, rdx, r8, r9, rbx, r15, r12, r13, 0, 0, r14, 0	; call (12 params)
		;-------------------------------------------------------------------------
		WinCall GetLastError
		;-------------------
		MOV		rcx, rax
		MOV		rdx, sw_show
		WinCall	ShowWindow
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


		Restore_Registers
		ret
	Start ENDP
END