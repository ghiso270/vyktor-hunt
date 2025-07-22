/// @func	player_suffer_damage(dmg, dir)
/// @desc	if not invincible, depletes the player's blood meter, starts invincibility cooldown and knockback
/// @arg	{Real}	_dmg	amount of blood lost
/// @arg	{Real}	_dir	provenience of the attack (-1 = left, +1 = right)
function player_suffer_damage(_dmg, _dir){
	if(invincibility_timer > 0) return 0;
	
	invincibility_timer = global.max_invincibility_time;
	obj_blood_meter.current_blood -= _dmg;
	
	if(obj_blood_meter.current_blood > 0){
		just_damaged = true;
		knockback_direction = _dir;
	} else
		game_over()
	return 0;
}