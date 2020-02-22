/// @description Initialize menus

//universal game access
global.Menu = self
global.online = true

//state - current "menu" of the game
state = STATE_ONLINE
//holds states in order visited for universal back button
state_queue = ds_stack_create()


buttons = ds_list_create(); //holds menu buttons
selected = 0; //selected button
input_buffer = 0; //small buffer to slow down gamepad input
input_buffer_max = 8
keyboard_input = false	//whether to show selection via keyboard
prev_mouse_x = mouse_x	//check to see if mouse move to turn off keyboard input

players = ds_list_create();
readys = ds_list_create();
names = ds_list_create();
game_players = ds_list_create();

//list to hold data for different menus, lobby
server_data = ds_list_create();

//universal colour array
ColourArray[0] = $80ff80;
ColourArray[1] = c_red;
ColourArray[2] = c_blue;
ColourArray[3] = c_yellow;
ColourArray[4] = c_green;
ColourArray[5] = c_purple;
ColourArray[6] = c_aqua;
ColourArray[7] = c_maroon;
ColourArray[8] = c_orange;
ColourArray[9] = c_teal;
ColourArray[10] = c_olive;
ColourArray[11] = c_ltgray;
ColourArray[12] = c_dkgray;
ColourArray[13] = c_navy;
ColourArray[14] = $ff8080;
ColourArray[15] = c_white;