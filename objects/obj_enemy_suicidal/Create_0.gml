if(!variable_instance_exists(id, "enemy_data")){
	enemy_data = {
		initialize_animations: function(){
			// sprites for ENEMY
			var _animations = array_create(ENEMY.NUM);

			_animations[ENEMY.IDLE] = new Animation(spr_error, [999]);
			_animations[ENEMY.WALK] = new Animation(spr_error, [999]);
			_animations[ENEMY.RUN]  = new Animation(spr_error, [999]);
			_animations[ENEMY.JUMP] = new Animation(spr_error, [999]);
			_animations[ENEMY.APEX] = new Animation(spr_error, [999], ENEMY.FALL);
			_animations[ENEMY.FALL] = new Animation(spr_error, [999]);
		
			return _animations;
		},
		move_speed: 0,
		jump_speed: 0,
		obstacle_range: 0,
		stroll_timer_min: 0,
		stroll_timer_max: 0,
		stroll_speed_multiplier: 0,
		vision: 0,
		hp: 0,
		blood_yield: 0,
		blood_type_yield: 0,
	}
}

#region state

change_state = function(){
	// 005 CODE DONE
	var _old_state = state;
	var _new_state = state;
	
	strolling = (player_distance > vision);
	
	if(is_grounded){
		var _obstacle_ahead = check_collision(obstacle_range*move_direction,0);
		if(_obstacle_ahead && player_xdistance > move_speed)
			_new_state = ENEMY.JUMP;
				
		// this condition prevents sudden stops during jumps
		else if(move_direction!=0)
			_new_state = strolling ? ENEMY.WALK : ENEMY.RUN;
		else
			_new_state = ENEMY.IDLE;
	} else if(ymv >= -2*global.gforce*DT and ymv <= 2*global.gforce*DT or _old_state==ENEMY.APEX)
		_new_state = ENEMY.APEX;
	else if(ymv >= 0)
		_new_state = ENEMY.FALL;
	else
		_new_state = ENEMY.JUMP;
	
	state = _new_state;
		
	return (_new_state != _old_state);
}

// sprites for ENEMY
animations = enemy_data.initialize_animations();

state = ENEMY.IDLE;

#endregion

#region animation

image_xscale = ENEMY_SIZE;
image_yscale = ENEMY_SIZE;
image_speed = 0;
sprite_index = animations[state].sprite;
image_blend = c_white;

animation_timer = 0;

u_color = shader_get_uniform(sh_outline, "color");
outline_color = undefined;

#endregion

#region movement

xmv = 0;
ymv = 0;
move_direction = 0;
move_speed = enemy_data.move_speed;
jump_speed = enemy_data.jump_speed;

is_grounded = false;
obstacle_range = enemy_data.obstacle_range;

x_remainder = 0;
y_remainder = 0;

strolling = true;
stroll_timer = 0;
stroll_timer_min = enemy_data.stroll_timer_min;
stroll_timer_max = enemy_data.stroll_timer_max;

// the walking speed will be this times the running speed
stroll_speed_multiplier = enemy_data.stroll_speed_multiplier;

#endregion

#region player relation

vision = enemy_data.vision;
player_xdistance = 0;
player_ydistance = 0;
player_distance = 0;

#endregion

#region attack and defense

invincibility_timer = 0;
get_hit = function() { enemy_suffer_damage() };

// total lives (1 player hit = 1 hp lost)
hp = enemy_data.hp;
blood_yield = enemy_data.blood_yield;
blood_type_yield = enemy_data.blood_type_yield;
blood_type = choose_random([[CHANCE.TYPE_0, "0"],
							[CHANCE.TYPE_A, "a"],
							[CHANCE.TYPE_B, "b"],
							[CHANCE.TYPE_AB, "ab"]]);
							
switch(blood_type){
	case "0":
		outline_color = global.type_0_meter_data.color;
		break;
	case "a":
		outline_color = global.type_a_meter_data.color;
		break;
	case "b":
		outline_color = global.type_b_meter_data.color;
		break;
	case "ab":
		outline_color = global.type_ab_meter_data.color;
		break;
}

#endregion

global.enemy_count++;

// restrict the coordinates so that it doesn't spawn in a corner
x = clamp(x, bbox_right - bbox_left, room_width  - (bbox_right - bbox_left));
y = clamp(y, bbox_bottom - bbox_top, room_height - (bbox_bottom - bbox_top));

// delete itself if spawned in a wall
if(check_collision(0,0))
	enemy_kill();

// reach the ground if spawned in the air
repeat(room_height){
	if(check_collision(0, 1)) break;
	
	y += 1;
}