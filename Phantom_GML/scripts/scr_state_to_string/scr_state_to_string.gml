/// @description scr_state_to_string(value)
/// @param value

// set input
var value = argument0;

// return string
switch (value) {
	case STATE_MAIN:
		return "STATE_MAIN"
	case STATE_ONLINE:
		return "STATE_ONLINE"
    case STATE_LOBBY:
        return "STATE_LOBBY"
    case STATE_GAME:
        return "STATE_GAME"
    case STATE_SCORE:
        return "STATE_SCORE"
	default:
		return "State not added to scr_network_state"
    }
