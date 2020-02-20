/// @description Go to tile
// You can write your code in this editor

if not repairing {
	if not ds_list_empty(player.repair_list){
		var tile = ds_list_find_value(player.repair_list,0)
		if instance_exists(tile){
			move_towards_point(tile.x,tile.y,move_speed)
		}
		else{
			ds_list_delete(player.repair_list,0)
		}
	}
}