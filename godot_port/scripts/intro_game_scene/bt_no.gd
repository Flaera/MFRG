extends StaticBody


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func go_game():
	Transition.play_fade("res://scenes/intro_game_talk/intro_game_talk.scn")
