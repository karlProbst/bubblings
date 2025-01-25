shader_type canvas_item;

#define iTime TIME
#define fragColor COLOR

uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform vec2 param1 = vec2(0.3, 0.2);
uniform vec2 param2 = vec2(0.4, 0.7);
uniform vec2 param3 = vec2(0.3, 0.1);

void fragment()
{
    vec2 uv = UV;
    vec2 dist = vec2(0.0);
    dist += texture(iChannel1,fract(uv+vec2(iTime*0.1,0.0))).rr * param1;
    dist += texture(iChannel1,fract(uv+vec2(iTime*-0.01,iTime*-0.1))).rr * param2;
    dist += texture(iChannel1,fract(uv+vec2(iTime*-0.003,iTime*0.2))).rr * param3;
    vec3 col = texture(iChannel0,uv - dist * 0.02 * 1.).rgb;
    col += pow(dot(normalize(vec3(dist.x,1.0,dist.y)),vec3(0.0,1.0,0.0)),16.0);
    fragColor = vec4(col,1.0);
}