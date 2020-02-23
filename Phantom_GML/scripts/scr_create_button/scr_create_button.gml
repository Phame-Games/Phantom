/// @function scr_create_button(type
/// @description handles the creation of a button
/// @param xx
/// @param yy
/// @param type | button action
// Returns new button ID

var xx = argument0
var yy = argument1
var type = argument2
var lay_instance = "Instances"

var btn = instance_create_layer(xx, yy, lay_instance, obj_button)
switch type{
	case "host":
		btn.sprite_index = spr_host_btn
		btn.action = "host"
		return btn
	case "direct":
		btn.sprite_index = spr_direct_btn
		btn.action = "direct"
		return btn
	case "quit":
		btn.sprite_index = spr_quit_btn
		btn.action = "quit"
		return btn
	case "back":
		btn.sprite_index = spr_back
		btn.action = "back"
		return btn
	case "restart":
		btn.sprite_index = spr_rest_btn
		btn.action = "restart"
		return btn
	case "ready":
		btn.sprite_index = spr_ready
		btn.action = "ready"
		return btn
}