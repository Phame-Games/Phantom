/// @function scr_send_input(input)
/// @description Sends general input, plus one specific key press
/// @param input | specific key press to send
// Returns null

// Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
buffer_seek(buff, buffer_seek_start, 0);

//write GAME ID to uniquely define game
buffer_write(buff, buffer_u8, GAME_ID)
	
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
	
var input = argument0;
buffer_write(buff, buffer_s8, input);
	
// write the mousX and mouseY
buffer_write(buff, buffer_u16, mouse_x);
buffer_write(buff, buffer_u16, mouse_y);

// Send this to the server
network_send_udp(client,ip,port,buff,buffer_tell(buff));

