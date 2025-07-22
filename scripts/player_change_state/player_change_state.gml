/// @func	player_change_state()
/// @desc	updates the state according to the current situation. Returns whether or not the state has been changed
/// @return	{Bool}
function player_change_state()
{
	var _old_state = state;
	var _new_state = ACTION.IDLE;
	
	move_direction = (!keyboard_check(move_cam_key))*(keyboard_check(right) - keyboard_check(left));
	
	// if grounded, can walk, jump or attack
	if(is_grounded){
		ymv = 0;
	
		if(move_direction != 0)
			_new_state = ACTION.WALK;
			
		if(keyboard_check_pressed(jump_key) || jump_key_buffer > 0)
			_new_state = ACTION.JUMP;
	}else{
		// determines the phase of the jump by checking if the ymv is in a certain range
		if((ymv >= -2*global.gforce && ymv < 2*global.gforce) || (_old_state==ACTION.APEX && ymv > 0)) // aka -2g <= ymv < 0
			_new_state = ACTION.APEX;

		else if(ymv >= 0)
			_new_state = ACTION.FALL;
		else
			_new_state = ACTION.JUMP;
			
		// case for falling is handled in update_animation(), since it requires the apex animation to end
	}	
	// set to attack if the button is pressed
	// interrupt the animation only if trying to move with multiplier = 0
	if(((keyboard_check_pressed(eat_key) && eat_cooldown <= 0) || _old_state==ACTION.EAT) && (eat_move_speed_multiplier != 0))
		_new_state = ACTION.EAT;
		
	if((keyboard_check_pressed(keep_key) || _old_state==ACTION.KEEP) && (keep_move_speed_multiplier != 0))
		_new_state = ACTION.KEEP;
		
		
	if(_old_state == ACTION.HIT){
		if(is_grounded) {
			_new_state = ACTION.IDLE;
			xmv = 0;
		}else
			_new_state = ACTION.HIT;
	}
	if(just_damaged) {
		_new_state = ACTION.HIT;
		just_damaged = false;
		xmv =  global.knockback_hforce;
		ymv = -global.knockback_vforce;
	}
	
	state = _new_state;
	return (_new_state != _old_state);
}