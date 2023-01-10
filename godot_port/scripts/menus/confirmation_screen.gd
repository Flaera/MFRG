extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
class ConfirmationScreen extends KinematicBody:
	var n_opts
	var index
	var pos3d
	var deltax


	func _init(var number_options=2, var delta_x=540):
		pos3d = Vector3.ZERO
		index = 0
		n_opts = number_options
		deltax = delta_x
	
	func getNOpts():return n_opts
	func getIndex():return index
	func getDeltaX():return deltax
	func setNOpts(var n: int): n_opts=n
	func setIndex(var n: int): index=n
	func setDeltaX(var n: int): deltax=n
	
	
	func controlIndex():
		#print("index=",index,left,right)
		var right=Input.is_action_just_pressed("ui_right")
		var left=Input.is_action_just_pressed("ui_left")
		if (getNOpts()>=2):
			if (right and getIndex()<getNOpts()-1):
				pos3d.x = getDeltaX()
				setIndex(getIndex()+1)
			elif (left and getIndex()>0):
				pos3d.x = -getDeltaX()
				setIndex(getIndex()-1)
			else:
				pos3d.x = 0
		#print("DEBUG=", pos3d, " index=", index)

		var confirm = false
		if (Input.is_action_just_pressed("ui_accept")):
			confirm = true
		
		var index_return = 0
		if (getIndex()%2==0):
			index_return = 1
		return [confirm, index_return, pos3d]
	
	
	func printMe():
		print("Hello, Gdscript!")
