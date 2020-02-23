/// @description Initialize networking

global.online = true;	//set menu to treat game as online

global.Server = noone
global.connectip = "127.0.0.1"
global.Networking = self
global.have_server = false	//set in obj_server
global.server_type = network_socket_udp

//local servers
serverlist = ds_list_create();
servernames = ds_list_create();
server_refresh = ds_list_create();

//create a server to listen on our broadcast port....
broadcast_server = network_create_server(network_socket_udp, 6511, 100);

//set up menu
Direct_IP = instance_create_layer(room_width/2-10, room_height-90, "Instances", obj_input);
Direct_IP.title = " "
Direct_IP.text = "Enter Direct IP"
Name_input = instance_create_layer(room_width/2, room_height/2, "Instances", obj_input);
Name_input.title = "Player Name";
Name_input.text = "Newbius";

//try to load player name
scr_load_player();

//auto refresh
alarm[2] = 120