/// @description Draw each menu

switch(state){
	case STATE_LOBBY:
		#region Lobby menu
	    //set up drawing
	    draw_set_font(fnt_basic_small);
	    draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	    draw_set_color(c_black);
		
	    var sw = 32;
    
	    // if online draw info from server
	    if (global.online) {
	        var attributes = 2; //attributes per player
	        var playerAmount = ds_list_size(server_data); //amount of players * attributes
		
	        //attribute order: ready, name, colour
	        var bh = 32;
			
			var j = 0 //increases once per player versus the amount of attributes
	        //loop through and draw each player
	        for (var i = 0; i < playerAmount; i += attributes) {
				draw_set_color(c_white)
	            draw_rectangle(32, 62 + bh*i / attributes, room_width-32, 62+bh+bh*i / attributes, false);
				draw_set_color(c_black)
				draw_text(16+sw, 65 + bh*i / attributes, string_hash_to_newline("Ready: " + string(ds_list_find_value(server_data, i + 0))));
	            draw_text(220+sw, 65 + bh*i / attributes, string_hash_to_newline("Name: " + string(ds_list_find_value(server_data, i + 1))));
				draw_text(600+sw, 65 + bh*i / attributes, string_hash_to_newline("Colour: " + scr_colour_string(j++)));
				}
        
	        //draw prompt
	        draw_set_halign(fa_center);
			
			//ready up prompt
	        var prompt = "Enter"
			draw_text(room_width/2, room_height-80, string_hash_to_newline("Press " + prompt + " to ready up!"));
			}
	    else {
	        var di = 0; //draw index
			
	        // iterate through each local player
	        for (var i = 0; i < ds_list_size(players); i ++) {
	            draw_rectangle(32, 32 + bh*di, room_width-32, 32+bh+bh*i, true);
	            draw_set_halign(fa_left);
	//            draw_text(48+sw, 40 + bh*di, string_hash_to_newline("Team " + string(ds_list_find_value(teams, i))));
	            draw_text(128+sw, 40 + bh*di, string_hash_to_newline("Ready: " + string(ds_list_find_value(readys, i))));
	//            draw_text(240+sw*2, 40 + bh*di, string_hash_to_newline("Character: " + ds_list_find_value(classes, i)));
	//            draw_sprite(spr_lobby, 0, 48, 46 + bh*i);
	//            draw_sprite(spr_lobby, 1, 264, 46 + bh*i);
	            draw_set_halign(fa_center);
	//            var controls = local_controls[| i];
	            //var prompt = scr_get_input_name(global.controls[controls, LEFTSELC_KEY], LEFTSELC_KEY, global.controls[controls, KEY_TYPE]);
	            var prompt = "Enter"
				draw_text(room_width/2, 40 + bh*di+bh/2, string_hash_to_newline("Press " + prompt + " to ready up!"));
	            // increment draw index
	            di++
	        }
			/*
	        draw_set_color(c_gray)
	        // iterate throuch each non joined local player
	        for (var i = 0; i < controlsMax; i++) {
	            if (ds_list_find_index(local_controls, i) == -1) {
	                // if player is not yet in print prompt.
	                draw_rectangle(32, 33 + bh*di, room_width-32, 33+bh+bh*di, true);
	                var controls = i;
	                //var prompt = scr_get_input_name(global.controls[controls, ACTION2_KEY], ACTION2_KEY, global.controls[controls, KEY_TYPE]);
	                var prompt = "Mouse Left"
					draw_text(room_width/2, 40-16+ bh*di+bh/2, string_hash_to_newline("Press " + prompt + " to ready up!"));
	                // increment draw index
	                di++
	            }
	        }
			*/
	    }
		#endregion
		break
	}