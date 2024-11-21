#region// CONTROLES
function humira_States_Controles() {
	key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);
	key_left = keyboard_check(ord("A")) || keyboard_check(vk_left);
	key_jump = keyboard_check(vk_space) || keyboard_check(vk_up);
	key_jump_run = keyboard_check(vk_shift) || keyboard_check(vk_shift);
	
	//key_ataque = keyboard_check_pressed(ord("C"));
if keyboard_check(ord("R")) {
	audio_stop_sound(sound_Morte);
    // Reinicia a sala de acordo com a fase atual
    switch (global.fase) {
    case 1:
        room_goto(rm_Floresta); // Reinicia a fase Floresta
        global.pedacos_Chave = 0;  // Zera o contador total
        global.pedacos_Fase = 0;   // Zera o contador da fase atual
        break;
    case 2:
        room_goto(rm_Montanha); // Reinicia a fase Montanha
        global.pedacos_Chave = 4;  // Garante que o total acumulado seja 4 (fase 1 completa)
        global.pedacos_Fase = 0;   // Zera o contador da fase atual
        break;
    case 3:
        room_goto(rm_Rio); // Reinicia a fase Rio
        global.pedacos_Chave = 8;  // Garante que o total acumulado seja 8 (fase 2 completa)
        global.pedacos_Fase = 8;   // Zera o contador da fase atual
        break;
}

// Garantir que a variável de vida seja reiniciada
global.vida_max = 3;
global.vida = global.vida_max;
global.game_over = false;
}



}
#endregion // CONTROLES

#region //MOVIMENTAÇÃO
function humira_States_Movimentacao() {  
    if (!is_dead) {
        // Atualiza a posição anterior
        previous_x = x;
        previous_y = y;

        // Atualiza a velocidade horizontal com base na entrada do usuário
        var move = key_right - key_left;
        hspd = move * spd;

        // Atualiza a velocidade vertical com a gravidade
        gravidade();

        // Define a direção da imagem com base no movimento horizontal
        if (hspd != 0) {
            image_xscale = sign(hspd);
        }

        // COLISÃO HORIZONTAL
        if (place_meeting(x + hspd, y, obj_Parede)) {
            while (!place_meeting(x + sign(hspd), y, obj_Parede)) {
                x += sign(hspd);
            }
            hspd = 0; // Define hspd como 0 se houver colisão
        }
        x += hspd;

        // COLISÃO VERTICAL
        if (place_meeting(x, y + vspd, obj_Parede)) {
            while (!place_meeting(x, y + sign(vspd), obj_Parede)) {
                y += sign(vspd);
            }
            vspd = 0; // Define vspd como 0 se houver colisão
        }
        y += vspd;

        // Informações da animation Curve
        var channel = animcurve_get_channel(anim_grav, 0);
        var grav = animcurve_channel_evaluate(channel, global.time_grav);

        // Aplica gravidade se não estiver no chão
        if (!place_meeting(x, y + 1, obj_Parede)) {
            vspd += grav;
        } else {
            // Reseta o temporizador de gravidade se estiver no chão
            global.time_grav = 0;
        }

        // Aumenta o tempo para a gravidade calcular a curva ao longo do tempo
        global.time_grav += delta_time / 1000000;
        
        // Controle de pulo
        if (place_meeting(x, y + 1, obj_Parede) && key_jump) {
            if (key_jump_run && global.energia > 0) {
                vspd -= 22 + (15 * 0.4); // Pulo mais alto se estiver correndo
            } else {
                vspd -= 22; // Pulo normal
            }
        }

        // Controle de corrida e energia
        if (key_jump_run && global.energia > 0) {
            spd = spd_run;
            global.energia -= 0.5; // Diminui a energia gradualmente enquanto corre
        } else {
            spd = 10; // Velocidade normal quando não está correndo ou sem energia
        }

        // Recarregar energia quando não está correndo
        if (!key_jump_run) {
            if (global.energia < global.energia_max) {
                global.energia += 0.2; // Aumenta a energia gradualmente
            }
        }

        // Impede a energia de passar dos limites
        if (global.energia > global.energia_max) {
            global.energia = global.energia_max;
        }
        if (global.energia < 0) {
            global.energia = 0;
        }
    }
}

 
#endregion //MOVIMENTAÇÃO

#region //SPRITES
function humira_States_Sprites() {
    if (is_dead) {
        // Animação de morte
        sprite_index = spr_Humira_Dead;
        if (image_index == image_number - 1) {
            image_speed = 0; // Congela na última imagem
        } else {
            image_speed = 0.1; // Ajusta a velocidade
        }
    } else {
        // Pulo
        if (!place_meeting(x, y + 1, obj_Parede)) {
            sprite_index = spr_Humira_JumpIniti;
            if (sign(vspd) > 0.5) {
                sprite_index = spr_Humira_JumpFall;
            }
        } else {
            // Caminhada e Idle
            if (hspd != 0) {
                sprite_index = spr_Humira_Walking;
            } else if (place_meeting(x, y + 1, obj_Parede)) {
                sprite_index = spr_Humira_Idle;
            }
        }
    }
}
#endregion // SPRITES

#region // DANO
function humira_States_Dano() {
	 // Verificar se houve colisão entre o jogador e o boss
    var boss = instance_place(x + hspd, y, obj_Boss);
    
    if (boss) {
        // Aplica dano ao boss ao colidir com o jogador ou projétil
        boss_AplicarDano(5); // Ajuste o valor de dano conforme necessário
		global.check_stage();
    }
    // Se o personagem estiver morto, apenas atualiza a animação e retorna
    if (is_dead) {
        // Garantir que a animação de morte continue e pare no último frame
        if (image_index >= image_number - 1) {
            image_speed = 0;
            image_index = image_number - 1; // Garante que o sprite está no último frame
        } else {
            image_speed = 0.1; // Ajusta a velocidade da animação de morte
        }
        // Garantir que o personagem não entre no chão
        if (place_meeting(x, y + 1, obj_Parede)) {
            while (place_meeting(x, y + 1, obj_Parede)) {
                y -= 1; // Ajusta a posição para evitar que entre no chão
            }
        }
        return; // Sai da função para não executar o restante do código
    }

    // Verifica se o efeito de hit flash está ativo
    if (hit_flash_timer > 0) {
        // Aplica o efeito de flash alterando a cor do sprite
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, hit_flash_color, hit_flash_alpha);
        hit_flash_timer -= 1; // Decrementa o timer

        if (hit_flash_timer <= 0) {
            // Quando o timer chega a zero, reseta o efeito de flash
            draw_self(); // Redefine a aparência do sprite para o estado normal
        }
        return; // Sai da função para não executar o restante do código
    }

    // Verificar colisão com o chão e paredes
var chao = place_meeting(x, y + 1, obj_Parede);

if (!chao && vspd > 0) {
    var collision_e = instance_place(x, y + 1, obj_Inimigos_Parents);
    var collision_b = instance_place(x, y + 1, obj_Boss); // Verifica colisão com o boss

    if (collision_e) {
        vspd = 0;
        vspd -= pulo_height;
        pulo = false;
        instance_destroy(collision_e.id);
    } else if (collision_b) {
        vspd = 0;
        vspd -= 70; // Pode ajustar a força do recuo
        pulo = false;
        boss_AplicarDano(5); // Aplica dano ao boss, caso necessário
    }
}

// Verificar colisão com o inimigo


// Verificar colisão com inimigos e o boss horizontalmente
var inimigo_Bubble = instance_place(x + hspd, y, obj_Bubble);
var inimigo_Morcego = instance_place(x + hspd, y, obj_Morcego);
var inimigo_Sapo = instance_place(x + hspd, y, obj_Frog);
var buraco = instance_place(x + hspd, y, obj_Buraco_Negro);

var inimigo = inimigo_Bubble || inimigo_Morcego || inimigo_Sapo || buraco;

if (inimigo) {
    if (!dano_aplicado) {
        // Marcar dano como aplicado
        dano_aplicado = true;

        // Calcular a posição do inimigo
        // Armazena a posição X do inimigo
// Armazena a posição X do inimigo

// Definir recuo com base no movimento ou direção do jogador
if (hspd > 0) {
    hspd = -100; // Recuo para a esquerda (se movendo para a direita)
} else if (hspd < 0) {
    hspd = 100;  // Recuo para a direita (se movendo para a esquerda)
} else {
    // Jogador está parado, então recuar baseado na direção para onde ele está virado
    if (image_xscale > 0) {
        hspd = -100; // Se o jogador está virado para a direita, recua para a esquerda
    } else if (image_xscale < 0) {
        hspd = 100;  // Se o jogador está virado para a esquerda, recua para a direita
    }
}
// Verificar colisão com o boss diretamente
vspd = -20;

        // Reduzir a vida do jogador
        global.vida -= 1;

        // Ativar o efeito de hit flash
        hit_flash_timer = hit_flash_duration;

        // Evitar que o personagem fique preso em objetos
        while (place_meeting(x + hspd, y, obj_Parede)) {
            x += (hspd > 0) ? -1 : 1; // Ajusta a posição para evitar colidir
        }

        // Lógica para verificar colisão com o chão ou inimigos após o knockback
        if (!chao && vspd > 0) {
            var collision_e = instance_place(x, y + 1, obj_Inimigos_Parents);
			var collision_b = instance_place(x, y + 1, obj_Boss_Parent);
            if (collision_e || collision_b) {
                vspd = 0;
                vspd -= pulo_height;
                pulo = false;
                instance_destroy(collision_e.id);
            }   
    }
} else {
    // Se não houver colisão com o inimigo, reseta o controle de dano
    dano_aplicado = false;
}

// Aplica movimento
x += hspd;
y += vspd;   
}

if (boss) {
   show_debug_message("Colidiu com o boss");

    // Verifica se o jogador está colidindo com a parte de cima do boss
    if (y < boss.y) { // O jogador está acima do boss
        // Aplica um impulso para cima no jogador
        vspd = -20;

        // Aplica dano ao boss
        boss_AplicarDano(5); // Ajuste o valor de dano conforme necessário

        // Evita que o jogador receba dano do boss
        dano_aplicado = true;

    } else if (!dano_aplicado) { // O jogador está colidindo com o boss de lado
        // Marcar dano como aplicado para evitar repetição
        dano_aplicado = true;

        // Define o knockback baseado na direção
        if (hspd > 0) {
            hspd = -100; // Knockback para a esquerda se movendo para a direita
        } else if (hspd < 0) {
            hspd = 100;  // Knockback para a direita se movendo para a esquerda
        } else {
            hspd = (image_xscale > 0) ? -100 : 100; // Knockback baseado na direção do jogador
        }

        // Aplica o knockback
        x += hspd;
        vspd = -20;

        // Reduz a vida do jogador
        global.vida -= 1;

        // Ativar o efeito de hit flash
        hit_flash_timer = hit_flash_duration;

        // Evitar que o personagem fique preso em objetos
        while (place_meeting(x + hspd, y, obj_Parede)) {
            x += (hspd > 0) ? -1 : 1; // Ajusta a posição para evitar colidir
        }

        // Lógica para verificar colisão com o chão ou inimigos após o knockback
        if (!chao && vspd > 0) {
            var collision_e = instance_place(x, y + 1, obj_Inimigos_Parents);
            var collision_b = instance_place(x, y + 1, obj_Boss_Parent);
            if (collision_e || collision_b) {
                vspd = 0;
                vspd -= pulo_height;
                pulo = false;
               if (collision_e) {

    // Destruir o inimigo
    instance_destroy(collision_e.id);
}

            }
        }
    
} else {
    // Se não houver colisão com o inimigo, reseta o controle de dano
    dano_aplicado = false;
}

// Aplica movimento
x += hspd;
y += vspd;   
}

// Após a lógica de dano, continue com a lógica do jogo
// Atualizar a gravidade
vspd += gravity; // Adiciona gravidade se necessário


    // Checar se a vida do jogador chegou a zero
    if (global.vida <= 0) {
        is_dead = true;
        sprite_index = spr_Humira_Dead; // Muda o sprite para o sprite de morte

        // Desativa movimento e controle
        hspd = 0;
        vspd = 0;
        key_left = false;  // Desativa o controle para a esquerda
        key_right = false; // Desativa o controle para a direita

        // Marcar a animação de morte como tocada
        if (!global.death_animation_played) {
            // Se a animação de morte ainda não foi tocada
            image_speed = 0.1; // Ajusta a velocidade para garantir que a animação rode lentamente
            global.death_animation_played = true; // Marca a animação como já tocada
			
			//Tela Game over
			if (global.game_over == false) {
				var cam_x = camera_get_view_x(view_camera[0]);
				var cam_y = camera_get_view_y(view_camera[0]);
				layer_sequence_create("Sequencia", cam_x, cam_y, sq_GameOver);
				audio_stop_all();
				audio_play_sound(sound_Morte, 5, true);
				global.game_over = true
			}
        }

        // Garantir que o personagem não entre no chão
        if (place_meeting(x, y + 1, obj_Parede)) {
            while (place_meeting(x, y + 1, obj_Parede)) {
                y -= 1; // Ajusta a posição para evitar que entre no chão
            }
        }

        return; // Sai da função para não executar o restante do código
    }
	
}
#endregion // DANO

// Função de ataque deletada;

// Função de wall jump deletada;
