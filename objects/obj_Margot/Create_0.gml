hspd = 0;                  // Velocidade horizontal
vspd = 0;                  // Velocidade vertical
grv = 0.5;                 // Gravidade
global.time_grav = 0;
function gravidade() {
    vspd = vspd + grv;
}
