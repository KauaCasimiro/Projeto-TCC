if (pode_Abrir) {
    // Código para abrir a jaula, como trocar de sala, liberar animação, etc.
    instance_destroy();  // Exemplo: destruir a jaula
	global.game_win = true;
    // Tornar a instância 'UI' invisível
    var ui_instance = instance_find(obj_hud, 0);  // Encontra a instância 'UI'
    if (ui_instance != undefined) {
        ui_instance.visible = false;  // Torna a instância invisível
    }
			

    var cam_x = camera_get_view_x(view_camera[0]);
    var cam_y = camera_get_view_y(view_camera[0]);
    layer_sequence_create("Sequencia", cam_x, cam_y, sq_GameWin);
	audio_stop_all();
	audio_play_sound(sound_Creditos, 6, true);
}
