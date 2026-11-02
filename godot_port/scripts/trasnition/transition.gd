extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var path_file_scene = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_fade(path):
	path_file_scene = path
	$AnimationPlayer.play("fade_in_and_out")


func change_next_file_scene():
	get_tree().change_scene(path_file_scene)
