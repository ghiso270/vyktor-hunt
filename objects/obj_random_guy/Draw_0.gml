var color_shader_bgsampler = shader_get_sampler_index(sh_color_random_person, "source_palette");
var source_palette = sprite_get_texture(spr_random_person_palette, 0);

shader_set(sh_color_random_person);
texture_set_stage(color_shader_bgsampler, source_palette);
shader_set_uniform_f(u_color, color_get_red(outline_color)/255, color_get_green(outline_color)/255, color_get_blue(outline_color)/255, 1.0);
shader_set_uniform_f(u_shoe_color,  color_get_red(palette.shoe)/255,  color_get_green(palette.shoe)/255,  color_get_blue(palette.shoe)/255,  1.0);
shader_set_uniform_f(u_shirt_color, color_get_red(palette.shirt)/255, color_get_green(palette.shirt)/255, color_get_blue(palette.shirt)/255, 1.0);
shader_set_uniform_f(u_pants_color, color_get_red(palette.pants)/255, color_get_green(palette.pants)/255, color_get_blue(palette.pants)/255, 1.0);
shader_set_uniform_f(u_eyes_color,  color_get_red(palette.eyes)/255,  color_get_green(palette.eyes)/255,  color_get_blue(palette.eyes)/255,  1.0);
shader_set_uniform_f(u_hair_color,  color_get_red(palette.hair)/255,  color_get_green(palette.hair)/255,  color_get_blue(palette.hair)/255,  1.0);
shader_set_uniform_f(u_skin_color,  color_get_red(palette.skin)/255,  color_get_green(palette.skin)/255,  color_get_blue(palette.skin)/255,  1.0);

draw_self();
shader_reset();

if(!strolling) {
	draw_set_color(c_yellow);
	draw_circle(x,y-100, 20, false);
	draw_set_color(c_black);
	draw_set_font(fnt_basic);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, y-100, "!")
}