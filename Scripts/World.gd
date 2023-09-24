extends Node2D

var reputation : int = 100
var seconds_in_game: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.ship_hit_debris.connect(ship_hit_debris)
	
func ship_hit_debris():
	reputation -= 10
	Events.reputation_changed.emit(reputation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

