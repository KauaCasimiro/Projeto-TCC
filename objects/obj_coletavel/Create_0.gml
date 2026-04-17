// Inicializa as variáveis globais no começo do jogo
if (!variable_global_exists("pedacos_Chave")) {
    global.pedacos_Chave = 0; // Contador acumulado de pedaços
}
if (!variable_global_exists("total_Pedacos")) {
    global.total_Pedacos = 8; // Total de pedaços necessários para a chave completa
}
if (!variable_global_exists("fase")) {
    global.fase = 1; // Começa na fase 1
}
if (!variable_global_exists("pedacos_Fase")) {
    global.pedacos_Fase = 0; // Quantidade de pedaços na fase atual
}
