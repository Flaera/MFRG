extends VehicleBody

#var cp_load = load("res://scripts/cars/cars.gd")
var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var INFINITY: int = 1000
var delta_time_fps: float = 0.0


func _ready():
	var file = File.new()
	file.open("res://data_files/car_selected.txt", File.READ)
	var car: String = file.get_csv_line()[0]
	var data: Array = load("res://data_files/cars_specs.gd").new().specs[car]
	#print(data[2])
	car_phys = Cars.new(float(data[1]),float(data[2]),float(data[3]),float(data[4]))
	#cp_load.new(data[2],data[3],data[4],data[5])
	weight = 1000


func getDistance(var point: Vector3):
	pass


func actions(delta):
	var dist_r90: int = get_node("RayCast/RayCastR90").get_collision_point()[0]
	var dist_l90: int = get_node("RayCast/RayCastL90").get_collision_point()[0]
	#if (!get_node("RayCastR90").is_colliding()):
	#	dist_r90 = INFINITY
	#if (!get_node("RayCastL90").is_colliding()):
	#	dist_l90 = INFINITY
	print("dists:", dist_l90, "-", dist_r90, "-",
	get_node("RayCast/RayCastL90").get_collider())
	if (dist_r90<dist_l90):
		print("AQUI1-")
		axis.x = 1.0 # turn in left
	elif (dist_r90>dist_l90):
		print("AQUI2-")
		axis.x = -1.0
	#forever forward:
	axis.y=1.0
	brake_pedal=false
	if (!(get_node("RayCast/RayCastFront").is_colliding())):
		nitro = true
	else: nitro = false
	return


func _physics_process(delta):
	actions(delta)
	var calc = car_phys.mainCarPhys(axis, nitro, get_node("BackWheel"), get_node("BackWheel2"),
	 brake_pedal, brake, steering, delta)
	brake = calc[0]
	steering = calc[1]

	#UI:
	if car_phys.getMove()==true:
		var rpm_medium = (get_node("BackWheel").get_rpm()+get_node("BackWheel2").get_rpm())/2
		var velocity = abs(int((rpm_medium)/1.785714286))#abs(int(33.02*0.001885*rpm_medium))
		#print(" --- ",velocity)
		
		#Nitro particles:
		if (calc[2]>0.0 and nitro==true):
			get_node("lilas_invoker_nitro/CPUParticles").lifetime = 5
			get_node("lilas_invoker_nitro001/CPUParticles2").lifetime = 5
			get_node("lilas_invoker_nitro").visible = true
			get_node("lilas_invoker_nitro001").visible = true
		else:
			get_node("lilas_invoker_nitro/CPUParticles").lifetime = 0.01
			get_node("lilas_invoker_nitro001/CPUParticles2").lifetime = 0.01
			get_node("lilas_invoker_nitro").visible = false
			get_node("lilas_invoker_nitro001").visible = false
		#Dust particles:
		if (rpm_medium>10):
			get_node("FrontWheel/CPUParticles").visible = true
			get_node("FrontWheel2/CPUParticles").visible = true
			get_node("BackWheel/CPUParticles").visible = true
			get_node("BackWheel2/CPUParticles").visible = true
		else:
			get_node("FrontWheel/CPUParticles").visible = false
			get_node("FrontWheel2/CPUParticles").visible = false
			get_node("BackWheel/CPUParticles").visible = false
			get_node("BackWheel2/CPUParticles").visible = false

