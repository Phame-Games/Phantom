/// @description scr_toggle_key(state)
/// @param state
/*
* toggle key from PRESSED to ISPRESSED
* argument0 - key
*/
var value = argument0;
//start
    {
    if (value == KEY_PRESSED) return(KEY_ISPRESSED);
    if (value == KEY_RELEASED) return(KEY_ISRELEASED);
    else return(KEY_ISRELEASED);
    }
