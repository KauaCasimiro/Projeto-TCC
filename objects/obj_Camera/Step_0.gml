#region //Camera
if (instance_exists(obj_Humira)) {
    target_ = obj_Humira;
}

// Interpolação da posição da câmera para suavizar o movimento
x = lerp(x, target_.x, 0.1);
y = lerp(y, target_.y, 0.1);

// Calcula a posição da câmera para centralizar a visão do jogador

var width_ = camera_get_view_width(view_camera[0]);
var height_ = camera_get_view_height(view_camera[0]);
	#region // Screen Shake
	if (shake_lenght != 0){
	width_+= random_range(-shake_lenght, shake_lenght)
	height_+= random_range(-shake_lenght, shake_lenght)
	}
	
	#endregion

var cam_x = x - width_/2 ;
var cam_y = y - height_/2;

// Clamping para garantir que a câmera não saia dos limites da sala
cam_x = clamp(cam_x, 0, room_width - width_);
cam_y = clamp(cam_y, 0, room_height - height_);

// Define a posição da câmera na visão
camera_set_view_pos(view_camera[0], cam_x, cam_y);
#endregion


#region //Parallax
	var PL1 = layer_get_id("Plano_1");
	var PL2 = layer_get_id("Plano_2");
	var PL3 = layer_get_id("Plano_3");
	var PL4 = layer_get_id("Plano_4");
	
	layer_x(PL1, lerp(0, camera_get_view_x(view_camera[0]), -0.1));
	layer_x(PL2, lerp(0, camera_get_view_x(view_camera[0]), -0.1));
	layer_x(PL3, lerp(0, camera_get_view_x(view_camera[0]), -0.1));
	layer_x(PL4, lerp(0, camera_get_view_x(view_camera[0]), -0.1));
#endregion

