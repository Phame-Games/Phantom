/// @description initialize variables

//character
character = "";
//team
Team = 0;
// ready - whether player is ready to move to next menu
ready = false;
// name - player name
name = "Player";
//player_id - accumulative global number to identify player
player_id = 0;
//input - input player is using
input = 0;
//gameCharacter - character in game
gameCharacter = noone;
//startX and startY - starting coordinates
startX = 0;
startY = 0;

/// server

if (global.have_server) {
    // connectID - order in which client connected, used in lobby code
    connectID = global.player_total;
    
    global.player_total++;
    }


// mouse input
mouseX = 0;
mouseY = 0;
//gamepad aiming
gamepad_aimx = 0//value -1 to 1, right joystick
gamepad_aimy = 0//value -1 to 1, right joystick

// currentRTT - store the current round trip time for messages
currentRTT = 0;

// ip - ip of client, used for disconnecting
ip = 0;

// dropBuffer - steps before a client is dropped, from not recieving a ping
dropBuffer = 60;

/// join lobby

// join the client into the lobby
show_debug_message("Call scr_join_lobby")
scr_join_lobby(other);

/// debug

// socketOut - the socket
socketOut = -1;

// messageSuccess - whether the message was succesful sent
messageSuccess = -1;

inputs = array_create(3);
