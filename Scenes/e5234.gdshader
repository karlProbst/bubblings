shader_type canvas_item;

uniform float iridescence_strength : hint_range(0.0, 1.0) = 0.5; // Strength of iridescence
uniform float fresnel_power : hint_range(1.0, 5.0) = 3.0; // Fresnel effect power
uniform vec3 bubble_color : source_color = vec3(0.8, 0.9, 1.0); // Base bubble color
uniform float transparency : hint_range(0.0, 1.0) = 0.8; // Bubble transparency
uniform float polygon_size = 100.0; // Size of the polygon in pixels

void fragment() {
    // Scale UV to match polygon size and center it
    vec2 uv = (UV - vec2(0.5)) * polygon_size / 100.0 * 2.0;

    float dist = length(uv); // Distance from the center
    vec2 view_dir = normalize(uv); // Simulate a viewing direction

    // Fresnel effect for edges
    float fresnel = pow(1.0 - dist, fresnel_power);

    // Iridescence effect based on distance
    float angle_factor = dist * 0.5 + 0.5;
    vec3 iridescence = vec3(0.5 + 0.5 * cos(6.283 * (angle_factor + vec3(0.0, 0.33, 0.66))));

    // Combine base bubble color with iridescence
    vec3 final_color = mix(bubble_color, iridescence, iridescence_strength);

    // Add transparency
    COLOR = vec4(final_color, transparency * fresnel);

    // Discard pixels outside the circular bubble
    if (dist > 1.0) {
        discard;
    }
}
