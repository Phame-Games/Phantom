/// @description Button click
switch action{
	case "host":
		global.Networking.alarm[1] = 1;
		break
	case "quit":
		game_end()
		break
	case "direct":
		global.Networking.alarm[0] = 1;
		break
	case "back":
		scr_state_switch(global.Menu.state, ds_stack_top(global.Menu.state_queue))
		break
	case "restart":
		game_restart()
		break
	case "ready":
		with(obj_client){
			scr_send_input(KEY_PRESSED)
		}
}