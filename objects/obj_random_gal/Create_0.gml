enemy_data = {
		initialize_animations: function(){
			// sprites for ENEMY
			var _animations = array_create(ENEMY.NUM);

			_animations[ENEMY.IDLE] = new Animation(spr_random_gal_idle,	[525,525]);
			_animations[ENEMY.WALK] = new Animation(spr_random_gal_walk,	[175,175,175,175,175,175,175,175]);
			_animations[ENEMY.RUN]  = new Animation(spr_random_gal_run,		[75,75,75,75,75,75,75,75,75,75,75,75]);
			_animations[ENEMY.JUMP] = new Animation(spr_random_gal_jump,	[275,275,275]);
			_animations[ENEMY.APEX] = new Animation(spr_random_gal_apex,	[25,25,25,25], ENEMY.FALL);
			_animations[ENEMY.FALL] = new Animation(spr_random_gal_fall,	[250,250,250]);
		
			return _animations;
		},
		move_speed: random_range(3,6)*ENEMY_SIZE,
		jump_speed: random_range(12,14)*ENEMY_SIZE,
		obstacle_range: 35,
		stroll_timer_min: 1000,
		stroll_timer_max: 5000,
		stroll_speed_multiplier: 0.3,
		vision: 600,
		hp: 2,
		blood_yield: 3,
		blood_type_yield: 1,
}

event_inherited();

palette = {
	shoe:  choose_random([[1, #ac1a1a], [1, #303f9f], [1, #039be5], [1, #fdd835], [1, #259b24], [1, #e91e63], [1, #e64a19], [1, #e0e0e0], [1, #7a2904]]),
	pants: choose_random([[1, #ac1a1a], [1, #303f9f], [1, #039be5], [1, #fdd835], [1, #259b24], [1, #e91e63], [1, #e64a19], [1, #e0e0e0], [1, #7a2904]]),
	shirt: choose_random([[1, #ac1a1a], [1, #303f9f], [1, #039be5], [1, #fdd835], [1, #259b24], [1, #e91e63], [1, #e64a19], [1, #e0e0e0], [1, #7a2904]]),
	
	hair:  choose_random([[0.5, #e4e1ce], [1, #998880], [2, #ff8119], [5, #ffc825], [10, #171111], [10, #53381a], [10, #9e6731], [5, #cd832c], [5, #620a16]]),
	eyes:  choose_random([[5, #343223], [1, #00d1d1], [1, #1f6998], [0.5, #ada516], [1, #3c492f], [2, #381008], [1, #444466], [10, #4d3c2a], [3, #97421d]]),
	skin:  choose_random([[3, #fee3c5], [2, #fee3c5], [2, #d49e7a], [1, #bb6536], [1, #cf965f], [1, #ad8a60], [1, #935f37], [1, #7f4422], [1, #291709]]),
}

u_shoe_color  = shader_get_uniform(sh_color_random_person, "shoe_color");
u_shirt_color = shader_get_uniform(sh_color_random_person, "shirt_color");
u_pants_color = shader_get_uniform(sh_color_random_person, "pants_color");
u_eyes_color  = shader_get_uniform(sh_color_random_person, "eyes_color");
u_hair_color  = shader_get_uniform(sh_color_random_person, "hair_color");
u_skin_color  = shader_get_uniform(sh_color_random_person, "skin_color");