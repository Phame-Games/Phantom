/// @description scr_send_tile_click()
/*
* Description:  send input data
* Parameters:   none
* Return:       void
*/


// start
with obj_client {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

    //write msgId
    buffer_write(buff, buffer_s8, CLIENT_PLAY);
    
    // write command
    buffer_write(buff, buffer_u8, UPDATE_CMD);
    
    //Write all players
	var count = ds_list_size(obj_menu.game_players); // get the amount of clients connected
	buffer_write(buff, buffer_u8, count)
	// check for clients to send confirmations
	for (i = 0; i < count; i++) { 
		var player = ds_list_find_value(obj_menu.game_players, i)
		//Train speed
	    buffer_write(buff, buffer_u8, player.Train.local_move_speed*10)
		//Repair list
		var repair_amount = ds_list_size(player.local_repair_list)
		buffer_write(buff, buffer_u8, repair_amount)
		for (var j = 0; j < repair_amount; j++) {
			var crack = ds_list_find_value(player.local_repair_list,j)
			if instance_exists(crack){
				buffer_write(buff, buffer_u16, crack.x)
				buffer_write(buff, buffer_u16, crack.y)
			}
			else{
				//Add tile that will fail
				buffer_write(buff, buffer_u16, 0)
				buffer_write(buff, buffer_u16, 0)
			}
	    }
	}

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
}
