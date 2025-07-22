
current_blood = clamp(current_blood, 0, capacity);

var was_selected = selected;
selected = (global.selected_meter_number == number);

// if the selection changed redraw the surface
if(was_selected != selected && surface_exists(bg_surf))
	surface_free(bg_surf);

// check if selected and key pressed
if(selected && keyboard_check(consume_blood_type_key)){
	
	// check if the blood values are valid (eg you can't transfer blood if it's 0)
	if(trasfer_timer <= 0 && current_blood >= global.blood_transfer_amount){
		trasfer_timer = global.blood_transfer_frequency;
		
		if(obj_blood_meter.current_blood < obj_blood_meter.capacity-global.blood_transfer_amount){
			current_blood -= global.blood_transfer_amount;
			obj_blood_meter.current_blood += global.blood_transfer_amount;
		}
		else if(obj_blood_meter.current_blood < obj_blood_meter.capacity){
			current_blood -= obj_blood_meter.capacity - obj_blood_meter.current_blood;
			obj_blood_meter.current_blood += obj_blood_meter.capacity - obj_blood_meter.current_blood;
		}
	}else trasfer_timer -= DT_MS;
}