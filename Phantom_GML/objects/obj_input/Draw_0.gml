/// @description  Draw the text box and "caption"

draw_self();
	
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(fnt_basic_small);
draw_set_valign(fa_middle);
draw_set_color(c_black)
draw_text( x-175,y+3, string_hash_to_newline(text));

draw_set_color(c_black);
draw_set_font(fnt_basic_medium)
draw_text( x-275,y-100, string_hash_to_newline(title));


