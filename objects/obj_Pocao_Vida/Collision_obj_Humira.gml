if (global.vida < global.vida_max) {
    global.vida += 1;  // Aumenta a vida atual até o máximo permitido
}

else if (global.vida == global.vida_max) {
	// Supondo que o jogador pegou uma poção de vida
global.vida_max += 1;  // Incrementa o máximo de vidas
global.vida = min(global.vida + 1, global.vida_max);  // Reestabelece 
}

instance_destroy();