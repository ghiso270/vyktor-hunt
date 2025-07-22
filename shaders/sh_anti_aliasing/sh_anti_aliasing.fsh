//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 texel_size;

void main() {
    vec2 texel = vec2(1.0) / texel_size;
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

    // Sample nearby pixels
    vec4 neighbor1 = texture2D(gm_BaseTexture, v_vTexcoord + vec2(texel.x, 0.0));
    vec4 neighbor2 = texture2D(gm_BaseTexture, v_vTexcoord + vec2(-texel.x, 0.0));
    vec4 neighbor3 = texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, texel.y));
    vec4 neighbor4 = texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, -texel.y));

    // Average color based on alpha smoothing
    col.a = (col.a + neighbor1.a + neighbor2.a + neighbor3.a + neighbor4.a) / 5.0;
    
    // Optional: soften color as well
    // col.rgb = (col.rgb + neighbor1.rgb + neighbor2.rgb + neighbor3.rgb + neighbor4.rgb) / 5.0;

    gl_FragColor = col;
}
