/// @description Initiate rooms!

//reset keyboard input for button selection
keyboard_input = false

switch global.Menu.state{
	case STATE_ONLINE:
		#region Online
		//Create buttons
		ds_list_add(buttons, scr_create_button(96, 832, "host"))
		ds_list_add(buttons, scr_create_button(300, 832, "direct"))
		ds_list_add(buttons, scr_create_button(736, 832, "quit"))
		#endregion
		break
	case STATE_LOBBY:
		#region Lobby
		ds_list_add(buttons, scr_create_button(96, 832, "ready"))
		ds_list_add(buttons, scr_create_button(736, 832, "back"))
		#endregion
		break
	case STATE_GAME:
		#region Game
		var players = ds_list_size(obj_client.network_players)
	
		show_debug_message("obj_menu.Room_Start Players made: " + string(players))
	
		var spacing = round((room_height/32)/(players+1))*32
		for (var i = 0; i < players; i ++){
			var player = instance_create_layer(16, spacing*(i+1)-16, "Instances", obj_player)
			player.connect_id = ds_list_find_value(obj_client.network_players, i)	//obj_network_player.connect_id on server side
			//set local client's player
			if player.connect_id == global.Client.connect_id{
				global.Client.Player = player
			}
			if global.have_server{
				var network_player = ds_map_find_value(global.Server.Clients, ds_map_find_value(global.Server.connect_ips, player.connect_id))
				network_player.Player = player
			}
				
			ds_list_add(Game_Players, player)
		}
		#endregion
		break
}

/* Sounds
if room = rm_networking or room = rm_lobby {
	audio_stop_all()
	audio_play_sound(msc_menu, 1, 1)
}
if room = rm_main {
	audio_stop_all()
	audio_play_sound(msc_game, 1, 1)
}
*/