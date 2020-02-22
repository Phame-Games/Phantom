/// @description Destroy created objects

//destroy ds_lists
ds_list_destroy(serverlist);
ds_list_destroy(servernames);

//destroy broadcast
network_destroy(broadcast_server);

//save player name
scr_save_player();

