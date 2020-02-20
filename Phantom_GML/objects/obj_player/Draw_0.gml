/// @description Lines to broken tracks
// You can write your code in this editor

if connect_id == obj_client.connect_id{
	if instance_exists(Repair) {
		sx = Repair.x
		sy = Repair.y
		if not ds_list_empty(repair_list){
			for (var i = 0; i < ds_list_size(repair_list); i++){
				var tile = ds_list_find_value(repair_list,i)
				if instance_exists(tile){
					draw_line_width_color(sx,sy,tile.x,tile.y,3,c_orange,c_orange)
					sx = tile.x
					sy = tile.y
				}
				else{
					ds_list_delete(repair_list, i)
					ds_list_delete(local_repair_list, i)
				}
			}
		}
	}
}
draw_set_font(fnt_basic)
draw_set_halign(fa_right)
draw_set_color(color)

draw_text(115+(150*connect_id),750,name)
draw_set_halign(fa_left)
draw_text (130+(150*connect_id), 750, game_score)
draw_set_color(c_white)