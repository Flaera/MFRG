extends VehicleBody

class_name Car

enum MODES {PLAYER, AI, STATIC}
export(MODES) var car_mode = MODES.AI

export var price: float
export var acceleration: float
export var max_torque: float
export var top_speed: float
export var nitro_max: float
export var velocity: float
export var max_rpm: float
export var fully_nitro: float
export var delta_nitro_inc: float
export var delta_nitro_dec: float

onready var backLeftWheel = $BackLeftWheel
onready var backRightWheel = $BackRightWheel
onready var nitroParticles = [$NitroParticles/CPUParticles, $NitroParticles2/CPUParticles]
onready var wheelParticles = [$FrontLeftWheel/CPUParticles, $BackLeftWheel/CPUParticles, $FrontRightWheel/CPUParticles, $BackRightWheel/CPUParticles]
onready var raycasts: Array = $RayCast.get_children()
#onready var interest_zones: Array
onready var collider = $CollisionShape
onready var canvas_layer = $Control/CanvasLayer
onready var progress_bar = $Control/CanvasLayer/ProgressBar
onready var velocimeter = $Control/CanvasLayer/velo
onready var pointer = $Control/CanvasLayer/pointer
onready var interest: Array = [0,0,0,0,0,0,0]
onready var danger: Array = [0,0,0,0,0,0,0]
onready var event
onready var index_checkpoints: int = 0
onready var checkpoints
onready var len_checkpoints: int
onready var curr_checkpoint
onready var index2: int = 0

var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var raycasts_by_name: Dictionary

const WEIGHT = 1000
const MAX_DISTANCE = 100000
const NO_COLLIDE = 200000


func disable_particles():
	$FrontLeftWheel/CPUParticles.visible=false
	$FrontRightWheel/CPUParticles.visible=false
	$BackLeftWheel/CPUParticles.visible=false
	$BackRightWheel/CPUParticles.visible=false
	$NitroParticles/CPUParticles.visible=false
	$NitroParticles2/CPUParticles.visible=false


func _ready():
	match car_mode:
		MODES.PLAYER:
			car_phys = Cars.new(acceleration, max_rpm, max_torque, fully_nitro)
			canvas_layer.visible = true
		MODES.AI:
			event = get_parent().get_parent().get_parent().get_parent()
			checkpoints = event.get_node("ViewportContainer/Viewport/checkpoints").get_children()
			len_checkpoints = len(checkpoints)
			curr_checkpoint = checkpoints[0].get_node("Area0")
			#set_raycasts()
			canvas_layer.visible=false
			#disable_particles()
			car_phys = Cars.new(acceleration, max_rpm, max_torque, fully_nitro)
			disable_input()
		MODES.STATIC:
			canvas_layer.visible=false
			disable_particles()
			#visible=false
			car_phys = Cars.new(acceleration, max_rpm, max_torque, fully_nitro)
			#set_raycasts()
			disable_input()
			
	#weight = WEIGHT
	#gravity_scale = 2.0
	#if (ResourceLoader.load("res://resources/saved_game/saved_game.tres").car_selected=="solo"):
	#	gravity_scale=4.0
		#weight=4.0
		
	
	#set_process_input(true)
	#set_process_unhandled_input(true)
	#set_process_unhandled_key_input(true)
	#set_process(true)
	#set_process_internal(true)
	#set_physics_process(true)



func _input(event):
	axis.x = Input.get_axis("g_right", "g_left")
	axis.y = Input.get_axis("g_up", "g_down")
	#axis = Input.get_vector("ui_right","ui_left","ui_down","ui_up")
	brake_pedal = Input.is_action_pressed("g_brake")
	nitro = Input.is_action_pressed("g_nitro")
	#print("axis=",axis)



func _physics_process(delta):
	var calc = car_phys.mainCarPhys(axis, nitro, backLeftWheel, backRightWheel,
	 brake_pedal, brake, steering, delta, car_mode)
	
	if car_phys.move==true and car_mode==0:
		#print("calc=",calc[1])
		brake = calc[0]
		steering = calc[1]
		#print("steering=",steering)
		progress_bar.value = calc[2]
		
		var car_velocity = calc[4]
		velocimeter.text = String(car_velocity)
		pointer.rotation_degrees = ((2*car_velocity)/2.307)-130

		#Nitro particles:
		#print("calc[2]=",calc[2])
		#$NitroParticles.particles.emitting=true
		for particle in nitroParticles:
			particle.emitting = calc[3]
			#print("NITRO ON|",particle.emitting,"|",calc[3])
		#return
		#Dust particles:
		for particle in wheelParticles:
			particle.emitting = abs(car_velocity) > 5
		#prev_pos=translation
	elif (car_mode==1):
		look_at_checkpoint(delta)
		axis.y = -1.0
		



func distance_2(origin: Vector3, target: Vector3):
	var vec0 = Vector2(origin.x, origin.z)
	var vec1 = Vector2(target.x, target.z)
	var result = vec0.distance_to(vec1)
	return result


func set_interest():
	interest = [-MAX_DISTANCE,-MAX_DISTANCE,
	-MAX_DISTANCE,-MAX_DISTANCE,
	-MAX_DISTANCE,-MAX_DISTANCE,
	-MAX_DISTANCE]
	#print(len(raycasts))
	for rc in range(0,len(raycasts)):
		if (raycasts[rc].is_colliding()==false):
			interest[rc]=NO_COLLIDE
		else:
			var point_collider = raycasts[rc].get_collision_point().distance_to(translation)
			interest[rc]=point_collider
	


func set_danger():
	danger=[0,0,0,0,0,0,0]
	for rc in range(0, len(raycasts)):
		if (raycasts[rc].is_colliding()==false):
			danger[rc]=NO_COLLIDE
		else:
			var point_collider = raycasts[rc].get_collision_point().distance_to(translation)
			danger[rc]=point_collider



func look_at_checkpoint(_delta):
	var index_in_array_rc = -1
	for rc in range(0,len(raycasts)):
		if (curr_checkpoint==raycasts[rc].get_collider()):
			index_in_array_rc=rc
			if (index_in_array_rc==0):
				steering=0.0
			elif (index_in_array_rc>0 and index_in_array_rc<4):
				steering = 0.6
			elif (index_in_array_rc>3 and index_in_array_rc<7):
				steering = -0.6
			print("RC=",raycasts[rc].get_collider().get_parent().name,"|ST=", steering)
	if (index_in_array_rc==-1):
		steering=0.0
	
	#var dist = translation.distance_to(curr_checkpoint.translation)
	#if (dist<5 and index2<len(checkpoints)-1): index2+=1
	if (index_checkpoints<len_checkpoints):
		curr_checkpoint=checkpoints[index_checkpoints].get_node("Area0")
	print("|curr=",curr_checkpoint.get_parent().name)



func disable_input():
	self.set_process_input(false)
	self.set_process_unhandled_input(false)
	self.set_process_unhandled_key_input(false)


func disable():
	if collider == null:
		collider = $CollisionShape
	self.set_process(false)
	self.set_process_internal(false)
	self.set_physics_process(false)
	self.set_physics_process_internal(false)
	self.set_process_input(false)
	self.set_process_unhandled_input(false)
	self.set_process_unhandled_key_input(false)
	self.visible = false
	mode = self.MODE_STATIC
	collider.set_deferred("disabled", true)


func enable():
	if collider == null:
		collider = $CollisionShape
	self.set_process(true)
	self.set_process_internal(true)
	self.set_physics_process(true)
	self.set_physics_process_internal(true)
	self.set_process_input(true)
	self.set_process_unhandled_input(true)
	self.set_process_unhandled_key_input(true)
	self.visible = true
	collider.set_deferred("disabled", false)
	mode = self.MODE_RIGID



