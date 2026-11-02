extends Control


var time: float = 0.0
var Res: Dictionary = {"640x360": Vector2(640,360),
"1280x720": Vector2(1280,720),
"1920x1080": Vector2(1920,1080)}
var res_array: Array = [Vector2(640,360),
	Vector2(1280,720),
	Vector2(1920,1080)]
onready var dir_class


func set_keymaps(res: Resource):
	print("act=",res.act_buttons[0])
	
	var up = "g_up"
	InputMap.action_erase_events(up)
	InputMap.action_add_event(up,res.act_buttons[0][0])
	
	var down = "g_down"
	InputMap.action_erase_events(down)
	InputMap.action_add_event(down,res.act_buttons[1][0])
	
	var right = "g_right"
	InputMap.action_erase_events(right)
	InputMap.action_add_event(right,res.act_buttons[2][0])
	
	var left = "g_left"
	InputMap.action_erase_events(left)
	InputMap.action_add_event(left,res.act_buttons[3][0])
	
	var nitro = "g_nitro"
	InputMap.action_erase_events(nitro)
	InputMap.action_add_event(nitro,res.act_buttons[4][0])
	
	var brake = "g_brake"
	InputMap.action_erase_events(brake)
	InputMap.action_add_event(brake,res.act_buttons[5][0])
	



# Called when the node enters the scene tree for the first time.
func _ready():
	
	var save_settings
	var save_game
	#dir_class = Directory.new()
	
	save_settings = load("user://game_settings.tres")
	save_game = load("user://saved_settings.tres")
	
	if (!ResourceLoader.exists("user://game_settings.tres")
	and !ResourceLoader.exists("user://saved_settings.tres")):
		var dir = Directory.new()
		save_settings = dir.copy("res://resources/game_settings/game_settings.tres","user://game_settings.tres")
		save_game = dir.copy("res://resources/saved_game/saved_game.tres","user://saved_game.tres")
		print("Save=",save_game)
		save_settings = load("user://game_settings.tres")
		save_game = load("user://saved_settings.tres")
	#dir_class.free()
	
	var music: int = -1
	var audio_channel_music = (save_settings.sound_and_music_volume)
	if (save_settings.sound_and_music_volume!=null and audio_channel_music>=int(-80) and audio_channel_music<=int(1)):
		music = int(audio_channel_music)
	else:
		music = int(-21)
	AudioServer.set_bus_volume_db(1,music)
	
	var size: int = -1
	if (save_settings.index_resolution!=null and (save_settings.index_resolution==0 or 
	save_settings.index_resolution==1 or 
	save_settings.index_resolution==2)):
		size = int(save_settings.index_resolution)#int(file_screen.get_csv_line()[0])
	else:
		pass
	print("SIZE==", size)
	if (size==0):
		OS.set_window_size(Res["640x360"])
	elif (size==1):
		OS.set_window_size(Res["1280x720"])
	elif (size==2):
		OS.set_window_size(Res["1920x1080"])
	else:
		OS.set_window_size(Res["1920x1080"])
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,res_array[size])
	
	set_keymaps(save_settings)


func _process(_delta):
	time += _delta
	if (time>5):
		Transition.play_fade("res://scenes/main_intro_game/intro_laguna.tscn")
