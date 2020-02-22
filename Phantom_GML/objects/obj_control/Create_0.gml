/// @description Setup room

//Generate the map
scr_generate_map()

//set fullscreen
//window_set_fullscreen(true)

//timed moving
move_speed = 0.5
move_buffer = 32/move_speed //distance divided by move speed
alarm[0] = move_buffer