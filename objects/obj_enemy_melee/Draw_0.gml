shader_set(sh_outline);
shader_set_uniform_f(u_color, color_get_red(outline_color)/255, color_get_green(outline_color)/255, color_get_blue(outline_color)/255, 1.0);
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