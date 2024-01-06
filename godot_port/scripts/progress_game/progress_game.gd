extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var delta_black: float = 1920/15
var delta_time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var events: Array = []
	var acc_events: int = 0
	var acc_events_five = 1
	var acc_char_three = 1
	for j in range(0,15,1):
		var file_events = File.new()
		file_events.open("res://data_files/event"+String(acc_events_five)+"_char"+String(acc_char_three)+".txt", File.READ)
		var event_info: int = int(file_events.get_csv_line()[0])
		file_events.close()
		events.append(event_info)
		if (acc_events!=0 and acc_events_five%5==0):
			acc_char_three += 1
			acc_events_five = 1
		else:
			acc_events_five += 1
		acc_events += 1
	for i in events:
		if (i==1):
			get_node("CanvasLayer/ColorRect").rect_position.x += delta_black


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_time+=delta
	if (delta_time>=5):
		get_tree().change_scene("res://scenes/map/map2.tscn")
