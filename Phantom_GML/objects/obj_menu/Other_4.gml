/// @description Initiate rooms!

if global.Menu.state = STATE_GAME{
	var players = ds_list_size(obj_client.network_players)
	show_debug_message("made" + string(players))
	var spacing = round((room_height/32)/(players+1))*32
	for (var i = 0; i < players; i ++){
		var player = instance_create_layer(16, spacing*(i+1)-16, "Instances", obj_player)
		player.connect_id = ds_list_find_value(obj_client.network_players, i)
		ds_list_add(game_players, player)
	}
}

if room = rm_networking or room = rm_lobby {
	audio_stop_all()
	audio_play_sound(msc_menu, 1, 1)
}
if room = rm_main {
	audio_stop_all()
	audio_play_sound(msc_game, 1, 1)
}