// Definir as dimensões da tela
var gui_larg = display_get_gui_width(); // Largura da tela
var gui_alt = display_get_gui_height(); // Altura da tela

// Definir o centro da tela
var x1 = gui_larg / 2; // Centro da largura da tela
var y1 = gui_alt / 2; // Centro da altura da tela

// Calcular a distância entre as linhas de texto
var dist = global.text_height; // Distância entre as linhas de texto (já definida)

// Calcular a posição do botão "Voltar" com base nos textos
var button_y = y1 + (dist * (array_length_1d(global.texts) - 1)) + 10; // Posição do botão

// Definir o alinhamento e cor do texto
draw_set_font(fnt_Min);
draw_set_halign(fa_center); // Centraliza horizontalmente
draw_set_valign(fa_center); // Centraliza verticalmente
draw_set_color(c_white); // Cor do texto

// Loop para desenhar os textos
for (var i = 0; i < array_length_1d(global.texts); i++) {
    var y_position = y1 + (dist * (i - 1)); // Ajusta a posição Y para os textos

    // Se o texto for o que você quer quebrar em duas linhas
    if (i == 1) {
        // Desenha a primeira linha do texto quebrado
        draw_text(x1, y_position, "Segure a tecla Shift para correr mais rápido");
        
        // Ajusta a posição y para a segunda linha com mais espaçamento
        var y_position2 = y_position + dist + -50; // Ajuste o valor para espaçamento adequado

        // Desenha a segunda linha do texto quebrado
        draw_text(x1, y_position2, "e pular mais alto, cuidado para não gastar toda sua energia");
    } 
    else if (i == 3) {
        // Desenha a primeira linha do texto quebrado
        draw_text(x1, y_position, "Colete todos os 8 pedaços de chave distribuidos");
        
        // Ajusta a posição y para a segunda linha com mais espaçamento
        var y_position2 = y_position + dist + -50; // Ajuste o valor para espaçamento adequado

        // Desenha a segunda linha do texto quebrado
        draw_text(x1, y_position2, "pelas fases para libertar sua mãe");
    } 
    else {
        // Para os outros textos, apenas desenha normalmente
        draw_text(x1, y_position, global.texts[i]);
    }
	if (i == 3) {
		break;
	}
}
// Adicionando o botão "Voltar" com retângulo pixelado
draw_set_color(c_purple); // Cor do botão

// Medir o texto do botão "Voltar"
var text_width = string_width(global.texts[4]);
var text_height = string_height(global.texts[4]);

// Desenhar retângulo pixelado ao redor do botão
var rect_margin = 5; // Margem extra ao redor do texto
var rect_x1 = x1 - (text_width / 2) - rect_margin;
var rect_x2 = x1 + (text_width / 2) + rect_margin;
var rect_y1 = button_y - (text_height / 2) - rect_margin;
var rect_y2 = button_y + (text_height / 2) + rect_margin;

draw_rectangle(rect_x1, rect_y1, rect_x2, rect_y2, false); // Retângulo ao redor do botão

// Desenhar o texto do botão
draw_set_color(c_lime); // Cor do texto
draw_text(x1, button_y, global.texts[4]);

// Resetando o font para o valor padrão
draw_set_font(-1);