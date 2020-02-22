/// @function scr_server_recieved_data()
/// @description Read client message data
// Returns null

//start
    {  
    // get the buffer the data resides in
    var buff = ds_map_find_value(async_load, "buffer");

    // read the command, msgId was already read in obj_server
    var cmd = buffer_read(buff, buffer_u8 );

    // Get the socket ID - this is the CLIENT socket ID. We can use this as a "key" for this client
    var ip = ds_map_find_value(async_load, "ip");

    // Look up the client details
    var inst = ds_map_find_value(Clients, ip);

    // continue if networkPlayer is already created
    if !(is_undefined(inst)) {
        // handle depending on command
        switch (cmd) {
            case INPUT_CMD:
                // get the amount of controls
                var amount = 3
                
                // iterate and get each input
                for (var i = 0; i < amount; i++;) {
                    var newState = buffer_read(buff, buffer_s8);
                    inst.inputs[i] = scr_update_input(inst.inputs[i], newState);
                    //show_debug_message(string(i) + " "+ string(inst.inputs[i]) + " "+string(newState));
				}
	            // get mouse position if in case mouse input
	            inst.mouseX = buffer_read(buff, buffer_u16);
	            inst.mouseY = buffer_read(buff, buffer_u16);
                break;
			case UPDATE_CMD:
				#region Client update
				//read amount of players
				var count = buffer_read(buff, buffer_u8)
				
				//check each client
				for (i = 0; i < count; i++) { 
					var player = ds_list_find_value(global.Menu.game_players, i)
				}
				#endregion
				break;
            case PING_CMD:
				#region Ping
                //client message, confirm login
                ds_map_replace(clientMessages, ip, SERVER_PLAY);  
                
                //read the latest sequence that the client recieved
                var sequenceIn = buffer_read(buff, buffer_u8);
                
                //get the index
                var index = ds_list_find_index(iplist, ip);
                
                // check if sequence is still in the queue
                if (ds_map_exists(sequenceOutQueues[| index], sequenceIn)) { 
                    //get time passed between sending and recieving back
                    var packetRTT = current_time - ds_map_find_value(sequenceOutQueue, sequenceIn);
                    var RTTChange = inst.currentRTT - packetRTT;
                    inst.currentRTT -= (RTTChange*.1); //adjust only by 10% to smooth out
                    }
                    
                // reset drop buffer
                inst.alarm[0] = inst.dropBuffer;
				#endregion
                break;
            }
        }
    }
