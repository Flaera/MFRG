extends Control

var specs: Dictionary
func _ready():
	specs = preload("res://data_files/cars_specs.gd").new().specs


func rulerThree(var maxim: float, var current: float):
	return (100*current)/maxim


func _process(delta):
	var file = File.new()
	file.open("res://data_files/car_selected.txt", File.READ)
	var car_str = file.get_csv_line()[0]
	print(car_str)
	get_node("CanvasLayer/Control/VBoxContainer/TextureProgressACCEL").value=rulerThree(5.1,specs[car_str][1])
	get_node("CanvasLayer/Control/VBoxContainer/TextureProgressRPM").value=rulerThree(500,specs[car_str][2])
	get_node("CanvasLayer/Control/VBoxContainer/TextureProgressTORQUE").value=rulerThree(250,specs[car_str][3])
	get_node("CanvasLayer/Control/VBoxContainer/TextureProgressNITRO").value=specs[car_str][4]
	file.close()
