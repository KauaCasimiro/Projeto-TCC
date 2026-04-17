// Evento Draw

var _x = 64;
var _y = 4;
var xx = 124;
var yy = 124
var distancia = 100;
//energia = (energia / max_energia) *100;

// Desenhar corações vazios (para indicar o máximo de vidas possíveis)
// Desenhar corações vazios (para o número máximo de vidas)
for (var i = 0; i < global.vida_max; i++) {
    var x1 = _x + (distancia * i);
    draw_sprite(spr_Vida, 1, x1, _y); // Desenha corações "vazios"
}

// Desenhar corações preenchidos (de acordo com a vida atual)
for (var i = 0; i < global.vida; i++) {
    var x1 = _x + (distancia * i);
    draw_sprite(spr_Vida, 0, x1, _y); // Desenha corações "cheios"
}



draw_sprite(spr_Chave, 0, 1270, 96);
draw_set_font(fnt_Large);
draw_text(1140, 76, string(global.pedacos_Chave));



/*draw_healthbar(20, 20, 1020, 40, global.time_grav*100, c_aqua,c_red,c_blue, 0, 1, 1);

draw_text(20, 50, global.time_grav);*/

draw_healthbar(xx - 20, yy + 5, xx + 200, yy - 15, global.energia, c_dkgray, c_aqua, c_blue, 0, true, true);

