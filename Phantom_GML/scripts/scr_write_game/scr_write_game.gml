/// @function scr_write_game()
/// @description Write all game data into a buffer
// Returns null

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
buffer_write(buff, buffer_u8, 0);//connect_id); Written in send buffer
    
//state
buffer_write(buff, buffer_u8, STATE_GAME);

//write command
buffer_write(buff, buffer_u8, UPDATE_CMD)

//hold space for specific camera x and y
buffer_write(buff, buffer_s16, 0);
buffer_write(buff, buffer_s16, 0);
	
//Write all players
var count = ds_list_size(global.Menu.Game_Players); // get the amount of clients connected
//	show_debug_message("scr_write_game player amount: " + string(count))
buffer_write(buff, buffer_u8, count)
// check for clients to send confirmations
for (var i = 0; i < count; i++) { 
	//obj_player
	var player = ds_list_find_value(global.Menu.Game_Players, i) //obj_player
	buffer_write(buff, buffer_s8, player.to)
//	show_debug_message("scr_write_game to: " + string(player.Unit.to))
}
    
// delocalize the write buffer
//buffer = buff;
    
