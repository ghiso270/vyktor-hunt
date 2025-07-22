if(global.game_speed == 0) exit;

if(obj_player.state == ACTION.KEEP)
	sprite_index = spr_keep_effect;
else if(obj_player.state == ACTION.EAT)
	sprite_index = spr_eat_effect;
else {
	obj_player.kept_blood_color = undefined;
	instance_destroy();
}

x = obj_player.x;
y = obj_player.y;

image_index = obj_player.image_index;

if(obj_player.state == ACTION.KEEP && can_change_dir && obj_player.image_index+1 == obj_player.keep_frame){
	image_xscale = obj_player.image_xscale;
	can_change_dir = false;
}
