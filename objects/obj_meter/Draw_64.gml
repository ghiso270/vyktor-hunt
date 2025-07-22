// if the blood has changed, discard previous surfaces
if(cache_blood != current_blood){
	if(surface_exists(cutter)) surface_free(cutter);
	if(surface_exists(surf))   surface_free(surf);	
}
	
// if they've been deleted, re-create the surfaces normally
if(!surface_exists(bg_surf)){
	bg_surf = surface_create(surf_size,surf_size);
	surface_set_target(bg_surf);
	draw_clear_alpha(c_black, 0);

	if(selected) draw_set_colour(outline_color_selected);
	else draw_set_colour(outline_color);


	draw_roundrect_ext(0, 0, width+2*thickness, height+2*thickness, rad, rad, routline);
		
	if(selected) draw_set_colour(bg_color_selected);
	else draw_set_colour(bg_color);

	draw_roundrect_ext(thickness, thickness, thickness+width, thickness+height, rad, rad, routline);
		
	surface_reset_target();
}
if(!surface_exists(cutter)){
	cutter = surface_create(surf_size,surf_size);
	surface_set_target(cutter);
	draw_clear_alpha(c_black, 0);

	// base shape
	draw_set_color(c_white);
	draw_rectangle(0,0, surf_size, surf_size, false);
	
	// cut concavity
	gpu_set_blendmode(bm_subtract);
	draw_roundrect_ext(0, 0, BAR_LENGTH_SCALE*current_blood, height, rad, rad, routline);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}
if(!surface_exists(surf)){
	surf = surface_create(surf_size,surf_size);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	
	// draw bar
	draw_set_colour(bar_color);
	draw_roundrect_ext(0, 0, width, height, rad, rad, routline);
	
	// cut bar
	gpu_set_blendmode(bm_subtract);
	draw_surface_ext(cutter, 0, 0, 1,1,0,c_white,1);
	gpu_set_blendmode(bm_normal);
		
	surface_reset_target();
}
// apply everything
draw_surface_ext(bg_surf, x1-thickness, y1-thickness, 1,1,0,c_white,1);
draw_surface_ext(surf, x1, y1, 1,1,0,c_white,1);
	
cache_blood = current_blood;


//var _txt_x = avg(x1,x2);
//var _txt_y = avg(y1,y2);

//draw_set_halign(fa_center);
//draw_set_valign(fa_middle);
//draw_set_color(text_color);
//draw_text(_txt_x, _txt_y,string(current_blood)+"/"+string(capacity));