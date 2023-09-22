extends Node2D

var spawn_timer: int = 10
var timer: Timer = Timer.new()
@export var mothership: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 1
	timer.one_shot = false
	timer.timeout.connect(on_timer_timeout)
	add_child(timer)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_timer_timeout():
	if spawn_timer == 0:
		var ship = mothership.instantiate()
		ship.global_position = global_position
		add_sibling(ship)
		spawn_timer = 15
	spawn_timer -= 1
	Events.portal_timer_changed.emit(spawn_timer)
	
