extends Spatial


var lilas: Object


func _ready():
	lilas = preload("res://scenes/cars/lilas/lilas_v2.scn")
	get_node("finish/AnimationPlayer").play("finish_action.001")
	#pos = get_node("car_invoker").translation
	#set_process(true)
	var curr_car = lilas.instance()
	get_node("car_invoker").add_child(curr_car)

