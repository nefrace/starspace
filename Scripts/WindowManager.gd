extends Node
class_name WindowManager

const BASE_RES: Vector2i = Vector2i(160, 144)
var current_scale: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func resize(scale: int = current_scale):
	get_window().size = BASE_RES * current_scale
