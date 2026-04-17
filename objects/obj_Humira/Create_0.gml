// Inicialização de variáveis globais e locais
global.death_animation_played = false;

// Prioridades de inicialização
hit_flash_duration = 10;   // Duração do efeito de hit flash em passos
hit_flash_timer = 0;       // Contador para controlar a duração do flash
hit_flash_color = c_red;   // Cor do efeito de flash
hit_flash_alpha = 1;       // Opacidade do flash (1 é completamente opaco)

is_dead = false;           // Verifica se o personagem está morto
death_frame = 0;           // Conta os frames da animação de morte

// Velocidades
spd = 10;                  // Velocidade base
spd_run = 15;              // Velocidade ao correr
spd_walk = 10;             // Velocidade ao andar

// Movimento horizontal e vertical
hspd = 0;                  // Velocidade horizontal
vspd = 0;                  // Velocidade vertical
grv = 0.5;                 // Gravidade
global.time_grav = 0;             // Tempo da gravidade

// Variáveis de dano e empurrão
dano_dir = 0;			   // Direção do dano
dano_aplicado = false;     // Verifica se o dano foi aplicado

// Variáveis de pulo

grounded = false;
in_knockback = false;
wall_direction = 0;
wall_jump_force = 12;
wall_jumping = false;
jumping_from_wall = false;
pulo = true;
pulo_height = 0.2;

// Variáveis para o texto piscante
blink_timer = 0;           // Contador para temporização
blink_interval = 30;       // Intervalo de piscar em frames
text_visible = true;       // Estado de visibilidade do texto
show_restart_text = false; // Flag para exibir o texto de reinício

//global.cerejas = 0;

// Configurações da imagem
image_speed = 0.4;

// Configurações de vida
// Inicialização no início do jogo, antes de qualquer troca de fase
// Inicialização das variáveis globais apenas uma vez, no início do jogo
if (!variable_global_exists("vida")) {
    global.vida_max = 3;
    global.vida = global.vida_max;
    global.energia_max = 100;
    global.energia = global.energia_max;
}

global.vida_salva = undefined;
global.energia_salva = undefined
// Se há valores salvos, restaura-os ao entrar em uma nova fase
if (global.vida_salva != undefined) {
    global.vida = global.vida_salva;
    global.energia = global.energia_salva;
}

// Limpa as variáveis salvas após restaurar
global.vida_salva = undefined;
global.energia_salva = undefined;

// Limpa as variáveis salvas após restaurar



previous_x = x;
previous_y = y;

// Função para aplicar a gravidade
function gravidade() {
    vspd = vspd + grv;
}
