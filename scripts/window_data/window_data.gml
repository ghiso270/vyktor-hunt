/// @func	WindowData(x, y, w, h)
/// @desc	constructor for a window_data struct
/// @arg	{Real}	x	horizontal position
/// @arg	{Real}	y	vertical position
/// @arg	{Real}	w	width
/// @arg	{Real}	h	height
function WindowData(_x, _y, _w, _h) constructor
{
	x = _x;
	y = _y;
	w = _w;
	h = _h;
	equals = function(window_data){
		if(x != window_data.x) return false;
		if(y != window_data.y) return false;
		if(w != window_data.w) return false;
		if(h != window_data.h) return false;
		
		return true;
	}
}