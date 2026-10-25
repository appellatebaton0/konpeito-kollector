shader_type canvas_item;

uniform vec2 multiplier;
uniform float thresh = 0.5;
uniform vec4 color_b :source_color;
uniform float speed = 10.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 new_uv = UV * multiplier;
	
	if (mod(new_uv.x + new_uv.y + (speed * TIME), 1.0) > thresh)
	{
		COLOR = color_b;
	}
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
