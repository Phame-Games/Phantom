/// @description scr_join_lobby(client)
/// @param client
/*
/ Description: joins a client into the lobby
/ Parameters : client - id of the client's obj_network_player on the server
/ Return     : void
*/

with (global.Menu) {
    // set input
    var connectID = argument0.connectID;
    var name = argument0.name;
    show_debug_message(string(connectID));

    var index = ds_list_find_index(players, connectID)
    if (index >= 0) {
        ds_list_delete(players, index);
        ds_list_delete(readys, index);
        }
    else {
        ds_list_add(players, connectID);
        ds_list_add(readys, false);
        }
    }
