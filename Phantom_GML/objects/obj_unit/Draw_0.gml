/// @description Debug
draw_self()

if global.Client.clientDebug {
	draw_set_font(fnt_basic)
	draw_text(x, y, string(to))
}