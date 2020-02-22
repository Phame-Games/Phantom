/// @description Recieving messages
var eventid = ds_map_find_value(async_load, "id");
socketIn = eventid; // the socket id coming from the server
serverIP = ds_map_find_value(async_load, "ip");

//show_debug_message(string(eventid));
//is this message for our socket?
if(client == eventid) {
	#region Read message header
	//read buffer data
    var buffer = ds_map_find_value(async_load, "buffer");
        
    //find start since the connection is UDP and not sorted out for us
    buffer_seek(buffer, buffer_seek_start,0);
    
	//read GAME ID to uniquely define game
	if buffer_read(buffer, buffer_u8) == GAME_ID{
	
	    //read msgId, confirmation message, or game message
	    var msgId = buffer_read(buffer, buffer_s8);
	
        
	    //set msgIDin for debug purposes
	    msgIDin = msgId;
        
	    //read sequence
	    var sequence = buffer_read(buffer, buffer_u8);
		#endregion
	//	show_debug_message("obj_client.Async msgID: " + scr_msg_id_to_string(msgId))
		//if more recent message, check
	    if (scr_sequence_more_recent(sequence, sequenceIn, SEQUENCE_MAX)) { //this package is newer and therefore requires an update, 65,535 is for buffer_u16
	        //update sequenceIn
	        sequenceIn = sequence;
		    //if in a state that needs a confirmation
		    if (global.NetworkState == NETWORK_CONNECT or global.NetworkState == NETWORK_LOGIN) {
				#region Connection/Login
	            //update disconnect buffer
	            alarm[0] = disconnectBuffer;
            
	            //check if server is confirming a connection
	            if (global.NetworkState == NETWORK_CONNECT and msgId == SERVER_CONNECT) {
	                //connection confirmed! move to login state
	                global.NetworkState = NETWORK_LOGIN;
					//show_debug_message("login" + string(eventid));
	                }
	            //check if server is confirming a login
	            if (global.NetworkState == NETWORK_LOGIN and msgId == SERVER_LOGIN) {
	                //connection confirmed! move to login state
	                global.NetworkState = NETWORK_PLAY;
					//show_debug_message("play" + string(eventid));
	                }
	            //game check is handled later
				#endregion
	            }
	        if (global.NetworkState == NETWORK_PLAY) {
				//set clients connect_id - order in which client connected to server, not an index to any list!
				connect_id = buffer_read(buffer, buffer_u8) //written in scr_send_buffer
	//			show_debug_message("obj_client.Async connect_id: " + string(connect_id))
			
	            if (msgId == SERVER_PLAY) {
					#region Server play
		            //update disconnect buffer
		            alarm[0] = disconnectBuffer;
                    
		            //get state
		            var state = buffer_read(buffer, buffer_u8);
	//				show_debug_message("obj_client.Async state: " + scr_state_to_string(msgId))
		            switch(state) {
		                case STATE_LOBBY: // lobby
		                    #region Lobby updates
							
							//temporarily hold server data, local because it is going to be called a lot of time
		                    var server_data = ds_list_create();
							
							//get player list
							var player_amount = buffer_read(buffer, buffer_u8)
	//						show_debug_message("obj_client.Async player_amount " + string(player_amount))
							for (var i = 0; i < player_amount; i ++){
								var ID = buffer_read(buffer, buffer_u8)	//obj_network_player.connect_id
								var name = buffer_read(buffer, buffer_string)
//								var ready = buffer_read(buffer, buffer_bool)
							
								//check if player is already added locally
								var index = ds_list_find_index(network_players, ID)
								if (index == -1){
									//add player locally
									ds_list_add(network_players, ID)
									ds_list_add(network_names, name)
								}
								else{
									//update name
									ds_list_replace(network_names, index, name)
	//								show_debug_message("obj_client.Async Update name " + string(ds_list_find_index(network_players, ID)))
								}
							}

						
							//get the random generator seed
							seeed = buffer_read(buffer, buffer_u32)

							//get the amount of players
		                    var players = buffer_read(buffer, buffer_u8)
						
		                    //read the data
		                    for (var i = 0; i < players; i++){
		                        ds_list_add(server_data, buffer_read(buffer, buffer_bool))    //ready
		                        ds_list_add(server_data, buffer_read(buffer, buffer_string))   //name
							}
							
		                    //copy loaded data to menu
		                    ds_list_copy(global.Menu.server_data, server_data);
		                    //delete temporary list
		                    ds_list_destroy(server_data);
							#endregion
		                    break;
		                case STATE_GAME:
		                    #region Game updates
							//check if already in game menu
		                    if (global.Menu.state == STATE_GAME and room == rm_main) {
								//read command
								var command = buffer_read(buffer, buffer_u8)
								
								if command == UPDATE_CMD{
									#region Update
				                    //hold space for specific camera x and y
				                    var cameraX = buffer_read(buffer, buffer_s16);
				                    var cameraY = buffer_read(buffer, buffer_s16);
								
									//read all players
									var count = buffer_read(buffer, buffer_u8)
									//update each player
									for (i = 0; i < count; i++) { 
										var player = ds_list_find_value(global.Menu.Game_Players, i)
										var to = buffer_read(buffer, buffer_s8)
										//ensure that to is not a -1 message sent after server already updated
										if to != -1
											player.Unit.to = to
	//									show_debug_message("obj_client.Async to: " + string(player.Unit.to))
									}
									#endregion
								}
								else if command == SYNC_CMD and not global.have_server{
									//read all players
									var count = buffer_read(buffer, buffer_u8)
									//update each player
									for (i = 0; i < count; i++) { 
										var player = ds_list_find_value(global.Menu.Game_Players, i)
										player.Unit.sx = buffer_read(buffer, buffer_u16)
										player.Unit.sy = buffer_read(buffer, buffer_u16)
										player.Unit.sync = true
									}
								}
                                
		                        //temporarily hold server data, local because it will be called a lot of times
		                        var server_data = ds_list_create();
							
		                        //copy loaded data to menu
		                        ds_list_copy(global.Menu.server_data, server_data);
                                
		                        //for (i = 0; i < ds_list_size(server_data); i++) show_debug_message(string(ds_list_find_value(server_data, i)));
                                
		                        // delete temporary list
		                        ds_list_destroy(server_data);
		                        }
							//if not in the right state, switch
		                    else if (global.Menu.state == STATE_LOBBY) {
		                        // switch to game menu
		                        with (global.Menu) scr_state_switch(STATE_LOBBY, STATE_GAME);
		                        }
							#endregion
		                    break;
		                case STATE_SCORE:
							#region Score screen
		                    // score screen updates
		                    if (global.Menu.state == STATE_SCORE) {
		                        // temporarily hold server data, local because it will be called a lot of times
		                        server_data = ds_list_create();
                                
		                        ds_list_add(server_data, buffer_read(buffer, buffer_string)); // add the message
		                        ds_list_add(server_data, buffer_read(buffer, buffer_string)); // add the seed
		                        ds_list_add(server_data, buffer_read(buffer, buffer_string)); // add the water delay
                                
		                        // get the amount of teams
		                        var teams = buffer_read(buffer, buffer_u8);
                                
		                        ds_list_add(server_data, teams); // add the amount of teams
                                
		                        // read the team data
		                        for(var i = 0; i < teams; i++){
		                            var  exists = buffer_read(buffer, buffer_bool); // whether the team exists
		                            ds_list_add(server_data, exists); // add whether the teams exists
                                    
		                            if (exists) {
		                                var players = buffer_read(buffer, buffer_u8); // amount of players on team
		                                ds_list_add(server_data, players); // add amount of players for the team
                                        
		                                ds_list_add(server_data, buffer_read(buffer, buffer_string)); // get team name
		                                ds_list_add(server_data, buffer_read(buffer, buffer_string)); // get team score
		                                ds_list_add(server_data, buffer_read(buffer, buffer_string)); // get team level
		                                ds_list_add(server_data, buffer_read(buffer, buffer_string)); // get team lives
                                        
		                                for (cp = 0; cp < players; cp++) {
		                                    ds_list_add(server_data, buffer_read(buffer, buffer_s16)); // get player sprite
                                            
		                                    var characterExists = buffer_read(buffer, buffer_bool); // check if player alive
		                                    ds_list_add(server_data, characterExists);   // if character is alive
		                                    if (characterExists) {
		                                        ds_list_add(server_data, buffer_read(buffer, buffer_u8));   // hp
		                                        ds_list_add(server_data, buffer_read(buffer, buffer_u8));   // energy
		                                        }
		                                    }
		                                }
		                            }
                                
		                        // copy loaded data to menu
		                        ds_list_copy(global.Menu.server_data, server_data);
                                
		                        // delete temporary list
		                        ds_list_destroy(server_data);
		                        }
		                    else {
		//                                scr_state_switch(STATE_GAME, STATE_SCORE);
		                        }
							#endregion
		                    break;
	                }
				#endregion
	            }
	        }
	    }
	}
}