shader_type canvas_item;

uniform sampler2D noise;
uniform float threshold = 0.715;
uniform vec2 velocity = vec2(1.0);
uniform float scalar = 2.0;
uniform vec2 mult = vec2(1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 new_uv = mod((UV * mult) + (TIME * -velocity / scalar), mult) / mult;
	
	float value = texture(noise, new_uv).r;
	
	if (value <= threshold)
	{
		COLOR *= vec4(0.0);
	}
	
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
