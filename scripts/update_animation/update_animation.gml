/// @func	update_animation()
/// @desc	makes the current animation play, if the animation finishes it gets changed or looped. Returns whether or not the state (with the animation) has been changed
/// @return	{Bool}
function update_animation()
{
	animation_timer += DT_MS;
	// while loop because some durations might be too short, and thus the timer should change multiple times in a single step
	while(animation_timer >= animations[state].durations[image_index])
	{
		if(animations[state].next_state >= 0 and image_index+1 >= animations[state].total_frames)
		{
			// change state
			state = animations[state].next_state;
			return true;
		}
		// re-adjusts the timer and goes to the next frame
		animation_timer -= animations[state].durations[image_index];
		image_index++;
		image_index %= animations[state].total_frames;
	}
	
	return false;
}