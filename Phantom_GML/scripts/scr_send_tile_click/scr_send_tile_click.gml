/// @description scr_send_tile_click()
/*
* Description:  send input data
* Parameters:   none
* Return:       void
*/


// start
with obj_client {
	var input = argument0
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

    //write msgId
    buffer_write(buff, buffer_s8, CLIENT_PLAY);
    
    // write command
    buffer_write(buff, buffer_u8, TILE_CMD);
    
    // write tile grid position
    buffer_write(buff, buffer_u16, input.x);
	buffer_write(buff, buffer_u16, input.y);
	buffer_write(buff, buffer_u8, argument1)

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
	show_debug_message("Send tile click" + string(input) + " " + string(input.x) + " " + string(input.y))
}
