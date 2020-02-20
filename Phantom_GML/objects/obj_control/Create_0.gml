/// @description

//Generate the map
scr_generate_map()

//Generate player
//instance_create_layer(-16, room_height/2 - 16, "Instances", obj_player)

//Break tile timer
break_buffer_max = 240
break_buffer_min = 120
alarm[0] = irandom_range(break_buffer_min, break_buffer_max)

//Coin generator
coin_buffer_max = 420
coin_buffer_min = 120
alarm[1] = irandom_range(coin_buffer_min, coin_buffer_max)

//set fullscreen
window_set_fullscreen(true)