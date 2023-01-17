# Script by Chevifier channel

extends Camera

var mouse = Vector2()

func _input(event):
	if (event is InputEventMouse):
		mouse = event.position
	if (event is InputEventMouseButton and event.pressed):
		if (event.button_index == BUTTON_LEFT):
			get_selection()


func get_selection():
	var worldspace = get_world().direct_space_state
	var start = project_ray_origin(mouse)
	var end = project_position(mouse,1000)
	var result = worldspace.intersect_ray(start,end)
	print("RESULT1:",result)
	if (result.collider.has_method("go_style_scene")==true):
		result.collider.go_style_scene()
	elif (result.collider.has_method("go_game")==true):
		result.collider.go_game()
