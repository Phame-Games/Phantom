/// @function scr_network_state_to_string(value)
/// @description Returns string of macro
/// @param value | value to convert
// Returns string

// set input
var value = argument0;

// return string
switch (value) {
    case NETWORK_CONNECT:
        return "NETWORK_CONNECT";
    case NETWORK_LOGIN:
        return "NETWORK_LOGIN";
    case NETWORK_PLAY:
        return "NETWORK_PLAY";
    }
