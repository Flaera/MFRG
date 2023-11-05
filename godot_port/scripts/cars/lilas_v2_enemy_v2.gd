extends VehicleBody

#var cp_load = load("res://scripts/cars/cars.gd")
var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var INFINITY: int = 1000
var delta_time_fps: float = 0.0
#var delta_rot: float = 0.0
var ray_signal: float = 1.0


func _ready():
	var file = File.new()
	file.open("res://data_files/car_selected.txt", File.READ)
	var car: String = file.get_csv_line()[0]
	var data: Array = load("res://data_files/cars_specs.gd").new().specs[car]
	#print(data[2])
	car_phys = Cars.new(float(data[1]),float(data[2]),float(data[3]),float(data[4]))
	#cp_load.new(data[2],data[3],data[4],data[5])
	weight = 1000


func look_at_checkpoint(var target: Node):
	var danger_zones: Array = [0,0,0,0,0,0,0]
	var raycast_l90: RayCast = get_node("RayCast/RayCastL90")
	var raycast_l30: RayCast = get_node("RayCast/RayCastL30")
	var raycast_l60: RayCast = get_node("RayCast/RayCastL60")
	var raycast_r90: RayCast = get_node("RayCast/RayCastR90")
	var raycast_r30: RayCast = get_node("RayCast/RayCastR30")
	var raycast_r60: RayCast = get_node("RayCast/RayCastR60")
	var raycast_front: RayCast = get_node("RayCast/RayCastFront")
	if (raycast_front.get_collider()==target):
		axis.x = 0.0
	else:
		if (raycast_l90.get_collider()!=null): danger_zones[0]=1
		if (raycast_l30.get_collider()!=null): danger_zones[1]=1
		if (raycast_l60.get_collider()!=null): danger_zones[2]=1
		if (raycast_r90.get_collider()!=null): danger_zones[3]=1
		if (raycast_r30.get_collider()!=null): danger_zones[4]=1
		if (raycast_r60.get_collider()!=null): danger_zones[5]=1
		if (raycast_front.get_collider()!=null): danger_zones[6]=1
		var acc_left: int = 0
		var acc_right: int = 0
		var acc_general: int = 0
		for i in danger_zones:
			if (acc_general<3 and i==1):
				acc_left+=1
			if (acc_general>=3 and acc_general<6 and i==1):
				acc_right+=1
			acc_general+=1
		if (acc_right>acc_left):
			axis.x = 1.0
		elif (acc_right<acc_left):
			axis.x = -1.0
		else:
			axis.x = -1.0
	#print(raycast_front.get_collider(), "|", target, "| axisx: ",axis.x)


func actions():
	#print("trans=",get_node("/root/event1_char1_v2/checkpoint0").translation)
	look_at_checkpoint(get_node("/root/event1_char1_v2/checkpoint0/StaticBody"))
	
	#forever forward:
	axis.y=1.0
	brake_pedal=false
	if (!(get_node("RayCast/RayCastFront").is_colliding())):
		nitro = true
	else: nitro = false
	return


func _physics_process(delta):
	actions()
	var calc = car_phys.mainCarPhys(axis, nitro, get_node("BackWheel"), get_node("BackWheel2"),
	 brake_pedal, brake, steering, delta)
	brake = calc[0]
	steering = calc[1]

	#UI:
	if car_phys.getMove()==true:
		var rpm_medium = (get_node("BackWheel").get_rpm()+get_node("BackWheel2").get_rpm())/2
		#var velocity = abs(int((rpm_medium)/1.785714286))#abs(int(33.02*0.001885*rpm_medium))
		#print(" --- ",velocity)
		
		#Nitro particles:
		if (calc[2]>0.0 and nitro==true):
			get_node("lilas_invoker_nitro/CPUParticles").lifetime = 5
			get_node("lilas_invoker_nitro001/CPUParticles2").lifetime = 5
			get_node("lilas_invoker_nitro/CPUParticles").emitting = true
			get_node("lilas_invoker_nitro001/CPUParticles2").emitting = true
		else:
			get_node("lilas_invoker_nitro/CPUParticles").lifetime = 0.01
			get_node("lilas_invoker_nitro001/CPUParticles2").lifetime = 0.01
			get_node("lilas_invoker_nitro/CPUParticles").emitting = false
			get_node("lilas_invoker_nitro001/CPUParticles2").emitting = false
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

