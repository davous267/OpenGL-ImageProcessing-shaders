#version 430 core

layout(location = 0) out vec4 final_color;

in VertexData
{
	// texture coordinate to color_tex sampler
	vec2 tex_coord;
} inData;

layout(binding = 0) uniform sampler2D color_tex;

const int kernel_size = 5;

// Takes convolution kernel and applies it to current fragment
// Size of (square) kernel can be changed above by assigning desired value to 'kernel_size'
vec3 convolution(int kernel[kernel_size][kernel_size], float kernel_multiplier = 1.0)
{
	vec2 texel_size = 1.0 / textureSize(color_tex, 0);

	vec3 res_color = vec3(0.0);
	int kernel_half = kernel_size / 2;

	for (int x = -kernel_half; x <= kernel_half; ++x)
	{
		for (int y = -kernel_half; y <= kernel_half; ++y)
		{
			vec2 xy_pos = inData.tex_coord + vec2(x, y) * texel_size;
			res_color += kernel_multiplier * 
						 kernel[x + kernel_half][y + kernel_half] *
						 texture(color_tex, xy_pos).rgb;
		}
	}

	return res_color;
}

// Allows to change contrast and brightness of actual fragment
vec3 point_transform(vec3 color, float contrast_modifier, float brightness_modifier = 0.0)
{
	return clamp(contrast_modifier * color + vec3(brightness_modifier), vec3(0.0), vec3(1.0));
}

// Converts given color to gray_scale
vec3 gray_scale(vec3 color)
{
	float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
	return vec3(gray);
}

void main()
{
	// Simple gauss blur 5x5 kernel
	int kernel[kernel_size][kernel_size] = {
		{ 1,  4,  6,  4, 1 },
		{ 4, 16, 24, 16, 4 },
		{ 6, 24, 36, 24, 6 }, 
		{ 4, 16, 24, 16, 4 },
		{ 1,  4,  6,  4, 1 },
	};

	// Using this sequence of commands I apply above kernel to actual fragment,
	// then I increase the contrast and decrease the brightness and convert result to gray scale
	final_color = vec4(gray_scale(point_transform(convolution(kernel, 1.0/256.0), 1.5, -0.1)), 1.0);
}