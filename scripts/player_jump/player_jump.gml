/// @func	player_jump(gravity, terminal_speed)
/// @desc	calculates vertical movement, but doesn't directly apply it
/// @arg	{Real}	_gravity	gravity
/// @arg	{Real}	_terminal_speed	maximum speed of the object while falling
function player_jump(_gravity = global.gforce*DT, _terminal_speed = global.gforce*10)
{
	// stores the jumping intent for a few frames, so the jump can happen immediately when the ground is touched
	if(keyboard_check_pressed(jump_key)) jump_key_buffer = global.jump_key_buffer_max;
	
	// if the jump button isn't pressed, stop the long jump
	if(!keyboard_check(jump_key)) jump_timer = 0;

	// if touching ground start the jump
	if(is_grounded){
		// if touching ground start the jump
		if(jump_key_buffer > 0) {
			jump_key_buffer = 0;
			coyote_timer = 0;
			jump_timer = global.jump_hold_timer_max;
			ymv = -jump_speed;
		}
		// end the function, because the following code needs to be exeuted only if the player isn't grounded
		return 0;
	}
	
	// keep falling faster until terminal speed
	if(ymv < _terminal_speed){
			
		//reduces gravity to allow higher jumps 
		if(jump_timer > 0) { 
			ymv += _gravity/(jump_timer+1);
			jump_timer -= DT;
		}
		// normal falling
		else {
			if(ymv >= 0) ymv += _gravity*global.fall_gravity;
			else ymv += _gravity;
		}
	}
		
		
	if(!keyboard_check(jump_key) && ymv < _terminal_speed) jump_timer = 0;
		
	// coyote time
	if(coyote_timer > 0) {
		if(keyboard_check_pressed(jump_key)){
			jump_timer = global.jump_hold_timer_max;
			ymv = -jump_speed;
		}
		coyote_timer -= DT_MS;
	}
	if(jump_key_buffer > 0) jump_key_buffer -= DT_MS;
	
	return 0;
}
