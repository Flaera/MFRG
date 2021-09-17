import bge
from bge import logic, types
from scripts.data_manager import SearchAssetWithProxie
from scripts.time_manager import TimeAction1


def CallCarAsset(invo):
    car = open(bge.logic.expandPath("//data_files/car_selected.txt"), "r")
    car_proxie_selected = car.readline()
    print("Car_proxie selected: -{}-".format(car_proxie_selected))

    car_proxie_selected = car_proxie_selected.replace('\n', '\0')
    print("edited - Car_proxie selected: -{}-".format(car_proxie_selected))

    car_selected = SearchAssetWithProxie(car_proxie_selected)
    print("Car_selected -only asset-: -{}-".format(car_selected))
    curr_scene = logic.getCurrentScene()
    ina_objs = logic.getCurrentScene().objectsInactive
    #print("Objs inactives in curr scene: ", ina_objs)
    
    car.close()

    if (car_selected in ina_objs):
        car_asset_selected = curr_scene.addObject(car_selected, invo, 0)
        invo["car_asset_selected"] = car_asset_selected
        print("Car finded in inactive layers!")
    else:
        print("Car not find in inactive layers!")


def Start():
	cont = logic.getCurrentController()
	own = cont.owner
    
	child = own.children
	own["child"] = child[0]
	print("children: {}".format(child[0]))

	delta_px = float(0)
	own["delta_py"] = float(-15) #-15; ray of circunference
	own["delta_pz"] = float(2.0) #1.0-1.5-4.5, min, mid and max
	own["delta_rx"] = float(89.5) #89.5-89.3, min and max
	delta_ry = float(0)
	delta_rz = float(0)
	own["child"].applyRotation([own["delta_rx"], delta_ry, delta_rz], 0)
    # child[0].worldOrientation = [delta_rx, delta_ry, delta_rz]
	own["child"].applyMovement([delta_px, own["delta_py"], own["delta_pz"]], 0)

	curr_scene = logic.getCurrentScene()
	car_invokator = curr_scene.objects["car_invokator"]
	CallCarAsset(car_invokator)

	ground_inclination_x = float(-0.03)
	ground_inclination_y = float(0.04)
	car_invokator["car_asset_selected"].applyRotation([ground_inclination_x,
		ground_inclination_y, 0], 0)
	
	own["time_action"] = float(0.0)

	own["rot_pz"] = float(0.0)
	#own["max_ang_z"] = float(4*1.5720030069351196)
	own["delta_time_z"] = 0.4 # time in decseconds to the cam make one loop
	own["max_ang_z"] = float(4*1.5720030069351196)
	#cam_transform rotation in z in decimates seconds:
	own["rot_vz"] = float(own["max_ang_z"]/own["delta_time_z"])/1000.0	
	#own["max_ang_z"] = float(2*3.14*own["delta_py"]*-1) #circufenrece
	#cam rotation in x:
	own["height_z"] = float(0.0)
	own["last_rot_x"] = float(0.0)
	#own["time_rz"] = float(1.0)
	print("max ang z=", own["max_ang_z"])

	garage_ui = cont.actuators["in_garage_ui"]
	cont.activate(garage_ui)


def SetCamHeightZ(own, x):
	#I HAVE APPLY THE FUNCTION OF TYPE F(X) = X^2 - BX + 0
	'''
	factor = float(1.2)
	delta_z = float(own["max_ang_z"]/own["delta_time_z"])/1000
	if ((x<own["max_ang_z"]-own["max_ang_z"]/4.0) and (x>own["max_ang_z"]/4.0)):
		return -factor*delta_z
	return factor*delta_z
	'''
	factor = float(230.0)
	peak = float(own["max_ang_z"]/2.0)
	x = x - float(own["max_ang_z"]/2.0)
	y = float(1.0*(x**2) - peak)# - peak)#float(own["max_ang_z"]/own["delta_time_z"])/1000	
	dz = float(y-own["height_z"])/factor
	own["height_z"] += dz
	#print("dz=", y, "x=", x)
	if (own["height_z"]<0.0):
		#print("Step 1")
		return dz
	elif own["height_z"]>=0.0:
		#print("Step 2")
		return dz
	#print("Step 3")
	return float(0.0)


def SetCamRotX(own,rot_pz=float(0.0)):
	a = float(0.0015)
	peak = float(own["max_ang_z"]/4.0+own["max_ang_z"]/8.0)
	#print("rotpz=", rot_pz)
	if rot_pz>=0.0 and rot_pz<peak:
		#print("Stage 1!!")
		own["last_rot_x"] += a
		a = float(a*-1.0)
		return a
	elif rot_pz>=peak and own["last_rot_x"]>float(0.000000):
		#print("Stage 2!!")
		own["last_rot_x"] -= a
		return a
	else:
		#print("Stage 3!!")
		return 0.0
	'''
	Implementaion with function of second degree:
	y = float(a*(rot_pz**2))

	delta_y = float(own["last_rot_x"]-y)
	own["last_rot_x"] = y
	#print("quad=", quad, end='')
	print("dy=", delta_y)
	return delta_y/10.0
	'''


def Update(cont):
	own = cont.owner

	# Controller of time:
	action = TimeAction1(own["time_action"])
	own["time_action"] = action[1]

	#To control rotation in axis z:
	if (own["rot_pz"]<own["max_ang_z"]) and (action[0]==True):
		#if (own.worldOrientation[0][0])>0.0:
		own["rot_pz"] += own["rot_vz"]#(abs(own.worldOrientation[0][0]))
		#print("rot_pz= ", own["rot_pz"])
		#print("world_ori = ", own.worldOrientation[0][0])
		angle_velocity = [0, 0, own["rot_vz"]]
		own.applyRotation(angle_velocity, 0)
		velo_pos = [0.0, 0.0, SetCamHeightZ(own, own["rot_pz"])]
		own["child"].applyMovement(velo_pos, False)
		own["child"].applyRotation([SetCamRotX(own, own["rot_pz"]), 0.0, 0.0], 1)
	elif own["rot_pz"]>=own["max_ang_z"]:
		#print("Reload!! rot_pz= ", own["rot_pz"])
		own["rot_pz"]=float(0.0000)
		

