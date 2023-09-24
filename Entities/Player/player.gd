extends BaseEntity
class_name Player

@export_category("Speed")
@export var max_thrust: float = 150.0
@export var thrust_acceleration: float = 700.0
@export var speed: float = 80.0
@export_category("rotation")
@export var rotation_speed : float = 270.0
@export var rotation_acceleration : float = 360.0
@export var rotation_decceleration : float = 720.0
@export_category("shooting")
## how many seconds spent between shots
@export var fire_rate: float = 0.3
var max_fire_rate: float = 0.3
@export var shoot_points: Array[Node2D] = []
@export var projectile: PackedScene
var shoot_point_index: int = 0

var angle: float = 0
var angle_moment: float = 0

var thrust: float = 0

func _ready():
	max_fire_rate = fire_rate 
	fire_rate = 0
	
func _process(delta):
	fire_rate = max(0, fire_rate - delta)
	if Input.is_action_pressed("fire") and fire_rate == 0:
		fire_rate = max_fire_rate
		var point := shoot_points[shoot_point_index]
		shoot_point_index = wrapi(shoot_point_index + 1, 0, len(shoot_points))
		var bullet = projectile.instantiate()
		bullet.global_position = point.global_position
		bullet.direction = deg_to_rad(angle)
		bullet.parent = self
		add_sibling(bullet)
		

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var rotating = Input.get_axis("ui_left", "ui_right")
	if rotating:
		var rot_speed = rotation_acceleration * delta
		if sign(rotating * angle_moment) == -1:
			rot_speed = rotation_decceleration * delta
		angle_moment = move_toward(angle_moment, rotating * rotation_speed, rot_speed)
	else:
		angle_moment = move_toward(angle_moment, 0.0, rotation_decceleration * delta)
	angle = wrapf(angle + angle_moment * delta, 0.0, 360.0)
	var angle_rad = deg_to_rad(angle)
	$Sprite.angle = angle
	$Sprite/RotatingCenter.rotation = angle_rad
	$"Sprite/8RotCenter".global_rotation = $Sprite.rot8
	var acceleration = Input.get_axis("ui_down", "ui_up")
	%ThrustForwardParticles.emitting = acceleration > 0
	%ThrustBackwardParticlesL.emitting = acceleration < 0
	%ThrustBackwardParticlesR.emitting = acceleration < 0
	if acceleration:
		thrust = move_toward(thrust, acceleration * max_thrust, thrust_acceleration * delta)
		velocity += (Vector2.RIGHT * thrust).rotated(angle_rad) * delta
		
	else:
		thrust = 0
		velocity = velocity.move_toward(Vector2.ZERO, 80.0 * delta)
		
	velocity = velocity.limit_length(speed)
	super._physics_process(delta)
