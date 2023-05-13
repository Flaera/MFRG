extends Spatial


var lilas: Object
var cam: Object
var curr_car: Object

func _ready():
	lilas = preload("res://scenes/cars/lilas/lilas_v2.scn")
	curr_car = lilas.instance()
	get_node("car_invoker").add_child(curr_car)

