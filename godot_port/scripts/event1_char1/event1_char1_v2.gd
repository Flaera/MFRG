extends Spatial


var car_loaded: Object
var curr_car: Object
var camera: Object
var curr_cam: Object
var loser: bool = false
var pts: float = 0.0
var timer: float
var win: int = 0
var golds: int = 0.0
var time_end: float = 0.0


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
	
	timer = 60.0
	get_node("Timer").start(timer) #time in seconds
	get_node("CanvasLayer/Control/Control/Label2/AnimationPlayer").play("anim_run_init_event")


func camTransform():
	#var cam = get_node("Camera")
	curr_cam.translation[0] = curr_car.translation[0]
	curr_cam.translation[2] = curr_car.translation[2]
	curr_cam.translation[1] = 38.0
	curr_cam.rotation_degrees[0] = -90.0
	curr_cam.rotation_degrees[1] = 180.0
	curr_cam.rotation_degrees[2] = 0.0


func winPlay(_delta):
	print("time_end=",time_end)
	if (win==1 and !get_node("CanvasLayer/Control/Control/Label/AnimationPlayer").is_playing()):
		print("AQUI ENTROU")
		get_node("CanvasLayer/Control/Control/Label/AnimationPlayer").play("anim_you_win")
		win=2
	elif (get_node("CanvasLayer/Control/Control/Label/AnimationPlayer").is_playing()):
		golds = lerp(golds,pts,0.1)
		win=3
	elif (win==3):
		golds = lerp(golds,pts,0.1)
		time_end += _delta
		if (time_end>=7.0): get_tree().change_scene("res://scenes/map/map.scn")
	get_node("CanvasLayer/Control/Control/Label").text = "Você venceu!\n\n"+String(golds)+" golds"


func _process(_delta):
	camTransform()
	var time = get_node("Timer").time_left
	var minutes = String(int(time/60))
	var seconds = String(int(time)%60)
	get_node("CanvasLayer/Control/Label").text = minutes+":"+seconds

	get_node("Area/AnimationPlayer").play("anim_end_event")
	
	if (time<=0.0 and loser==false):
		get_node("CanvasLayer/Control/Control/Label3/AnimationPlayer").play("anim_loser_event")
		loser = true
		print("Step1")
	elif (time<=0.0 and loser==true and
	!get_node("CanvasLayer/Control/Control/Label3/AnimationPlayer").is_playing()):
		get_tree().change_scene("res://scenes/map/map.scn")
		print("Step2")
	
	winPlay(_delta)


func _on_Area_body_entered(body):
	if (get_node("Timer").time_left<timer-0.05):
		get_node("Timer").paused = true
		pts = get_node("Timer").time_left*100
		get_node("CanvasLayer/Control/Control/Label").text = "Você venceu!\n\n0.0 golds"
		win = 1
