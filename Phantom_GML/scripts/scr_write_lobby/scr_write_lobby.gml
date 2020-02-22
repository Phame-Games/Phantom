/// @function scr_write_lobby()
/// @description Writes all lobby data from the server
// Returns null

// write lobby data into new buffer
//store server buffer in local variable because it will be called alot
var buff = gameBuffer;
    
//reset buffer to start - Networking ALWAYS reads from the START of the buffer
buffer_seek(buff, buffer_seek_start, 0);
    
//write GAME ID to uniquely define game
buffer_write(buff, buffer_u8, GAME_ID)
	
//write msgId, SERVER_PLAY because client has already logged on
buffer_write(buff, buffer_s8, SERVER_PLAY);
    
//write packet sequence
buffer_write(buff, buffer_u8, 0);//sequenceOut); Written in send buffer
buffer_write(buff, buffer_u8, 0);//connectID); Written in send buffer
    
//state
buffer_write(buff, buffer_u8, STATE_LOBBY);
	
//Write all players
var count = ds_list_size(iplist); // get the amount of clients connected
buffer_write(buff, buffer_u8, count)
//	show_debug_message("scr_write_lobby player amount: " + string(count))
// check for clients to send confirmations
for (i = 0; i < count; i++) { 
	//get the ip of the client to get the message
	var ip = ds_list_find_value(iplist, i);
    
	// get the network player
	var inst = ds_map_find_value(Clients, ip);
    
	buffer_write(buff, buffer_u8, inst.connectID)
	buffer_write(buff, buffer_string, inst.name)
	}
    
//total number of players
buffer_write(buff, buffer_u8, ds_list_size(global.Menu.players)); //buffer_u8 MAX: 255
buffer_write(buff, buffer_u32, obj_client.seeed);
    
//send player information in order
with(global.Menu) {
	//show_debug_message(string(ds_list_size(players)))
    for (var i = 0; i < ds_list_size(players); i ++) {
        buffer_write(buff, buffer_bool, ds_list_find_value(readys, i)); // ready
        buffer_write(buff, buffer_string, ds_list_find_value(names, i)); // name
        }
    }
