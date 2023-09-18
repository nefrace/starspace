@tool
extends Sprite2D
class_name Sprite8

@export var is_repeating := false
@export_range(0, 360) var angle: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var max_frames = 8 
	if is_repeating:
		max_frames = 4
	frame = wrapi(floor((angle+22.5) / 45.0), 0, max_frames)
