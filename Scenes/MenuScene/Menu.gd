extends CanvasLayer


@export var game_scene: PackedScene
@onready var music := %Music
@onready var sounds := %Sounds
@onready var scaler := %Scale
# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.music = MusicPlayer.menu_theme
	%Start.grab_focus()
	scaler.text = "SCALE: %d" % ConfigManager.scale
	music.text = "MUSIC: %d" % ConfigManager.music
	sounds.text = "SOUND: %d" % ConfigManager.sound


func _process(_delta):
	var change := 0
	if Input.is_action_just_pressed("ui_left"):
		change = -1
	if Input.is_action_just_pressed("ui_right"):
		change = 1
	var active := get_viewport().gui_get_focus_owner()

	match active:
		music:
			ConfigManager.music = clamp(ConfigManager.music + change, 0, 11)
			music.text = "MUSIC: %d" % ConfigManager.music
		sounds:
			ConfigManager.sound = clamp(ConfigManager.sound + change, 0, 11)
			sounds.text = "SOUND: %d" % ConfigManager.sound
		scaler:
			ConfigManager.scale = wrapi(ConfigManager.scale + change, 1, 7)
			scaler.text = "SCALE: %d" % ConfigManager.scale


func _on_start_pressed():
	MusicPlayer.music = MusicPlayer.game_theme
	SceneManager.switch_to_packed(game_scene)


func _on_quit_pressed():
	await SceneManager.tween_in()
	get_tree().quit()


func _on_options_pressed():
	%Main.hide()
	%Options.show()
	%Scale.grab_focus()


func _on_back_pressed():
	%Main.show()
	%Options.hide()
	%OptionsButton.grab_focus()


func _on_music_pressed():
	pass # Replace with function body.


func _on_sounds_pressed():
	pass # Replace with function body.
