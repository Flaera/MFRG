extends Control

onready var acceleration_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressACCEL
onready var RPM_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressRPM
onready var torque_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressTORQUE
onready var nitro_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressNITRO
#onready var car_name_label = $CanvasLayer/Control/VBoxContainer/L_CAR_NAME
onready var res_savegame: Resource = ResourceLoader.load("res://resources/saved_game/saved_game.tres")

#var specs: Dictionary


func _ready():
	#specs = preload("res://data_files/cars_specs.gd").new().specs
	
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))




func rulerThree(var maxim: float, var current: float):
	return (100*current)/maxim


func _process(delta):
	#var file = File.new()
	#file.open("res://data_files/car_selected.txt", File.READ)
	#var car_str = file.get_csv_line()[0]
	#print(car_str)
	#get_node("CanvasLayer/Control/VBoxContainer/TextureProgressACCEL").value=rulerThree(5.1,specs[car_str][1])
	#get_node("CanvasLayer/Control/VBoxContainer/TextureProgressRPM").value=rulerThree(500,specs[car_str][2])
	#get_node("CanvasLayer/Control/VBoxContainer/TextureProgressTORQUE").value=rulerThree(250,specs[car_str][3])
	#get_node("CanvasLayer/Control/VBoxContainer/TextureProgressNITRO").value=specs[car_str][4]
	#file.close()
	var current_selected_car = load("res://scenes/cars_updated/"+res_savegame.car_selected+".tscn")
	var car_instance = current_selected_car.instance()
	acceleration_texture.value=rulerThree(5.1, car_instance.acceleration)
	RPM_texture.value=rulerThree(500, car_instance.max_rpm)
	torque_texture.value=rulerThree(250, car_instance.max_torque)
	nitro_texture.value=car_instance.nitro_max
	#car_name_label.text = car_instance.name
