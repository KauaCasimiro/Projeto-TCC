// Aplicar a gravidade para simular a queda
vspd += gravidade;
y += vspd;

// Parar a poção ao tocar o chão (substitua "obj_Parede" pelo objeto que representa o chão)
if (place_meeting(x, y + 1, obj_Parede)) {
    vspd = 0;
    y = yprevious; // Evitar que passe do chão
}

// Verificação de colisão com o jogador
if (place_meeting(x, y, obj_Humira)) {
    // Aumenta a vida do jogador ao coletar a poção
    if (global.vida < global.vida_max) {
        global.vida += 1;  // Aumenta a vida atual até o máximo permitido
    } else {
        // Incrementa o máximo de vidas se a vida já está no máximo
        global.vida_max += 1;
        global.vida = min(global.vida + 1, global.vida_max);
    }

    // Destroi a poção ao ser coletada
    instance_destroy();
}
