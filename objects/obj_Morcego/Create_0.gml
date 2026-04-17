event_inherited();
move_spd = 2.50;
move_dir = -1; // Direção horizontal: -1 para esquerda, 1 para direita
xscale = 1;
alvo = noone; // Inicialização do alvo como 'noone'
var tempo_espera = 60; // Espera por 1 segundo (60 frames)
var perseguindo = false; // Flag de perseguição
var cor_morcego = c_white; // Cor inicial


// Função de movimento
state_fly = function() {
    // Verifica se há uma parede à frente
    var ground_ahead = place_meeting(x + (move_dir * 10), y, obj_Parede);
    
    // Se houver parede à frente, inverte a direção
    if (ground_ahead) {
        move_dir *= -1; // Inverte a direção
    }

    // Move o objeto horizontalmente
    x += move_dir * move_spd;

    // Verifica se o morcego está fora dos limites da tela e corrige
    if (y < 0) {
        y = 0; // Limita a altura mínima
    } else if (y > room_height) {
        y = room_height; // Limita a altura máxima
    }

    // Ajusta a escala do sprite para a direção correta
    image_xscale = (move_dir == -1) ? -1 : 1; // Define a escala com base na direção
}

// Função para calcular o campo de visão
function campo_Visao(_largura, _altura, _xscale) {
    var _x1, _y1, _x2, _y2;
    
    _x1 = x;
    _y1 = y + _altura / 1.5 - sprite_height / 3;

    // Se o morcego estiver indo para a direita
    // Verificar a direção do morcego e definir _x2
    if (move_dir == 1) {
        _x2 = _x1 + _largura; // Campo de visão à direita
        image_xscale = 1; // Olhar para a direita
    } 
    else if (move_dir == -1) {
        _x2 = _x1 - _largura; // Campo de visão à esquerda
        image_xscale = -1; // Olhar para a esquerda
    }
    else {
        // Fallback caso move_dir seja 0 ou outro valor inesperado
        _x2 = _x1 + _largura; // Definir para a direita como padrão
        image_xscale = 1; // Olhar para a direita por padrão
    }

    _y2 = _y1 - _altura;

    // Desenhar o retângulo para depuração (opcional)
    //draw_rectangle(_x1, _y1, _x2, _y2, false);
    
    // Verificar colisão dentro do retângulo de visão
    var _alvo = collision_rectangle(_x1, _y1, _x2, _y2, obj_Humira, 0, 1);
    
    return _alvo;
}

function perseguir() {
    // Definir valores da largura e altura do campo de visão
    

    // Atualizar alvo com base na visão do morcego
    var alvo = campo_Visao(larg_Visao, sprite_height * alt_visao, xscale);
	
	  if (instance_exists(alvo)) {
        if (!perseguindo) {
            // Detecção do jogador
            cor_morcego = c_yellow; // Mudar a cor para amarelo
            move_spd = 0; // Parar o morcego por 1 segundo
            tempo_espera -= 1; // Contar tempo

            if (tempo_espera <= 0) {
                // Quando o tempo terminar, começar a perseguição
                perseguindo = true;
                cor_morcego = c_white; // Voltar à cor normal
            }
        } else {
            // Lógica de perseguição
            var _dir = point_direction(x, y, alvo.x, alvo.y);
            move_spd = 3.5;
            hspd = lengthdir_x(move_spd, _dir);
            vspd = lengthdir_y(move_spd, _dir);
        }
    } else {
        // Quando não há alvo, o morcego volta ao estado normal
        perseguindo = false;
        tempo_espera = 60; // Resetar o tempo
        move_spd = 2.5; // Velocidade padrão
        cor_morcego = c_white; // Cor padrão
    }

    // Atualizar a cor do morcego
    image_blend = cor_morcego;
}
