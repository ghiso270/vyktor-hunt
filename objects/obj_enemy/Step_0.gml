if(global.game_speed == 0) exit;

if(spawn_timer <= 0){
	if(global.enemy_count < global.max_enemy_count){
		// the more enemies you kill, the rarer they become
		spawn_timer = sqrt(global.kills+1)*irandom_range(min_time, max_time);
	
		// create 2 ranges for left and rigth side, to exclude the center (blocked range)
		var _spawn_range_left  = [clamp(obj_player.x-spawn_range, 0, room_width), clamp(obj_player.x-blocked_range, 0, room_width)];
		var _spawn_range_right = [clamp(obj_player.x+blocked_range, 0, room_width), clamp(obj_player.x+spawn_range, 0, room_width)];
	
		// the right side gets attached the the left side to create a continuous range
		// if the random number is out of the left side, translate its position to the original right side
		var _random_pos = irandom_range(_spawn_range_left[0], _spawn_range_right[1]-2*blocked_range);
		if(_random_pos > _spawn_range_left[1])
			_random_pos += 2*blocked_range;
	
		// TODO add enemies
		var _random_enemy = choose_random([[1, obj_random_guy], [1, obj_random_gal], [1, obj_fangirl]]);
		instance_create_layer(_random_pos, y, "Entities", _random_enemy);
	}
}
else spawn_timer -= DT_MS;