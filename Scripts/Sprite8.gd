@tool
extends Sprite2D
class_name Sprite8

@export var is_repeating := false
@export_range(0, 360) var angle: float = 0
var transformed_rotation: float = 0
var rot8: float = 0:
	set(value):
		pass
	get: 
		return deg_to_rad(transformed_rotation)
		
var rot8_deg: float = 0:
	set(value):
		pass
	get:
		return transformed_rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var max_frames = 8 
	if is_repeating:
		max_frames = 4
	var index : int = floor((angle+22.5) / 45.0)
	transformed_rotation = index * 45.0
	frame = wrapi(index, 0, max_frames)
