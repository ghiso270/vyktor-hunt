/// @func	enemy_suffer_damage(dmg)
/// @desc	reduces enemy hp
function enemy_suffer_damage(){
	if(invincibility_timer <= 0){
		hp -= 1;
		image_blend = c_red;
		invincibility_timer = global.enemy_invincibility_time;
	}
	
	if(hp <= 0){
		enemy_kill();
		global.kills++;
	}
	return 0;
}