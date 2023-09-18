extends BaseEntity

@export var random_start: bool = true
@export var initial_velocity: Vector2 = Vector2.ZERO
@export var random_max_velocity: float = 40.0
@export var health: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	if random_start:
		initial_velocity = (Vector2.RIGHT * randf_range(0.0, random_max_velocity)).rotated(randf()*PI*2)
	velocity = initial_velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func receive_damage(dmg: int, from: Node2D):
	health -= dmg
	if health <= 0:
		die()
		queue_free()
