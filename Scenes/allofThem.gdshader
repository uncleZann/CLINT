shader_type canvas_item;
uniform sampler2D distortionTexture;

void fragment() {
	vec2 distortedUv = UV + texture(distortionTexture, UV).r * 0.08;
	vec4 screenColor = texture(TEXTURE, distortedUv);
	COLOR = screenColor;
}