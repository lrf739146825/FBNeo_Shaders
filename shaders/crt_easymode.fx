/*
    CRT Shader by EasyMode
    License: GPL

    A flat CRT shader ideally for 1080p or higher displays.

    Recommended Settings:

    Video
    - Aspect Ratio: 4:3
    - Integer Scale: Off

    Shader
    - Filter: Nearest
    - Scale: Don't Care

    Example RGB Mask Parameter Settings:

    Aperture Grille (Default)
    - Dot Width: 1
    - Dot Height: 1
    - Stagger: 0

    Lottes' Shadow Mask
    - Dot Width: 2
    - Dot Height: 1
    - Stagger: 3
*/

#include "defaults.inc"

#define BRIGHT_BOOST 1.2
#define DILATION 1.0
#define GAMMA_INPUT 2.0
#define GAMMA_OUTPUT 1.8
#define MASK_SIZE 1.0
#define MASK_STAGGER 0.0
#define MASK_STRENGTH 0.3
#define MASK_DOT_HEIGHT 1.0
#define MASK_DOT_WIDTH 1.0
#define SCANLINE_BEAM_WIDTH_MAX 1.5
#define SCANLINE_BEAM_WIDTH_MIN 1.5
#define SCANLINE_BRIGHT_MAX 0.65
#define SCANLINE_BRIGHT_MIN 0.35
#define SCANLINE_CUTOFF 400.0
#define SCANLINE_STRENGTH 1.0
#define SHARPNESS_H 0.5
#define SHARPNESS_V 1.0

#define FIX(c) max(abs(c), 1e-5)
#define PI 3.141592653589
#define TEX2D(c) dilate(tex2D(tex, c).rgba)
#define mod(x,y) (x - y * trunc(x/y))

#define ENABLE_LANCZOS 1

// uniforms
sampler2D tex0;
float2    texture_size;
float2    output_size;
float2    video_size;

float4 dilate(float4 col)
{
    float4 x = lerp(float4(1.0, 1.0, 1.0, 1.0), col, DILATION);

    return col * x;
}

float curve_distance(float x, float sharp)
{

/*
    apply half-circle s-curve to distance for sharper (more pixelated) interpolation
    single line formula for Graph Toy:
    0.5 - sqrt(0.25 - (x - step(0.5, x)) * (x - step(0.5, x))) * sign(0.5 - x)
*/

    float x_step = step(0.5, x);
    float curve = 0.5 - sqrt(0.25 - (x - x_step) * (x - x_step)) * sign(0.5 - x);

    return lerp(x, curve, sharp);
}

float4x4 get_color_matrix(sampler2D tex, float2 co, float2 dx)
{
    return float4x4(TEX2D(co - dx), TEX2D(co), TEX2D(co + dx), TEX2D(co + 2.0 * dx));
}

float3 filter_lanczos(float4 coeffs, float4x4 color_matrix)
{
    float4 col = mul(coeffs, color_matrix);
    float4 sample_min = min(color_matrix[1], color_matrix[2]);
    float4 sample_max = max(color_matrix[1], color_matrix[2]);

    col = clamp(col, sample_min, sample_max);

    return col.rgb;
}


float4 main_fragment(default_v2f input) : COLOR
{
    float2 dx = float2(1.0 / texture_size.x, 0.0);
    float2 dy = float2(0.0, 1.0 / texture_size.y);
    float2 pix_co = input.texcoord * texture_size - float2(0.5, 0.5);
    float2 tex_co = (floor(pix_co) + float2(0.5, 0.5)) / texture_size;
    float2 dist = frac(pix_co);
    float curve_x;
    float3 col, col2;

#if ENABLE_LANCZOS
    curve_x = curve_distance(dist.x, SHARPNESS_H * SHARPNESS_H);

    float4 coeffs = PI * float4(1.0 + curve_x, curve_x, 1.0 - curve_x, 2.0 - curve_x);

    coeffs = FIX(coeffs);
    coeffs = 2.0 * sin(coeffs) * sin(coeffs / 2.0) / (coeffs * coeffs);
    coeffs /= dot(coeffs, float4(1.0, 1.0, 1.0, 1.0));

    col = filter_lanczos(coeffs, get_color_matrix(tex0, tex_co, dx));
    col2 = filter_lanczos(coeffs, get_color_matrix(tex0, tex_co + dy, dx));
#else
    curve_x = curve_distance(dist.x, SHARPNESS_H);

    col = lerp(TEX2D(tex_co).rgb, TEX2D(tex_co + dx).rgb, curve_x);
    col2 = lerp(TEX2D(tex_co + dy).rgb, TEX2D(tex_co + dx + dy).rgb, curve_x);
#endif

    col = lerp(col, col2, curve_distance(dist.y, SHARPNESS_V));

    float val = GAMMA_INPUT / (DILATION + 1.0);
    col = pow(col, float3(val, val, val));

    float luma = dot(float3(0.2126, 0.7152, 0.0722), col);
    float bright = (max(col.r, max(col.g, col.b)) + luma) / 2.0;
    float scan_bright = clamp(bright, SCANLINE_BRIGHT_MIN, SCANLINE_BRIGHT_MAX);
    float scan_beam = clamp(bright * SCANLINE_BEAM_WIDTH_MAX, SCANLINE_BEAM_WIDTH_MIN, SCANLINE_BEAM_WIDTH_MAX);
    float scan_weight = 1.0 - pow(cos(input.texcoord.y * 2.0 * PI * texture_size.y) * 0.5 + 0.5, scan_beam) * SCANLINE_STRENGTH;

    float mask = 1.0 - MASK_STRENGTH;
    float2 mod_fac = floor(input.texcoord * output_size * texture_size / (video_size * float2(MASK_SIZE, MASK_DOT_HEIGHT * MASK_SIZE)));
    int dot_no = int(mod((mod_fac.x + mod(mod_fac.y, 2.0) * MASK_STAGGER) / MASK_DOT_WIDTH, 3.0));
    float3 mask_weight;

    if (dot_no == 0) mask_weight = float3(1.0, mask, mask);
    else if (dot_no == 1) mask_weight = float3(mask, 1.0, mask);
    else mask_weight = float3(mask, mask, 1.0);

    if (video_size.y >= SCANLINE_CUTOFF) scan_weight = 1.0;

    col2 = col.rgb;
    col *= float3(scan_weight, scan_weight, scan_weight);
    col = lerp(col, col2, scan_bright);
    col *= mask_weight;

    val = 1.0 / GAMMA_OUTPUT;
    col = pow(col, float3(val, val, val));

    return float4(col * BRIGHT_BOOST, 1.0);
}

technique t
{
    pass p0
    {
        VertexShader = compile vs_3_0 default_vertex();
        PixelShader = compile ps_3_0 main_fragment();
    }
}
