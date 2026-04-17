// Calcular as dimensões da tela
var gui_larg = display_get_gui_width(); // Largura da tela
var gui_alt = display_get_gui_height(); // Altura da tela

// Definir y1 e x1 para o centro da tela
var x1 = gui_larg / 2; // Centro da largura da tela
var y1 = gui_alt / 2; // Centro da altura da tela

// Calcular a posição do botão
var dist = global.text_height; // Distância entre as linhas de texto (já definida)
var button_y = y1 + (dist * (array_length_1d(global.texts) - 1)) + 10; // Posição do botão

// Verificar se o jogador clicou no botão "Voltar"
if (mouse_check_button_pressed(mb_left)) {
    if (mouse_x >= x1 - 100 && mouse_x <= x1 + 100 && mouse_y >= button_y - 20 && mouse_y <= button_y + 20) {
        room_goto(Menu);  // Vai para o menu principal
    }
}

// Verificar se o jogador pressionou Enter ou Espaço para ativar o botão
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    if (mouse_x >= x1 - 100 && mouse_x <= x1 + 100 && mouse_y >= button_y - 20 && mouse_y <= button_y + 20) {
        room_goto(Menu);  // Vai para o menu principal
    }
}
