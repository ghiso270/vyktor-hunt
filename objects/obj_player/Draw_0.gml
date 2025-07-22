draw_sprite_ext(legs.sprite_index, legs.image_index, x, y, image_xscale, image_yscale, 0, image_blend, image_alpha);

// TODO add effects
if(state == ACTION.KEEP){
	var _col = (kept_blood_color == undefined) ? #87b1c9 : kept_blood_color;
	shader_set(sh_outline);
	shader_set_uniform_f(u_color, color_get_red(_col)/255, color_get_green(_col)/255, color_get_blue(_col)/255, 1.0);
	draw_self();
	shader_reset();
}else{
	draw_self();
}