extends AudioStreamPlayer

var game_theme := preload("res://music/nh_game.mp3")
var menu_theme := preload("res://music/nh_menu.mp3")
@export var music: AudioStream:
	set(value):
		if music == value:
			return
		if is_playing():
			await stop_music()
		stream = value
		start_music()

func _ready():
	bus = "Music"

func start_music(time: float = 1):
	var t := get_tree().create_tween()
	play()
	volume_db = linear_to_db(0.001)
	t.tween_property(self, "volume_db", linear_to_db(1.0), time)
	await t.finished
		

func stop_music(time: float = 1):
	var t := get_tree().create_tween()
	t.tween_property(self, "volume_db", linear_to_db(0.001), time)
	await t.finished
	stop()
