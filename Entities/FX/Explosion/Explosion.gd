extends Node2D
class_name Explosion

## Radius of explosion
@export var radius: float = 16
## Time to explosion to disappear
@export var lifetime: float = 0.5
@export var sfx: AudioStream
var max_lifetime: float = lifetime
@export_color_no_alpha var color = Color.hex(0xf7ecb9ff)

func _ready():
	max_lifetime = lifetime
	material.set_shader_parameter("color", color)
	material.set_shader_parameter("inner_offset", Vector2(randf_range(-0.5, 0.5), randf_range(-0.5, 0.5)))
	$SFX.stream = sfx
	$SFX.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= delta
	material.set_shader_parameter("inner", remap(lifetime, max_lifetime, 0.0, 0.0, 1.5))
	if lifetime <= 0:
		queue_free()
	

func _draw():
	draw_rect(Rect2(-radius, -radius, radius * 2, radius * 2), Color.WHITE)

