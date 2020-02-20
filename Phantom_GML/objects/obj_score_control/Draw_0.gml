/// @description Draw end box
// You can write your code in this editor

draw_sprite(spr_score_gui,-1,382,400)
draw_set_color(c_black)
draw_set_font(fnt_basic_small)
draw_text(260,382,obj_control.winner + " WINS!")
draw_set_font(fnt_basic_large)
