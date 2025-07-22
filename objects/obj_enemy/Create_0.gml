min_time = global.enemy_spawn_rate_min;
max_time = global.enemy_spawn_rate_max;

spawn_timer = sqrt(global.kills+1)*irandom_range(min_time, max_time);

spawn_range = global.enemy_spawn_range;
blocked_range = global.enemy_spawn_blocked_range;

global.kills = 0;
global.enemy_count = 0;