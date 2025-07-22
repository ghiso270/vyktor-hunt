/// @func check_collision(dx,dy)
/// @desc checks collisions
/// @arg {Real}	_dx	horizontal movement
/// @arg {Real}	_dy	vertical movement
/// @return {Bool}
function check_collision(_dx, _dy) 
{
	return place_meeting(x + _dx, y + _dy, global.obstacles);
}