/// @description Initialize server

//set by obj_networking
server_name = ""

global.have_server = true;

//counters
global.connect_id = 0;

//create our server. Server creation may fail if there is already a server running. If it does fail, delete eveything and kill this instance
var alignment = 1;
broadcast_buffer = buffer_create(32, buffer_fixed, alignment);
gameBuffer = buffer_create(32, buffer_grow, alignment);//buffer_create(16384, buffer_fixed, alignment);

Clients = ds_map_create();	//obj_network_player
//relate connect_id to client ip
connect_ips = ds_map_create()
//parallel lists
iplist = ds_list_create();
portlist = ds_list_create();
sequenceOuts = ds_list_create();
sequenceOutQueues = ds_list_create();

//clientMessages - messages to the client, connection, login, game
clientMessages = ds_map_create();
//clientBuffer - buffer for small client messages
confirmBuffer = buffer_create(24, buffer_fixed, alignment);

//try and create the actual server
server = network_create_server(global.server_type, 6510, 32 );
if server < 0{    
    //if theres already a server running, shut down and delete.
    instance_destroy();
}

//setup a timer so we can broadcast the server IP out to local clients looking...
alarm[0]=BROADCAST_RATE;

//serverDebug - whether or not to draw server debug information
serverDebug = false;