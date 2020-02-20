/// @description  Create server and initialise map

//global.Server set to id in obj_online

global.counter = 0;
global.have_server = true;

//counters
global.player_total = 0;


// create our server. Server creation may fail if there is already a server running. If it does fail, delete eveything and kill this instance
var alignment = 1;
broadcast_buffer = buffer_create(32, buffer_fixed, alignment);
gameBuffer = buffer_create(32, buffer_grow, alignment);//buffer_create(16384, buffer_fixed, alignment);
Clients = ds_map_create();
iplist = ds_list_create();
portlist = ds_list_create();
sequenceOuts = ds_list_create();
sequenceOutQueues = ds_list_create();

// clientMessages - messages to the client, connection, login, game
clientMessages = ds_map_create();
// clientBuffer - buffer for small client messages
confirmBuffer = buffer_create(24, buffer_fixed, alignment);

// Try and create the actual server
server = network_create_server(global.ServerType, 6510, 32 );
if( server<0 ){    
    // If theres already a server running, shut down and delete.
    instance_destroy();
}

// Setup a timer so we can broadcast the server IP out to local clients looking...
alarm[0]=60;

//create menu
alarm[1] = 1;

// NOW DONE INDIVIDUALLY
/*
//realiabilty, ordering, and congestion avoidance for UDP
sequenceOut = 0; // stores latest packet sequence that the server has sent out
sequenceOutMax = SEQUENCE_MAX; //65,535 is the max for buffer_u16
sequenceOutQueue = ds_map_create();
*/

//startBuffer - small buffer to allow first client to connect
startBuffer = 30;
sendBuffer = 0;

// serverDebug - whether or not to draw server debug information
serverDebug = false;

//tiles - list of all tiles that have been clicked, reset often
tiles = ds_list_create()
tile_change_types = ds_list_create()