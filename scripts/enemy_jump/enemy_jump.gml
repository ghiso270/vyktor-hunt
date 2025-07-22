/// @func	enemy_jump(gravity, terminal_speed)
/// @desc	calculates vertical movement, but doesn't directly apply it
/// @arg	{Real}	_gravity	gravity
/// @arg	{Real}	_terminal_speed	maximum speed of the object while falling
function enemy_jump(_gravity = global.gforce*DT, _terminal_speed = global.gforce*10)
{
	// 005 CODE DONE
	if(is_grounded)
		ymv = -jump_speed;
	else if(ymv < 0)
		ymv += _gravity;
	else if(ymv < _terminal_speed)
		ymv += _gravity// /global.fall_gravity;
		
	return 0;
}
