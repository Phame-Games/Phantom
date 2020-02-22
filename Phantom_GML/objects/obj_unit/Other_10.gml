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