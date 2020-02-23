/// Pinging Server

buffer_seek( buffer, buffer_seek_start, 0 );
buffer_write( buffer, buffer_u8, 0 );
buffer_write( buffer, buffer_s32, current_time );
show_debug_message( "current time: " + string(current_time) );
result = network_send_raw( socket, buffer, buffer_tell(buffer) );
alarm[0] = room_speed;