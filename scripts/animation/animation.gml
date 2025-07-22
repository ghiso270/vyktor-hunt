/// @func	Animation(sprite, durations, next_state)
/// @desc	constructor for an animation struct
/// @arg	{Asset.GMSprite}		_sprite			The sprite assigned to the animation
/// @arg	{Array}					_durations		The durations of each frame of the animation, in milliseconds
/// @arg	{Real}					_next_state		State to switch to after the animation has finished. If set to -1 (default), the animation will loop
function Animation(_sprite, _durations, _next_state = -1) constructor
{
	if(array_length(_durations) != sprite_get_number(_sprite))
		show_message("non-standard assignment of durations at " + str(_durations));
		
	sprite = _sprite;
	durations = _durations; // in milliseconds
	total_frames = array_length(_durations);
	next_state = _next_state;
}