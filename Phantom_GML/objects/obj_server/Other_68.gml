/// @description  Server network control

//find buffer
var buff = ds_map_find_value(async_load, "buffer");
//find start since the connection is UDP and not sorted out for us
buffer_seek(buff, buffer_seek_start, 0);

//write GAME ID to uniquely define game
if buffer_read(buff, buffer_u8) == GAME_ID{
	
	//read message id
	var msgId = buffer_read(buff, buffer_s8);

	switch (msgId) {
	    case CLIENT_CONNECT:
	        //client connecting
			show_debug_message("obj_server.Async Call scr_connect_client")
	        scr_connect_client();
	        break;
	    case CLIENT_LOGIN:
	        //client logging in
			show_debug_message("obj_server.Async Call scr_login_client")
	        scr_login_client();
	        break;
	    case CLIENT_PLAY:
	        //all other sockets are connected client sockets, and we have recieved commands from them.
	        scr_server_recieved_data();
	        break;
	}
}

