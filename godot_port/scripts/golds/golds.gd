extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://data_files/gold.txt",File.READ)
	var golds = file.get_csv_line()
	get_node("LGolds").text = " Golds: "+String(golds[0])+" "


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
