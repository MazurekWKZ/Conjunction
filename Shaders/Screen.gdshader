shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float luma_threshold: hint_range(0.0, 1.0, 0.01);
uniform vec4 tint: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_pixel = textureLod(screen_texture, SCREEN_UV, 0.0);
	float pixel_luma = (screen_pixel.r * 0.59 + 
						screen_pixel.g * 0.3 + 
						screen_pixel.b * 0.11);
						
	if (pixel_luma > luma_threshold)
	{
		COLOR = pixel_luma * tint;
		COLOR.a = 1.0;
	}
	else
	{
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
