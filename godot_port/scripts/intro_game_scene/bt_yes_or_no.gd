extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func go_scene(scene):
	get_tree().change_scene(scene)
