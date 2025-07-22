visible = false;
sprite_index = spr_gameover;
image_alpha = 1;
points = undefined;

buttons = [];
array_push(buttons, new Button(RES_WIDTH/2-225, RES_HEIGHT/2+550, spr_pause_button, -6, 6, "QUIT",
	function(obj){
		with(obj){
			if(is_clicked() || keyboard_check_pressed(ord("Q")))
				change_room_timer = 50;
			else if(change_room_timer != undefined){
				if(change_room_timer <= 0){
					global.game_speed = 1;
					obj_gameover_screen.visible = false;
					game_end(0);
				}else
					change_room_timer -= delta_time/1000;
			}
			
			if(is_pressed() || keyboard_check(ord("Q"))){
				subimg = 2;
				label_data.color = #6c0808;
			}else if(check_hover()){
				subimg = 1
				label_data.color = #865f46;
			}else{
				subimg = 0;
				label_data.color = #865f46;
			}
		}
	},
	{color: c_black, font: fnt_button, size: 1.25}
));
buttons[0].change_room_timer = undefined;

array_push(buttons, new Button(RES_WIDTH/2+225, RES_HEIGHT/2+550, spr_pause_button, 6, 6, "RESTART",
	function(obj){
		with(obj){
			if(is_clicked() || keyboard_check_pressed(ord("R")))
				change_room_timer = 50;
			else if(change_room_timer != undefined){
				if(change_room_timer <= 0){
					global.game_speed = 1;
					obj_gameover_screen.visible = false;
					room_restart();
				}else
					change_room_timer -= delta_time/1000;
			}
			
			if(is_pressed() || keyboard_check(ord("R"))){
				subimg = 2;
				label_data.color = #6c0808;
			}else if(check_hover()){
				subimg = 1
				label_data.color = #865f46;
			}else{
				subimg = 0;
				label_data.color = #865f46;
			}
		}
	},
	{color: c_black, font: fnt_button, size: 1}
));
buttons[1].change_room_timer = undefined;

buttons_num = array_length(buttons);