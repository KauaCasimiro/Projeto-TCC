// Simula o progresso do carregamento
if (global.load_progress < 100) {
    global.load_progress += 5; // Incrementa o progresso
    alarm[0] = 30; // Chama novamente o alarme
} else {
    room_goto_next(); // Troca para a próxima sala após o carregamento
}
