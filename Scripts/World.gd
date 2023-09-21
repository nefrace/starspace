extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.portal_timer_changed.connect(on_portal_time_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_portal_time_changed(val: int):
	print(val)
