extends Control


var Res: Dictionary = {"640x360": Vector2(640,360),
"HD - 1280x720": Vector2(1280,720),
"Full HD - 1920x1080": Vector2(1920,1080),
"4K - 3840x2160": Vector2(3840,2160)}


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("640x360",0)
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("HD - 1280x720",1)
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("Full HD - 1920x1080",2)
	get_node("CanvasLayer/VBoxContainer/OptionButton").add_item("4K - 3840x2160",3)
	get_node("CanvasLayer/VBoxContainer/OptionButton").grab_focus()


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
	
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,size)


func _on_ButtonBack_pressed():
	quit()


func _on_ButtonEN_pressed():
	TranslationServer.set_locale("en_US")


func _on_ButtonPT_pressed():
	TranslationServer.set_locale("pt_BR")
