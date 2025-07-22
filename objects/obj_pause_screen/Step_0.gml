if(keyboard_check_pressed(pause_key) && global.game_speed){
	global.game_speed = 0;
	just_paused = true;
	image_index = irandom(sprite_get_number(sprite_index)-1);
	visible = true;
}

if(!visible) exit;

if(!keyboard_check(pause_key)) just_paused = false;

for(var i=0; i<buttons_num; i++)
	buttons[i].step();