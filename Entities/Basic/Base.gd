extends CharacterBody2D
class_name BaseEntity

@export_category("Collision Response")
@export var bounce_multiplier: float = 0.5
@export_category("Death Effects")
@export var death_effects: Array[Effect] = []
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	var collided: bool = move_and_slide()
	if collided:
		var collision: KinematicCollision2D = get_last_slide_collision()
		var collider: CharacterBody2D = collision.get_collider()
		if collider.has_method("react_to_hit"):
			collider.react_to_hit(self)
		if collider.is_in_group("colliders"):
			collider.velocity += velocity * collider.bounce_multiplier
		velocity = velocity.reflect(collision.get_normal()) * -bounce_multiplier

func die():
	for effect in death_effects:
		if effect.has_method("effect"):
			effect.effect(self)
