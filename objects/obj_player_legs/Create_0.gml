#region state

// sprites for ACTION
animations = array_create(ACTION.NUM);

animations[ACTION.IDLE] = new Animation(spr_vampire_legs_idle, [175,175,175,175,175,175]);
animations[ACTION.WALK] = new Animation(spr_vampire_legs_walk, [75,75,75,75,75,75,75,75,75,75,75,75]);
animations[ACTION.JUMP] = new Animation(spr_vampire_legs_jump, [275,275,275]);
animations[ACTION.APEX] = new Animation(spr_vampire_legs_apex, [50,25,50,25,50,25,50,25], ACTION.FALL);
animations[ACTION.FALL] = new Animation(spr_vampire_legs_fall, [125,125,125,125]);
animations[ACTION.EAT]  = new Animation(spr_vampire_legs_eat,  [999]);
animations[ACTION.KEEP] = new Animation(spr_vampire_legs_keep, [75,75,75,125], ACTION.IDLE);
animations[ACTION.HIT]  = new Animation(spr_vampire_legs_hit,  [999]);

state = ACTION.IDLE;

#endregion

#region animation

image_speed = 0;
sprite_index = animations[ACTION.IDLE].sprite;

animation_timer = 0;

body = obj_player;

#endregion

change_state = function() {
	var _old_state = state;
	var _new_state = body.state;
	
	if(_new_state == ACTION.KEEP) {
		if(body.is_grounded){
			if(body.move_direction != 0)
				_new_state = ACTION.WALK;
		}else{
			// determines the phase of the jump by checking if the ymv is in a certain range
			if((body.ymv >= -2*global.gforce && body.ymv < 2*global.gforce) || (_old_state==ACTION.APEX && body.ymv > 0)) // aka -2g <= ymv < 0
				_new_state = ACTION.APEX;

			else if(body.ymv >= 0)
				_new_state = ACTION.FALL;
			else
				_new_state = ACTION.JUMP;
		}
	}
	
	state = _new_state;
	return (_new_state != _old_state);
}