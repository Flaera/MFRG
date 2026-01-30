extends Control

onready var acceleration_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressACCEL
onready var RPM_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressRPM
onready var torque_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressTORQUE
onready var nitro_texture = $CanvasLayer/Control/VBoxContainer/TextureProgressNITRO
onready var car_name_label = $CanvasLayer/Control/VBoxContainer/L_CAR_NAME
onready var select_lang
var specs: Dictionary
var acc: int

func _ready():
	specs = preload("res://data_files/cars_specs.gd").new().specs
	acc = 0
	
	select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))


func _exit_tree():
	select_lang.free()


func rulerThree(var maxim: float, var current: float):
	return (100*current)/maxim

func changeUIProperties(current_selected_car: Car):
	acceleration_texture.value=rulerThree(5.1, current_selected_car.acceleration)
	RPM_texture.value=rulerThree(500, current_selected_car.max_rpm)
	torque_texture.value=rulerThree(250, current_selected_car.max_torque)
	nitro_texture.value=current_selected_car.nitro_max
	car_name_label.text = current_selected_car.name

