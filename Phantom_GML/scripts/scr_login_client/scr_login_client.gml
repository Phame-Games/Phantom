/// @function scr_login_client()
/// @description Updates player information, name
// Returns null

// get the buffer the data resides in
var buff = ds_map_find_value(async_load, "buffer");
    
// get the IP that the socket comes from
var ip = ds_map_find_value(async_load, "ip");
    
// look up the client object
var inst = ds_map_find_value(Clients, ip);
    
// Set the client "name"
inst.name = buffer_read(buff, buffer_string);
    
// update name in lobby
var playerIndex = inst.connect_id;
show_debug_message("Update name: " + inst.name)
var index = ds_list_find_index(global.Menu.players, playerIndex)
ds_list_replace(global.Menu.names, index, inst.name);
    
// client message, confirm login
ds_map_replace(clientMessages, ip, SERVER_LOGIN);  
