// Evento Create
speed = 8; // Velocidade do projétil
direction = 0; // Direção será ajustada quando o projétil for instanciado
dano_aplicado = false;

function dano_Pedra() {
    // Verificar se a mosca saiu dos limites da sala
    if (x < 0 || x > room_width || y < 0 || y > room_height) {
        instance_destroy(); // Destroi o projétil se sair da sala
    }
    
    // Verificar colisão com a parede
    if (place_meeting(x, y, obj_Parede)) {
        instance_destroy(); // Destroi o projétil se colidir com uma parede
        return; // Sai da função
    }

    // Verificar colisão com o jogador (obj_Humira)
    var player = instance_place(x, y, obj_Humira); // Verifica se colidiu com o jogador
    if (player) {
        if (!dano_aplicado) {
            // Marcar dano como aplicado
            dano_aplicado = true;

            with (player) {
                global.vida -= 1;  // Reduz a vida do jogador
                hit_flash_timer = hit_flash_duration;  // Ativa o efeito de hit flash

                // Calcular o recuo com base na posição relativa da mosca ao jogador
                if (x < other.x) {
                    hspd = -100;  // Recuo para a esquerda
                } else {
                    hspd = 100; // Recuo para a direita
                }

                // Impulso vertical leve
                vspd = -20;  // Ajuste conforme necessário

                // Evitar que o jogador fique preso em objetos
                while (place_meeting(x + hspd, y, obj_Parede)) {
                    x += (hspd > 0) ? -1 : 1; // Ajusta a posição
                }

                // Aplicar movimento
                x += hspd;
                y += vspd;

                // Definindo a gravidade como uma variável local
                var gravidade = 0.5; // Ajuste o valor conforme necessário

                // Aplicar gravidade
                if (!place_meeting(x, y + 1, obj_Parede)) {
                    vspd += gravidade; // Agora deve funcionar
                } else {
                    vspd = 0; // Reseta a velocidade vertical se estiver no chão
                }
            }

            // Destrói a mosca após causar o dano
            instance_destroy();
        }
    } else {
        // Reseta o controle de dano se não houver colisão
        dano_aplicado = false;
    }
}
