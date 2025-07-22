/// @func	player_eat()
/// @desc	player attack that refills the blood meter
function player_eat(){
	if(image_index+1 == eat_frame || eat_frame == -1){
		if(can_damage){
			var _enemy = obj_attack_area.colliding_enemy;
			if(_enemy != undefined){
				obj_blood_meter.current_blood += _enemy.blood_yield;
				can_damage = false;
				
				// must be last command because _enemy becomes void after deletion
				_enemy.get_hit();
			}
		}
	}else can_damage = true;
}