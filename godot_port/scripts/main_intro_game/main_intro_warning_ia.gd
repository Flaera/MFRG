extends Control


var time: float = 0.0


func _ready():
	$CanvasLayer/VBoxContainer/Label.text="Este jogo teve uso de IA (Inteligêncial Artificial) para compor os scripts de IA dos inimigos de Anne!"
	$CanvasLayer/VBoxContainer/Label2.text="This game used AI (Artificial Intelligence) to compose the AI ​​scripts for Anne's enemies!"


func _process(_delta):
	time += _delta
	if (time>5):
		get_tree().change_scene("res://scenes/select_lang/select_lang.tscn")
