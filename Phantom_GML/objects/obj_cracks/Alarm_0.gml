/// @description 

if breaking > 6 {
	if image_index = 0 {
		image_index = 3
	}
	else {
		image_index = 0
		breaking --
	}
	alarm_set (0, 30)
}
	
if breaking > 3 and breaking < 7 {
	if image_index = 1 {
		image_index = 3
	}
	else {
		image_index = 1
		breaking --
	}
	alarm_set (0, 30)
}
	
if breaking > 0 and breaking < 4 {
	if image_index = 2 {
		image_index = 3
	}
	else {
		image_index = 2
		breaking --
	}
	alarm_set (0, 30)
}

if breaking = 0 {
	image_index = 4
}