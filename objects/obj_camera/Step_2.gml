if(keyboard_check_pressed(vk_f11)){
	// if windowed save the current x position before setting fullscreen
	if(!is_fullscreen && is_window_set){
		global.window_data.x = window_get_x();
		global.window_data.y = window_get_y();
	}
	is_window_set = false;
	is_fullscreen = !is_fullscreen;
	window_set_fullscreen(is_fullscreen);
}


if(!is_window_set && !is_fullscreen){
	// keep trying until the window changes
	// once it does, set the correct position and size
	if(check_window_changed()) {
		window_set_size(global.window_data.w, global.window_data.h);
		window_set_position(global.window_data.x, global.window_data.y);
	}
	if(global.window_data.equals(get_current_window_data()))
		is_window_set = true;
}

if(global.game_speed == 0) exit;
// TODO fix shift+look near room border
var _xtarget = instance_exists(obj) ? obj.x : x;
var _ytarget = instance_exists(obj) ? obj.y : y;

var _xdirection = keyboard_check(right) - keyboard_check(left);
var _ydirection = keyboard_check(down) - keyboard_check(up);

if(keyboard_check(move_cam_key)){
	_xtarget += _xdirection * look_move_visual;
	_ytarget += _ydirection * look_move_visual;
}

var _dx = _xtarget - x;
var _dy = _ytarget - y;
var _dist = point_distance(x,y, _xtarget, _ytarget);

if(_dist > deadzone) {
    x += _dx * spd * DT; // Smooth movement
    y += _dy * spd * DT;
}