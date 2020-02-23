/// @description Check clicking of buttons

// get box size
var sb = 8; // side buffer
var pw;
var aw = 0; // width of actions
var ro = 2*8; // rows
var mw = string_width(string_hash_to_newline(prompt)); // width of message

// get actions width
var s = 0; // spacing between buttons
for (var i = 0; i < ds_list_size(actions); i++;)
    aw += string_width(string_hash_to_newline(actionTitles[| i]))+sb*2+sb*s++;

// set box width
if (aw > mw)
    pw = aw/2+sb;
else
    pw = mw/2+sb;
	
var dx = x-aw/2+sb;
var dy = y+ro;
var bh = 16;
for (var i = 0; i < ds_list_size(actions); i++;) {
	var bw = string_width(string_hash_to_newline(actionTitles[| i]))+sb*2;
    if point_in_rectangle(mouse_x, mouse_y, dx, dy-bh, dx+bw, dy+bh) {
		actionSel = i
		event_user(0)
		instance_destroy();
	}
	dx += bw+sb
}
