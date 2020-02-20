/// @description  Draw message + action options

//setup drawing
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_basic);
draw_set_alpha(1);

// get box size
var sb = 8; // side buffer
var pw;
var ph = 16*2;
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

// box drawing
draw_set_color(c_dkgray);
draw_rectangle(x-pw, y-ph, x+pw, y+ph, false);
draw_set_color(c_gray);
draw_rectangle(x-pw, y-ph, x+pw, y+ph, true);
draw_set_color(c_white);
draw_text(x, y-ro, string_hash_to_newline(prompt));

// action drawing
draw_set_halign(fa_left);
var dx = x-aw/2+sb;
var dy = y+ro;
var bh = 16;
for (var i = 0; i < ds_list_size(actions); i++;) {
    var bw = string_width(string_hash_to_newline(actionTitles[| i]))+sb*2;
    draw_set_color(c_dkgray);
    draw_rectangle(dx, dy-bh, dx+bw, dy+bh, false);
	
    if (i == actionSel)
        draw_set_color(c_blue);
		
    else
        draw_set_color(c_gray);
		
    draw_rectangle(dx, dy-bh, dx+bw, dy+bh, true);
    draw_set_color(c_white);
    draw_text(dx+sb, y+ro, string_hash_to_newline(actionTitles[| i]));
    dx += bw+sb
}
