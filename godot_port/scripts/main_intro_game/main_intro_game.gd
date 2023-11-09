extends Control


var time: float = 0.0
var Res: Dictionary = {"640x360": Vector2(640,360),
"HD - 1280x720": Vector2(1280,720),
"Full HD - 1920x1080": Vector2(1920,1080),
"4K - 3840x2160": Vector2(3840,2160)}


# Called when the node enters the scene tree for the first time.
func _ready():
	var file_screen = File.new()
	file_screen.open("res://data_files/size_screen.txt", File.READ)
	var size = int(file_screen.get_csv_line()[0])
	file_screen.close()
	if (size==0):
		OS.set_window_size(Res["640x360"])
	elif (size==1):
		OS.set_window_size(Res["HD - 1280x720"])
	elif (size==2):
		OS.set_window_size(Res["Full HD - 1920x1080"])
	elif (size==3):
		OS.set_window_size(Res["4K - 3840x2160"])


func _process(_delta):
	time += _delta
	if (time>5):
		get_tree().change_scene("res://scenes/select_lang/select_lang.tscn")
