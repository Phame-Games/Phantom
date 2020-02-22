/// @description  Broadcast our location occasionally. Clients pick this up and can then display servers to the user. 
if global.Menu.state == STATE_LOBBY{
	buffer_seek(broadcast_buffer, buffer_seek_start, 0);
	buffer_write(broadcast_buffer, buffer_string, server_name);
	network_send_broadcast(server, 6511, broadcast_buffer, buffer_tell(broadcast_buffer));

	//broadcast once a second...

		alarm[0] = 60

	show_debug_message("broadcast")
}