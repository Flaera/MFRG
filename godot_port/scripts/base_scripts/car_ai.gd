extends KinematicBody

onready var event=self.get_parent().get_parent().get_parent().get_parent()
onready var raycasts = $Raycasts.get_children()
# context array
onready var interest = [Vector3.ZERO,Vector3.ZERO,Vector3.ZERO,
						Vector3.ZERO,Vector3.ZERO,Vector3.ZERO,
						Vector3.ZERO]
onready var danger = [Vector3.ZERO,Vector3.ZERO,Vector3.ZERO,
						Vector3.ZERO,Vector3.ZERO,Vector3.ZERO,
						Vector3.ZERO]
onready var velocity: Vector3 = Vector3.ZERO

export var max_speed = 150
export var steer_force = 0.1
#export var look_ahead = 100
#export var num_rays = 8
export var accel: float = 25
export var gravity: float = 9.8



func set_danger():
	for i in range(0,len(raycasts)):
		if (raycasts[i].get_collider()!=null):
			danger[i]=raycasts[i].get_collision_point()
		else:
			danger[i]=Vector3.ZERO


func set_interest():
	for i in range(0,len(raycasts)):
		if (raycasts[i].get_collider()==null):
			interest[i]=Vector3(1.0,1.0,1.0)
		elif (raycasts[i].get_collider().is_in_group("checkpoint_ia")):
			interest[i]=raycasts[i].get_collision_point()
		else:
			interest[i]=Vector3.ZERO


func choose_directions():
	for i in range(0,len(interest)):
		if (danger[i]!=Vector3.ZERO):
			interest[i]=Vector3.ZERO
	var angle_point = Vector3.ZERO
	for j in range(0,len(interest)):
		if (j==0):pass
		elif (j>=1 and j<=3):
			#Left
			angle_point += interest[j]*30.0
		else:
			#Right
			angle_point += interest[j]*-30.0
	return deg2rad(angle_point.y)
	


func _physics_process(delta):
	set_danger()
	set_interest()
	var direction_target=choose_directions()
	#print("DEBUG==",velocity)
	#global_rotate(Vector3.UP,direction_target)
	velocity.y = -gravity
	velocity.z = lerp(velocity.z,(accel*delta)+velocity.z,accel*delta)
	print(velocity)
	clamp(velocity.z,0.0,max_speed)
	move_and_collide(velocity*delta)

