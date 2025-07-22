varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 key = vec4(0.0, 1.0, 0.0, 1.0); // greenscreen-like green
uniform vec4 color;

void main()
{
	vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    if(base_color == key){
		base_color = color;
	}

    gl_FragColor = base_color * v_vColour;
}