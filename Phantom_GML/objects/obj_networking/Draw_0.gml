/// @description Draw server list

draw_set_font(fnt_basic_small);
draw_set_color(c_white);
draw_set_halign(fa_left);
var sx = 128
var sy = 560
var fh = 50
draw_text(sx, sy + 10,string_hash_to_newline("Select server"))
draw_line(sx, sy + fh/2, room_width - sx, sy + fh/2)

var yindex = sy + fh
var count = ds_list_size(serverlist);
for(var i=0;i<count;i++){
    draw_text(sx, yindex, string_hash_to_newline(ds_list_find_value(serverlist, i)+"  "+ds_list_find_value(servernames, i)+"'s server") );
    yindex+=fh;
}