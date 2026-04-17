// Teleporta o jogador para a próxima fase se ele tiver a quantia exata de pedaços
if (global.fase == 1 && global.pedacos_Chave >= 4) {
    // Salva a vida e energia atuais do jogador antes de mudar de fase
    global.vida_salva = global.vida;
    global.energia_salva = global.energia;
    global.fase = 2; // Avança para a fase Montanha
    room_goto_next();
} else if (global.fase == 2 && global.pedacos_Chave >= 8) {
    global.vida_salva = global.vida;
    global.energia_salva = global.energia;
    global.fase = 3; // Avança para a fase Rio
    room_goto_next();
}
