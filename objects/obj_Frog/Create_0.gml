event_inherited();
// Inicializa a direção e o timer
move_dir = -1; // Começa com a direção para a esquerda
timer_turn = irandom_range(60, 120); // Define o tempo inicial aleatório
alvo = noone;
xscale = 1;
larg_Visao = 500;
alt_Visao = 2;
 

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

function campo_Visao(_largura, _altura, _xscale) {
    var _x1, _y1, _x2, _y2;
    
    _x1 = x;
    _y1 = y + _altura / 10.5; // Ajuste para garantir que a altura esteja correta

    // Se o sapo estiver indo para a esquerda
    if (move_dir == 1) {
        _x2 = _x1 - _largura; // Campo de visão à esquerda
        image_xscale = 1;    // Olhar para a esquerda
    } 
    // Se o sapo estiver indo para a direita
    else if (move_dir == -1) {
        _x2 = _x1 + _largura; // Campo de visão à direita
        image_xscale = -1;     // Olhar para a direita
    } else {
        _x2 = _x1 - _largura; // Fallback para esquerda
        image_xscale = 1;    // Olhar para a esquerda por padrão
    }

    _y2 = _y1 - _altura;

    // Desenhar o retângulo para depuração (opcional)
    draw_rectangle(min(_x1, _x2), _y1, max(_x1, _x2), _y2, false);
    
    // Verificar colisão dentro do retângulo de visão
    var _alvo = collision_rectangle(min(_x1, _x2), _y1, max(_x1, _x2), _y2, obj_Humira, 0, 1);
    
    return _alvo;
}


//MEXA SOMENTE DAQUI PARA BAIXO!!!!!!

// Função de perseguição (atualizada para disparar projétil assim que o jogador é detectado)
function atacar() {
    alvo = campo_Visao(larg_Visao, sprite_height * alt_Visao, xscale);
    
    // Debug para verificar o alvo
    //show_debug_message("Alvo: " + string(alvo));

    // Verifica se o alvo existe
    if (instance_exists(alvo)) {
        var _dir = point_direction(x, y, alvo.x, alvo.y);
        
        // Sapo para de se mover e prepara para o ataque
        sprite_index = spr_Frog_Attack; // Define o sprite de ataque
        
        // Ajusta a direção do sapo para olhar para o alvo
        if (alvo.x > x) {
            image_xscale = -1; // Olha para a direita
            move_dir = -1; // Mantenha a direção
            //show_debug_message("Alvo à direita");
        } else {
            image_xscale = 1; // Olha para a esquerda
            move_dir = 1; // Mantenha a direção
            //show_debug_message("Alvo à esquerda");
        }

        // Verifica se o frame está correto para disparar
        if (image_index >= 11 && image_index < 12) {
            if (!instance_exists(obj_Fly)) {
                //show_debug_message("Disparando mosca");
                var mosca = instance_create_layer(x, y, "projeteis", obj_Fly);
                mosca.direction = _dir; // Direção correta para o projétil
                mosca.image_xscale = (alvo.x < x) ? -1 : 1; // Corrige a direção do projétil
            } else {
                //show_debug_message("Já existe um projétil em cena");
            }

            image_speed = 0; // Congela no frame 12
        } else if (image_index < 11) {
            image_speed = 1; // Continua a animação até chegar ao frame 12
        }
    } else { 
        //show_debug_message("Alvo não encontrado, voltando ao estado idle.");

        // Verifica se a animação de ataque terminou
        if (image_index < sprite_get_number(spr_Frog_Attack) - 1) {
            image_speed = 1; // Continua a animação até o final
        } else {
            sprite_index = spr_Frog_Idle; // Volta ao sprite de idle
            image_speed = 1; // Retorna à anim ão normal
            image_blend = c_white; // Reseta a cor do sapo
            timer_turn = irandom_range(60, 120); // Reinicia o temporizador
            state_idle();  // Chama a função de idle

            //show_debug_message("Estado: idle");
        }
    }
}
