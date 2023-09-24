extends BaseEntity
class_name BasicDebris

@export var random_start: bool = true
@export var initial_velocity: Vector2 = Vector2.ZERO
@export var random_max_velocity: float = 40.0
@export var health: int = 3
@export var randomize_rotation: bool = false
@export var randomize_flip: bool = false

var slowdown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if random_start:
		initial_velocity = (Vector2.RIGHT * randf_range(0.0, random_max_velocity)).rotated(randf()*PI*2)
	velocity = initial_velocity
	if randomize_rotation:
		rotation_degrees = randi_range(0, 4) * 90
	if randomize_flip:
		$Sprite2D.flip_h = randf() > 0.5
		$Sprite2D.flip_v = randf() > 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if slowdown:
		velocity = velocity.move_toward(Vector2.ZERO, 15.0 * delta)
		
	if position.x < -200 || position.x > 680 || position.y < -200 || position.x > 632:
		queue_free()

func receive_damage(dmg: int, from: Node2D):
	health -= dmg
	if health <= 0:
		die()
		queue_free()
		Events.debris_destroyed.emit()

func _exit_tree():
	print(position)
	
func _on_rail_field_area_area_entered(area):
	slowdown = true


func _on_rail_field_area_area_exited(area):
	slowdown = false
