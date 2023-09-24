extends Node2D

@export var next: PackedScene

func _ready():
	$AnimationPlayer.play("intro")

func on_end():
	SceneManager.switch_to_packed(next)
