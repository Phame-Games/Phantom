/// @description scr_send_input()
/*
* Description:  send input data
* Parameters:   none
* Return:       void
*/

// start
    {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

    //write msgId
    buffer_write(buff, buffer_s8, CLIENT_PLAY);
    
    // write command
    buffer_write(buff, buffer_u8, INPUT_CMD);
    
    // write all the input
	for (var i = 0; i < 2; i++;) {
        // input the input state
        var input = scr_get_mouse_input(i);
        buffer_write(buff, buffer_s8, input);
        }
	
	var input = scr_get_key_input(vk_enter);
    buffer_write(buff, buffer_s8, input);
	
	// write the mousX and mouseY
	buffer_write(buff, buffer_u16, mouse_x);
	buffer_write(buff, buffer_u16, mouse_y);

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
    }
