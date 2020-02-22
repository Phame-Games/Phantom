/// @description Client updates

///network control
switch (global.NetworkState) {
    case(NETWORK_CONNECT):
		#region Attempt to connect to server
        if (connectBuffer > 0) {
            //move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
            buffer_seek(buff, buffer_seek_start, 0);
    
            //write msgId
            buffer_write(buff, buffer_s8, CLIENT_CONNECT);
    
            //send this to the server
            var message = network_send_udp(client,ip,port,buff,buffer_tell(buff));
			
            if (message < 0){ //network_send_udp returns number less than zero if message fails
                if !(instance_exists(obj_input_message)) {
	                //if we can't connect, show and error and restart... could be more graceful :)
	                with (instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_message)) {
	                    prompt = "ERROR: Can not connect to server";
	                    ds_list_add(actions, "backOnlineLobby");
	                    ds_list_add(actionTitles, "Back");
	                }
                }
            }
            
            //lower connect buffer
            connectBuffer --;
            }
        else {
            //time for connect ran out
            if !(instance_exists(obj_input_message)) {
	            with (instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_message)) {
	                prompt = "ERROR: Connection time ran out";
	                ds_list_add(actions, "backOnlineLobby");
	                ds_list_add(actionTitles, "Back");
                }
            }
        }
        
        #endregion
        break;
    case(NETWORK_LOGIN):
		#region Login 
        //client has connected to the server, so send our "player name"
        scr_send_login(player_name);
        #endregion
        break;
    case(NETWORK_PLAY):
		#region Game is running
		
		//keep connection alive on the server side
        scr_send_keep_alive();
		
		switch global.Menu.state{
			case STATE_LOBBY:
				scr_send_input();
				break
			case STATE_GAME:
				scr_send_update()
				break
		}
		#endregion
        break;
}