extends CharacterBody2D

@export_category("Speed")
@export var MAX_THRUST: float = 150.0
@export var THRUST_ACCELERATION: float = 700.0
@export var SPEED: float = 80.0
@export_category("Rotation")
@export var ROTATION_SPEED : float = 270.0
@export var ROTATION_ACCELERATION : float = 360.0
@export var ROTATION_DECCELERATION : float = 720.0


var angle: float = 0
var angle_moment: float = 0

var thrust: float = 0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var rotating = Input.get_axis("ui_left", "ui_right")
	if rotating:
		var rot_speed = ROTATION_ACCELERATION * delta
		if sign(rotating * angle_moment) == -1:
			rot_speed = ROTATION_DECCELERATION * delta
		angle_moment = move_toward(angle_moment, rotating * ROTATION_SPEED, rot_speed)
	else:
		angle_moment = move_toward(angle_moment, 0.0, ROTATION_DECCELERATION * delta)
	angle = wrapf(angle + angle_moment * delta, 0.0, 360.0)
	var angle_rad = deg_to_rad(angle)
	var frame = wrapi(floor((angle+22.5) / 45.0), 0, 8)
	$Sprite.frame = frame
	$Sprite/RotatingCenter.rotation = angle_rad
	
	var acceleration = Input.get_axis("ui_down", "ui_up")
	if acceleration:
		thrust = move_toward(thrust, acceleration * MAX_THRUST, THRUST_ACCELERATION * delta)
		velocity += (Vector2.RIGHT * thrust).rotated(angle_rad) * delta
	else:
		thrust = 0
		velocity = velocity.move_toward(Vector2.ZERO, 80.0 * delta)
		
	velocity = velocity.limit_length(SPEED)
	
	move_and_slide()
