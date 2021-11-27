from bge import events, logic
from scripts.menu_scripts.menu_horizontal import HardMenuHorizontal
from scripts.manager_scenes import ManagerScenes


cont = logic.getCurrentController()


def Start(cont):
	own = cont.owner
	scene = logic.getCurrentScene()
	filec = open(logic.expandPath("//data_files/player_cars.txt"), 'r', encoding="utf-8")
	file_cars = filec.readlines()
	print("filescars:", file_cars)	
	#cars = []
	#cars = file_cars.split('\n')
	alert_hollow = str("-- Vazio --")
	try:
		scene.objects["opt0_car_sel"]["Text"] = file_cars[0].split('_')[0].upper()
		own["pos0_ishollow"] = False
	except:
		scene.objects["opt0_car_sel"]["Text"] = alert_hollow
		own["pos0_ishollow"] = True
	try:
		scene.objects["opt1_car_sel"]["Text"] = file_cars[1].split('_')[0].upper()
		own["pos1_ishollow"] = False
	except:
		print("AQUI PQ N!!!")
		scene.objects["opt1_car_sel"]["Text"] = alert_hollow
		own["pos1_ishollow"] = True
	try:
		scene.objects["opt2_car_sel"]["Text"] = file_cars[2].split('_')[0].upper()
		own["pos2_ishollow"] = False
	except:
		scene.objects["opt2_car_sel"]["Text"] = alert_hollow
		own["pos2_ishollow"] = True

	garage_sel = scene.objects["garage_selector"]	
	own["garage_menu"] = HardMenuHorizontal(garage_sel, 3, -1.94)
	filec.close()
	
	own["old_index_car"] = int(0)
	own["one_time"] = int(0)

	own["manager_scenes"] = ManagerScenes()

	#garage_ui = cont.actuators["in_garage_ui"]
	#cont.activate(garage_ui)	
	#re_loading = cont.actuators["re_loading"]
	#cont.activate(re_loading)



def SwapCars(opts, own):
	if (own["one_time"]==0):
		scene_list = logic.getSceneList()
		#print("scene_list: ", scene_list)

		filec = open(logic.expandPath("//data_files/player_cars.txt"), 'r', encoding="utf-8")
		file_cars = filec.readlines()
		#deleta objeto:
		file_car_sel = open(logic.expandPath("//data_files/car_selected.txt"), 'r', encoding="utf-8")
		fcar_selected = file_car_sel.read()
		print("fcar_selected:", fcar_selected)
		index_garage = int(1)
		for i in range(0, len(scene_list)):
			if scene_list[i]=="like_garage":
				index_garage = i
				break
		current_car = fcar_selected.split("_")[0]+"_only_asset\0"
		scene_list[index_garage].objects[current_car].endObject()
		file_car_sel.close()
		#reescre objeto:
		if (opts[1] < len(file_cars)):
			file_car_sel = open(logic.expandPath("//data_files/car_selected.txt"), 'w', encoding="utf-8")
			file_car_sel.write(file_cars[opts[1]])
			#chama objeto reescrito:
			current_car_asset = file_cars[opts[1]].split("_")[0]+"_only_asset\0"
			print("curr car asset:-{}-".format(current_car_asset))
			scene_list[index_garage].addObject(current_car_asset, "car_invokator")
			file_car_sel.close()
			own["old_index_car"] = opts[1]
		else:
			#chama objeto reescrito:
			current_car_asset = file_cars[own["old_index_car"]].split("_")[0]+"_only_asset\0"
			scene_list[index_garage].addObject(current_car_asset, "car_invokator")
		#fecha os arquivos restantes:
		filec.close()
		own["one_time"] = 1


def Update(cont):
	own = cont.owner
	scene = logic.getCurrentScene()

	garage_sel = scene.objects["garage_selector"]
	left = cont.sensors["left"].positive
	right = cont.sensors["right"].positive
	enter_key = cont.sensors["enter_key"].positive
	if (left==True or right==True):
		own["one_time"] = 0

	#print("second file cars list:", file_cars)
	opts = []
	opts = own["garage_menu"].ActiveHardMenuHoriControl(enter_key, left, right)
	SwapCars(opts, own)
	
	re_like_garage = cont.actuators["re_like_garage"]
	re_garage_ui = cont.actuators["re_garage_ui"]
	re_specs = cont.actuators["re_specs"]
	if (opts[0] == True and own["pos0_ishollow"]==False):
		own["manager_scenes"].OnlyAddScene("map")
		own["manager_scenes"].OnlyRemoveScenes(cont, [re_like_garage, re_garage_ui, re_specs])
	elif (opts[0] == True and own["pos1_ishollow"]==False):
		own["manager_scenes"].OnlyAddScene("map")
		own["manager_scenes"].OnlyRemoveScenes(cont, [re_like_garage, re_garage_ui, re_specs])
	elif (opts[0] == True and own["pos2_ishollow"]==False):
		own["manager_scenes"].OnlyAddScene("map")
		own["manager_scenes"].OnlyRemoveScenes(cont, [re_like_garage, re_garage_ui, re_specs])


