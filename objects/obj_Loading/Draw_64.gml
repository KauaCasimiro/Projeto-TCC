// Coordenadas para centralizar o loading na tela
draw_set_font(fnt_Min);
var x_center = display_get_gui_width() / 2;
var y_center = display_get_gui_height() / 2;

// Ângulo com base no progresso
var angle = (global.load_progress / 100) * 360;

// Desenhar o sprite preenchendo gradualmente
draw_sprite_ext(
    spr_Loading,       // Seu sprite circular
    0,                 // Subimagem (0 para estático)
    x_center,          // Coordenada X
    y_center,          // Coordenada Y
    1,                 // Escala X
    1,                 // Escala Y
    0,                 // Rotação do sprite
    c_white,           // Cor
    1                  // Opacidade
);

// Máscara para simular preenchimento radial
draw_sprite_part(
    spr_Loading,       // Seu sprite
    0,                 // Subimagem
    0,                 // X inicial do recorte
    0,                 // Y inicial do recorte
    sprite_width * (angle / 360), // Largura da parte preenchida
    sprite_height,     // Altura total do sprite
    x_center,          // Coordenada X
    y_center           // Coordenada Y
);

// Texto do progresso
draw_set_color(c_white);
draw_text(x_center - 20, y_center + 50, string(global.load_progress) + "%");
