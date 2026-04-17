event_inherited();
move_spd = 1.20;
move_dir = -1;
part_system = part_system_create();
part_system_depth(part_system, -100); // Garantir que as partículas sejam visíveis acima de outros objetos

// Criar o tipo de partículas
part_type = part_type_create();
part_type_shape(part_type, pt_shape_explosion); // Forma de explosão
part_type_size(part_type, 0.5, 1, 0, 0); // Tamanho variável
part_type_color3(part_type, c_yellow, c_orange, c_red); // Gradiente de cores
part_type_alpha3(part_type, 1, 0.5, 0); // Dissolver no final
part_type_life(part_type, 30, 50); // Tempo de vida
part_type_speed(part_type, 3, 6, 0, 0); // Velocidade
part_type_direction(part_type, 0, 360, 0, 0); // Direção aleatória
part_type_gravity(part_type, 0.2, 270); // Gravidade suave


state_walk = function() {
    var ground = place_meeting(x, y + 1, obj_Parede);

    if (ground) {
        // Calcula a velocidade horizontal com base na direção
        hspd = move_dir * move_spd;

        // Ajusta a escala do sprite para a direção correta
        image_xscale = -move_dir;
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





state = state_walk;




function gravidade() {
	vspd = vspd + grv;
}

 /*
 São 2:51 da manhã, dia 23/08/2024, fiquei longas 3 horas tentando resolver isso, e agora funcionou
 NUNCA MAIS MEXA NISSO, E UTILIZE SEMPRE A MESMA BASE PARA OS PRÓXIMOS
 */