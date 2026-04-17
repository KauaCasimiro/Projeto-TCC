draw_set_font(fnt_Large);
draw_set_color(c_white);

var dist = 60; // Espaçamento entre as opções
var gui_larg = display_get_gui_width();
var gui_alt = display_get_gui_height();
var x1 = gui_larg / 2; // Centro da largura da tela
var y1 = gui_alt / 2; // Centro da altura da tela (não usado diretamente aqui)

for (var i = 0; i < op_max; i++) {
    draw_set_halign(fa_center); // Centraliza horizontalmente
    draw_set_valign(fa_center); // Centraliza verticalmente no texto
    if (index == i){
		draw_set_color(c_yellow);
	} else {
		draw_set_color(c_white)
	}

	
	draw_text(x1, y1 + (dist * i), opcoes[i]); // Usa x1 como centro no eixo X
	
		
}

draw_set_font(-1); // Reseta a fonte
