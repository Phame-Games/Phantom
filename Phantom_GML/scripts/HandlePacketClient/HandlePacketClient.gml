/// Client Script: HandlePacketClient

var buffer = argument[0];
//ensure that message is from python server

var ss = buffer_read(buffer, buffer_u8)
//show_debug_message(string(ss))
if ss == GAME_ID_PYTHON{
	var msg_id = buffer_read( buffer, buffer_u8 );
	show_debug_message("Received packet id : " + string(msg_id))
	switch( msg_id ) {
	    case 0:
	        // Ping Feedback from Server
	        var time = buffer_read( buffer, buffer_u32 );
	        show_debug_message("Received time: " + string(time));
	        ping = current_time - time - room_speed;
	        break;
	}
}