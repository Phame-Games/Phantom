/// @description Post-initialization setup

//get unique player colour based on join order
colour = global.Menu.ColourArray[connect_id]

//get unique network player information
name = ds_list_find_value(obj_client.network_names,connect_id)