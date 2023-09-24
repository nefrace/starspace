extends Node2D

@export var active: bool = true
@export var max_debris: int = 10
var debris_spawned: int = 0
@export var mean_interval: float = 2.0
@export var debris_list: Array[PackedScene] = []
var next_spawn_time: float = 0

func _ready():
	Events.ship_flew_away.connect(ship_gone)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		return
	next_spawn_time -= delta
	if next_spawn_time <= 0:
		next_spawn_time = clamp(randfn(mean_interval, 3), 0.5, 10)
		if debris_spawned >= max_debris:
			active = false
			return
		var debris := debris_list[randi_range(0, len(debris_list)-1)]
		var d: BasicDebris = (debris.instantiate() as BasicDebris)
		var angle := deg_to_rad(randf_range(40, 320))
		var position = Vector2(240, 216) + Vector2.UP.rotated(angle) * 230
		d.global_position = position
		d.random_start = false
		d.initial_velocity = Vector2.DOWN.rotated(angle).rotated(randf_range(-0.5, 0.5)) * randf_range(20.0, 50.0)
		add_sibling(d)
		debris_spawned += 1

func ship_gone():
	active = true
	debris_spawned = 0
	max_debris += 2
