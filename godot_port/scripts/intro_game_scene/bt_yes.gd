extends StaticBody


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func go_style_scene():
	get_tree().change_scene("res://scenes/menu_group_choice/menu_group_choice.scn")
