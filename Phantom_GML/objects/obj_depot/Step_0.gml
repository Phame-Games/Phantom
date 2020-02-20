/// @description Insert description here
// You can write your code in this editor

var train = instance_nearest(x,y,obj_train)
if distance_to_object(train) < 32{
	train.player.game_score += ds_list_size(train.cart_list)
	for (var i = ds_list_size(train.cart_list)-1; i >-1 ; i--){
		audio_play_sound(snd_cash, 1, 0)
		var cart = ds_list_find_value(train.cart_list,i)
		instance_create_layer(cart.x,cart.y,"Instances_1",obj_coin)
		instance_destroy(cart)
	}
	ds_list_clear(train.cart_list)
}
