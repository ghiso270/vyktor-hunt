//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D source_palette;

uniform vec4 shoe_color;
uniform vec4 shirt_color;
uniform vec4 pants_color;
uniform vec4 eyes_color;
uniform vec4 hair_color;
uniform vec4 skin_color;

uniform vec4 blood_type_color;
vec4 key = vec4(0.0, 1.0, 0.0, 1.0); // greenscreen-like green

vec4 blend(vec4 base_color, vec4 add_color) {
	vec4 new_color;
	
	new_color.rgb = base_color.rgb * (1.0 - add_color.a) + add_color.rgb * add_color.a;
	new_color.a = base_color.a + (1.0-base_color.a)*add_color.a;
	
	return new_color;
}

void main() {
    vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    float palette_size = 11.0;
    float px = 1.0 / palette_size;
	
    if(base_color == key)
		base_color = blood_type_color;
    else for (float i = 0.0; i < palette_size; i++) {
        vec4 source = texture2D(source_palette, vec2(i * px, 0.0));
        if (distance(base_color, source) < 0.01) {
				 if(i == 0.0) base_color = skin_color; // base skin
			else if(i == 1.0) base_color = blend(skin_color, vec4(0.2235294, 0.0, 0.0, 0.1372549)); // shadow skin
			else if(i == 2.0) base_color = blend(skin_color, vec4(0.0980392, 0.0, 0.0, 0.8509804)); // outline skin
			else if(i == 3.0) base_color = eyes_color; // base eye
			else if(i == 4.0) base_color = hair_color; // base hair
			else if(i == 5.0) base_color = shoe_color; // base shoe
			else if(i == 6.0) base_color = blend(shoe_color, vec4(0.0,       0.0, 0.0, 0.6980392)); // outline shoe
			else if(i == 7.0) base_color = pants_color; // base pants
			else if(i == 8.0) base_color = blend(pants_color,vec4(0.0,       0.0, 0.0, 0.6980392)); // outline pants
			else if(i == 9.0) base_color = shirt_color; // base shirt
			else if(i == 10.0)base_color = blend(shirt_color,vec4(0.0,       0.0, 0.0, 0.6980392)); // outline shirt
			
        }
		base_color *= v_vColour;
    }
    gl_FragColor = base_color;
}
