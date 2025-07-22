/// @func	player_knockback(gravity, terminal speed)
/// @desc	pushes the player backwards
/// @arg	{Real}	_gravity			gravity
/// @arg	{Real}	_terminal_speed	maximum speed of the object while falling
function player_knockback(_gravity = global.gforce*DT, _terminal_speed = global.gforce*10){
	if(ymv <= 0)
		ymv += _gravity;
	else if(ymv < _terminal_speed)
		ymv += _gravity*global.fall_gravity;
	
	x_remainder += knockback_direction*xmv*DT;
	var _move_count = floor(x_remainder); // how many total pixels the character needs to move this frame.
	var _direction = sign(_move_count); // It is 1, 0, or -1.
	x_remainder -= _move_count;
	
	_move_count *= _direction;
	repeat (_move_count)
	{
		var _collision_found = check_collision(_direction, 0);

		if (!_collision_found)
			x += _direction; // goes in that direction for 1 pixel every loop
		else {
			break; // stops from colliding
		}
	}

	// same as before but vertical movement instead
	y_remainder += ymv*DT;
	_move_count = floor(y_remainder); // how many total pixels the character needs to move this frame.
	_direction = sign(_move_count); // It is 1, 0, or -1.
	y_remainder -= _move_count;
	
	_move_count *= _direction;

	repeat (_move_count)
	{
		var _collision_found = check_collision(0, _direction);

		if (!_collision_found)
			y += _direction; // goes in that direction for 1 pixel every loop
		else {
			ymv = 0;
			break; // stops from colliding
		}
	}
	is_grounded = check_collision(0, 1);
}