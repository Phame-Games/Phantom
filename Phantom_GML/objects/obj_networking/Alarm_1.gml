/// @description  Start game - local client+server
var i = iServerName;
global.ServerName = i.text;

// create server
global.Server = instance_create_layer(0,0,"lay_instances",obj_server);

// check if succesful
if(global.have_server == false ) {
    show_debug_message("Cant create server");
    }
else {
    // tell client to connect to itself
    global.connectip = "127.0.0.1";
    
    // stop broadcasting
    show_debug_message("#######################################");
    show_debug_message("Start game");
    show_debug_message("#######################################");
    
    // switch menu to the lobby
    scr_state_switch(STATE_ONLINE, STATE_LOBBY);
    // create client
    instance_create_layer(0, 0, "lay_instances", obj_client);
    // client takes care of all networking now
    instance_destroy();
    }

