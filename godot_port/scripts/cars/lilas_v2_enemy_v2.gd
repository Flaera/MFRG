extends VehicleBody

#var cp_load = load("res://scripts/cars/cars.gd")
var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var INFINITY: int = 1000
var delta_time_fps: float = 0.0
#var delta_rot: float = 0.0
var centrelized: bool = false
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
	#var rotl: float = 1.0
	#var rotr: float = -1.0
	#f (abs(axis.x)<=rot_inc):
	#	var distance_or_radius: float = translation.distance_to(target_vector3)
	#	var angle: float = translation.angle_to(target_vector3)
	#	print("dist: ", distance_or_radius, "| angle: ", angle)
	#	var tmpl: float = rotl*angle#(angle*3.1415*distance_or_radius)/180
	#	var tmpr: float = rotr*angle#(angle*3.1415*distance_or_radius)/180
	#	if (abs(tmpr)<abs(tmpl)):
	#		axis.x = tmpr
	#	else: axis.x = tmpl
	#elif (abs(axis.x)>0.0):
	#	axis.x = axis.x-(rot_inc*delta)#rotation_degrees[1] += (rot_inc*delta)
	if (axis.x<=1.0):
		centrelized = true
	else: centrelized = false
	var raycast_l90: RayCast = get_node("RayCast/RayCastL90")
	var raycast_l30: RayCast = get_node("RayCast/RayCastL30")
	var raycast_l60: RayCast = get_node("RayCast/RayCastL60")
	var raycast_r90: RayCast = get_node("RayCast/RayCastR90")
	var raycast_r30: RayCast = get_node("RayCast/RayCastR30")
	var raycast_r60: RayCast = get_node("RayCast/RayCastR60")
	if (raycast_l90.get_collider()==target
	 or raycast_l30.get_collider()==target
	 or raycast_l60.get_collider()==target):
		print("L")
		ray_signal = 1.0
	elif (raycast_r90.get_collider()==target
	 or raycast_r30.get_collider()==target
	 or raycast_r60.get_collider()==target):
		print("R")		
		ray_signal = -1.0
	var angle_to: float = translation.angle_to(target.translation) * ray_signal
	axis.x = angle_to
	print("| axisx: ",axis.x)


func actions():
	#print("trans=",get_node("/root/event1_char1_v2/checkpoint0").translation)
	look_at_checkpoint(get_node("/root/event1_char1_v2/checkpoint0"))
	
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

