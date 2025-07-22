/// @func	enemy_attack()
/// @desc	the attack action for the enemy
function enemy_attack()
{
	switch(attack_type){
		case ATTACK.MELEE:
			if(player_distance <= attack_range && image_index+1 == attack_frame)
				obj_player.suffer_damage(damage, sign(obj_player.x - x));
			break;
		default:
			break;
	}
	return 0;
}