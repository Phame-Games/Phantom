/// @description Movement
switch to{
	case 0:
		path_start (pth_straight, move_speed, path_action_stop, 0)
		path_orientation = 0
		break
	case 1:
		path_start (pth_straight, move_speed, path_action_stop, 0)
		path_orientation = 90
		break
	case 2:
		path_start (pth_straight, move_speed, path_action_stop, 0)
		path_orientation = 180
		break
	case 3:
		path_start (pth_straight, move_speed, path_action_stop, 0)
		path_orientation = 270
		break
}
//reset to
to = -1
Player.to = to

image_angle = path_orientation