/// @description Input
if !(instance_exists(obj_input_message)){
	if connect_id == global.Client.connect_id{
		//update input
		scr_game_input(inputs)
	
		/// @description  get input
		if (input_buffer < 0) {
			#region Update inputs array
		    var buffer = false; // whether or not input was put in
    
		    // get input
			var input = global.controls[controls, KEY_TYPE]
		    switch (input) {
		        case CONTROLS_KEYBOARD:
		            inputs[LEFT_KEY] = scr_get_key_input(global.controls[controls, LEFT_KEY]);
		            inputs[RIGHT_KEY] = scr_get_key_input(global.controls[controls, RIGHT_KEY]);
		            inputs[UP_KEY] = scr_get_key_input(global.controls[controls, UP_KEY]);
		            inputs[DOWN_KEY] = scr_get_key_input(global.controls[controls, DOWN_KEY]);
		            inputs[ACTION_KEY] = scr_get_key_input(global.controls[controls, ACTION_KEY]);
		            inputs[ACTION2_KEY] = scr_get_key_input(global.controls[controls, ACTION2_KEY]);
		            inputs[LEFTSELC_KEY] = scr_get_key_input(global.controls[controls, LEFTSELC_KEY]);
		            inputs[RIGHTSELC_KEY] = scr_get_key_input(global.controls[controls, RIGHTSELC_KEY]);
			
		            // check if there was any input
		            if (keyboard_check(vk_anykey)){
		                buffer = true;
					}
			
		            break;
		        case CONTROLS_MOUSE:
		            inputs[LEFT_KEY] = scr_get_key_input(global.controls[controls, LEFT_KEY]);
		            inputs[RIGHT_KEY] = scr_get_key_input(global.controls[controls, RIGHT_KEY]);
		            inputs[UP_KEY] = scr_get_key_input(global.controls[controls, UP_KEY]);
		            inputs[DOWN_KEY] = scr_get_key_input(global.controls[controls, DOWN_KEY]);
		            inputs[ACTION_KEY] = scr_get_key_input(global.controls[controls, ACTION_KEY]);
		            inputs[ACTION2_KEY] = scr_get_key_input(global.controls[controls, ACTION2_KEY]);
		            inputs[LEFTSELC_KEY] = scr_get_mouse_input(global.controls[controls, LEFTSELC_KEY]);
		            inputs[RIGHTSELC_KEY] = scr_get_mouse_input(global.controls[controls, RIGHTSELC_KEY]);
			
		            // set mouse position
		            mouseX = window_view_mouse_get_x(0);
		            mouseY = window_view_mouse_get_y(0);
			
		            // check if there was any input
		            if (keyboard_check(vk_anykey) or device_mouse_check_button(0, mb_any)){
		                buffer = true;
					}
			
		            break;
			
		        default:
		            // joystick input
					inputs[LEFT_KEY] = scr_get_gamepad_input(global.controls[controls, LEFT_KEY], input);
			        inputs[RIGHT_KEY] = scr_get_gamepad_input(global.controls[controls, RIGHT_KEY], input);
			        inputs[UP_KEY] = scr_get_gamepad_input(global.controls[controls, UP_KEY], input);
			        inputs[DOWN_KEY] = scr_get_gamepad_input(global.controls[controls, DOWN_KEY], input);
			        inputs[ACTION_KEY] = scr_get_gamepad_input(global.controls[controls, ACTION_KEY], input);
			        inputs[ACTION2_KEY] = scr_get_gamepad_input(global.controls[controls, ACTION2_KEY], input);
			        inputs[LEFTSELC_KEY] = scr_get_gamepad_input(global.controls[controls, LEFTSELC_KEY], input);
			        inputs[RIGHTSELC_KEY] = scr_get_gamepad_input(global.controls[controls, RIGHTSELC_KEY], input);
			
					//reset input buffer
					if (scr_array_sum(inputs, inputs_length) != -5) //-5 number for when everything is released
						buffer = true

					//aiming
					gamepad_aimx = gamepad_axis_value(input, gp_axisrh)
					gamepad_aimy = gamepad_axis_value(input, gp_axisrv)
			
		            break;
		    }
			#endregion
    
		    // reset input buffer if in menu
		    if (global.Menu.state != STATE_GAME and buffer)
		        input_buffer = input_buffer_max
		
			if inputs[RIGHT_KEY] and place_free(x + GRID, y)
				to = 0
			else if inputs[UP_KEY] and place_free(x, y - GRID)
				to = 1
			else if inputs[LEFT_KEY] and place_free(x - GRID, y)
				to = 2
			else if inputs[DOWN_KEY] and place_free(x, y + GRID)
				to = 3
		}
		else {
			// tick
		    input_buffer --;
		
		    // reset input
		    inputs[LEFT_KEY] = 0;
		    inputs[RIGHT_KEY] = 0;
		    inputs[UP_KEY] = 0;
		    inputs[DOWN_KEY] = 0;
		    inputs[ACTION_KEY] = 0;
		    inputs[ACTION2_KEY] = 0;
		    inputs[LEFTSELC_KEY] = 0;
		    inputs[RIGHTSELC_KEY] = 0;
		}
	}
}