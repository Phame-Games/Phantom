/// @function scr_send_login(name)
/// @description Sends the name of the client to the server
/// @param	name | name to send
// Returns null

var name = argument0;
//start
    {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

	//write GAME ID to uniquely define game
	buffer_write(buff, buffer_u8, GAME_ID)
	
    //write msgId
    buffer_write(buff, buffer_s8, CLIENT_LOGIN);
    // Write the name into the buffer.
    buffer_write(buff, buffer_string, name);

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
    }


