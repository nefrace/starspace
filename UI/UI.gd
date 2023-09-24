extends CanvasLayer

@export var player: Player
var debris_in_line: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.portal_timer_changed.connect(portal_timer_changed)
	Events.reputation_changed.connect(reputation_changed)
	Events.debris_in_line.connect(on_debris_in_line)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func portal_timer_changed(time: int):
	var new_text := "%02d" % time if time > 0 else "--"
	%PortalTimer.text = new_text

func reputation_changed(new_rep: int):
	%Reputation.value = new_rep


func _on_debris_warning_timer_timeout():
	%DebrisWarning.visible = debris_in_line && !%DebrisWarning.visible

func on_debris_in_line(in_line: bool):
	debris_in_line = in_line
