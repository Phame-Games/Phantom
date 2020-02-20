/// @description scr_network_state_to_string(value)
/// @param value
/* 
* Description:  takes the msgID contsant and returns the corresponding string
* Parameters:   value - networkState
* Returns:      string
*/

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
