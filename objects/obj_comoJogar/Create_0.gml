// obj_como_jogar Create Event
global.texts = [
    "Use as teclas A/D ou as setas para se mover", 
    "Segure a tecla Shift para correr mais rápido e pular mais alto, cuidado para não gastar toda sua energia", 
    "Utilize a tecla Espaço ou a seta para cima para pular", 
    "Colete todos os 8 pedaços de chave distribuidos pelas fases para libertar sua mãe",
	"Voltar"
];
global.current_text = 0; // Começa no primeiro texto

// Definindo text_height para ser usado no Draw e Step
global.text_height = 80; // Distância entre as linhas de texto
