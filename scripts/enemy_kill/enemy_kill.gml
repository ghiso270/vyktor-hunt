/// @func	enemy_kill()
/// @desc	deletes the instance of the enemy
function enemy_kill(){
	global.enemy_count--;
	instance_destroy();
}