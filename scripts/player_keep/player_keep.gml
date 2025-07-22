/// @func	player_keep()
/// @desc	player attack that fills the blood-type meters
function player_keep(){
	if(image_index+1 == keep_frame){
		if(can_damage){
			var _enemy = obj_attack_area.colliding_enemy;
			if(_enemy != undefined){
				kept_blood_color = _enemy.outline_color;
				switch(_enemy.blood_type){
					case "0":
						obj_type_0_meter.current_blood += _enemy.blood_type_yield;
						break;
					case "a":
						obj_type_a_meter.current_blood += _enemy.blood_type_yield;
						break;
					case "b":
						obj_type_b_meter.current_blood += _enemy.blood_type_yield;
						break;
					case "ab":
						obj_type_ab_meter.current_blood += _enemy.blood_type_yield;
						break;
					default:
						show_error("non-existent blood type", true);
						break;
				}
				can_damage = false;
				
				// must be last command because _enemy becomes void after deletion
				_enemy.get_hit();
			}
		}
	}else can_damage = true;
}