extends Control


var time: float = 0.0
var Res: Dictionary = {"640x360": Vector2(640,360),
"1280x720": Vector2(1280,720),
"1920x1080": Vector2(1920,1080)}
var res_array: Array = [Vector2(640,360),
	Vector2(1280,720),
	Vector2(1920,1080)]


# Called when the node enters the scene tree for the first time.
func _ready():
	var save_settings = load("res://resources/game_settings/game_settings.tres")
	#var file_screen = File.new()
	#file_screen.open("res://data_files/size_screen.txt", File.READ)
	var size = save_settings.index_resolution#int(file_screen.get_csv_line()[0])
	#file_screen.close()
	AudioServer.set_bus_volume_db(1,save_settings.sound_and_music_volume)
	if (size==0):
		OS.set_window_size(Res["640x360"])
	elif (size==1):
		OS.set_window_size(Res["1280x720"])
	elif (size==2):
		OS.set_window_size(Res["1920x1080"])
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,res_array[size])
	
	
	


func _process(_delta):
	time += _delta
	if (time>5):
		get_tree().change_scene("res://scenes/select_lang/select_lang.tscn")
