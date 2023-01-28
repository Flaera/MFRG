extends VehicleBody


var axis: Vector2 = Vector2(0.0,0.0)
var acceleration: Vector3
var rotation_max: Vector3
var speed_max: Vector3
var nitro_max: Vector3


func _ready():
	rotation_degrees.y = 180.0
	get_node("SpatialCam/Camera").current=true
	#var wheel0 = get_node("FrontWheel")
	#var wheel1 = get_node("FrontWheel2")
	#var wheel2 = get_node("BackWheel")
	#var wheel3 = get_node("BackWheel2")

	#wheel0.suspension_stiffness=60
	#wheel1.suspension_stiffness=60
	#wheel2.suspension_stiffness=60
	#wheel3.suspension_stiffness=60
	
	#wheel0.suspension_travel=0.5
	#wheel1.suspension_travel=0.5
	#wheel2.suspension_travel=0.5
	#wheel3.suspension_travel=0.5
	
	#wheel0.damping_compression=60
	#wheel1.damping_compression=60
	#wheel2.damping_compression=60
	#wheel3.damping_compression=60
	
	#wheel0.damping_relaxation=60
	#wheel1.damping_relaxation=60
	#wheel2.damping_relaxation=60
	#wheel3.damping_relaxation=60
	
	#wheel0.wheel_friction_slip=7.8
	#wheel1.wheel_friction_slip=7.8
	#wheel2.wheel_friction_slip=7.8
	#wheel3.wheel_friction_slip=7.8
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


func camTransform():
	var cam: Object = get_node("SpatialCam")
	cam.translation[1] = 38.0
	cam.rotation_degrees[0] = -90.0
	cam.rotation_degrees[1] = 180.0
	cam.rotation_degrees[2] = 0.0
	


func _process(delta):
	#print(axis," ", engine_force)
	if axis.y>0:
		engine_force=120
		brake=0.0
	else:
		if (axis.y<0):
			brake = 0.8
		else:
			brake = 0.0
		engine_force=0.0
	steering = deg2rad(axis.x*40)

	camTransform()
