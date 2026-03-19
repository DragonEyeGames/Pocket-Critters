shader_type canvas_item;

uniform vec2 player_pos;
uniform float radius = 50.0;
uniform float strength = 10.0;
uniform float wind_strength = 2.0;
uniform float wind_speed = 2.0;

void vertex() {
	// --- WIND ---
	float wind = sin(TIME * wind_speed + VERTEX.y * 0.1) * wind_strength;

	// --- PLAYER PUSH ---
	vec2 world_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	float dist = distance(world_pos, player_pos);

	float push = 1.0 - smoothstep(0.0, radius, dist);
	vec2 dir = normalize(world_pos - player_pos);

	float height_factor = UV.y; // top moves more than bottom
	
	VERTEX.x += wind * height_factor;
	VERTEX.x += dir.x * push * strength * height_factor;
}