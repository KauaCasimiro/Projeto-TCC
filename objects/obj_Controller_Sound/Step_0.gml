// Verificar se o jogador morreu
if (global.game_over == true) {
    // Parar qualquer música que esteja tocando
    audio_stop_sound(floresta);
	audio_stop_sound(montanha);
	audio_stop_sound(rio);
}

if (global.game_win == true) {
	audio_stop_sound(rio);
}

// Verificar se a sala atual é Menu ou comoJogar
if(room == Menu || room == comoJogar) {
    // Verificar se a música do menu não está tocando
    if (!audio_is_playing(menu)) {
        // Tocar a música do menu em loop
        audio_play_sound(menu, 1, true);  // '1' para volume máximo e 'true' para loop
    }
} else if (room == rm_Floresta) {
    // Verificar se a música do menu ainda está tocando e parar
    if (audio_is_playing(menu)) {
        audio_stop_sound(menu);
    }

    // Tocar a música da floresta
    if (!audio_is_playing(floresta)) {
        audio_play_sound(floresta, 2, true);  // Tocar som da floresta em loop
    }
}
else if (room == rm_Montanha) {
    // Verificar se a música da floresta ainda está tocando e parar
    if (audio_is_playing(floresta)) {
        audio_stop_sound(floresta);
    }

    // Tocar a música da montanha
    if (!audio_is_playing(montanha)) {
        audio_play_sound(montanha, 3, true);  // Tocar som da montanha em loop
    }
}
else if (room == rm_Rio) {
    // Verificar se a música da montanha ainda está tocando e parar
    if (audio_is_playing(montanha)) {
        audio_stop_sound(montanha);
    }

    // Tocar a música do rio
    if (!audio_is_playing(rio)) {
        audio_play_sound(rio, 4, true);  // Tocar som do rio em loop
    }
}
