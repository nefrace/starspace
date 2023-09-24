extends Node
class_name WindowManager

var BASE_RES: Vector2i = Vector2i(160, 144)


func resize(scale: int = 1):
	await get_tree().process_frame
	print("resizing")
	var new_scale := BASE_RES * scale
	var dsize := DisplayServer.screen_get_size()
	var dpos := DisplayServer.screen_get_position()
	var win := get_window()
	win.size = new_scale
	win.position = dpos + dsize / 2 - new_scale / 2
