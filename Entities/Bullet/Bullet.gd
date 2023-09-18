extends CharacterBody2D

@export var direction: float = 0.0
@export var speed: float = 100.0
@export var parent: Node2D

var explosion = preload("res://Entities/FX/Explosion/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.angle = rad_to_deg(direction)
	velocity = Vector2(speed, 0).rotated(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision := move_and_collide(velocity * delta)
	if collision:
		var collider := collision.get_collider()
		if collider.has_method("receive_damage"):
			collider.receive_damage(1, parent)
		var expl := (explosion.instantiate() as Explosion)
		expl.global_position = global_position 
		expl.radius = 6
		expl.lifetime = 0.2
		add_sibling(expl)
		queue_free()
