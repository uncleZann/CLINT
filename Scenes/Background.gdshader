shader_type canvas_item;
uniform sampler2D distortionTexture;

void fragment() {
	vec2 distortedUv = UV + texture(distortionTexture, UV).r * sin(TIME) * 0.02;
	vec4 screenColor = texture(TEXTURE, distortedUv);
	COLOR = screenColor;
}
