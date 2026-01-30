extends Control

onready var save_settings: Resource = load("user://game_settings.tres")
onready var select_lang = SelectLang.new()
onready var control_settings_scn: PackedScene = preload("res://scenes/main_menu/controls_settings.tscn")
var Res: Dictionary = {"640x360": Vector2(640,360),
"1280x720": Vector2(1280,720),
"1920x1080": Vector2(1920,1080)}


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton.add_item("640x360",0)
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton.add_item("1280x720",1)
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton.add_item("1920x1080",2)
	"""if (TranslationServer.get_locale() == "en_US"):
		print("aqui")
		$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/ButtonEN.grab_focus()
	elif (TranslationServer.get_locale()=="pt_BR"):
		$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/ButtonPT.grab_focus()
	print("language=",TranslationServer.get_locale())"""
	#var file_screen = File.new()
	#file_screen.open("res://data_files/size_screen.txt", File.READ)
	var index: int = save_settings.index_resolution#int(file_screen.get_csv_line()[0])
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton.selected = index
	AudioServer.set_bus_volume_db(1,save_settings.sound_and_music_volume)
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/HSlider.value = save_settings.sound_and_music_volume
	
	select_lang.textInAllNodes(get_node("."))
	
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer2/HSliderContrastMenu.value = save_settings.contrast_tex
	select_lang.contrast_in_texturesrects(get_node("."))

	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer2/HSliderContrastMenu2.value = save_settings.contrast_3d

	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton.grab_focus()


func _exit_tree():
	select_lang.free()


func quit():
	get_node("/root/ControlMenu/ViewportContainer/Viewport/VBoxContainer/ButtonContinue").grab_focus()
	get_node("/root/ControlMenu/ViewportContainer/Viewport/VBoxContainer").visible=true
	queue_free()


func _process(_delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		quit()


func _on_OptionButton_item_selected(index):
	var size = Res[$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton.get_item_text(index)]
	#var file_size = File.new()
	#file_size.open("res://data_files/size_screen.txt", File.WRITE)
	#file_size.store_string(String(index))
	#file_size.close()
	save_settings.index_resolution=index
	ResourceSaver.save("user://game_settings.tres", save_settings)
	OS.set_window_size(size)
	#print("==",size)
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,size)


func _on_ButtonBack_pressed():
	quit()


func _on_ButtonEN_pressed():
	TranslationServer.set_locale("en_US")


func _on_ButtonPT_pressed():
	TranslationServer.set_locale("pt_BR")


func _on_HSlider_value_changed(value):
	print("value=",value)
	#AudioServer.set_bus_volume_db(1,false)
	AudioServer.set_bus_volume_db(1,value)
	save_settings.sound_and_music_volume = value
	ResourceSaver.save("user://game_settings.tres", save_settings)


func _on_ColorPickerButton_color_changed(color):
	save_settings.color_legend = color
	ResourceSaver.save("user://game_settings.tres", save_settings)


func _on_HSliderContrast_value_changed(value):
	save_settings.contrast_tex = value
	ResourceSaver.save("user://game_settings.tres", save_settings)
	select_lang.contrast_in_texturesrects(get_node("."))
	get_node("/root/ControlMenu").call("_ready")
	$CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer2/HSliderContrastMenu.grab_focus()


func _on_HSliderContrastMenu2_value_changed(value):
	save_settings.contrast_3d = value
	ResourceSaver.save("user://game_settings.tres", save_settings)


func _on_B_CONTROLS_pressed():
	#add_child(control_settings_scn.instance())
	get_tree().change_scene("res://scenes/main_menu/controls_settings.tscn")
