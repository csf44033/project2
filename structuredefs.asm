rect STRUCT
	left	dd ?
	top		dd ?
	right	dd ?	
	bottom	dd ?
rect ENDS

d2d1_pixel_format STRUCT
	format		dd ?
	alphaMode	dd ?
d2d1_pixel_format ENDS

d2d1_render_target_properties STRUCT
	_type		dd ?
	pixelFormat	d2d1_pixel_format <>
	dpiX		real4 0.0
	dpiY		real4 0.0
	usage		dd ?
	minLevel	dd ?
d2d1_render_target_properties ENDS

d2d1_size_u STRUCT
	_width	dd ?
	_height	dd ?
d2d1_size_u ENDS

d2d1_hwnd_render_target_properties STRUCT
	hwnd			dq ?
	pixelSize		d2d1_size_u <>
	presentOptions	dd ?
d2d1_hwnd_render_target_properties ENDS

d3dcolorvalue STRUCT
	r real4 0.0
	g real4 0.0
	b real4 0.0
	a real4 0.0
d3dcolorvalue ENDS

WNDCLASS STRUCT
	cbSize			DD SIZEOF(WNDCLASS)
	style			DD ?
	WNDPROC			DQ ?
	cbClsExtra		DD ?
	cbWndExtra		DD ?
	hInstance		DQ ?
	hIcon			DQ ?
	hCursor			DQ ?
	hbrBackground	DQ ?
	lpszMenuName	DQ ?
	lpszClassName	DQ ?
	hIconSm			DQ ?
WNDCLASS ENDS