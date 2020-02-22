/// @description Remove from Menu button list
var index = ds_list_find_index(global.Menu.buttons, self)
if index != -1{
	ds_list_delete(global.Menu.buttons, index)
}