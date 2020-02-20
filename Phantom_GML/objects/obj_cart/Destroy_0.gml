/// @description Insert description here
// You can write your code in this editor

if instance_exists(player.Train){
	var index = ds_list_find_index(player.Train.cart_list,id)
	if index != -1{
		ds_list_delete(player.Train.cart_list,index)
	}
}