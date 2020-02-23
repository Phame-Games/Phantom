/// @description Close server

// destroy server
global.have_server = false;

// destroy network
network_destroy(server);

// destroy any client persistent objects
var count = ds_list_size(iplist); // get the amount of clients connected

// check for clients to send confirmations
for (i = 0; i < count; i++) { 
    //get the ip of the client to get the message
    var ip = ds_list_find_value(iplist, i);
    
    // get the network player
    var inst = ds_map_find_value(Clients, ip);
    
    // remove network player from lobby
    scr_join_lobby(inst);
    
    // destroy the persistent network player object
    instance_destroy(inst);
    
    // remove the player's specific sequenceOutQueue
    ds_map_destroy(sequenceOutQueues[| i]); 
    }

// delete buffers
buffer_delete(broadcast_buffer);
buffer_delete(gameBuffer);
buffer_delete(confirmBuffer);
// destroy lists
ds_list_destroy(iplist);
ds_list_destroy(portlist);
ds_list_destroy(sequenceOuts);
ds_list_destroy(sequenceOutQueues);
// destroy maps
ds_map_destroy(Clients);
ds_map_destroy(clientMessages);
ds_list_destroy(sequenceOutQueues);

