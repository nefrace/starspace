shader_type canvas_item;
uniform vec4 color: source_color;
uniform float outer : hint_range(0.0, 1.0, 0.01);
uniform float inner : hint_range(0.0, 2.0, 0.01);
uniform vec2 inner_offset;

float sdCircle( vec2 p, float r )
{
    return length(p) - r;
}

float circleDist (vec2 uv) {
 float circle1 = smoothstep(0.0002, 0.0001, sdCircle(uv, outer));
 float circle2 = smoothstep(0.0001, 0.0002, sdCircle(uv + inner_offset, inner));
 return (circle1 * circle2);
}



void fragment(){
 vec2 central_uv = UV * 2. - 1.;
 
 COLOR.rgb = color.rgb;
 COLOR.a = circleDist(central_uv);
}