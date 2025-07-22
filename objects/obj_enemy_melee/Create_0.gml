#region state

change_state = function(){
	// 005 CODE DONE
	var _old_state = state;
	var _new_state = state;
	
	strolling = (player_distance > vision);
	
	if(is_grounded){
		if(player_distance <= attack_range)
			_new_state = ENEMY.ATK;
        else {
			var _obstacle_ahead = check_collision(obstacle_range*move_direction,0);
			if(_obstacle_ahead && player_xdistance > move_speed)
				_new_state = ENEMY.JUMP;
				
			// this condition prevents sudden stops during jumps
			else if(player_xdistance > move_speed && move_direction!=0)
				_new_state = strolling ? ENEMY.WALK : ENEMY.RUN;
			else
				_new_state = ENEMY.IDLE;
		}
	} else if(ymv >= -2*global.gforce*DT and ymv < 0 or _old_state==ENEMY.APEX)
		_new_state = ENEMY.APEX;
	else if(ymv >= 0)
		_new_state = ENEMY.FALL;
	else
		_new_state = ENEMY.JUMP;
	
	state = _new_state;
		
	return (_new_state != _old_state);
}

// sprites for ENEMY
animations = array_create(ENEMY.NUM);

// TODO chage these when using as superclass
animations[ENEMY.IDLE] = new Animation(spr_enemy1_idle,   [150,150]);
animations[ENEMY.WALK] = new Animation(spr_enemy1_walk,   [150,150]);
animations[ENEMY.RUN]  = new Animation(spr_enemy1_run,   [150,150]);
animations[ENEMY.JUMP] = new Animation(spr_enemy1_jump,   [200,200,200,200]);
animations[ENEMY.APEX] = new Animation(spr_enemy1_apex,   [50,50,50], ENEMY.FALL);
animations[ENEMY.FALL] = new Animation(spr_enemy1_fall,   [150,150]);
animations[ENEMY.ATK]  = new Animation(spr_enemy1_attack, [75,75,75,75,75]);

state = ENEMY.IDLE;

#endregion

#region animation

image_xscale = ENEMY_SIZE;
image_yscale = ENEMY_SIZE;
image_speed = 0;
sprite_index = spr_enemy1_idle;
image_blend = c_white;

animation_timer = 0;

u_color = shader_get_uniform(sh_outline, "color");
outline_color = undefined;

#endregion

#region movement

xmv = 0;
ymv = 0;
move_direction = 0;
move_speed = 5*ENEMY_SIZE;
jump_speed = 12*ENEMY_SIZE;

is_grounded = false;
obstacle_range = 35;

x_remainder = 0;
y_remainder = 0;

strolling = true;
stroll_timer = 0;
stroll_timer_min = 1000;
stroll_timer_max = 5000;

// the walking speed will be this times the running speed
stroll_speed_multiplier = 0.3;

#endregion

#region player relation

vision = 500;
player_xdistance = 0;
player_ydistance = 0;
player_distance = 0;
attack_range = 100;

#endregion

#region attack and defense

invincibility_timer = 0;
get_hit = function() { enemy_suffer_damage() };
attack_type = ATTACK.MELEE;
damage = 5;

// total lives (1 player hit = 1 hp lost)
hp = 3;
blood_yield = 5;
blood_type_yield = 2;
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

// TODO chage these when using as superclass
// the animation frame in which this enemy deals damage to the player, starting from 1
attack_frame = 4;

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