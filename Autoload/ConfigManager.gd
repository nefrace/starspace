extends Node

var scale: int = 2:
	set(value):
		if scale == value:
			return
		scale = value
		WM.resize(scale)
		save()
var music: int = 5:
	set(value):
		if music == value:
			return
		music = clamp(value, 0, 10)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(float(music) / 10.0))
		save()
var sound: int = 5:
	set(value):
		if sound == value:
			return
		sound = clamp(value, 0, 10)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), linear_to_db(float(sound) / 10.0))
		save()

# Called when the node enters the scene tree for the first time.
func _ready():
	var f := ConfigFile.new()
	var err := f.load("user://config.cfg")
	if err != OK:
		return
	
	scale = f.get_value("options", "scale")
	music = f.get_value("options", "music")
	sound = f.get_value("options", "sound")


func save():
	var f := ConfigFile.new()
	f.set_value("options", "scale", scale)
	f.set_value("options", "music", music)
	f.set_value("options", "sound", sound)
	f.save("user://config.cfg")
