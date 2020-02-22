/// @description Draw server debug information
if (serverDebug) {
    // setup drawing
    draw_set_color(c_dkgray);
    draw_set_alpha(0.5);
    
    // set draw offset
    var drawOffset = 0;
    var yOffset = 20;
    
    // once a frame, we send clients any priority message, if not in game
    var count = ds_list_size(iplist); // get the amount of clients connected
    
    // draw background
    draw_rectangle(0, 0, 500, count*2*yOffset+30+10+60, false);
    
    // setup drawing
    draw_set_halign(fa_left);
    draw_set_font(fnt_basic);
    draw_set_color(c_red);
    
    // draw the amount of players
    draw_text(10,10,string_hash_to_newline("players: "+string(global.player_total)));
	draw_text(10, 30+yOffset*drawOffset++, "Server Socket: " + string(server));
    
	if count == 0{
		//Warning
		draw_text(10, 30+yOffset*drawOffset++, "No clients in iplist!");
	}
	else{
	    // check for clients to send confirmations
	    for (i = 0; i < count; i++) {
	        //get the ip of the client to get the message
	        var ip = ds_list_find_value(iplist, i);
        
	        // find the type of message to send
	        var message = ds_map_find_value(clientMessages, ip);
        
	        // get the network player
	        var inst = ds_map_find_value(Clients, ip);
        
	        // get the latest sequence out
	        var sequenceOut = sequenceOuts[| i];
        
	        // draw RTT
	        draw_text(10, 30+yOffset*drawOffset, string_hash_to_newline(string(ip)));
	        draw_text(340, 30+yOffset*drawOffset, string_hash_to_newline(string(inst.currentRTT)));
	        draw_text(160, 30+yOffset*drawOffset, string_hash_to_newline(scr_network_state_to_string(message)));
	        if (inst.alarm[0] < inst.dropBuffer-2) {
	            draw_text(400, 30+yOffset*drawOffset, string_hash_to_newline(string(inst.alarm[0])));
	            }
	        // increment drawOffset
	        drawOffset++;
	        draw_text(10, 30+yOffset*drawOffset, string_hash_to_newline("Socket Out: " + string(inst.socketOut)));
	        draw_text(10, 50+yOffset*drawOffset, string_hash_to_newline("Message Success: " + string(inst.messageSuccess)));
	        draw_text(10, 70+yOffset*drawOffset, string_hash_to_newline("Sequence Out: " + string(sequenceOut)));
	        // increment drawOffset
	        drawOffset++;
	        }
	}
    
    // reset alpha
    draw_set_alpha(1);
    }

