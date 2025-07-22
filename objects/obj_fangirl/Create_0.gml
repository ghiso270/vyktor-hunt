enemy_data = {
		initialize_animations: function(){
			// sprites for ENEMY
			var _animations = array_create(ENEMY.NUM);

			_animations[ENEMY.IDLE] = new Animation(spr_fangirl_idle,	[525,525]);
			_animations[ENEMY.WALK] = new Animation(spr_fangirl_walk,	[175,175,175,175,175,175,175,175]);
			_animations[ENEMY.RUN]  = new Animation(spr_fangirl_run,		[75,75,75,75,75,75,75,75,75,75,75,75]);
			_animations[ENEMY.JUMP] = new Animation(spr_fangirl_jump,	[275,275,275]);
			_animations[ENEMY.APEX] = new Animation(spr_fangirl_apex,	[25,25,25,25], ENEMY.FALL);
			_animations[ENEMY.FALL] = new Animation(spr_fangirl_fall,	[250,250,250]);
		
			return _animations;
		},
		move_speed: random_range(4,7)*ENEMY_SIZE,
		jump_speed: random_range(12,14)*ENEMY_SIZE,
		obstacle_range: 35,
		stroll_timer_min: 1000,
		stroll_timer_max: 5000,
		stroll_speed_multiplier: 0.3,
		vision: 500,
		hp: 2,
		blood_yield: 3,
		blood_type_yield: 1,
}

event_inherited();