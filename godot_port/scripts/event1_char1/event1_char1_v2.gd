extends Spatial


var car_loaded: Object
var curr_car: Object
var camera: Object
var curr_cam: Object
var loser: bool = false


func _ready():
	var file = File.new()
	file.open("res://data_files/car_selected.txt",File.READ)
	var car = file.get_csv_line()[0]
	car_loaded = load("res://scenes/cars/"+car+".scn")
	file.close()
	curr_car = car_loaded.instance()
	get_node("car_invoker").add_child(curr_car)

	camera = preload("res://scenes/camera/camera.scn")
	curr_cam = camera.instance()
	get_node("car_invoker").add_child(curr_cam)
	
	get_node("Timer").start(5.0) #time in seconds
	get_node("CanvasLayer/Control/Control/AnimationPlayer").play("anim_init_event")


func camTransform():
	#var cam = get_node("Camera")
	curr_cam.translation[0] = curr_car.translation[0]
	curr_cam.translation[2] = curr_car.translation[2]
	curr_cam.translation[1] = 38.0
	curr_cam.rotation_degrees[0] = -90.0
	curr_cam.rotation_degrees[1] = 180.0
	curr_cam.rotation_degrees[2] = 0.0


func _process(_delta):
	camTransform()
	var time = get_node("Timer").time_left
	var minutes = String(int(time/60))
	var seconds = String(int(time)%60)
	get_node("CanvasLayer/Control/Label").text = minutes+":"+seconds

	if (time<=0.0 and loser==false):
		get_node("CanvasLayer/Control/Control/AnimationPlayer2").play()
	elif (time<=0.0 and
	!get_node("CanvasLayer/Control/Control/AnimationPlayer2").is_playing()):
		get_tree().change_scene("res://scenes/map/map.scn")
