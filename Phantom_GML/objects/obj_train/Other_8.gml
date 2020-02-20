/// @description 

event_inherited()

//Destroy if not on the tracks

from = scr_find_to(to)

tile = instance_position (x, y, obj_track)
cracks = instance_position (x, y, obj_cracks)

if tile = noone {
	instance_destroy (self)
}
if instance_exists(cracks){
	if cracks.image_index = 4 {
		instance_destroy (self)
	}
}
if tile != noone {
	if tile.path[from] != 1 {
		instance_destroy (self)
	}
}

//update to and from
if tile != noone {
	for (var i = 0; i < 4; i ++){
		if i != from{
			if tile.path[i]{
				to = i
			}
		}
	}
}
event_user(0)
show_debug_message("Carts " + string(ds_list_size(cart_list)))
//check for cart
with(instance_place(x, y, obj_score)){
	with(other){
		audio_play_sound(snd_coin, 1, 0)

		var cart = -1
		if ds_list_empty(cart_list){
			cart = scr_add_cart(x,y,to,from)
		}else{
			var caboose = ds_list_find_value(cart_list,ds_list_size(cart_list)-1)
			cart = scr_add_cart(caboose.x,caboose.y,caboose.to,caboose.from)
		}
		cart.player = player
		ds_list_add(cart_list,cart);
	}
	instance_destroy()
}