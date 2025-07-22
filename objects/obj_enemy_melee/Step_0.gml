if(global.game_speed == 0) exit;

// instead of executing the function every time, the value is stored inside a variable until the coordinates change
is_grounded = check_collision(0, 1);

player_ydistance = abs(obj_player.y-y);
player_xdistance = abs(obj_player.x-x);
player_distance  = sqrt(sqr(player_xdistance) + sqr(player_ydistance));
	
if(strolling) {
	if(stroll_timer <= 0){
		stroll_timer = irandom_range(stroll_timer_min, stroll_timer_max);
		move_direction = stroll_speed_multiplier * irandom_range(-1, 1);
		var _obstacle_ahead = check_collision(sign(move_direction),0);
		if(_obstacle_ahead)
			move_direction *= -1;
	}else
		stroll_timer -= DT_MS;
	
	var _obstacle_ahead = check_collision(sign(move_direction),0);
	if(_obstacle_ahead)
		stroll_timer = 0;
}else{
	// if in the air don't change direction
	if(is_grounded){
		if(player_xdistance <= move_speed) move_direction = 0;
		else move_direction = sign(obj_player.x-x);
	}
	stroll_timer = 0;
}

var _state_changed = change_state();
if(invincibility_timer > 0) {
	invincibility_timer -= DT_MS;
	image_blend = c_red;
}else image_blend = c_white;

switch(state){
	case ENEMY.IDLE:
		enemy_idle();
		break;
	case ENEMY.WALK:
	case ENEMY.RUN:
		enemy_move();
		break;
	case ENEMY.JUMP:
	case ENEMY.APEX:
	case ENEMY.FALL:
		enemy_jump();
		enemy_move();
		break;
	case ENEMY.ATK:
		enemy_attack();
		break;
}

// makes it face the correct direction
if(move_direction!=0) image_xscale = ENEMY_SIZE*sign(move_direction);

if(_state_changed)
{
	// changes animation to match the current state
	sprite_index = animations[state].sprite;
	
	// reset animation to 1st frame
	image_index = 0;
	animation_timer = 0;
}

var _animation_changed = update_animation();
// same as above
if(_animation_changed)
{
	sprite_index = animations[state].sprite;
	image_index = 0;
	animation_timer = 0;
}