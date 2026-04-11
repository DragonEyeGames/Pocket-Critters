shader_type canvas_item;

// Time of day: 0.0 - 24.0
uniform float time_of_day : hint_range(0.0, 24.0);

// Maximum tint strength at night/dusk/dawn
uniform float intensity : hint_range(0.0, 1.0) = 0.6;

vec3 get_tint_color(float hour) {
    // Define key colors for smooth interpolation
    vec3 night = vec3(0.2, 0.3, 0.5);
    vec3 dawn = vec3(0.5, 0.6, 1.0);
    vec3 sunrise = vec3(1.0, 0.8, 0.6);
    vec3 day = vec3(0.0);       // invisible, no tint
    vec3 sunset = vec3(1.0, 0.7, 0.8);

    // Smooth interpolation using linear blending
    if(hour < 6.0) {
        // Night -> Dawn
        return mix(night, dawn, hour / 6.0);
    } else if(hour < 9.0) {
        // Dawn -> Sunrise -> Day
        return mix(dawn, sunrise, (hour - 6.0) / 3.0);
    } else if(hour < 18.0) {
        // Sunrise -> Day
        return mix(sunrise, day, (hour - 9.0) / 9.0);
    } else if(hour < 21.0) {
        // Day -> Sunset -> Night
        return mix(day, sunset, (hour - 18.0) / 3.0);
    } else {
        // Sunset -> Night
        return mix(sunset, night, (hour - 21.0) / 3.0);
    }
}

float get_alpha(float hour) {
    // Make daytime fully transparent, night/dusk/dawn tinted
    if(hour < 6.0) return intensity;                 // Night
    if(hour < 9.0) return intensity * (1.0 - (hour - 6.0)/3.0);  // Fades out into day
    if(hour < 18.0) return 0.0;                     // Day
    if(hour < 21.0) return intensity * ((hour - 18.0)/3.0);       // Fades in at dusk
    return intensity;                                // Night
}

void fragment() {
    vec3 tint = get_tint_color(time_of_day);
    float alpha = get_alpha(time_of_day);
    COLOR = vec4(tint, alpha);
}