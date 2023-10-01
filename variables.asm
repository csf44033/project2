d2d1Factory				DQ ?
Main_Handle				DQ ?
ID2D1HwndRenderTarget	DQ ?
Black_Brush				DQ ?
in_shutdown qword 0

;WindowProc variables
classStyle		equ CS_VREDRAW OR CS_HREDRAW OR CS_DBLCLKS OR CS_OWNDC OR CS_PARENTDC
main_style		equ ws_visible or ws_tiledwindow or ws_popup or ws_border

client_width equ 300
client_height equ 300