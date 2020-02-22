/// @description Unit updating
with par_unit{
	event_user(0)
}
alarm[0] = move_buffer

//sync
if global.have_server{
	with obj_server{
		scr_write_game_sync()
        
		var count = ds_list_size(iplist); // get the amount of clients connected
		
        //check for clients to send information
        for (var i = 0; i < count; i++) { 
            //get the ip of the client to get the message
            var ip = ds_list_find_value(iplist, i);
                    
            //find the type of message to send
            var message = ds_map_find_value(clientMessages, ip);
                    
            //check if client is logged in
            if (message == SERVER_PLAY) {
                // update the buffer with client specific information
         
                // send pre_written data
                scr_send_buffer(ip, i, gameBuffer);
            }
        }
	}
}