var mouseX = device_mouse_x_to_gui(0); // Obtém a posição X do mouse no GUI
var mouseY = device_mouse_y_to_gui(0); // Obtém a posição Y do mouse no GUI

var dist = 60; // Distância entre cada opção
var gui_larg = display_get_gui_width(); // Largura do GUI
var gui_alt = display_get_gui_height(); // Altura do GUI
var x1 = gui_larg / 2; // Posição central no eixo X
var y1 = gui_alt / 2; // Posição inicial no eixo Y

// Detectar qual opção o cursor está sobre
for (var i = 0; i < op_max; i++) {
    // Calcula a área de cada opção (um retângulo em torno do texto)
    var opt_x = x1 - 100; // Largura de 200px centrada
    var opt_y = y1 + (dist * i) - 20; // Altura ajustada com uma margem
    var opt_w = 200; // Largura do retângulo
    var opt_h = 40; // Altura do retângulo

    // Verifica se o mouse está dentro da área da opção
    if (mouseX > opt_x && mouseX < opt_x + opt_w && mouseY > opt_y && mouseY < opt_y + opt_h) {
        index = i; // Atualiza o índice com o índice da opção onde o cursor está
    }
}
