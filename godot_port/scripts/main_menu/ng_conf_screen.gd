extends Node


var save_file: Resource


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/ColorRect/VBoxContainer/B_NO").grab_focus()
	save_file = preload("res://resources/saved_game/saved_game.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_B_NO_pressed():
	get_node("/root/ControlMenu/VBoxContainer/ButtonNG").grab_focus()
	queue_free()


func _on_B_YES_pressed():
	
	#var file_init_car = File.new()
	#file_init_car.open("res://data_files/car_selected.txt", File.WRITE)
	#file_init_car.store_string("lilas")
	#file_init_car.close()
	save_file.car_selected = "lilas"
	
	"""var file_cars = File.new()
	file_cars.open("res://data_files/player_cars.txt", File.WRITE)
	file_cars.store_string("lilas\nVAZIO\nVAZIO")
	file_cars.close()"""
	save_file.car0_in_garage = "lilas"
	save_file.car1_in_garage = "VAZIO"
	save_file.car2_in_garage = "VAZIO"
	
	#var file_golds = File.new()
	#file_golds.open("res://data_files/gold.txt", File.WRITE)
	#file_golds.store_string("3000")
	#file_golds.close()
	save_file.gold = 3000
	
	#var file_state = File.new()
	#file_state.open("res://data_files/progress_in_game.txt", File.WRITE)
	#file_state.store_string("0")
	#file_state.close()
	save_file.state = 0
	
	"""var acc_char: int = 1
	var acc_events: int = 1
	for i in range(1,16,1):
		var file = File.new()
		file.open("res://data_files/event"+String(acc_events)+"_char"+String(acc_char)+".txt", File.WRITE)
		file.store_string("0")
		file.close()
		if (i%5==0):
			acc_char += 1
			acc_events = 1
		else:
			acc_events += 1"""
	save_file.event1_char1 = 0
	save_file.event2_char1 = 0
	save_file.event3_char1 = 0
	save_file.event4_char1 = 0
	save_file.event5_char1 = 0
	
	save_file.event1_char2 = 0
	save_file.event2_char2 = 0
	save_file.event3_char2 = 0
	save_file.event4_char2 = 0
	save_file.event5_char2 = 0
	
	save_file.event1_char3 = 0
	save_file.event2_char3 = 0
	save_file.event3_char3 = 0
	save_file.event4_char3 = 0
	save_file.event5_char3 = 0

	var save_status = ResourceSaver.save("res://resources/saved_game/saved_game.tres", save_file)
	get_tree().change_scene("res://scenes/ng_prologue/ng_prologue.tscn")

