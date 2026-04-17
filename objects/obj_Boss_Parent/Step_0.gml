// COLISÃO HORIZONTAL
if (place_meeting(x + hspd, y, obj_Parede)) {
    while (!place_meeting(x + sign(hspd), y, obj_Parede)) {
        x += sign(hspd);
    }
    hspd = 0; // Define hspd como 0 se houver colisão
	
}
x = x + hspd;

// COLISÃO VERTICAL
if (place_meeting(x, y + vspd, obj_Parede)) {
    while (!place_meeting(x, y + sign(vspd), obj_Parede)) {
        y += sign(vspd);
    }
    vspd = 0; // Define vspd como 0 se houver colisão
}
y = y + vspd;



function gravidade() {
	vspd = vspd + grv;
}