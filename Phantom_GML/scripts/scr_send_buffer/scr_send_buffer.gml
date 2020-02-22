/// @function scr_send_buffer()
/// @description Server function to send a buffer to a client, individualized
/// @param ip | Ip needs to be found to check the client's state
/// @param index | client index in the parallel arrays
/// @param buffer | buffer with information to send
// Returns null

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
buffer_seek(buffer, buffer_seek_start, 2);
var sequenceOut = sequenceOuts[| index];
buffer_write(buffer, buffer_u8, sequenceOut);
buffer_write(buffer, buffer_u8, inst.connectID);
buffer_seek(buffer, buffer_seek_end, 0);
sequenceOuts[| index] = scr_increment_in_bounds(sequenceOut, 1, 0, SEQUENCE_MAX, true);

// send message
inst.messageSuccess = network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
