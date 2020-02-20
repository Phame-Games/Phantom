/// @description 

ds_list_delete(player.repair_list,ds_list_find_index(player.repair_list,repairing))
instance_destroy(repairing)
repairing = false