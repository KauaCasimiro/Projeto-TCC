event_inherited();
gravidade();

// Controle do estado
if (keyboard_check_pressed(ord("L"))) {
    if (state == "parado") {
        state = "movendo"; 
    } else {
        state = "parado"; 
    }
}

// Chama a função apropriada com base no estado
switch (state) {
    case "parado": {
        state_idle();
        
        // Verifica se a sprite está correta e reseta a animação
        if (sprite_index != spr_Boss) {
            sprite_index = spr_Boss;
            image_index = 0;
        }

        // Garante que o boss fique totalmente parado
        hspd = 0;

        // Temporizador para o boss começar a andar mesmo sem o jogador por perto
        if (timer_move <= 0) {
            state = "movendo";
            timer_move = irandom_range(180, 300); // Tempo aleatório para o próximo movimento
        } else {
            timer_move--;
        }
        
        // Verifica a distância e se o jogador está no campo de visão
        if (instance_exists(obj_Humira)) {
            var _dist = point_distance(x, y, obj_Humira.x, obj_Humira.y);
            alvo = campo_Visao(larg_Visao, sprite_height * alt_Visao, xscale);

            // Se o jogador estiver perto e no campo de visão, inicia a perseguição
            if (_dist < 1000 && instance_exists(alvo)) {
                state = "movendo";
            }
        }
        break;
    }

    case "movendo": {
        state_walk();

        // Ajusta o sprite de movimento e reseta a animação
        if (sprite_index != spr_Boss_Run) {
            sprite_index = spr_Boss_Run;
            image_index = 0;
        }
        
        alvo = campo_Visao(larg_Visao, sprite_height * alt_Visao, xscale);
        if (instance_exists(alvo)) {
            var _dist = point_distance(x, y, alvo.x, alvo.y);

            // Se o jogador está no campo de visão e a uma distância apropriada
            if (_dist < 500) {
                hspd = 0;
                state = "ataque";
                show_debug_message("Jogador no campo de visão. Boss em estado de ataque.");
            } else {
                // Move em direção ao jogador
                var _dir = point_direction(x, y, alvo.x, alvo.y);
                move_spd = 3.5;
                hspd = lengthdir_x(move_spd, _dir);
                x += hspd;
            }
        } else {
            // Se o jogador não está no campo de visão, retorna ao estado parado após um tempo
            if (timer_idle <= 0) {
                state = "parado";
                timer_idle = irandom_range(60, 120);
            } else {
                timer_idle--;
            }
        }
        break;
    }

    case "ataque": {
        state_attack();
		
        // Aplica a velocidade de ataque com base no estágio atual
        image_speed = global.boss_attack_speed;
        
		if (global.vida <= 0) { // Verifica se a vida do player chegou a zero
		    state = "idle"; // Define o estado do boss como idle
			state_idle();
			sprite_index = spr_Boss;
			image_blend = c_white;
		    hspd = 0; // Parar o movimento do boss
		    vspd = 0; // Parar qualquer movimento vertical do boss, se houver
    // Outras ações para configurar o boss no estado de idle, se necessário
}
    }
}

global.check_stage();

// No Step Event do boss

// Efeito de piscar entre vermelho e branco antes de desaparecer
if (destroy_timer > 0) {
    destroy_timer -= 1;
    
    // Alterna a cor entre vermelho e branco a cada intervalo de `flash_timer`
    if (flash_timer > 0) {
        flash_timer -= 1;
    } else {
        image_blend = (image_blend == c_red) ? c_white : c_red; // Alterna entre branco e vermelho
        flash_timer = 5; // Redefine o temporizador de flash para o próximo intervalo
    }

    // Destrói o boss quando o temporizador de destruição acabar
    if (destroy_timer <= 0) {
        instance_destroy();
    }
}
