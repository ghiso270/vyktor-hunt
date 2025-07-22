#region object relation

// executes after one frame to ensure every object spawned
obj = obj_player;

// target
if(instance_exists(obj)){
	x = obj.x;
	y = obj.y;
}

deadzone = 10;
spd = 1/4; // (between 0 and 1)

#endregion
#region view

look_move_visual = 250;

is_fullscreen = window_get_fullscreen();
is_window_set = true;
get_current_window_data = function(){
	return new WindowData(window_get_x(), window_get_y(), window_get_width(), window_get_height()) ;
}
last_window_data = get_current_window_data()
check_window_changed = function(ignore_pos=false, ignore_size=false){
	var current_window_data = get_current_window_data();
	
	if(!ignore_pos && last_window_data.x != current_window_data.x) {
		last_window_data = current_window_data;
		return true;
	}
	if(!ignore_pos && last_window_data.y != current_window_data.y) {
		last_window_data = current_window_data;
		return true;
	}
	if(!ignore_size && last_window_data.w != current_window_data.w) {
		last_window_data = current_window_data;
		return true;
	}
	if(!ignore_size && last_window_data.h != current_window_data.h) {
		last_window_data = current_window_data;
		return true;
	}
	
	return false;
}

view_width = global.view_size.w;
view_height = global.view_size.h;

port_width = global.window_data.w;
port_height = global.window_data.h;
view_camera[VIEW_ID] = camera_create_view(x, y, view_width, view_height,0,id,-1,-1, view_width, view_height);

view_set_wport(VIEW_ID, port_width);
view_set_hport(VIEW_ID, port_height);

view_set_visible(VIEW_ID, true);

#endregion