extends Label


func _process(_delta):
	var file_velo = File.new()
	file_velo.open("res://data_files/curr_velocity.txt",File.READ)
	var data_velo = file_velo.get_8()
	print("data_velo=",data_velo)
	var velocity = data_velo/2
	#print(" --- ",velocity)
	text = String(velocity)
	file_velo.close()
	#get_node("CanvasLayer/pointer").rotation_degrees = 
