if(current_blood <= 0) game_over();
if(global.game_speed == 0) exit;

loss_timer -= DT_MS;
if(loss_timer <= 0){
	loss_timer += global.blood_loss_frequency;
	current_blood -= global.blood_loss;
}

event_inherited();