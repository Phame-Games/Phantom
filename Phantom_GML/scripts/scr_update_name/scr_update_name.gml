/// @function scr_update_name(playerIndex, name)
/// @description updates name of the client on the menu
/// @param playerIndex - connectId of the client
/// @param name - new name for the player
// Returns null

with (global.Menu) ds_list_replace(names, argument0, argument1);
show_debug_message("scr_update_name replaced: " + string(argument0) + " with " + string(argument1))