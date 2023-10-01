EXTERN __imp_D2D1CreateFactory		: dq
EXTERN __imp_GetClientRect			: dq
EXTERN __imp_RegisterClassExA			: dq
EXTERN __imp_GetModuleHandleA		: dq
EXTERN __imp_DefWindowProcA			: DQ
EXTERN __imp_ValidateRect			: DQ
EXTERN __imp_DestroyWindow			: DQ
EXTERN __imp_PostQuitMessage		: DQ
EXTERN __imp_UnregisterClassA		: DQ
EXTERN __imp_SystemParametersInfoA	: DQ
EXTERN __imp_AdjustWindowRect		: DQ
EXTERN __imp_PostQuitMessage		: DQ
EXTERN __imp_GetLastError			: dq
EXTERN __imp_LoadIconA				: dq
EXTERN __imp_LoadCursorA			: dq
EXTERN __imp_CreateWindowExA		: dq
EXTERN __imp_ShowWindow				: dq
EXTERN __imp_ExitProcess			: dq

D2D1CreateFactory		textequ <__imp_D2D1CreateFactory>
GetClientRect			textequ <__imp_GetClientRect>
RegisterClass			textequ <__imp_RegisterClassExA>
GetModuleHandle			textequ <__imp_GetModuleHandleA>
DefWindowProc			textequ <__imp_DefWindowProcA>
ValidateRect			textequ <__imp_ValidateRect>
DestroyWindow			textequ <__imp_DestroyWindow>
PostQuitMessage			textequ <__imp_PostQuitMessage>
UnregisterClass			textequ <__imp_UnregisterClassA>
SystemParametersInfo	textequ <__imp_SystemParametersInfoA>
AdjustWindowRect		textequ <__imp_AdjustWindowRect>
PostQuitMessage			textequ <__imp_PostQuitMessage>
GetLastError			textequ <__imp_GetLastError>
CreateWindowEx			textequ <__imp_CreateWindowExA>
LoadIconA				textequ <__imp_LoadIconA>
LoadCursorA				textequ <__imp_LoadCursorA>
ShowWindow				textequ <__imp_ShowWindow>
ExitProcess				textequ <__imp_ExitProcess>