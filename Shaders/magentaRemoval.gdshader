shader_type canvas_item;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (col.rgb == vec3(1.0, 0.0, 1.0)) {
		discard;
	}
	
	COLOR = col;
}