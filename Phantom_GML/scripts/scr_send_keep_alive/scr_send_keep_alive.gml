/// @function scr_send_keep_alive()
/// @description Ping the server now and then so we know if we're still connected or not....
// Returns null

    {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

	//write GAME ID to uniquely define game
	buffer_write(buff, buffer_u8, GAME_ID)
	
    //write msgId -1 - disconnect, 0 - game, 1 - connect
    buffer_write(buff, buffer_s8, CLIENT_PLAY);
    //write the command into the buffer.
    buffer_write(buff, buffer_u8, PING_CMD );
    
    // send the most recent sequence for RTT, round trip time, checking
    buffer_write(buff, buffer_u8, sequenceIn);

    // Send this to the server
    var size = network_send_udp(client,ip,port,buff,buffer_tell(buff));
    if( size<=0 ) { //network_send_udp returns number less than one if message fails
        network_destroy(client);
        buffer_delete(buff);
        game_restart();
        }
    }

