extends VehicleBody

#var cp_load = load("res://scripts/cars/cars.gd")
var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var INFINITY: int = 1000
var delta_time_fps: float = 0.0
#var delta_rot: float = 0.0
var index_checkpoint: int = 0
var event_name: String


func _ready():
	var file = File.new()
	file.open("res://data_files/car_selected.txt", File.READ)
	var car: String = file.get_csv_line()[0]
	var data: Array = load("res://data_files/cars_specs.gd").new().specs[car]
	#print(data[2])
	car_phys = Cars.new(float(data[1]),float(data[2]),float(data[3]),float(data[4]))
	#cp_load.new(data[2],data[3],data[4],data[5])
	weight = 1000
	var file_event = File.new()
	file_event.open("res://data_files/event_name.txt", File.READ)
	event_name = file_event.get_as_text()
	file_event.close()


func look_at_checkpoint(var target: Spatial):
	var interest_zones: Array = [0,0,0,0,0,0]
	var target_node: Area = target.get_node("Area0")
	var raycast_l90: RayCast = get_node("RayCast/RayCastL90")
	var raycast_l30: RayCast = get_node("RayCast/RayCastL30")
	var raycast_l60: RayCast = get_node("RayCast/RayCastL60")
	var raycast_r90: RayCast = get_node("RayCast/RayCastR90")
	var raycast_r30: RayCast = get_node("RayCast/RayCastR30")
	var raycast_r60: RayCast = get_node("RayCast/RayCastR60")
	var raycast_front: RayCast = get_node("RayCast/RayCastFront")
	if (raycast_front.get_collider()==target_node):
		#print("ACHOU!!")
		axis.x = 0.0
	else:
		if (raycast_l90.get_collider()==target_node): interest_zones[0]=1
		if (raycast_l30.get_collider()==target_node): interest_zones[1]=1
		if (raycast_l60.get_collider()==target_node): interest_zones[2]=1
		if (raycast_r90.get_collider()==target_node): interest_zones[3]=1
		if (raycast_r30.get_collider()==target_node): interest_zones[4]=1
		if (raycast_r60.get_collider()==target_node): interest_zones[5]=1
		var acc_left: int = 0
		var acc_right: int = 0
		var acc_general: int = 0
		for i in interest_zones:
			if (acc_general<3 and i==1):
				acc_left+=1
			if (acc_general>=3 and acc_general<6 and i==1):
				acc_right+=1
			acc_general+=1
		#print("accr=",acc_right," accl=",acc_left)
		if (acc_right>acc_left):
			axis.x = -1.0#translation.angle_to(target.global_translation)
		elif (acc_right<acc_left):
			axis.x = 1.0
		else:
			axis.x = 0.0
	#print(raycast_front.get_collider(), "|", target, "| axisx: ",axis.x)


func actions():
	#print("trans=",get_node("/root/event1_char1_v2/checkpoint0").translation)
	var file = File.new()
	file.open("res://data_files/cp_enemy.txt",File.READ)
	index_checkpoint = int(file.get_csv_line()[0])
	file.close()
	#print("cp=",index_checkpoint)
	var checkpoint = get_node("/root/"+event_name+"/checkpoint"+String(index_checkpoint))
	look_at_checkpoint(checkpoint)
	#look_at(-car_test.translation, Vector3(0,1,0))
	#look_at(get_node("/root/event1_char1_v2/checkpoint"+String(index_checkpoint)).translation,Vector3.UP)
	#var steering_target = get_node("/root/event1_char1_v2/checkpoint"+String(index_checkpoint))
	#var fwd = self.linear_velocity.normalized()
	#var target_vector = (steering_target - global_translation)
	#var distance = target_vector.length()
	#axis.x = fwd.cross(target_vector.normalized()).y
	#look_at(steering_target.translation, Vector3(0,1,0))
	#var direction = steering_target - self.global_translation
	#var angleto = translation.angle_to(direction)
	#axis.x = angleto
	#print("axis.x=",axis.x)
	#if (steering_value>0.0):
	#	axis.x = 1.0
	#else:
	#	axis.x = -1.0
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

