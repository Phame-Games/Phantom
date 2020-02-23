/// @function scr_set_controls_default(player, controller)
/// @description Set the players controls to the default
/// @param player | the player controls to reset
/// @param controller | the type of default controlls

// set input
var player = argument0;
var controller = argument1;

// set controls
switch (controller) {
    case CONTROLS_KEYBOARD:
        global.controls[player, LEFT_KEY] = vk_left;
        global.controls[player, RIGHT_KEY] = vk_right;
        global.controls[player, UP_KEY] = vk_up;
        global.controls[player, DOWN_KEY] = vk_down;
        global.controls[player, ACTION_KEY] = vk_up;         // jump
        global.controls[player, ACTION2_KEY] = vk_numpad3;   // selection
        global.controls[player, LEFTSELC_KEY] = vk_numpad1;  // ice
        global.controls[player, RIGHTSELC_KEY] = vk_numpad2; // fire
        global.controls[player, KEY_TYPE] = CONTROLS_KEYBOARD;
        break;
    case CONTROLS_MOUSE:
        global.controls[player, LEFT_KEY] = ord("A");
        global.controls[player, RIGHT_KEY] = ord("D");
        global.controls[player, UP_KEY] = vk_space;
        global.controls[player, DOWN_KEY] = ord("S");
        global.controls[player, ACTION_KEY] = ord("W");      // jump
        global.controls[player, ACTION2_KEY] = vk_enter;     // selection
        global.controls[player, LEFTSELC_KEY] = mb_left;     // ice
        global.controls[player, RIGHTSELC_KEY] = mb_right;   // fire
        global.controls[player, KEY_TYPE] = CONTROLS_MOUSE;
        break;
	default:
		global.controls[player, LEFT_KEY] = -gp_axislh;
        global.controls[player, RIGHT_KEY] = gp_axislh;
        global.controls[player, UP_KEY] = -gp_axislv;
        global.controls[player, DOWN_KEY] = gp_axislv;
        global.controls[player, ACTION_KEY] = -gp_axislv;      // jump
        global.controls[player, ACTION2_KEY] = gp_start;     // selection
        global.controls[player, LEFTSELC_KEY] = gp_shoulderrb;     // ice
        global.controls[player, RIGHTSELC_KEY] = gp_shoulderlb;   // fire
        global.controls[player, KEY_TYPE] = controller;
    }
