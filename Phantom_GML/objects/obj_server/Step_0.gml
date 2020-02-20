/// @description  client messages
    // once a frame, we send clients any priority message, if not in game
    var count = ds_list_size(iplist); // get the amount of clients connected

    // if there is at least one client, continue
    if (count > 0) {
        // send appropiate game data
        switch(global.Menu.state) {
            case STATE_LOBBY:
                // write the lobby information to the sending buffer
                scr_write_lobby();
                
                // check for clients to send confirmations
                for (i = 0; i < count; i++) { 
                    //get the ip of the client to get the message
                    var ip = ds_list_find_value(iplist, i);
                    
                    // find the type of message to send
                    var message = ds_map_find_value(clientMessages, ip);
                    
                    // check if need to send a confirmation
                    if (message != SERVER_PLAY) {
                        // send neccesary confirmation
                        //show_debug_message("not play")
                        // get the client message buffer
                        var buff = confirmBuffer;
                        
                        // reset buffer to start - Networking ALWAYS reads from the START of the buffer
                        buffer_seek(buff, buffer_seek_start, 0);
                        
                        // write msgId
                        buffer_write(buff, buffer_s8, message);
                        
                        // write packet sequence
                        buffer_write(buff, buffer_u8, 0);//sequenceOut); Written in send buffer
                        
                        // send confirmation to the client
                        scr_send_buffer(ip, i, buff);
                        }
                    else {
                        // send pre_written lobby data
                        scr_send_buffer(ip, i, gameBuffer);
                        }
                    }
                break;
            case STATE_PATHS:
                // write the path information to the sending buffer
//                scr_write_paths();
                
                // check for clients to send information
                for (i = 0; i < count; i++) { 
                    //get the ip of the client to get the message
                    var ip = ds_list_find_value(iplist, i);
                    
                    // find the type of message to send
                    var message = ds_map_find_value(clientMessages, ip);
                    
                    // check if client is logged in
                    if (message == SERVER_PLAY) {
                        // send pre_written data
                        scr_send_buffer(ip, i, gameBuffer);
                        }
                    }
                break;
            case STATE_GAME:
                // write the game information to the sending buffer
                scr_write_game();
                
                // check for clients to send information
                for (i = 0; i < count; i++) { 
                    //get the ip of the client to get the message
                    var ip = ds_list_find_value(iplist, i);
                    
                    // find the type of message to send
                    var message = ds_map_find_value(clientMessages, ip);
                    
                    // check if client is logged in
                    if (message == SERVER_PLAY) {
                        // update the buffer with client specific information
//                        scr_write_game_update(ip, i);
                        
                        // send pre_written data
                        scr_send_buffer(ip, i, gameBuffer);
                        }
                    }
                break;
            case STATE_SCORE:
                // write the score information to the sending buffer
//                scr_write_score();
                
                // check for clients to send information
                for (i = 0; i < count; i++) { 
                    //get the ip of the client to get the message
                    var ip = ds_list_find_value(iplist, i);
                    
                    // find the type of message to send
                    var message = ds_map_find_value(clientMessages, ip);
                    
                    // check if client is logged in
                    if (message == SERVER_PLAY) {
                        // send pre_written data
                        scr_send_buffer(ip, i, gameBuffer);
                        }
                    }
                break;
            }
        }

/// update server sequence once for all messages

// NOW DONE INDIVIDUALLY IN SEND BUFFER
/*
// increment the sequence
sequenceOut ++;

// keep the sequence in bounds
if (sequenceOut >= sequenceOutMax) sequenceOut = 0;

// add packet to queue for checking with client's acks
ds_map_replace(sequenceOutQueue, sequenceOut, current_time);
// all values are cycled through, every 255 steps, keeping things up to date
*/

/* */
/// server debug
if (keyboard_check_pressed(vk_f1)) {
    // toggle whether to draw server debug
    serverDebug = scr_toggle(serverDebug);
    }

/* */
/*  */
