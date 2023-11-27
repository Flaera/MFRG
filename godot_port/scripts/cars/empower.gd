extends VehicleBody

#var cp_load = load("res://scripts/cars/cars.gd")
var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool

func _ready():
	var data: Array = load("res://data_files/cars_specs.gd").new().specs["empower"]
	#print(data[2])
	car_phys = Cars.new(float(data[1]),float(data[2]),float(data[3]),float(data[4]))
	#cp_load.new(data[2],data[3],data[4],data[5])
	get_node("Control/CanvasLayer").visible = car_phys.getMove()
	weight = 1000


func _input(event):
	if (event.is_action_pressed("ui_left")):
		axis.x = 1.0
	if (event.is_action_pressed("ui_right")):
		axis.x=-1.0
	if (event.is_action_pressed("ui_up")):
		axis.y=1.0
	if (event.is_action_pressed("ui_down")):
		axis.y=-1.0
	if (event.is_action_released("ui_right") or event.is_action_released("ui_left")):
		axis.x=0.0
	if (event.is_action_released("ui_down") or event.is_action_released("ui_up")):
		axis.y=0.0
	if (event.is_action_pressed("ui_brake")):
		brake_pedal=true
	if (event.is_action_released("ui_brake")):
		brake_pedal=false
	if (event.is_action_pressed("ui_select")): nitro = true
	if (event.is_action_released("ui_select")): nitro = false


func _physics_process(delta):
	var calc = car_phys.mainCarPhys(axis, nitro, get_node("BackWheel"), get_node("BackWheel2"),
	 brake_pedal, brake, steering, delta)
	brake = calc[0]
	steering = calc[1]

	#UI:
	if car_phys.getMove()==true:
		get_node("Control/CanvasLayer/ProgressBar").value = calc[2]
		var rpm_medium = (get_node("BackWheel").get_rpm()+get_node("BackWheel2").get_rpm())/2
		var velocity = abs(int((rpm_medium)/1.785714286))#abs(int(33.02*0.001885*rpm_medium))
		#print(" --- ",velocity)
		get_node("Control/CanvasLayer/velo").text = String(velocity)
		get_node("Control/CanvasLayer/pointer").rotation_degrees = ((2*velocity)/2.307)-130
		
		#Nitro particles:
		if (calc[2]>0.0 and nitro==true):
			get_node("empower_invoker_nitro/CPUParticles").emitting = true
			get_node("empower_invoker_nitro001/CPUParticles").emitting = true
		else:
			get_node("empower_invoker_nitro/CPUParticles").emitting = false
			get_node("empower_invoker_nitro001/CPUParticles").emitting = false
		#Dust particles:
		if (rpm_medium>10):
			get_node("FrontWheel/CPUParticles").emitting = true
			get_node("FrontWheel2/CPUParticles").emitting = true
			get_node("BackWheel/CPUParticles").emitting = true
			get_node("BackWheel2/CPUParticles").emitting = true
		else:
			get_node("FrontWheel/CPUParticles").emitting = false
			get_node("FrontWheel2/CPUParticles").emitting = false
			get_node("BackWheel/CPUParticles").emitting = false
			get_node("BackWheel2/CPUParticles").emitting = false

