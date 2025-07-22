if(global.game_speed == 0) exit;

var _state_changed = change_state();

if(_state_changed)
{
	// changes animation to match the current state
	sprite_index = animations[state].sprite;
	
	// reset animation to 1st frame
	image_index = 0;
	animation_timer = 0;
}

var _animation_changed = update_animation();

// same as above
if(_animation_changed)
{
	sprite_index = animations[state].sprite;
	image_index = 0;
	animation_timer = 0;
}