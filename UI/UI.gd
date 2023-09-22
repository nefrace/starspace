extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.portal_timer_changed.connect(portal_timer_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func portal_timer_changed(time: int):
	var new_text := "%02d" % time if time > 0 else "--"
	%PortalTimer.text = new_text
