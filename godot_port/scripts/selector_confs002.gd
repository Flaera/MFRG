extends KinematicBody
#extends "res://scripts/menus/confirmation_screen.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var conf_screen
var n_opts = 2
var index = 0
var pos3d
var deltax


func saveStyleDefault():
	var file = File.new()
	file.open("res://data_files/style.dat", File.WRITE)
	file.store_string("Anne9")
	file.close()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	saveStyleDefault()
	#conf_screen = ConfirmationScreen.new()
	n_opts = 2
	index = 0
	pos3d = Vector3(1,0,0)
	deltax = 780


func modulate(sn):
	pos3d.x *= deltax
	move_and_slide(sn*pos3d, Vector3.UP)
	pos3d.x = 1


func _movement(dt):
		#print("index=",index,left,right)
		var right=Input.is_action_just_pressed("ui_right")
		var left=Input.is_action_just_pressed("ui_left")
		if (n_opts>=2):
			if (index==n_opts-1 and right):
				modulate(-1)
				index=0
			elif (index==0 and left):
				modulate(1)
				index=n_opts-1
		print("DEBUG=", pos3d, " index=", index)
		if (right and pos3d.x<deltax and (index in range(0, n_opts))):
			modulate(1)
			index+=1
		elif (left and pos3d.x>=1 and (index in range(0, n_opts))):
			modulate(-1)
			index-=1
		
		var confirm = false
		if (Input.is_action_just_pressed("ui_accept")):
			confirm = true
	
		return [confirm,index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var sys_res = _movement(delta)

	if (sys_res[0]==true and sys_res[1]==0):
		print("Primeira opção, selecionar estilo")
	elif (sys_res[0]==true and sys_res[1]==1):
		print("Segunda opção, ir direto pra intro do game")
