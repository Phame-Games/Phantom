/// @function scr_load_player()
/// @description Loads the player data
// Returns null

// open file
if (file_exists("player.ini")) {
    ini_open("player.ini");
    
    // load name
    var section = "online";
    Name_input.text = ini_read_string(section, "name", "Newbius");
	Direct_IP.text = ini_read_string(section, "direct_ip", "192.168.1.1");
    
    //close file
    ini_close();
    }
