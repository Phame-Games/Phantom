/// @description Destroy created objects

//destroy ds_lists
ds_list_destroy(serverlist);
ds_list_destroy(servernames);
ds_list_destroy(server_refresh)

//destroy broadcast
network_destroy(broadcast_server);

//save player name
scr_save_player();

