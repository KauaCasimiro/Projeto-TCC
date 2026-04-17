//Deus tenha piedade de quem for ler esse código daqui pra frente.
event_inherited();
move_spd = 5;
move_dir = 1; // Inicia a direção para a direita
alvo = noone;
xscale = 1;
larg_Visao = 1000;
alt_Visao = 2;
timer_turn = irandom_range(60, 120);
timer_rock = 0;
timer_move = 0;
timer_idle = 0;
state = "parado";
global.boss_life = 200; // Vida inicial do boss (exemplo)
flash_timer = 0; // Timer para o efeito de flash
destroy_timer = -1; // Temporizador de destruição (-1 significa que ainda não começou)
flash_color = c_red; // Cor inicial do flash (vermelho)
global.boss_alive = true;
global.boss_stage = 1;              // Estágio inicial
global.boss_attack_speed = 1;       // Velocidade de ataque inicial
global.boss_color = c_yellow;       // Cor inicial (amarelo)
global.stage_2_life_threshold = 66;    // Vida mínima para estágio 2
global.stage_3_life_threshold = 33;    // Vida mínima para estágio 3
existe = true;
global.check_stage = function() {
    if (global.boss_life > global.stage_2_life_threshold) {
        global.boss_attack_speed = 0.5 ;
        global.boss_color = c_yellow;
    } else if (global.boss_life > global.stage_3_life_threshold) {
        global.boss_attack_speed = 1.2;
        global.boss_color = c_orange;
    } else {
        global.boss_attack_speed = 1.5;
        global.boss_color = c_red;
    }
};

 function campo_Visao(_largura, _altura, _xscale) {
    var _x1, _y1, _x2, _y2;
    
    _x1 = x;
    _y1 = y - _altura / -4; // Ajuste para garantir que a altura esteja correta

    // Se o sapo estiver indo para a esquerda
    if (move_dir == 1) {
        _x2 = _x1 + _largura; // Campo de visão à esquerda
        image_xscale = 1;    // Olhar para a esquerda
    } 
    // Se o sapo estiver indo para a direita
    else if (move_dir == -1) {
        _x2 = _x1 - _largura; // Campo de visão à direita
        image_xscale = -1;     // Olhar para a direita
    } else {
        _x2 = _x1 - _largura; // Fallback para esquerda
        image_xscale = 1;    // Olhar para a esquerda por padrão
    }

    _y2 = _y1 - _altura;

    // Desenhar o retângulo para depuração (opcional)
    //draw_rectangle(min(_x1, _x2), _y1, max(_x1, _x2), _y2, false);
    
    // Verificar colisão dentro do retângulo de visão
    var _alvo = collision_rectangle(min(_x1, _x2), _y1, max(_x1, _x2), _y2, obj_Humira, 0, 1);
    
    return _alvo;
}

// Função de idle (estado parado)
state_idle = function() {
    // Verifica se o temporizador já terminou
    if (timer_turn <= 0) {
        // Inverte o valor de 'move_dir' para alternar o espelhamento
        move_dir *= -1;
        
        // Aplica a escala horizontal, apenas espelhando a imagem
        image_xscale = move_dir;
        
        // Reinicia o temporizador
        timer_turn = irandom_range(60, 120); // Define um novo tempo
    } else {
        // Reduz o temporizador a cada frame
        timer_turn--;
    }
}

// Função de movimento (estado caminhando)
state_walk = function() {
    var ground = place_meeting(x, y + 1, obj_Parede);

    if (ground) {
        // Calcula a velocidade horizontal com base na direção
        sprite_index = spr_Boss_Run;
        hspd = move_dir * move_spd;

        // Ajusta a escala do sprite para a direção correta
        image_xscale = move_dir;
        image_yscale = 1;
        
        // Verifica se há chão à frente na direção do movimento
        var ground_ahead = place_meeting(x + (move_dir * 90), y + 1, obj_Parede);
        
        // Se houver parede à frente ou não houver chão à frente, inverte a direção
        if (place_meeting(x + hspd, y, obj_Parede) || !ground_ahead) {
            move_dir *= -1; // Inverte a direção
            hspd = move_dir * move_spd; // Recalcula a velocidade horizontal com a nova direção
        }
        
        // Move o objeto
        x += hspd;
    }
}

// Função de ataque (estado atacando)
state_attack = function() {
    // Detecta o jogador dentro do campo de visão
    alvo = campo_Visao(larg_Visao, sprite_height * alt_Visao, xscale);

    // Debug para verificar o alvo
    show_debug_message("Alvo: " + string(alvo));

    // Verifica se um alvo existe dentro da visão
    if (instance_exists(alvo)) {
        var _dir = point_direction(x, y, alvo.x, alvo.y);

        // O boss se prepara para atacar
        if (sprite_index != spr_Boss_Attack) {
            sprite_index = spr_Boss_Attack;
            image_index = 0;
            image_speed = 1;

            // Aplica a cor conforme o estágio do boss
            if (global.boss_stage == 3) {
                image_blend = c_red;
            } else if (global.boss_stage == 2) {
                image_blend = c_orange;
            } else {
                image_blend = c_yellow;
            }
        }

        // Ajusta a direção do boss para olhar para o alvo
        image_xscale = (alvo.x > x) ? 1 : -1;
        show_debug_message((alvo.x > x) ? "Alvo à direita" : "Alvo à esquerda");

        // Checa se o temporizador permite lançar uma nova pedra
        if (timer_rock <= 0 && image_index >= 2 && image_index < 3) {
            show_debug_message("Lançando pedra");
            var rock = instance_create_layer(x, y, "projeteis", obj_Rock);
            rock.direction = _dir;
            rock.image_xscale = (alvo.x < x) ? -1 : 1;

            timer_rock = 12;
        }

        // Reduz o temporizador a cada frame
        if (timer_rock > 0) {
            timer_rock--;
        }

    } else { 
        // Se não houver alvo, retorna ao estado idle
        show_debug_message("Alvo não encontrado, voltando ao estado idle.");

        // Verifica se a animação de ataque terminou
        if (image_index >= sprite_get_number(spr_Boss_Attack) - 1) {
            sprite_index = spr_Boss;
            image_speed = 1;
            image_blend = c_white;  // Reseta a cor ao retornar ao idle
            timer_turn = irandom_range(60, 120);

            // Volta ao estado idle com a alternância de direção
            state = "parado";
            state_idle();
            show_debug_message("Estado: idle");
        }
    }
}




