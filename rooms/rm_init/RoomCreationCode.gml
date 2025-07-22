#region character behavior

#macro PLAYER_SIZE 3
#macro ENEMY_SIZE 3

// defines all possible states for the player
enum ACTION {
	IDLE,
	WALK,
	
	JUMP,
	APEX,
	FALL,
	
	EAT,
	KEEP,
	
	//BAT,
	HIT,
	
	NUM, // this is the "length" of the enum
}

// defines all possible states for the enemies
enum ENEMY {
	IDLE,
	WALK,
	RUN,
	
	JUMP,
	APEX,
	FALL,
	
	ATK,
	
	NUM, // this is the "length" of the enum
}

// defines all possible attack types for the enemies
enum ATTACK {
	PASSIVE,		// eg damaging aura
	MELEE,			// eg biting
	RANGED_LINE,	// eg bullets
	RANGED_CURVE,	// eg hammer throws
}

// all of these are percentual
enum CHANCE {
	TYPE_0 = 10,
	TYPE_A = 25,
	TYPE_B = 25,
	TYPE_AB= 40,
}

#endregion

#region keys

globalvar up; up = vk_up;
globalvar left; left = vk_left;
globalvar down; down = vk_down;
globalvar right; right = vk_right;
globalvar jump_key; jump_key = vk_space;
globalvar eat_key; eat_key = ord("A");
globalvar keep_key; keep_key = ord("Z");
globalvar consume_blood_type_key; consume_blood_type_key = ord("Q");
globalvar move_cam_key; move_cam_key = vk_shift;
globalvar pause_key; pause_key = vk_escape;

#endregion

#region physics

// specifying the size is necessary to avoid accidentally skipping obstacles with the *_move() function
#macro MIN_OBSTACLE_SIZE 64
global.obstacles = [obj_ground];

global.gforce = 10;
global.fall_gravity = 2;
global.knockback_hforce = 15; // horizontal force
global.knockback_vforce = 15; // vertical force

global.jump_key_buffer_max = 150;
global.coyote_timer_max = 150;
global.jump_hold_timer_max = 5;

#endregion

#region time

// multiplicative speed
// eg if set to 2 the player will move twice as fast
global.game_speed = 1;

// calculated later
global.average_dt = undefined;
#macro AVERAGE_DT_SAMPLES 15

// standard delta_time (game speed instead of delta_time for stability)
#macro DT (global.game_speed*delta_time/50000)

// delta_time in milliseconds
#macro DT_MS (global.game_speed*delta_time/1000)


#endregion

#region upgrades and bars

#macro BAR_LENGTH_SCALE 8

global.upgrade_factor = percent(10); // upgrades will increase by x% multiplicatively (compound interest)
global.upgrade_cost_scale = percent(15); // same but with cost for each successive upgrade

global.blood_type_gain_multiplier = 1;
global.blood_gain_multiplier = 1;
global.blood_loss = 0.1; // amount lost per loss event
global.blood_loss_frequency = 200; // frequency of loss event (ms)
global.blood_transfer_amount = 0.5; // amount transferred per loss event
global.blood_transfer_frequency = 0; // frequency of transfer event (ms)
global.selected_meter_number = 4; // goes from 1 ("0") to 4 ("AB")

global.kills = 0; // quantity of enemies killed
global.enemy_count = 0; // current number of enemies in the room
global.max_enemy_count = 20; // current number of enemies in the room

global.enemy_invincibility_time = 200;
global.max_invincibility_time = 1500;

global.eat_cooldown = 300;

// invincibility_frequency being in the form [k]*(2*pi/global.max_invincibility_time) is mathematically proven to satifsy the following 2 conditions:
// 1 - cos = 1 when timer = max_timer, so almost fully opaque when timer starts
// 2 - cos = 1 when timer = 0,		   so almost fully opaque when timer ends
global.invincibility_frequency = 3*(2*pi/global.max_invincibility_time);

// actual spawn rate = irandom_range(rate_min, rate_max)
global.enemy_spawn_rate_min = 1500; // ms
global.enemy_spawn_rate_max = 3000; // ms

// area around the player that allows spawning
global.enemy_spawn_range = 3000; // pixels
// area around the player in which they CAN'T spawn (must be smaller), to prevent aggressive enemies spawning too close
global.enemy_spawn_blocked_range = 800; // pixels

global.blood_meter_data = {
	xpos: 10,
	ypos: 10,
	capacity: 50,
	starting_blood: 50,
	color: #880808,
	number: 0,
}
global.type_0_meter_data = {
	xpos: -10,
	ypos: 10,
	capacity: 25,
	starting_blood: 0,
	color: #FF0000,
	number: 1,
}
global.type_a_meter_data = {
	xpos: -10,
	ypos: 80,
	capacity: 25,
	starting_blood: 0,
	color: #FFFF00,
	number: 2,
}
global.type_b_meter_data = {
	xpos: -10,
	ypos: 150,
	capacity: 25,
	starting_blood: 0,
	color: #0000FF,
	number: 3,
}
global.type_ab_meter_data = {
	xpos: -10,
	ypos: 220,
	capacity: 25,
	starting_blood: 0,
	color: #00FF00,
	number: 4,
}

#endregion

#region view

#macro VIEW_ID 0
#macro RES_WIDTH 2560
#macro RES_HEIGHT 1440

// TODO remove these once rm_init Creation Code has been written
global.view_size = {
	w: 1440,
	h: 810,
}
global.screen_size = {
	w: 1920,
	h: 1080,
}

// TODO remove these once rm_init Creation Code has been written
global.window_data = new WindowData(200, 200, 1280, 720);

#endregion

#region start execution

randomise();

// read from config.ini
// read global.view_size
// read global.window_data
// TODO replace this
var _fullscreen = true;

window_set_position(-200, -200);
window_set_fullscreen(_fullscreen);

if(!_fullscreen){
	window_set_position(global.window_data.x, global.window_data.y);
	window_set_size(global.window_data.w, global.window_data.h);
}

surface_resize(application_surface, RES_WIDTH, RES_HEIGHT);
display_set_gui_size(RES_WIDTH, RES_HEIGHT);

room_goto_next();

#endregion