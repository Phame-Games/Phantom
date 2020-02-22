/// @description Input

// check if game is paused
//if !(instance_exists(obj_input_button)){
{
    var haxis = 0; //left or right
    var vaxis = 0; //up or down
    var action = false; //clicking
    var input; //gamepad input
    var axis_buffer = GAMEPAD_AXIS_TOL; //buffer till push starts counting
    
    //get input
    if (input_buffer < 0) {
        //judge input based on current state
        switch(state){
            case STATE_GAME:
                break //no menu
            default: //other menus
				#region Get input
				//gamepad input
		        for (input = 0; input < 4; input++) {
		            var chaxis = gamepad_axis_value(input, gp_axislh);
		            var cvaxis = gamepad_axis_value(input, gp_axislv);
			
		            // axis check
		            if (chaxis > axis_buffer or chaxis < -axis_buffer) haxis = 1*sign(chaxis)
		            if (cvaxis > axis_buffer or cvaxis < -axis_buffer) vaxis = 1*sign(cvaxis)
			
		            // action
		            if(gamepad_button_check_released(input, gp_face1)) action = true;
		        }
        
		        //keyboard input
				if keyboard_check(vk_anykey) keyboard_input = true; //show selection via keyboard
		        if (keyboard_check(vk_left) or keyboard_check(ord("A")) or keyboard_check(ord("J"))) haxis = -1;
		        if (keyboard_check(vk_right) or keyboard_check(ord("D")) or keyboard_check(ord("L"))) haxis = 1;
		        if (keyboard_check(vk_up) or keyboard_check(ord("W")) or keyboard_check(ord("I"))) vaxis = -1;
		        if (keyboard_check(vk_down) or keyboard_check(ord("S")) or keyboard_check(ord("K"))) vaxis = 1;
		        if (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) action = true;  
        
				// reset buffer if got input
		        if (haxis != 0 or vaxis != 0 or action != false){
		            input_buffer = input_buffer_max;
				}
				#endregion
				#region Default
//                if keyboard_input{
	                //selector
	                if (ds_list_size(buttons) > 0) {
//						show_debug_message("obj_menu.Step selected: " + string(selected))
						//button controls
						var button = ds_list_find_value(buttons, selected);
					
						//if on value button limit changes of selection to only down and up to allow left and right to change value
	                    if (instance_exists(button)){
	//						show_debug_message("obj_menu.Step Button exists")
							//show button as selected
							if mouse_x != prev_mouse_x{
								prev_mouse_x = mouse_x
								keyboard_input = false;
								button.image_index = 0
							}
							else{
								button.image_index = 1
							}
							
							if haxis != 0 or vaxis != 0{
								//no longer show button as selected
								button.image_index = 0
								if (button.action == "value" or button.action == "valueAction"){
									selected = scr_increment_in_bounds(selected, vaxis, 0, ds_list_size(buttons)-1, true);
								}
								else{
			                        selected = scr_increment_in_bounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
								}
							}
						
			                if (button.action == "value") {
			                    button.value = scr_increment_in_bounds(button.value, haxis, 0, ds_list_size(button.values)-1, true);
			                }
					
			                else if (button.action == "valueAction") {
			                    button.value = scr_increment_in_bounds(button.value, haxis, 0, ds_list_size(button.values)-1, true);
			                    // if value changed do action
			                    if (haxis != 0)
			                        with (button) event_user(1);
			                }
					
			                // press button
			                if (action) {
			                    with (button) {
									//perform the button's action
			                        event_user(0);
			                    }
			                }
						}
						//else allow any direction to change selected button
	                    else{
	                        selected = scr_increment_in_bounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
						}
					
	                }
					//else allow any direction to change selected button
					else{
	                    selected = scr_increment_in_bounds(selected, haxis+vaxis, 0, ds_list_size(buttons)-1, true);
					}
	//				show_debug_message("obj_menu.Step pso tselected: " + string(selected))
//				}
				#endregion
				break
				
        }
    }
	
    else input_buffer--;
}


/// client input
//REMOVE? Switch case with 1 case
switch(state) {
    case STATE_LOBBY:
        if(global.online and global.have_server) {
            var Server = obj_server;
			
            // check for client input
            var count = ds_list_size(Server.iplist); //total number of players
            var iplist = Server.iplist //store locally because it is called many times
            
            //check join key for each player
            for(i=0 ;i<count; i++) {   
                //get the ip
                var ip = ds_list_find_value(iplist,i);
        
                //get the player instance so that we can check it
                var inst = ds_map_find_value(Server.Clients, ip);
                
                // other input
                var playerIndex = ds_list_find_index(players, inst.connectID);

                // initiate input
                var vaxis = 0;
                var haxis = 0;
                
                // get input
                if (inst.inputs[2] == KEY_PRESSED) {
                    ds_list_replace(readys, playerIndex, scr_toggle(ds_list_find_value(readys, playerIndex)));
                    // unpress key
                    inst.inputs[2] = scr_toggle_key(inst.inputs[2]);
                }
            }
			
			//if there is a player in the lobby
            if (ds_list_size(players)){
                //check for start
                var start = true; //set to false if a player is not ready
                
                //check if any player is not ready
                for(i = 0; i < ds_list_size(players); i++) {   
                    if !(ds_list_find_value(readys, i)) start = false;
                }
                
                //start if all are ready
                if (start) {
                    //start game
                    show_debug_message("All ready!");
                    
                    //switch to next menu
                    scr_state_switch(STATE_LOBBY, STATE_GAME)
                }
            }
        }
	}
