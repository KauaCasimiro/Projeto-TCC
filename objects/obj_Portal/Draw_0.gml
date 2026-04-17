// Define o sprite do portal com base na quantidade de pedaços coletados
if ((global.fase == 1 && global.pedacos_Chave >= 4) || (global.fase == 2 && global.pedacos_Chave >= 8)) {
    draw_sprite(spr_Portal, 1, x, y); // Sprite azul (portal ativo)
} else {
    draw_sprite(spr_Portal, 0, x, y); // Sprite cinza (portal inativo)
}

// Exibe o contador de pedaços de chave
draw_set_font(fnt_Large);
draw_text(x - 50, y, string(global.pedacos_Chave) + "/" + string(global.fase == 1 ? 4 : 8));
