extends Control


var Res: Dictionary = {"640x360": Vector2(640,360),
"1280x720": Vector2(1280,720),
"1920x1080": Vector2(1920,1080)}


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("640x360",0)
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("1280x720",1)
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("1920x1080",2)
	get_node("CanvasLayer/VBoxContainer/OptionButton").grab_focus()
	var file_screen = File.new()
	file_screen.open("res://data_files/size_screen.txt", File.READ)
	var index: int = int(file_screen.get_csv_line()[0])
	get_node("CanvasLayer/VBoxContainer/OptionButton").selected = index


func quit():
	get_node("/root/ControlMenu/VBoxContainer/ButtonNG").grab_focus()
	queue_free()


func _process(_delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		quit()


func _on_OptionButton_item_selected(index):
	var size = Res[get_node("CanvasLayer/VBoxContainer/OptionButton").get_item_text(index)]
	var file_size = File.new()
	file_size.open("res://data_files/size_screen.txt", File.WRITE)
	file_size.store_string(String(index))
	file_size.close()
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
	if (value==45):
		AudioServer.set_bus_volume_db(1,true)
	else:
		AudioServer.set_bus_volume_db(1,false)
		AudioServer.set_bus_volume_db(1,value)
