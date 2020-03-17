/// @description Initialize client

//Global trackers
global.Client = self

#region Game
//random generator seed
rand_seed = current_time

//keep track of local player object
Player = noone
#endregion

//Unique identifiers
//set by obj_networking
player_name = ""

#region Python client
Client_Python = instance_create_layer(0, 0, LAY, obj_client_python)
#endregion

#region Networking
//disconnectBuffer - buffer before asking to disconnect
disconnectBuffer = 60;

//server IP and port, needed to send packets
ip = global.connectip;
port = 6510;

//create a buffer for the network messages
var alignment = 1;
buff = buffer_create(256, buffer_grow, alignment);
//create a UDP socket
client = network_create_socket(global.server_type); //Value less than zero if it fails

//attempt to connect to server
global.NetworkState = NETWORK_CONNECT;
connectBuffer = 30; //give client one secound to connect

//realiabilty, ordering, and congestion avoidance for UDP
sequenceIn = -1; // stores latest packet sequence that the client has recieved

//network indentifiers
//parallel to obj_server.iplist if have_server
network_players = ds_list_create()
network_names = ds_list_create()

//used to identify which client this is to the server
connect_id = -1	//order in which client connected to server, not an index to any list!
#endregion

#region Debug
//clientDebug - whether to show debug for the client
clientDebug = false;

//msgIDin - the latest server message ID
msgIDin = 0;

//socketIn - the socket id coming in from the server
socketIn = -1;

//serverIP - IP address of where message are coming in from
serverIP = -1;
#endregion
