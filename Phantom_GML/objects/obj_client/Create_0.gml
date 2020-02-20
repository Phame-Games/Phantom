/// @description  server game data

//The random generator
seeed = current_time

// add all basic sprites to send into a list
basicSprites = ds_list_create();
basicImages = ds_list_create();
basicXs = ds_list_create();
basicYs = ds_list_create();

// add all characters to send into a list
characterSprites = ds_list_create();
characterImages = ds_list_create();
characterXs = ds_list_create();
characterYs = ds_list_create();
characterHPs = ds_list_create();
characterEnergys = ds_list_create();
characterNames = ds_list_create();

// water_height
water_height = 0;

// disconnectBuffer - buffer before asking to disconnect
disconnectBuffer = 60;

///initialize the client
player_name = global.ServerName;   //get the name that was selected (it's a server OR player name)

//server IP and port, needed to send packets
ip = global.connectip;
port = 6510;

//create a buffer for the network messages
var alignment = 1;
buff = buffer_create(256, buffer_grow, alignment);
//create a UDP socket
client = network_create_socket(global.ServerType); //Value less than zero if it fails
//remember this socket ID so the server can ignore it (if we have a local server)

// remember client id
global.Client = id;

//attempt to connect to server
global.NetworkState = NETWORK_CONNECT;
connectBuffer = 30; //give client one secound to connect

//realiabilty, ordering, and congestion avoidance for UDP
sequenceIn = -1; // stores latest packet sequence that the client has recieved

/// debug

// clientDebug - whether to show debug for the client
clientDebug = false;

// msgIDin - the latest server message ID
msgIDin = 0;

// socketIn - the socket id coming in from the server
socketIn = -1;

// serverIP - IP address of where message are coming in from
serverIP = -1;

network_players = ds_list_create()
network_names = ds_list_create()
connect_id = -1

