if to = 0 {
	path_start (pth_straight, move_speed, path_action_stop, 0)
	path_orientation = 0
}
if to = 1 {
	path_start (pth_straight, move_speed, path_action_stop, 0)
	path_orientation = 90
}
if to = 2 {
	path_start (pth_straight, move_speed, path_action_stop, 0)
	path_orientation = 180
}
if to = 3 {
	path_start (pth_straight, move_speed, path_action_stop, 0)
	path_orientation = 270
}
image_angle = path_orientation
/*
show_debug_message ("escape")
if from = 0 and to = 1 {
path_start (pth_turn2, move_speed, path_action_stop, 0)
path_orientation = 90
rotate = -90
}
if from = 0 and to = 2 {
path_start (pth_straight, move_speed, path_action_stop, 0)
path_orientation = 270
rotate = 0
}
if from = 0 and to = 3 {
path_start (pth_turn1, move_speed, path_action_stop, 0)
path_orientation = 90
rotate = 90
}
if from = 1 and to = 0 {
path_start (pth_turn1, move_speed, path_action_stop, 0)
path_orientation = 270
rotate = -90
}
if from = 1 and to = 2 {
path_start (pth_turn2, move_speed, path_action_stop, 0)
path_orientation = 180
rotate = -90
}
if from = 1 and to = 3 {
path_start (pth_straight, move_speed, path_action_stop, 0)
path_orientation = 0
rotate = 0
}
if from = 2 and to = 0 {
path_start (pth_straight, move_speed, path_action_stop, 0)
path_orientation = 90
rotate = 0
}
if from = 2 and to = 1 {
path_start (pth_turn1, move_speed, path_action_stop, 0)
path_orientation = 0
show_debug_message ("erdgh")
rotate = 90
}
if from = 2 and to = 3 {
path_start (pth_turn2, move_speed, path_action_stop, 0)
path_orientation = 270
}
if from = 3 and to = 0 {
path_start (pth_turn2, move_speed, path_action_stop, 0)
path_orientation = 0
rotate = -90
}
if from = 3 and to = 1 {
path_start (pth_straight, move_speed, path_action_stop, 0)
path_orientation = 180
rotate = 0
}
if from = 3 and to = 2 {
path_start (pth_turn1, move_speed, path_action_stop, 0)
path_orientation = 90
rotate = 90
}
*/