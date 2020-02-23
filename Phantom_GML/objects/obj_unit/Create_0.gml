/// @description Initialize unit

event_inherited()

//initialize variable to hold Player instance ID
Player = noone

//post-initialization setup
alarm[0] = 1

//operation variables
move_speed = obj_control.move_speed

//direction to move
to = -1 //-1 stop, 0 right, 1 up, 2 left, 3 down

