/// @function scr_join_lobby(client)
/// @description joins a client or removes them
/// @param Client | id of the client's obj_network_player on the server
// Returns null

with (global.Menu) {
    //set input
    var connectID = argument0.connectID;

    var index = ds_list_find_index(players, connectID)
    if (index >= 0) {
		show_debug_message("scr_join_lobby Removing connectID: " + string(connectID));
        ds_list_delete(players, index);
        ds_list_delete(readys, index);
        }
    else {
		show_debug_message("scr_join_lobby Adding connectID: " + string(connectID));
        ds_list_add(players, connectID);
        ds_list_add(readys, false);
        }
    }
