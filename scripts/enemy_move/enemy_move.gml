/// @func	enemy_move()
/// @desc	calculates horizontal movement and moves the enemy in both axes
function enemy_move()
{
	// 005 CODE DONE
	
	// boolean condition makes it either 1 or 0
	xmv = move_direction * move_speed;
	
	x_remainder += xmv*DT;
	var _move_count = floor(abs(x_remainder)) * sign(x_remainder); // how many total pixels the character needs to move this frame.
	var _direction = sign(_move_count); // It is 1, 0, or -1.
	x_remainder -= _move_count;
	
	_move_count *= _direction;
	repeat (_move_count)
	{
		var _collision_found = check_collision(_direction, 0);

		if (!_collision_found)
			x += _direction; // goes in that direction for 1 pixel every loop
		else
			break; // stops from colliding
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
	return 0;
}