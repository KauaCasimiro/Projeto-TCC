switch(index) {
	case 0: {
		room_goto_next();
		break;
	}
	
	case 1: {
		room_goto(comoJogar);
		break;
	}
	
	case 2: {
		game_end();
		break;
	}
}