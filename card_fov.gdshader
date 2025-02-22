// godot shader 

// 伪3d效果, 而且在启用region的节点下也能正常工作

shader_type canvas_item;



// Camera FOV

uniform float fov : hint_range(1, 179) = 90;

uniform bool cull_back = true;

uniform float y_rot : hint_range(-180, 180) = 0.0;

uniform float x_rot : hint_range(-180, 180) = 0.0;



uniform float inset : hint_range(0, 1) = 0.0;

// Consider changing this to a uniform and changing it from code

uniform float hovering;

uniform float rand_trans_power = 1.0;

uniform float rand_seed;

uniform float vortex_amt:hint_range(-10.0, 10.0, 0.1);

uniform float rotation:hint_range(-10.0, 10.0, 0.1) = 0.0;

// 全局着色器变量 在脚本中设置鼠标位置

global uniform vec2 mouse_screen_pos = vec2(0.0, 0.0);

uniform vec2 mouse_screen_pos_test = vec2(0.0, 0.0);





varying flat vec2 o;

varying vec3 p;



varying vec2 transformed_world_to_canvas_coordinates;

varying flat vec2 pivot;

varying flat vec2 region_rate;

varying flat mat3 inv_rot_mat;





vec2 rotate(vec2 uv, vec2 pivot_r, float angle)

{



	mat2 rotation_mat = mat2(vec2(cos(angle), -sin(angle)),

						vec2(sin(angle), cos(angle)));

	uv -= pivot_r;

	uv = uv * rotation_mat;

	uv += pivot_r;

	return uv;

}

// Creates rotation matrix

void vertex(){

	vec2 my_region_rate = abs(VERTEX) *2.0;

	region_rate = TEXTURE_PIXEL_SIZE * my_region_rate;

	if(VERTEX_ID == 0 ){

		pivot = UV ;

		}

	if(VERTEX_ID == 1){



		pivot = UV - vec2(0.0, region_rate.y);



	}

	if(VERTEX_ID == 2){

		pivot = UV - vec2(region_rate.x, region_rate.y);

	}

	if(VERTEX_ID == 3){

		pivot = UV - vec2(region_rate.x, 0.0);

	}

	float rand_angel = rand_trans_power * mod(TIME * (0.9 + mod(rand_seed, 0.5)), 2.0 * PI);

	vec2 rand_vec = vec2(cos(rand_angel), sin(rand_angel));

	transformed_world_to_canvas_coordinates = (inverse(MODEL_MATRIX) * vec4(mouse_screen_pos, 0.0, 1.0) ).xy;

	vec2 mouse_force = hovering * 0.5* (transformed_world_to_canvas_coordinates )/ length(region_rate/TEXTURE_PIXEL_SIZE) + rand_vec*0.05 *rand_trans_power;

	

	float sin_b = sin(y_rot / 180.0 * PI + mouse_force.x);

	float cos_b = cos(y_rot / 180.0 * PI + mouse_force.x);

	float sin_c = sin(x_rot / 180.0 * PI + -mouse_force.y);

	float cos_c = cos(x_rot / 180.0 * PI + -mouse_force.y);

	

	inv_rot_mat;

	inv_rot_mat[0][0] = cos_b;

	inv_rot_mat[0][1] = 0.0;

	inv_rot_mat[0][2] = -sin_b;

	

	inv_rot_mat[1][0] = sin_b * sin_c;

	inv_rot_mat[1][1] = cos_c;

	inv_rot_mat[1][2] = cos_b * sin_c;

	

	inv_rot_mat[2][0] = sin_b * cos_c;

	inv_rot_mat[2][1] = -sin_c;

	inv_rot_mat[2][2] = cos_b * cos_c;

	

	

	vec2 uv = (UV - pivot ) / region_rate;



	

	float t = tan(fov / 360.0 * PI);



	VERTEX += (uv - 0.5) * 1.0*my_region_rate * t * (1.0 - inset);

	

}



void fragment(){

	vec2 uv = (UV - pivot ) / region_rate;

	

	float t = tan(fov / 360.0 * PI);

	p = inv_rot_mat * vec3((uv - 0.5), 0.5 / t);

	float v = (0.5 / t) + 0.5;

	p.xy *= v * inv_rot_mat[2].z;

	o = v * inv_rot_mat[2].xy;

	

	if (cull_back && p.z <= 0.0) discard;

	uv = (p.xy / p.z).xy - o;

	uv += 0.5;

	float asp = (region_rate/TEXTURE_PIXEL_SIZE).y/ (region_rate/TEXTURE_PIXEL_SIZE).x;

	uv.y *= asp;

	uv = rotate(uv, vec2(0.5, 0.5), rotation + rand_trans_power*0.05*sin(TIME * (0.9 + mod(rand_seed, 0.5)) + rand_seed * 123.8985));

	uv.y /= asp;

	

	if(uv.x >1.0 || uv.x < 0.0){

		discard;

	}

	if(uv.y >1.0 || uv.y < 0.0){

		discard;

	}

	uv = pivot + uv * region_rate;

  COLOR = texture(TEXTURE, uv);

}