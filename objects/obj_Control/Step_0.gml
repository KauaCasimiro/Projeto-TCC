// Em obj_Pocao_Vida, evento Step

// Reduz o temporizador para recriação da poção
potion_timer -= 1;

if (potion_timer <= 0 && global.boss_alive) { // Verifica se o boss está vivo
    // Reinicia o temporizador para 10 segundos
    potion_timer = 10 * room_speed;

    // Define uma posição aleatória na parte superior da sala
    var pos_x = irandom(room_width - sprite_width); // Garante que caia dentro dos limites da sala
    var pos_y = -sprite_height; // Acima da tela, para dar a impressão de que está caindo do céu

    // Cria uma nova poção no topo da sala
    instance_create_layer(pos_x, pos_y, "Instances_1", obj_Pocao_Vida);
}
