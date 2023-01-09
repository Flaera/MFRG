extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
class ConfirmationScreen:
	var n_opt
	var deltax
	var index = 0
	var pos3d

	func _init(var number_options=2, var delta_x=4.5):
		n_opt = number_options
		deltax = delta_x
		pos3d = Vector3.ZERO


	func _ready():
		pass # Replace with function body.

			
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass
