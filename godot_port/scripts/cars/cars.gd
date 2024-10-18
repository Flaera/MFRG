class_name Cars


var acceleration: float
var max_torque: float
var top_speed: float
var velocity: float
var max_rpm: float
var delta_nitro_inc: float
var delta_nitro_dec: float
var move: bool
var fully_nitro: float
var nitro_max: float
func _init(accel, rpmm, torque, nm, mv=true):
	acceleration = accel
	max_torque = torque
	max_rpm = rpmm
	velocity = 0.0
	nitro_max = nm
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
	var cast_particles_nitro: bool = false
	if (move==true):
		steering = lerp(steering, axis.x*0.6, 6*delta_time)
		var accel_dir: float = axis.y * acceleration * delta_time
		
		#pedal control:
		#if (axis.y==-1):
		#	accel/=2
		#print("NITRO=", boost_button)
		if (boost_button==true and axis.y==-1 and
		 fully_nitro>0.0):
			accel_dir = accel_dir * (10)
			fully_nitro -= delta_nitro_dec * delta_time
			#steering = lerp(steering, axis.y, 5*delta_time)
			cast_particles_nitro = true
		elif (fully_nitro<nitro_max):
			cast_particles_nitro = false
			fully_nitro += delta_nitro_inc * delta_time
		#print(" -- ", accel, " -- ", 33.02*0.001885*max_rpm)
		var rpm0 = back_wheel1.get_rpm()
		var rpm1 = back_wheel2.get_rpm()
		#if (rpm0>=max_torque or rpm1>=max_torque):
		#	back_wheel1.engine_force = max_torque
		#	back_wheel2.engine_force = max_torque
		#else:
		#GEAR REVERSE:
		#var last_gear: int = 1
		if (axis.y>0.0 and abs(rpm0)<max_torque/2):
			back_wheel1.engine_force += 1 * abs(accel_dir) * max_torque * abs(1-rpm0/max_rpm)
			back_wheel2.engine_force += 1 * abs(accel_dir) * max_torque * abs(1-rpm1/max_rpm)
			#last_gear = axis.y
		#ACCELERATION:
		elif (axis.y<0.0 and abs(rpm0)<max_torque*2.3):
			back_wheel1.engine_force += -1 * abs(accel_dir) * max_torque * abs(1-rpm0/max_rpm)
			back_wheel2.engine_force += -1 * abs(accel_dir) * max_torque * abs(1-rpm1/max_rpm)
			#last_gear = axis.y
		#TO STOP THE CAR:
		else:
			back_wheel1.engine_force = 0#last_gear * abs(accel_dir) * max_torque * abs(1-rpm1/max_rpm)
			back_wheel2.engine_force = 0#last_gear * abs(accel_dir) * max_torque * abs(1-rpm1/max_rpm)
		#print("|", abs(rpm0), "|", max_torque, "|", "|")


		if (brake_on==true):
			brake_force += 1000*(acceleration/2)*delta_time
		else:
			brake_force = 0.0


	var result = [brake_force, steering, fully_nitro, cast_particles_nitro]
	return result
