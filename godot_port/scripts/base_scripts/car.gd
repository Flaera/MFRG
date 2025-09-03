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
export var steering_speed: float = 0.8
export var max_engine_force = 1200
export var max_steering_angle = 0.3
export var brake_force = 20
export var speed_path: float = 0.0075

export (NodePath) var path_to_follow
var path_follow_node

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
onready var audio_sp_node = preload("res://assets/sounds_fx/car_banging.tscn")
onready var interest: Array = [Vector3.ZERO,Vector3.ZERO,
								Vector3.ZERO,Vector3.ZERO,
								Vector3.ZERO,Vector3.ZERO,
								Vector3.ZERO]
onready var danger: Array = [Vector3.ZERO,Vector3.ZERO,
								Vector3.ZERO,Vector3.ZERO,
								Vector3.ZERO,Vector3.ZERO,
								Vector3.ZERO]
onready var event
#onready var checkpoints
#onready var index_checkpoints: int = 0
#onready var len_checkpoints: int
#onready var curr_checkpoint
onready var index2: int = 0
onready var timer_reverse_on: bool = false
onready var timer_reverse: float = 0.0
onready var nitro_launching: bool = true

var car_phys: Cars
var axis: Vector2 = Vector2(0.0,0.0)
var brake_pedal = false
var nitro: bool
var raycasts_by_name: Dictionary

const MASS = 1000
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
			print("Player=",car_mode)
		MODES.AI:
			event = get_parent().get_parent().get_parent().get_parent()
			#checkpoints = event.get_node("ViewportContainer/Viewport/checkpoints").get_children()
			
			#len_checkpoints = len(checkpoints)
			#curr_checkpoint = checkpoints[0]
			#set_raycasts()
			canvas_layer.visible=false
			#disable_particles()
			car_phys = Cars.new(acceleration, max_rpm, max_torque, fully_nitro)
			disable_input()
			print("IA=",car_mode)
			
			if path_to_follow != null and has_node(path_to_follow):
				path_follow_node = get_node(path_to_follow)
		MODES.STATIC:
			canvas_layer.visible=false
			disable_particles()
			#visible=false
			car_phys = Cars.new(acceleration, max_rpm, max_torque, fully_nitro)
			#set_raycasts()
			disable_input()
			print("Static=",car_mode)
			
	#mass = MASS
	#gravity_scale = 2.0
	#var car_used = ResourceLoader.load("res://resources/saved_game/saved_game.tres").car_selected
	#if (car_used=="solo" or car_used=="sun" or car_used=="caixa"):
	gravity_scale=2.0
	#else:
	#	gravity_scale=1.0
	#mass = 8*MASS
	#weight=MASS
	
	
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
	
	if car_phys.move==true and car_mode==0:
		var calc = car_phys.mainCarPhys(axis, nitro, backLeftWheel, backRightWheel,
		brake_pedal, brake, steering, delta, car_mode)
		#print("calc=",calc[1])
		brake = calc[0]
		steering = calc[1]
		#print("steering=",steering)
		progress_bar.value = calc[2]
		
		var car_velocity = calc[4]
		velocity = calc[4]
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
		
		#Sound engine:
		if ($SoundsFX/AudioStreamPlayerMotor.playing==false):
			$SoundsFX/AudioStreamPlayerMotor.play()
		#Sound nitro:
		if (nitro==true and nitro_launching==true):
			$SoundsFX/AudioStreamPlayerNitro.play()
			nitro_launching=false
		if (Input.is_action_just_released("g_nitro")):
			nitro_launching=true
			
		
		#print("DEBUG==",nitro,"|",nitro_launching)
	elif (car_phys.move==true and car_mode==1):
		look_at_checkpoint(delta)
		nitro=true
		var calc_ai = car_phys.mainCarPhys(axis, nitro, backLeftWheel, backRightWheel,
		brake_pedal, brake, steering, delta, car_mode)
		
		


func look_at_checkpoint(delta):
	#var dist: float = global_transform.origin.distance_to(curr_checkpoint.global_transform.origin)
	#if dist < 15.0 and index_checkpoints < len_checkpoints:
	#	index_checkpoints += 1
	if path_follow_node == null:
		return
	
	#var dist = path_follow_node.global_transform.origin.distance_to(self.global_transform.origin)
	#if (dist>10.0):
	path_follow_node.unit_offset += delta*speed_path
	print("PATH=", path_follow_node.unit_offset,"|")
	
	# Pega posição do alvo
	var target_pos = path_follow_node.global_transform.origin
	
	# Adiciona um leve offset adiante do ponto (opcional, ajustável)
	target_pos += path_follow_node.transform.basis.z * 5.0
	
	# Vetores de direção
	var to_target = (target_pos - global_transform.origin).normalized()
	var forward = +global_transform.basis.z.normalized()  # Frente do carro (ajuste se necessário)

	# Alinhamento
	var dot = forward.dot(to_target)
	var angle = forward.cross(to_target).y  # Gira em torno do eixo Y (para direção lateral)
	
	# Suaviza o ângulo
	steering = clamp(angle, -1, 1)
	
	# Decide aceleração/freio
	if dot > 0.2:
		axis.y = -1.0  # Acelera
		brake = false
	elif dot < -0.2:
		axis.y = 1.0  # Dá ré se muito atrás (opcional)
		brake = true
	else:
		axis.y = 0.0
		brake = false
	
	# DEBUG
	#print("🚗 dot:", dot, " angle:", angle, " steering:", steering, " axis.y:", axis.y, " brake:", brake)
	


func multiply_vector(vec1: Vector3, vec2: Vector3) -> float:
	var a1=vec1[0]
	var b1=vec1[1]
	var c1=vec1[2]
	var a2=vec2[0]
	var b2=vec2[1]
	var c2=vec2[2]
	return sqrt(pow(a1*a2,2)+pow(b1*b2,2)+pow(c1*c2,2))
	


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


func _on_AreaSFX_body_entered(body):
	if car_mode==0 and body!=self and not(body.is_in_group("ground")):
		#print("BODY:",body)
		var audio_sp_instantiate = audio_sp_node.instance()
		$SoundsFX.add_child(audio_sp_instantiate)

