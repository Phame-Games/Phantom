with (other) {
///network control
switch(global.NetworkState) {
    case(NETWORK_CONNECT): //attempt to connect to server
        if (connectBuffer > 0) {
            //move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
            buffer_seek(buff, buffer_seek_start, 0);
    
            //write msgId
            buffer_write(buff, buffer_s8, CLIENT_CONNECT);
    
            // Send this to the server
            var message = network_send_udp(client,ip,port,buff,buffer_tell(buff));
			
            if(message < 0){ //network_send_udp returns number less than zero if message fails
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
            // time for connect ran out
            if !(instance_exists(obj_input_message)) {
            with (instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_message)) {
                prompt = "ERROR: Connection time ran out";
                ds_list_add(actions, "backOnlineLobby");
                ds_list_add(actionTitles, "Back");
                }
                }
            }
        
        //break
        break;
    case(NETWORK_LOGIN): //login 
        //client has connected to the server, so send our "player name"
        scr_send_login(player_name);
        //break
        break;
    case(NETWORK_PLAY): //game is running
        scr_send_keep_alive();
        if global.Menu.state = STATE_GAME{
			scr_send_update()
		}
        //break
        break;
    }

}
/// client input
if (global.NetworkState == NETWORK_PLAY) {
    scr_send_input();
    /*
    with(global.Menu) {
        switch(state) {
            case STATE_LOBBY:
                // join input
                if (keyboard_check_pressed(ord('F')))
                    with(other) scr_sendKey(ord('F'), 1);
                else if (keyboard_check_released(ord('F')))
                    with(other) scr_sendKey(ord('F'), 0);
                // ready input
                if (keyboard_check_pressed(ord('T')))
                    with(other) scr_sendKey(ord('T'), 1);
                else if (keyboard_check_released(ord('T')))
                    with(other) scr_sendKey(ord('T'), 0);
                // up input
                if (keyboard_check_pressed(ord('W')))
                    with(other) scr_sendKey(ord('W'), 1);
                else if (keyboard_check_released(ord('W')))
                    with(other) scr_sendKey(ord('W'), 0);
                // down input
                if (keyboard_check_pressed(ord('S')))
                    with(other) scr_sendKey(ord('S'), 1);
                else if (keyboard_check_released(ord('S')))
                    with(other) scr_sendKey(ord('S'), 0);
                // left input
                if (keyboard_check_pressed(ord('A')))
                    with(other) scr_sendKey(ord('A'), 1);
                else if (keyboard_check_released(ord('A')))
                    with(other) scr_sendKey(ord('A'), 0);
                // right input
                if (keyboard_check_pressed(ord('D')))
                    with(other) scr_sendKey(ord('D'), 1);
                else if (keyboard_check_released(ord('D')))
                    with(other) scr_sendKey(ord('D'), 0);
            case STATE_GAME:
                // send mouse position
                with (other) scr_sendMouse(mouse_x, mouse_y);
                // jump input
                if (keyboard_check_pressed(vk_space))
                    with(other) scr_sendKey(ord('F'), 1);
                else if (keyboard_check_released(vk_space))
                    with(other) scr_sendKey(ord('F'), 0);
                // mouse input
                if (mouse_check_button_pressed(mb_left))
                    with(other) scr_sendKey(ord('G'), 1);
                if (mouse_check_button_released(mb_left))
                    with(other) scr_sendKey(ord('G'), 0);
                if (mouse_check_button_pressed(mb_right))
                    with(other) scr_sendKey(ord('H'), 1);
                if (mouse_check_button_released(mb_right))
                    with(other) scr_sendKey(ord('H'), 0);
                // up input
                if (keyboard_check_pressed(ord('W')))
                    with(other) scr_sendKey(ord('W'), 1);
                else if (keyboard_check_released(ord('W')))
                    with(other) scr_sendKey(ord('W'), 0);
                // down input
                if (keyboard_check_pressed(ord('S')))
                    with(other) scr_sendKey(ord('S'), 1);
                else if (keyboard_check_released(ord('S')))
                    with(other) scr_sendKey(ord('S'), 0);
                // left input
                if (keyboard_check_pressed(ord('A')))
                    with(other) scr_sendKey(ord('A'), 1);
                else if (keyboard_check_released(ord('A')))
                    with(other) scr_sendKey(ord('A'), 0);
                // right input
                if (keyboard_check_pressed(ord('D')))
                    with(other) scr_sendKey(ord('D'), 1);
                else if (keyboard_check_released(ord('D')))
                    with(other) scr_sendKey(ord('D'), 0);
            }
        }
    */
    }

/* */
/*  */