if (global.pedacos_Chave == 8 && (!instance_exists(obj_Boss) || !obj_Boss.existe)) {
    pode_Abrir = true;  // Agora a jaula pode ser aberta
} else {
    pode_Abrir = false; // Caso contrário, a jaula não pode ser aberta
}
