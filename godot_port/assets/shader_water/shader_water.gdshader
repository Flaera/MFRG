shader_type spatial;

uniform vec2 amplitude = vec2(0.3,0.15);
uniform vec2 frequency = vec2(3.0,2.5);
uniform vec2 time_factor = vec2(2.0,3.0);

uniform sampler2D texture_map: hint_albedo;
uniform vec2 texture_scale = vec2(8.0,4.0);

uniform sampler2D normal_map: hint_normal;


float height(vec2 pos, float time){
	return (amplitude.x*sin(pos.x*frequency.x+time*time_factor.x)) + (amplitude.y*sin(pos.y*frequency.y+time*time_factor.y));}


void vertex(){
	VERTEX.y += height(VERTEX.xz,TIME);
	
	TANGENT = normalize(vec3(0.0, height(VERTEX.xz+vec2(0.0,0.2),TIME)-height(VERTEX.xz+vec2(0.0,-0.2),TIME),0.4));
	BINORMAL = normalize(vec3(0.4, height(VERTEX.xz+vec2(0.2,0.0),TIME)-height(VERTEX.xz+vec2(-0.2,0.0),TIME),0.0));
	NORMAL = cross(TANGENT,BINORMAL);
}

void fragment(){
	vec2 speed = vec2(0.05,0.05);
	speed *= TIME;
	
	ALBEDO = texture(texture_map, UV*texture_scale+speed).rgb;
	NORMALMAP = texture(normal_map, UV*texture_scale+speed).rgb;
	METALLIC = 0.5;
	ROUGHNESS = 0.2;
}