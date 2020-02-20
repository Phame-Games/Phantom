/// @description  Detect clicking on server list

var yindex = 40+30;
var count = ds_list_size(serverlist);
if( mouse_y > 70 and mouse_y < (70+(count * 30)) ){
    var picked = floor(((mouse_y-70)/30) );
    global.connectip = ds_list_find_value(serverlist, picked );
    alarm[0] = 2;
}
