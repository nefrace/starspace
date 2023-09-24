extends ExplosionResource
class_name PlayerExplosionResource

func effect(parent: Node2D):
	var timer = Timer.new()
	timer.wait_time = 0.3
	timer.one_shot = false
	parent.add_child(timer)
	timer.start()
	for i in range(5):
		var expl : Explosion = (explosion_scene.instantiate() as Explosion)
		expl.radius = randf_range(8, 14)
		expl.lifetime = 0.3
		expl.position = parent.position + Vector2.RIGHT.rotated(randf()*PI*2) * randf() * 6
		expl.sfx = preload("res://sfx/expl02.wav")
		parent.add_sibling(expl)
		await timer.timeout
	var expl : Explosion = (explosion_scene.instantiate() as Explosion)
	expl.radius = 18
	expl.lifetime = 1
	expl.color = Color.from_string("#bd502f", Color.WHITE)
	expl.position = parent.position
	expl.sfx = preload("res://sfx/expl01.wav")
	parent.add_sibling(expl)
	Events.player_dead.emit()
