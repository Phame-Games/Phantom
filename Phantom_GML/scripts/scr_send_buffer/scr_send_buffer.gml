/*
/ Description: send the buffer to the specified client
/ Script Call: scr_send_buffer(ip, index, buffer)
/ Parameters : ip - given, because ip needs to be found to check client state
/              index - client index in the parallel arrays
/              buffer - buffer with information to send
/ Return     : void
*/

// set input
var ip = argument0;
var index = argument1;
var buffer = argument2;

// get other needed parameters for sending
var socket = server;
var port = ds_list_find_value(portlist, index);

// get the network player for debug
var inst = ds_map_find_value(Clients, ip);
inst.socketOut = socket;

// update to the clients specific sequence out
buffer_seek(buffer, buffer_seek_start, 1);
var sequenceOut = sequenceOuts[| index];
buffer_write(buffer, buffer_u8, sequenceOut);
buffer_write(buffer, buffer_u8, inst.connectID);
buffer_seek(buffer, buffer_seek_end, 0);
sequenceOuts[| index] = scr_increment_in_bounds(sequenceOut, 1, 0, SEQUENCE_MAX, true);

// send message
inst.messageSuccess = network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
