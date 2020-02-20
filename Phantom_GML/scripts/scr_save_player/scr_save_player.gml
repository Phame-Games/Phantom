/// @description scr_save_player()
/* 
* Description: save player
* Parameters:  none
* Returns:     void
*/

    //open file
    ini_open("player.ini");
    
    //save data
    section = "online";
    ini_section_delete(section);
    ini_write_string(section, "name", iServerName.text);
    ini_write_string(section, "direct_ip", directIP.text);
    
    //close file
    ini_close(); 
