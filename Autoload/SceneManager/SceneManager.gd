extends CanvasLayer


func switch_to_file(file: String):
	await tween_in()
	get_tree().change_scene_to_file(file)
	await tween_out()
	
func switch_to_packed(scene: PackedScene):
	await tween_in()
	get_tree().change_scene_to_packed(scene)
	await tween_out()


func tween_in():
	var i := 0
	var tw = get_tree().create_tween()
	for c in $Control.get_children():
		var stripe : Control = c as Control
		stripe.position.x = -180
		var initial_position = stripe.position
		tw.parallel().tween_property(stripe, "position", Vector2(0, initial_position.y), 0.4).set_delay(i * 0.1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		i += 1
	await tw.finished

func tween_out():
	var i := 0
	var tw = get_tree().create_tween()
	for c in $Control.get_children():
		var stripe : Control = c as Control
		stripe.position.x = 0
		var initial_position = stripe.position
		tw.parallel().tween_property(stripe, "position", Vector2(-180, initial_position.y), 0.4).set_delay(i * 0.1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		i += 1
	await tw.finished
