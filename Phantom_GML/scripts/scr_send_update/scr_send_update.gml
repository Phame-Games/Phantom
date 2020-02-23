/// @function scr_send_update()
/// @description Sends a generic Game state update
// Returns null



// start
with obj_client {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);
	
	//write GAME ID to uniquely define game
	buffer_write(buff, buffer_u8, GAME_ID)
	
    //write msgId
    buffer_write(buff, buffer_s8, CLIENT_PLAY);
    
    //write command
    buffer_write(buff, buffer_u8, UPDATE_CMD);
	
	//write requested movement
	buffer_write(buff, buffer_s8, Player.to)
    
    //Write all players
	/*
	var count = ds_list_size(global.Menu.Game_Players); // get the amount of clients connected
	buffer_write(buff, buffer_u8, count)
	// check for clients to send confirmations
	for (i = 0; i < count; i++) { 
		var player = ds_list_find_value(global.Menu.Game_Players, i)
	}
	*/

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
}
