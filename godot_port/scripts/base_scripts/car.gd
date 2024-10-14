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
onready var interest_zones: Array
onready var collider = $CollisionShape
onready var canvas_layer = $Control/CanvasLayer
onready var progress_bar = $Control/CanvasLayer/ProgressBar
onready var velocimeter = $Control/CanvasLayer/velo
onready var pointer = $Control/CanvasLayer/pointer

var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var raycasts_by_name: Dictionary

const WEIGHT = 1000

func _ready():
	match car_mode:
		MODES.PLAYER:
			car_phys = Cars.new(price, acceleration, max_rpm, max_torque)
			canvas_layer.visible = car_phys.getMove()
		MODES.AI:
			set_raycasts()
			car_phys = Cars.new(price, acceleration, max_rpm, max_torque)
			disable_input()
	
	weight = WEIGHT
	gravity_scale = 2.0
	set_process_input(true)
	set_process(true)
	set_process_internal(true)
	set_physics_process(true)


func _input(event):
	axis.x = Input.get_axis("ui_right", "ui_left")
	axis.y = Input.get_axis("ui_up", "ui_down")
	#axis = Input.get_vector("ui_right","ui_left","ui_down","ui_up")
	brake_pedal = event.is_action_pressed("ui_brake")
	nitro = event.is_action_pressed("ui_select")
	#print("axis=",axis)



func _physics_process(delta):
	var calc = car_phys.mainCarPhys(axis, nitro, backLeftWheel, backRightWheel,
	 brake_pedal, brake, steering, delta)
	brake = calc[0]
	steering = calc[1]

	#UI:
	if car_phys.getMove()==true:
		progress_bar.value = calc[2]
		var rpm_medium = (backLeftWheel.get_rpm()+backRightWheel.get_rpm())/2
		var velocity = abs(int((rpm_medium)/1.785714286))#abs(int(33.02*0.001885*rpm_medium))
		#print(" --- ",velocity)
		velocimeter.text = String(velocity)
		pointer.rotation_degrees = ((2*velocity)/2.307)-130

		#Nitro particles:
		for particle in nitroParticles:
			particle.emitting = calc[2] > 0.0 and nitro == true
		#Dust particles:
		for particle in wheelParticles:
			particle.emitting = rpm_medium > 10


func look_at_checkpoint(var target: Spatial):
	var interest_zones: Array = [0,0,0,0,0,0]
	var target_node: Area = target.get_node("Area0")
	
	if interest_zones.has(1):
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

func set_raycasts():
	interest_zones.resize(raycasts.size()-1)
	interest_zones.fill(0)
	for raycast in raycasts:
		raycast.connect("colliding", self, "_on_raycast_colliding")
		raycast.connect("non_colliding", self, "_on_raycast_non_colliding")
		raycasts_by_name[raycast.name] = raycast


func _on_raycast_colliding(raycast):
	var raycast_index = raycasts.find(raycast)
	if raycast_index != 0:
		interest_zones[raycast_index-1] = 1
		return
	axis.x = 0.0


func _on_raycast_non_colliding(raycast):
	var raycast_index = raycasts.find(raycast)
	if raycast_index != 0:
		interest_zones[raycast_index-1] = 0
		return

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
	mode = RigidBody.MODE_STATIC
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
	mode = RigidBody.MODE_RIGID
