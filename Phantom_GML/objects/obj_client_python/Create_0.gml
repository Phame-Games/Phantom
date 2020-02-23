/// Initialize the client

// Required client variables
var type, ip_address, port;
type = network_socket_tcp;
ip_address = "127.0.0.1";
port = 64198;

//set timeout to connect, 4000 recommened for online, 1000 for LAN
network_set_config(network_config_connect_timeout, 4000);
//network_set_config(network_config_use_non_blocking_socket, 1);

// Create the socket
socket = network_create_socket( type );
network_connect_raw( socket, ip_address, port );

// Initialize client variables
ping = -1;
result = -1;

/// Initialize the buffer

var size, type, alignment;

size = 1024;
type = buffer_fixed;
alignment = 1;
buffer = buffer_create( size, type, alignment );
alarm[0] = room_speed;