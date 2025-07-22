#region state

// sprites for ACTION
animations = array_create(ACTION.NUM);

animations[ACTION.IDLE] = new Animation(spr_vampire_idle, [175,175,175,175,175,175]);
animations[ACTION.WALK] = new Animation(spr_vampire_walk, [75,75,75,75,75,75,75,75,75,75,75,75]);
animations[ACTION.JUMP] = new Animation(spr_vampire_jump, [275,275,275]);
animations[ACTION.APEX] = new Animation(spr_vampire_apex, [50,25,50,25,50,25,50,25], ACTION.FALL);
animations[ACTION.FALL] = new Animation(spr_vampire_fall, [125,125,125,125]);
animations[ACTION.EAT]  = new Animation(spr_vampire_eat,  [150], ACTION.IDLE);
animations[ACTION.KEEP] = new Animation(spr_vampire_keep, [75,75,75,175], ACTION.IDLE);
animations[ACTION.HIT]  = new Animation(spr_vampire_hit,  [999]);

state = ACTION.IDLE;

#endregion

#region animation

image_xscale = PLAYER_SIZE;
image_yscale = PLAYER_SIZE;

image_speed = 0;
sprite_index = spr_vampire_idle;

animation_timer = 0;

legs = obj_player_legs;
instance_create_depth(x,y,depth, legs);

#endregion

#region movement

ymv = 0;
xmv = 0;
move_direction = 0;

move_speed = 9*PLAYER_SIZE;
jump_speed = 15*PLAYER_SIZE;

// this will be the slowness factor if moving while attacking
eat_move_speed_multiplier = 4;
keep_move_speed_multiplier = 1;

x_remainder = 0;
y_remainder = 0;

#endregion

#region jump

jump_key_buffer = 0;
coyote_timer = 0;
jump_timer = 0;

is_grounded = false;

#endregion

#region attack and hit

suffer_damage = function(_dmg, _dir) { player_suffer_damage(_dmg, _dir) };
invincibility_timer = global.max_invincibility_time;
just_damaged = false;
knockback_direction = 0;
kept_blood_color = undefined;
u_color = shader_get_uniform(sh_outline, "color");

// the attack area will be a circle with this centre and radius
// note that the coordinates are relative to the player's, and the x will be relative to the facing direction
attack_centre = {x:45, y:-30}; 
attack_range = 30;

can_damage = true;
eat_cooldown = 0;

// TODO change this
eat_frame = 1; // frame of the eat animation that deals damage
keep_frame = 2; // frame of the eat animation that deals damage

eat = function(){ player_eat() };
keep = function(){ player_keep() };


#endregion