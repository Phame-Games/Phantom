if not place_meeting(x,y,obj_train) and not place_meeting(x,y,obj_cracks) {
	var near = instance_nearest(x,y,obj_train)
	if near.player.connect_id == obj_client.connect_id or distance_to_object(near) > protection_range{
		scr_send_tile_click(id, 1)
	}
}