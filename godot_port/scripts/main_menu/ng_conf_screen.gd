extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_B_NO_pressed():
	queue_free()


func _on_B_YES_pressed():
	
	var file_init_car = File.new()
	file_init_car.open("res://data_files/car_selected.txt", File.WRITE)
	file_init_car.store_string("lilas")
	file_init_car.close()
	
	var file_golds = File.new()
	file_golds.open("res://data_files/gold.txt", File.WRITE)
	file_golds.store_string("3000")
	file_golds.close()
	
	var file_state = File.new()
	file_state.open("res://data_files/progress_in_game.txt", File.WRITE)
	file_state.store_string("0")
	file_state.close()
	var acc_char: int = 1
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
			acc_events += 1

	get_tree().change_scene("res://scenes/ng_prologue/ng_prologue.tscn")

