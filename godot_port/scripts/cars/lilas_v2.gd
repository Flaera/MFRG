extends VehicleBody


var axis: Vector2 = Vector2(0.0,0.0)

func _ready():
	pass


func _input(event):
	if (event.is_action_pressed("ui_left")):
		axis.x = 1.0
	elif (event.is_action_pressed("ui_right")):
		axis.x=-1.0
	if (event.is_action_pressed("ui_up")):
		axis.y=1.0
	elif (event.is_action_pressed("ui_down")):
		axis.y=-1.0
	if (event.is_action_released("ui_right") or event.is_action_released("ui_left")):
		axis=Vector2(0.0,0.0)
	if (event.is_action_released("ui_down") or event.is_action_released("ui_up")):
		axis=Vector2(0.0,0.0)

func _process(delta):
	if axis.y>0:
		engine_force=120
		brake=0.0
	else:
		brake = 0.0
		engine_force=0.0
	steering = deg2rad(axis.x*40)
