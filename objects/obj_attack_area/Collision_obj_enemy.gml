if(global.game_speed == 0) exit;

if(obj_player.state == ACTION.KEEP){
	if(obj_player.image_index+1 == obj_player.keep_frame)
		colliding_enemy = other;
	else if(obj_player.image_index+1 > obj_player.keep_frame)
		colliding_enemy = undefined;
}
else if(obj_player.state == ACTION.EAT){
	if(obj_player.image_index+1 == obj_player.eat_frame || obj_player.eat_frame == -1)
		colliding_enemy = other;
	else if(obj_player.image_index+1 > obj_player.eat_frame)
		colliding_enemy = undefined;
}
