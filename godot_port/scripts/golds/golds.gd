extends HBoxContainer


func _process(_delta):
	var file = File.new()
	file.open("res://data_files/gold.txt",File.READ)
	var golds = file.get_csv_line()
	get_node("LGolds").text = " Golds: "+String(golds[0])+" "
	file.close()
