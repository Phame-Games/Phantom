/// @description networking code
var eventid = ds_map_find_value(async_load, "id");
socketIn = eventid; // the socket id coming from the server
serverIP = ds_map_find_value(async_load, "ip");

//show_debug_message(string(eventid));
//is this message for our socket?
if(client == eventid) {
    // if in a state that needs a confirmation
    if (global.NetworkState == NETWORK_CONNECT or global.NetworkState == NETWORK_LOGIN) {
        // read buffer data
        var buffer = ds_map_find_value(async_load, "buffer");
        
        // find start since the connection is UDP and not sorted out for us
        buffer_seek(buffer, buffer_seek_start,0);
        
        // read msgId, confirmation message, or game message
        var msgId = buffer_read(buffer, buffer_s8);
        
        // set msgIDin for debug purposes
        msgIDin = msgId;
        
        // read sequence
        var sequence = buffer_read(buffer, buffer_u8);
        
        // if more recent message, check
        if (scr_sequence_more_recent(sequence, sequenceIn, SEQUENCE_MAX)) { //this package is newer and therefore requires an update, 65,535 is for buffer_u16
            // update sequenceIn
            sequenceIn = sequence;
            
            // update disconnect buffer
            alarm[0] = disconnectBuffer;
            
            // check if server is confirming a connection
            if (global.NetworkState == NETWORK_CONNECT and msgId == SERVER_CONNECT) {
                // connection confirmed! move to login state
                global.NetworkState = NETWORK_LOGIN;
				//show_debug_message("login" + string(eventid));
                }
            // check if server is confirming a login
            if (global.NetworkState == NETWORK_LOGIN and msgId == SERVER_LOGIN) {
                // connection confirmed! move to login state
                global.NetworkState = NETWORK_PLAY;
				//show_debug_message("play" + string(eventid));
                }
            // game check is handled later
            }
        }
    }
//show_debug_message(string("next"));

///game networking code
    var eventid = ds_map_find_value(async_load, "id");
    
    //is this message for our socket?
    if(client == eventid) {
        if (global.NetworkState = NETWORK_PLAY) {
            //read all data....
            var buff = ds_map_find_value(async_load, "buffer");
            
            //find start since the connection is UDP and not sorted out for us
            buffer_seek(buff, buffer_seek_start, 0);
            
            //read msgId, needed so server can ignore it's own commands
            var msgId = buffer_read(buff, buffer_s8);
            // update debug
            msgIDin = msgId;
			
            if (msgId == SERVER_PLAY) { //server message, low priority
                //read sequence
                var sequence = buffer_read(buff, buffer_u8);
				connect_id = buffer_read(buff, buffer_u8);
                if (scr_sequence_more_recent(sequence, sequenceIn, SEQUENCE_MAX)) { //this package is newer and therefore requires an update, 65,535 is for buffer_u16
                    //update sequenceIn
                    sequenceIn = sequence;
                    // update disconnect buffer
                    alarm[0] = disconnectBuffer;
                    
                    //get state
                    var state = buffer_read(buff, buffer_u8);
					
                    switch(state) {
                        case STATE_LOBBY: // lobby
                            // lobby updates
                            
							//Get player list
							var player_amount = buffer_read(buff, buffer_u8)
							for (var i = 0; i < player_amount; i ++){
								var ID = buffer_read(buff, buffer_u8)
								var name = buffer_read(buff, buffer_string)
								
								var index = ds_list_find_index(network_players, ID)
								if (index == -1){
									ds_list_add(network_players, ID)
									ds_list_add(network_names, name)
								}
								else{
									ds_list_replace(network_names, index, name)
									//show_debug_message("hhsafs" + string(ds_list_find_index(network_players, ID)))
								}
							}
								
                            // get the amount of players
                            var players = buffer_read(buff,buffer_u8);
							seeed = buffer_read(buff,buffer_u32)
                            // temporarily hold server data, local because it will be called a lot of times
                            server_data = ds_list_create();
                            // read the data
                            for(var i=0;i<players;i++){
                                ds_list_add(server_data, buffer_read(buff,buffer_bool));     // ready
                                ds_list_add(server_data, buffer_read(buff,buffer_string));   // name
                                }
                            // copy loaded data to menu
                            ds_list_copy(global.Menu.server_data, server_data);
                            // delete temporary list
                            ds_list_destroy(server_data);
                            break;
                        case STATE_GAME:
                            // game updates
                            if (global.Menu.state == STATE_GAME and room == rm_main) {
                                // hold space for specific camera x and y
                                var cameraX = buffer_read(buff, buffer_s16);
                                var cameraY = buffer_read(buff, buffer_s16);
								
								//Write all players
								var count = buffer_read(buff, buffer_u8)
								// check for clients to send confirmations
								for (i = 0; i < count; i++) { 
									var player = ds_list_find_value(obj_menu.game_players, i)
									//Train speed
									if global.have_server{
										buffer_read(buff, buffer_u8)
									}
									else{
										//player.Train.move_speed = buffer_read(buff, buffer_u8)/10
										buffer_read(buff, buffer_u8)
									}
									//Repair list
									//ds_list_clear(player.repair_list)
									var repair_amount = buffer_read(buff, buffer_u8)
									for (var j = 0; j < repair_amount; j++) {
										cx = buffer_read(buff, buffer_u16)
										cy = buffer_read(buff, buffer_u16)
										var crack = instance_position(cx, cy, obj_cracks)
										if instance_exists(crack) {
											if ds_list_find_index(player.repair_list, crack) == -1{
												ds_list_add(player.repair_list, crack)
											}
										}
								    }
								}
		
								//Update tiles
								var tile_amount = buffer_read(buff, buffer_u8)
								for (var i = 0; i < tile_amount; i ++){
									var xx = buffer_read(buff, buffer_u16)
									var yy = buffer_read(buff, buffer_u16)
									var tile = instance_position(xx, yy, obj_track)
									tile.image_index = buffer_read(buff, buffer_u8)
									tile.alarm[0] = 1
									show_debug_message(string(tile) + " " + string(tile.image_index))
								}
                                
                                // temporarily hold server data, local because it will be called a lot of times
                                server_data = ds_list_create();
                                
                                //ds_list_add(server_data, teams); // add the amount of teams
                                
                                // copy loaded data to menu
                                ds_list_copy(global.Menu.server_data, server_data);
                                
                                //for (i = 0; i < ds_list_size(server_data); i++) show_debug_message(string(ds_list_find_value(server_data, i)));
                                
                                // delete temporary list
                                ds_list_destroy(server_data);
                                
                                // gather sprite information
                                
                                
                                /*
                                show_debug_message("size" + string(basicSpritesSize) + " " + string(characterSpritesSize));
                                for (i = 0; i < ds_list_size(basicSprites); i++) {
                                    show_debug_message("sprite:" + string(ds_list_find_value(basicSprites, i)));
                                    show_debug_message("image:" + string(ds_list_find_value(basicImages, i)));
                                    show_debug_message("x    : " + string(ds_list_find_value(basicXs, i)));
                                    show_debug_message("y    : " + string(ds_list_find_value(basicYs, i)));
                                    }
                                for (i = 0; i < ds_list_size(characterSprites); i++) {
                                    show_debug_message("sprite:" + string(ds_list_find_value(characterSprites, i)));
                                    show_debug_message("image:" + string(ds_list_find_value(characterImages, i)));
                                    show_debug_message("x    : " + string(ds_list_find_value(characterXs, i)));
                                    show_debug_message("y    : " + string(ds_list_find_value(characterYs, i)));
                                    }
                                */
                                }
                            else if (global.Menu.state == STATE_LOBBY) {
                                // switch to game menu
                                with (global.Menu) scr_state_switch(STATE_LOBBY, STATE_GAME);
                                }
                            else if (global.Menu.state == STATE_SCORE) {
                                // switch to game menu
//                                scr_state_switch(STATE_SCORE, STATE_GAME);
                                }
                            break;
                        case STATE_SCORE: // score screen
                            // score screen updates
                            if (global.Menu.state == STATE_SCORE) {
                                // temporarily hold server data, local because it will be called a lot of times
                                server_data = ds_list_create();
                                
                                ds_list_add(server_data, buffer_read(buff, buffer_string)); // add the message
                                ds_list_add(server_data, buffer_read(buff, buffer_string)); // add the seed
                                ds_list_add(server_data, buffer_read(buff, buffer_string)); // add the water delay
                                
                                // get the amount of teams
                                var teams = buffer_read(buff, buffer_u8);
                                
                                ds_list_add(server_data, teams); // add the amount of teams
                                
                                // read the team data
                                for(var i = 0; i < teams; i++){
                                    var  exists = buffer_read(buff, buffer_bool); // whether the team exists
                                    ds_list_add(server_data, exists); // add whether the teams exists
                                    
                                    if (exists) {
                                        var players = buffer_read(buff, buffer_u8); // amount of players on team
                                        ds_list_add(server_data, players); // add amount of players for the team
                                        
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team name
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team score
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team level
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team lives
                                        
                                        for (cp = 0; cp < players; cp++) {
                                            ds_list_add(server_data, buffer_read(buff, buffer_s16)); // get player sprite
                                            
                                            var characterExists = buffer_read(buff, buffer_bool); // check if player alive
                                            ds_list_add(server_data, characterExists);   // if character is alive
                                            if (characterExists) {
                                                ds_list_add(server_data, buffer_read(buff, buffer_u8));   // hp
                                                ds_list_add(server_data, buffer_read(buff, buffer_u8));   // energy
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
                            break;
                        }
                    }
                }
            }
        }

/* */
/*  */
