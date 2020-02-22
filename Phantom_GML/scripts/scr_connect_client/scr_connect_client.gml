/// @function scr_connect_client()
/// @description connects a client to the server, disconnections handled in obj_network_player
// Returns null

//get the IP and port that the socket comes from
var ip = ds_map_find_value(async_load, "ip");
var port = ds_map_find_value(async_load, "port");
    
//check if this client is already connected
if !(ds_map_exists(Clients, ip)) {
    //add client to our list of connected clients
    ds_list_add(iplist, ip);
    ds_list_add(portlist, port);
    ds_list_add(sequenceOuts, 0);
    ds_list_add(sequenceOutQueues, ds_map_create());

    //create a new player, and pick a random colour for that player        
    var inst = instance_create_layer(0,0, "lay_instances", obj_network_player);
    inst.ip = ip;
    
    //put this instance into a map, using the ip as the lookup
    ds_map_add(Clients, ip, inst);
    
	var playerIndex = inst.connect_id;	//works because create event is already run
	ds_map_add(connect_ips, playerIndex, ip)
		
    //send confirmation message to client
    ds_map_add(clientMessages, ip, SERVER_CONNECT);
    }
//disconnecting handled in obj_network_player

