function boss_AplicarDano(dano) {
    if (instance_exists(obj_Boss)) {
        with (obj_Boss) {
            // Reduz a vida do boss
            global.boss_life -= dano;

            // Verifica e atualiza o estágio com base na vida restante
            if (global.boss_life <= global.stage_3_life_threshold) {
                global.boss_stage = 3;
                global.boss_attack_speed = 2;
                image_blend = c_red;
            } else if (global.boss_life <= global.stage_2_life_threshold) {
                global.boss_stage = 2;
                global.boss_attack_speed = 1.5;
                image_blend = c_orange;
            } else {
                global.boss_stage = 1;
                global.boss_attack_speed = 1;
                image_blend = c_yellow;
            }

            // Inicia a destruição quando a vida chegar a zero
            if (global.boss_life <= 0 && destroy_timer == -1) {
                flash_timer = 5; // Temporizador de piscar entre as cores
                destroy_timer = 60; // Duração antes da destruição
				global.boss_alive = false; // Marca o boss como morto
                state_idle();
				screen_Shake(15, 60);
            }
        }
    }
}
