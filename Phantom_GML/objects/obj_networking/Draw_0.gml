/// @description Draw server list
/*
draw_set_font(fnt_basic);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(10,41+10,string_hash_to_newline("Select server"));
draw_line(10,41+30, room_width-10,41+30);

var yindex = 41+40;
var count = ds_list_size(serverlist);
for(var i=0;i<count;i++){
    draw_text(10,yindex, string_hash_to_newline(ds_list_find_value(serverlist, i)+"  "+ds_list_find_value(servernames, i)+"'s server") );
    yindex+=30;
}

*/