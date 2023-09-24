extends CanvasLayer

@export var menu_scene: PackedScene
@export var root_node: Node
var debris_in_line: bool = false
var seconds_in_game: int = 0:
	set(value):
		seconds_in_game = value
		%Time.text = "TIME: %02d:%02d" % [floor(seconds_in_game/60), seconds_in_game % 60]
	get:
		return seconds_in_game
var debris_destroyed: int = 0:
	set(value):
		debris_destroyed = value
		%Destroyed.text = "DESTROYED: %d" % [debris_destroyed]
	get:
		return debris_destroyed

var timer: Timer
func _ready():
	timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = false
	timer.timeout.connect(on_timer_timeout)
	add_child(timer)
	timer.start()
	Events.portal_timer_changed.connect(portal_timer_changed)
	Events.reputation_changed.connect(reputation_changed)
	Events.health_changed.connect(health_changed)
	Events.debris_destroyed.connect(on_debris_destroyed)
	Events.debris_in_line.connect(on_debris_in_line)
	Events.player_dead.connect(on_player_dead)
	Events.rep_is_zero.connect(on_rep_zero)

func _process(_delta):
	var t := get_tree()
	if Input.is_action_just_pressed("ui_cancel"):
		t.paused = !t.paused
		%Paused.visible = t.paused
	if Input.is_action_just_pressed("ui_accept") && t.paused:
		MusicPlayer.stop()
		t.paused = false
		SceneManager.switch_to_file("res://Scenes/MenuScene/MenuScene.tscn")

func on_timer_timeout():
	seconds_in_game += 1
	
func on_debris_destroyed():
	debris_destroyed += 1

func portal_timer_changed(time: int):
	var new_text := "%02d" % time if time > 0 else "--"
	%PortalTimer.text = new_text

func reputation_changed(new_rep: int):
	%Reputation.value = new_rep
	
func health_changed(health: int):
	%Health.value = health
	if health <= 0:
		timer.stop()


func _on_debris_warning_timer_timeout():
	%DebrisWarning.visible = debris_in_line && !%DebrisWarning.visible

func on_debris_in_line(in_line: bool):
	debris_in_line = in_line

func gameover(label: Label):
	var tw: Tween = get_tree().create_tween()
	var t := %Time 
	var d := %Destroyed
	label.show()
	d.show()
	t.show()
	label.position.y = 180
	d.position.x = -160
	t.position.x = 160
	tw.tween_property(label, "position", Vector2(label.position.x, 60), 2).set_trans(Tween.TRANS_BACK)
	tw.parallel().tween_property(t, "position", Vector2(25, t.position.y), 2).set_trans(Tween.TRANS_BACK).set_delay(1.3)
	tw.parallel().tween_property(d, "position", Vector2(25, d.position.y), 2).set_trans(Tween.TRANS_BACK).set_delay(1.5)
	await tw.finished
	await get_tree().create_timer(3).timeout
	SceneManager.switch_to_file("res://Scenes/MenuScene/MenuScene.tscn")

func on_player_dead():
	gameover(%GameOverDead)
	
func on_rep_zero():
	gameover(%GameOverRep)
