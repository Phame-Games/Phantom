/// @description scr_get_mouse_input(button)
/// @param button
/* 
* Description: gets the current state of the key
* Parameters:  key - unicode value for the key
* Returns:     real, the constant value state of the key
*/

// set input
var key = argument0;

// return state
if (device_mouse_check_button_pressed(0, key))
    return (KEY_PRESSED);
else if (device_mouse_check_button(0, key))
    return (KEY_ISPRESSED);
else if (device_mouse_check_button_released(0, key))
    return (KEY_RELEASED);
else
    return (KEY_ISRELEASED);

