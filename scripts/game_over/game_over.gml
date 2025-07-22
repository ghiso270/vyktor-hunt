/// @func	game_over()
/// @desc	end the current game and shows the results screen before the option to repeat the game or go back to the start screen
function game_over(){
	obj_gameover_screen.visible = true;
	global.game_speed = 0;
}