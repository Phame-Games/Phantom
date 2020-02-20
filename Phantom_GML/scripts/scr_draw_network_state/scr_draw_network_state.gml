/*
/ Description: draws the network state constant as a string
/ Script Call: scr_draw_network_state(state)
/ Parameters : state - int state constant
/ Return     : string
*/

// set input
var state = argument0;

// check state, and draw constant name accordingly
switch (state) {
    case SERVER_CONNECT:
        return("SERVER_CONNECT");
    case SERVER_LOGIN:
        return("SERVER_LOGIN");
    case SERVER_PLAY:
        return("SERVER_PLAY");
    default:
        return("ERROR: INCORRECT STATE");
    }
/*
if (global.NetworkState == NETWORK_CONNECT) draw_text(0, 100, "NETWORK_CONNECT");
else if (global.NetworkState == NETWORK_LOGIN) draw_text(0, 100, "NETWORK_LOGIN");
else if (global.NetworkState == NETWORK_PLAY) draw_text(0, 100, "NETWORK_PLAY");
*/