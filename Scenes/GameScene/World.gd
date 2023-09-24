extends Node2D

var reputation : int = 100
var seconds_in_game: int = 0
var debris_destroyed: int = 0
var is_rep_zero: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.ship_hit_debris.connect(ship_hit_debris)
	
func ship_hit_debris():
	reputation -= 10
	Events.reputation_changed.emit(reputation)
	if reputation <= 0 && !is_rep_zero:
		Events.rep_is_zero.emit()
		is_rep_zero = true

