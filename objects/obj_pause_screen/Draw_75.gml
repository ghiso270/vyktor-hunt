if(!visible) exit;


draw_sprite_ext(spr_pause_menu_dark_effect,0, 0, 0, RES_WIDTH, RES_HEIGHT, 0, c_black, dark_effect_opacity);
draw_sprite_ext(sprite_index, image_index, RES_WIDTH/2, RES_HEIGHT/2, 6,6,0, c_white, image_alpha);

for(var i=0; i<buttons_num; i++)
	buttons[i].show();