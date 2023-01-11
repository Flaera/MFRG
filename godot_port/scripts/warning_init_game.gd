extends Viewport

onready var w = preload("res://data_files/warnings.gd").new().warnings
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("mainText").rect_size
	get_node("mainText").text = w['3']
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#get_node("mainTextSprite3d/Node/Viewport/mainText").rect_size
	#get_node("mainTextSprite3d/Node/Viewport/mainText").text = w['3']
	#pass
