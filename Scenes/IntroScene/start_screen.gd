extends Node2D

@export var next_scene: PackedScene
var is_switching: bool = false


func to_game():
	SceneManager.switch_to_packed(next_scene)

func _input(event):
	if is_switching:
		return
	if event is InputEventKey or event is InputEventMouseButton:
		to_game()
		is_switching = true
