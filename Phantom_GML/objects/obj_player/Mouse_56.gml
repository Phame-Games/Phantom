/// @description Repair Tiles
// You can write your code in this editor

if connect_id = obj_client.connect_id{
	with instance_position(mouse_x,mouse_y,obj_cracks){
		if (ds_list_find_index(other.local_repair_list,id) == -1){
			ds_list_add(other.local_repair_list,id)
			show_debug_message(id)
		}
	}
}
