// Incrementa a contagem de pedaços de chave
global.pedacos_Chave++;  // Contador global de todos os pedaços coletados
global.pedacos_Fase++;   // Contador específico para a fase atual

// Destroi o pedaço de chave após ser coletado
instance_destroy();  

// Verifica se o jogador coletou pedaços suficientes para a fase atual
if (global.fase == 1 && global.pedacos_Fase >= 4) {
    show_message("Você coletou 4 pedaços de chave. Abra o portal para a Montanha.");
} else if (global.fase == 2 && global.pedacos_Fase >= 8) {
    show_message("Você coletou 4 pedaços de chave. Abra o portal para o Rio.");
} else if (global.fase == 3 && global.pedacos_Chave >= global.total_Pedacos) {
    show_message("Você coletou todos os pedaços de chave!");
}
