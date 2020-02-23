/// @description Start game - connect to a remote server

//switch menu to the lobby
scr_state_switch(STATE_ONLINE, STATE_LOBBY);

//create  client
var client = instance_create_layer(0, 0, "lay_instances", obj_client);
client.player_name = Name_input.text
	
// client takes care of all networking now
instance_destroy();
