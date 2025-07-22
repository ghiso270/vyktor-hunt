if(!visible) exit;


draw_sprite_ext(sprite_index, image_index, RES_WIDTH/2, RES_HEIGHT/2, 6,6,0, c_white, image_alpha);

for(var i=0; i<buttons_num; i++)
	buttons[i].show();

var type_0 = obj_type_0_meter.current_blood;
var type_a = obj_type_a_meter.current_blood;
var type_b = obj_type_b_meter.current_blood;
var type_ab = obj_type_ab_meter.current_blood;

points = 1000*type_0 + 400*type_a + 400*type_b + 250*type_ab;
draw_set_valign(fa_left)
draw_set_halign(fa_center)
draw_set_font(fnt_score)
draw_set_color(#6c0808);
draw_text_transformed(1290, 802, str(points), 1.25, 1, 0);