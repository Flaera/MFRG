extends Control


onready var time: float = 0.0


func _process(_delta):
	time += _delta
	if (time>5):
		Transition.play_fade("res://scenes/select_lang/select_lang.tscn")
