extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var width_screen: float = 1920
onready var amount_events: float = 15
onready var delta_black_part: float = width_screen/amount_events
onready var delta_black: float = 0.0
onready var delta_time: float = 0.0
onready var amount_events_complete: float = 0.0
onready var save_file = preload("res://resources/saved_game/saved_game.tres")
onready var max_time_in_scene: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	var events: Array = [save_file.event1_char1,
						save_file.event2_char1,
						save_file.event3_char1,
						save_file.event4_char1,
						save_file.event5_char1,
						save_file.event1_char2,
						save_file.event2_char2,
						save_file.event3_char2,
						save_file.event4_char2,
						save_file.event5_char2,
						save_file.event1_char3,
						save_file.event2_char3,
						save_file.event3_char3,
						save_file.event4_char3,
						save_file.event5_char3]
	for i in events:
		if (i==true):
			amount_events_complete+=1
			
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_black = lerp(delta_black, amount_events_complete*delta_black_part, delta)
	get_node("ViewportContainer/Viewport/CanvasLayer/ColorRect").rect_position.x = delta_black
	delta_time+=delta
	if (delta_time>=max_time_in_scene):
		get_tree().change_scene("res://scenes/map/map2.tscn")
	#print("delta_scene_progression=",delta_time)
