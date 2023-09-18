extends Effect
class_name ExplosionResource

@export var radius: float = 16
@export var time: float = 0.5
var explosion_scene = preload("res://Entities/FX/Explosion/Explosion.tscn")

func effect(parent: Node2D):
	var expl : Explosion = (explosion_scene.instantiate() as Explosion)
	expl.radius = radius 
	expl.lifetime = time
	expl.position = parent.position
	parent.add_sibling(expl)
	print("Explosion created")
