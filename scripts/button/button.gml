/// @desc constructor for a UI Button
/// @param {Real}						x				horizontal position
/// @param {Real}						y				vertical position
/// @param {Asset.GMSprite}				sprite			the image of the button: it must can have more frames that can be selected later
/// @param {Real}						xscale			x scaling of the sprite
/// @param {Real}						yscale			y scaling of the sprite
/// @param {Any}						label			the text or sprite shown on the button
/// @param {Function}					step			function that each frame. it should be like this: function(instance){with(instance){...}}
/// @param {Struct}						label_data		struct that contains the label data (when text). defaults to {color: c_black, font: fnt_basic, size: 1}
function Button(x, y, sprite, xscale, yscale, label, step=function(obj){with(obj){}}, label_data = {color: c_black, font: fnt_basic, size: 1}) constructor {
	self.x = x;
	self.y = y;
	
	self.sprite = sprite;
	self.subimg = 0;
	
	self.xscale = xscale;
	self.yscale = yscale;
	
	self.w = abs(xscale) * (sprite_get_bbox_right(sprite) - sprite_get_bbox_left(sprite));
	self.h = abs(yscale) * (sprite_get_bbox_bottom(sprite) - sprite_get_bbox_top(sprite));
	
	self.label = (is_string(label) || sprite_exists(label)) ? label : "";
	self.label_data = label_data;
	
	self.check_hover = function(){
		var m_x = device_mouse_x_to_gui(0);
		var m_y = device_mouse_y_to_gui(0);

		var hover = (m_x >= x - w/2 && m_x <= x + w/2 && m_y >= y - h/2 && m_y <= y + h/2);
		return hover;
	}
	
	self.is_clicked = function(){
		var check = (mouse_check_button_pressed(mb_left) && check_hover());
		return check;
	}
	self.is_pressed = function(){
		var check = (mouse_check_button(mb_left) && check_hover());
		return check;
	}
	self._step = step;
	self.step = function(obj = self){
		_step(obj);
	};
	
	self.show = function(){
		draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, 0, c_white, 1);
		
		if(is_string(label)){
			draw_set_color(label_data.color);
			draw_set_font(label_data.font);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text_transformed(x, y, label, label_data.size, label_data.size, 0);
		}else{
			draw_sprite(label, 0, x, x);
		}
		
	}
}