extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += Vector2.DOWN * 100 * delta
	if position.y > 532:
		Events.ship_flew_away.emit()
		queue_free()
	var bodies := get_overlapping_bodies()
	if !bodies:
		return
	for obj in bodies:
		if obj.is_in_group("debris"):
			obj.die()
			obj.queue_free()
			Events.ship_hit_debris.emit()
		if obj is Player:
			obj.health = 0
