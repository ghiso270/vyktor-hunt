if(global.game_speed == 0) exit;

eat_cooldown -= DT_MS;

// instead of executing the function every time, the value is stored inside a variable until the coordinates change
is_grounded = check_collision(0, 1);

var _state_changed = player_change_state();
	
//if it's touching ground restart coyote timer
if(is_grounded)
	coyote_timer = global.coyote_timer_max;

if(keyboard_check_pressed(up)) global.selected_meter_number -= 1;
if(keyboard_check_pressed(down)) global.selected_meter_number += 1;
global.selected_meter_number = wrap(global.selected_meter_number, 1, 4);

// set transparency to oscillate if invincible
if(invincibility_timer > 0){
	image_alpha = 0.5+0.25*cos(global.invincibility_frequency * invincibility_timer);
	invincibility_timer -= DT_MS;
}else image_alpha = 1;

switch(state){
	case ACTION.IDLE:
		player_idle();
		break;
	case ACTION.WALK:
		player_move();
		break;
	case ACTION.JUMP:
	case ACTION.APEX:
	case ACTION.FALL:
		player_jump();
		player_move(); // apply movement
		break;
	case ACTION.EAT:
		// only executes at the beginning
		if(!instance_exists(obj_attack_area)){
			instance_create_layer(x,y,"Entities", obj_attack_area);
			eat_cooldown = global.eat_cooldown;
			can_damage = true;
		}
		
		player_eat();
		move_direction = sign(image_xscale)*eat_move_speed_multiplier;
		ymv = 0;
		player_move();
		break;
	case ACTION.KEEP:
		if(!instance_exists(obj_attack_area)){
			instance_create_layer(x,y,"Entities", obj_attack_area);
			can_damage = true;
		}
		player_keep();
		move_direction = sign(move_direction)*keep_move_speed_multiplier;
		player_jump();
		player_move();
		break;
	case ACTION.HIT:
		player_knockback();
		break;
}

// makes it face the correct direction
if(move_direction!=0 && state != ACTION.EAT) image_xscale = PLAYER_SIZE*sign(move_direction);

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