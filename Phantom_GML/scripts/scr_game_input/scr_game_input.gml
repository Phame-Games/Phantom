/// @function scr_game_input()
/// @description all input for gameplay
/// @param inputs | Input array to update
// Returns null

var inputs = argument0

// write all the input
var controls = 0;
var amount = array_length_2d(global.controls, controls);
var j = 0

// send input according to type
switch (global.controls[controls, KEY_TYPE]) {
    case CONTROLS_KEYBOARD:
        for (var i = 0; i < amount-1; i++;) {
            // input the input state
            inputs[j++] = scr_get_key_input(global.controls[controls, i]);
            }
        break;
    case CONTROLS_MOUSE:
        for (var i = 0; i < amount-3; i++;) {
            // input the input state
            inputs[j++] = scr_get_key_input(global.controls[controls, i]);
            }
        for (var i = amount-3; i < amount-1; i++;) {
            // input the input state
            inputs[j++] = scr_get_mouse_input(global.controls[controls, i]);
            }
        break;
    default:
        // joystick input
		var device = global.controls[controls, KEY_TYPE]
		for (var i = 0; i < amount-1; i++) {
            // input the input state
            inputs[j++] = scr_get_gamepad_input(global.controls[controls, i], device);
            }
    }
    
if global.controls[controls, KEY_TYPE] != CONTROLS_KEYBOARD and global.controls[controls, KEY_TYPE] != CONTROLS_MOUSE {
	//write gamepad aiming
	gamepad_aimx = gamepad_axis_value(input, gp_axisrh)
	gamepad_aimy = gamepad_axis_value(input, gp_axisrv)
}
else {
	// write the mousX and mouseY
	mouseX = mouse_x
	mouseY = mouse_y
}