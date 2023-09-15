class_name Cars


var acceleration: float
var max_torque: float
var top_speed: float
var nitro_max: float
var velocity: float
var max_rpm: float
var fully_nitro: float
var delta_nitro_inc: float
var delta_nitro_dec: float
var move: bool
func _init(accel, rpmm, torque, nm, mv=true):
	acceleration = accel
	max_torque = torque
	max_rpm = rpmm
	nitro_max = nm
	velocity = 0.0
	fully_nitro = nm
	delta_nitro_inc = 2.0
	delta_nitro_dec = 15.0
	move = mv


func getMove():
	var file = File.new()
	file.open("res://data_files/play_car.txt", File.READ)
	move = bool(file.get_line())
	return move


func setMove(var move_flag: bool):
	var file = File.new()
	file.open("res://data_files/play_car.txt", File.WRITE)
	var move_add = file.store_line(move_flag)
	move = move_add


func mainCarPhys(axis, boost_button, back_wheel1, back_wheel2, brake_on,
 brake_force, steering, delta_time):
	var rpm: float = 0.0
	if (move==true):
		steering = lerp(steering, axis.x*0.4, 5*delta_time)
		var accel: float = axis.y * acceleration
		
		#pedal control:
		if (axis.y==-1):
			accel/=2
		
		if (boost_button==true and fully_nitro>0.0):
			accel = axis.y * (acceleration * 1000)
			#steering = lerp(steering, axis.y, 5*delta_time)
			fully_nitro -= delta_nitro_dec * delta_time
		elif (fully_nitro<nitro_max):
			fully_nitro += delta_nitro_inc * delta_time
		#print(" -- ", accel, " -- ", 33.02*0.001885*max_rpm)
		rpm = back_wheel1.get_rpm()
		back_wheel1.engine_force = accel * max_torque * (1-rpm/max_rpm)
		rpm = back_wheel2.get_rpm()
		back_wheel2.engine_force = accel * max_torque * (1-rpm/max_rpm)

		if (brake_on==true):
			brake_force += 1000*(acceleration/2)*delta_time
		else:
			brake_force = 0.0


	var result = [brake_force, steering, fully_nitro]
	return result
