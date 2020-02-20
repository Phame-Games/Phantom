/// @description scr_update_input(oldState, newState)
/// @param oldState
/// @param  newState
/* 
* Description:  update the control to the next state
* Parameters:   oldState - the old state of the input
*               newState - the new target state
* Returns:      real - state
*/

// set input
var oldState = argument0;
var newState = argument1;

// take step to new state
switch (oldState) {
    case KEY_PRESSED:
        switch (newState) {
            case KEY_PRESSED:
            case KEY_ISPRESSED:
                return KEY_ISPRESSED;
            case KEY_RELEASED:
            case KEY_ISRELEASED:
                return KEY_RELEASED;
            }
    case KEY_ISPRESSED:
        switch (newState) {
            case KEY_PRESSED:
            case KEY_ISPRESSED:
                return KEY_ISPRESSED;
            case KEY_RELEASED:
            case KEY_ISRELEASED:
                return KEY_RELEASED;
            }
    case KEY_RELEASED:
        switch (newState) {
            case KEY_PRESSED:
            case KEY_ISPRESSED:
                return KEY_PRESSED;
            case KEY_RELEASED:
            case KEY_ISRELEASED:
                return KEY_ISRELEASED;
            }
    case KEY_ISRELEASED:
        switch (newState) {
            case KEY_PRESSED:
            case KEY_ISPRESSED:
                return KEY_PRESSED;
            case KEY_RELEASED:
            case KEY_ISRELEASED:
                return KEY_ISRELEASED;
            }
    default:
        return newState;
    }

