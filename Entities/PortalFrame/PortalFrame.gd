extends Node2D

var spawn_timer: int = 60
var timer: Timer = Timer.new()
@export var mothership: PackedScene
var debris_in_line: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 1
	timer.one_shot = false
	timer.timeout.connect(on_timer_timeout)
	add_child(timer)
	timer.start()
	Events.ship_flew_away.connect(ship_gone)
	await get_tree().process_frame
	Events.portal_timer_changed.emit(spawn_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var debris = $RailField.get_overlapping_areas()
	var old_status := debris_in_line
	debris_in_line = len(debris) > 0
	if old_status != debris_in_line:
		Events.debris_in_line.emit(debris_in_line)

func on_timer_timeout():
	if spawn_timer == 1:
		$RailField/ParticlesBasic.emitting = false
		$RailField/ParticlesActive.emitting = true
	if spawn_timer == 0:
		var ship = mothership.instantiate()
		ship.global_position = global_position + Vector2.UP * 100
		add_sibling(ship)
		Events.ship_spawned.emit()
		await get_tree().create_timer(2).timeout
		$RailField/ParticlesActive.emitting = false
	spawn_timer -= 1
	Events.portal_timer_changed.emit(spawn_timer)
	
func ship_gone():
	$RailField/ParticlesBasic.emitting = true
	spawn_timer = 60

func _on_rail_field_body_entered(body):
	Events.debris_in_line.emit(true)
