/// @function scr_msg_id_to_String(msgID)
/// @description Converts macro value to string of macro name
/// @param msgID
// Returns name of macro

// set input
var msgID = argument0;

// return string
switch (msgID) {
    case CLIENT_CONNECT:
        return "CLIENT_CONNECT";
    case SERVER_CONNECT:
        return "SERVER_CONNECT";
    case CLIENT_LOGIN:
        return "CLIENT_LOGIN";
    case SERVER_LOGIN:
        return "SERVER_LOGIN";
    case CLIENT_PLAY:
        return "CLIENT_PLAY";
    case SERVER_PLAY:
        return "SERVER_PLAY";
    }
