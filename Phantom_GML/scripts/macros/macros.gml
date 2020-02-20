#macro NETWORK_CONNECT 0
#macro NETWORK_LOGIN 2
#macro NETWORK_PLAY 1
#macro LEFT_KEY 0
#macro RIGHT_KEY 1
#macro UP_KEY 2
#macro DOWN_KEY 3
#macro ACTION_KEY 4
#macro ACTION2_KEY 5
#macro LEFTSELC_KEY 6
#macro RIGHTSELC_KEY 7
#macro KEY_TYPE 8

#macro INPUT_CMD 0
#macro PING_CMD 1
#macro TILE_CMD 2
#macro UPDATE_CMD 3

#macro KEY_PRESSED 2
#macro KEY_ISPRESSED 1
#macro KEY_ISRELEASED 0
#macro KEY_RELEASED -1
#macro CLIENT_CONNECT 5
#macro SERVER_CONNECT 6
#macro CLIENT_LOGIN 3
#macro SERVER_LOGIN 4
#macro CLIENT_PLAY 0
#macro SERVER_PLAY 2
#macro SEQUENCE_MAX 255
#macro CONTROLS_KEYBOARD 5
#macro CONTROLS_MOUSE 6
#macro CONTROLS_GP1 0
#macro CONTROLS_GP2 1
#macro CONTROLS_GP3 2
#macro CONTROLS_GP4 3
#macro CONTROLS_GP5 4
#macro GAMEPAD_AXIS_TOL .5

#macro STATE_GAME_OPTIONS -6
#macro STATE_ONLINE -5
#macro STATE_CONTROLS -4
#macro STATE_DEBUGOPTIONS -3
#macro STATE_OPTIONS -2
#macro STATE_MAIN -1
#macro STATE_LOBBY 0
#macro STATE_PATHS 1
#macro STATE_GAME 2
#macro STATE_SCORE 3

#macro GRAB_TOL 6   //maximum number of pixels away a player's hit box can be and still grab an object
#macro PLAYER_TOL 3 //number of pixels on either side of the character sprite before the hit box
#macro HANGING_TOL 8 //Number of pixels from the top of a ledge a character must be to grab onto the ledge
