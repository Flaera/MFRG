extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var path_file_scene = ""
#onready var one_time = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass#$AnimationPlayer.play("RESET")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_fade(path):
	#if one_time==false:
		#one_time=true
	path_file_scene = path
	$AnimationPlayer.play("fade_in_and_out")


func change_next_file_scene():
	get_tree().change_scene(path_file_scene)
