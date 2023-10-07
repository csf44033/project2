client_rect rect <>
window_rect rect <>
work_rect rect <>
render_target_properties LABEL d2d1_render_target_properties
	dd 0
	dd 0
	dd 0
	dd ?
	real4 0.0
	real4 0.0
	dd 0
	dd 0
hwnd_render_target_properties LABEL d2d1_hwnd_render_target_properties
	dq ?
	dd ?
	dd ?
	dd 0
color_black LABEL d3dcolorvalue
	real4 0.0
	real4 0.0
	real4 0.0
	real4 1.0

wc LABEL WNDCLASS
				DD classStyle
				DD ?
				DQ defWindowProc
				DD 0
				DD 0
wnd_hinst		DQ ?
wnd_hIcon		DQ ?
wnd_hCursor		DQ ?
				DQ 0
				DQ 0
				DQ CLASS_NAME