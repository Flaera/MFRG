extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
class ConfirmationScreen:
	var n_opt
	var deltax
	var index = 0


	func ConfirmationScreen(var button, var number_options=2, var delta_x=0.5):
		n_opt = number_options
		deltax = delta_x


	func applyTranslate():
		if (n_opt>=2):
			if (index==n_opt-1):
				index=0
			elif (index==0):
				index=n_opt-1


	func _ready():
		pass # Replace with function body.


	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass
