/// @function scr_join_lobby(client)
/// @description joins a client or removes them
/// @param Client | id of the client's obj_network_player on the server
// Returns null

with (global.Menu) {
    //set input
    var connect_id = argument0.connect_id;

    var index = ds_list_find_index(players, connect_id)
    if (index >= 0) {
		show_debug_message("scr_join_lobby Removing connect_id: " + string(connect_id));
        ds_list_delete(players, index)
        ds_list_delete(readys, index)
		ds_list_add(names, index)
        }
    else {
		show_debug_message("scr_join_lobby Adding connect_id: " + string(connect_id));
        ds_list_add(players, connect_id)
        ds_list_add(readys, false)
		ds_list_add(names, "") //set when clients logs in
        }
    }
