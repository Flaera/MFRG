extends KinematicBody


const cs0 = preload("res://scripts/menus/confirmation_screen.gd").ConfirmationScreen
onready var cs1 = cs0.new()

func saveStyleDefault():
	var file = File.new()
	file.open("res://data_files/style.dat", File.WRITE)
	file.store_string("Anne9")
	file.close()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	saveStyleDefault()
	#conf_screen = ConfirmationScreen.new()


func _physics_process(delta):
	var sys_res = cs1.controlIndex()
	move_and_slide(sys_res[2],Vector3.UP)
	#var mouse1 = get_node("Sprite3D/Viewport/Button_yes").is
	if (sys_res[0]==true and sys_res[1]==0):
		print("Primeira opção, selecionar estilo")
		#get_tree().change_scene()
	elif (sys_res[0]==true and sys_res[1]==1):
		print("Segunda opção, ir direto pra intro do game")
		#get_tree().change_scene()
