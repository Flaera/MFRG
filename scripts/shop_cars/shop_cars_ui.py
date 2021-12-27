from bge import logic, events
from data_files.car_general_infos import cars
from scripts.manager_scenes import ManagerScenes


def Start(cont):
    own = cont.owner
    scene_list = logic.getSceneList()
    own["index_shop"] = 1
    for i in range(len(scene_list)):
        if scene_list[i] == "shop_cars":
            own["index_shop"] = i
            break

    own["max_cars"] = len(cars)
    own["current_key"] = '0'
    first_car = cars[own["current_key"]][0].split('_')[0]+"_only_asset"
    own["current_car"] = scene_list[own["index_shop"]].addObject(first_car, "logic_point")
    ManagerScenes().OnlyAddScene("gold_board")


def SellCar(own, cont):

    gold_int = 0
    with open(logic.expandPath("//data_files/gold.txt"), 'r') as gold_file:
        gold_str = gold_file.read()
        gold_int = int(gold_str)
    
    amount_cars = 0
    car_str = []
    with open(logic.expandPath("//data_files/player_cars.txt"), 'r') as car_file:
        car_str = car_file.readlines()
        amount_cars = int(len(car_str))
    print("cars vec=", car_str)
    if (amount_cars==3):
        ManagerScenes().OnlyAddScene("conf_screen_fully_garage")
        ManagerScenes().OnlyPauseScene(cont, [cont.actuators["pau_shop"],
         cont.actuators["pau_shop_ui"]])
        return 1
    elif (gold_int<cars[own["current_key"]][1]):
        ManagerScenes().OnlyAddScene("conf_screen_no_money")
        ManagerScenes().OnlyPauseScene(cont, [cont.actuators["pau_shop"],
         cont.actuators["pau_shop_ui"]])
        return 2
    else:
        for i in car_str:
            if (i.split('_')[0]==own["current_car"].name.split('_')[0]):
                ManagerScenes().OnlyAddScene("conf_screen_already_car")
                ManagerScenes().OnlyPauseScene(cont, [cont.actuators["pau_shop"],
                 cont.actuators["pau_shop_ui"]])
                return 3

    gold_int = gold_int-cars[own["current_key"]][1]
    with open(logic.expandPath("//data_files/gold.txt"), 'w') as gold_file:
        gold_file.write(str(gold_int))
    with open(logic.expandPath("//data_files/player_cars.txt"), 'a') as cars_file:
        cars_file.write(own["current_car"].name.split('_')[0]+"_proxie\n")
    return 4
        

def SwapCars(own):
    scene_list = logic.getSceneList()
    own["current_car"].endObject()
    car = cars[own["current_key"]][0].split('_')[0]+"_only_asset"
    own["current_car"] = scene_list[own["index_shop"]].addObject(car, "logic_point")


def Update(cont):
    own = cont.owner
    #print("current_car: ", own["current_car"])
    own["Text"] = own["current_car"].name.split('_')[0].upper()

    keyboard = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED
    enter = keyboard[events.ENTERKEY]==tap
    left = keyboard[events.LEFTARROWKEY]==tap
    right = keyboard[events.RIGHTARROWKEY]==tap
    one = keyboard[events.ONEKEY]==tap

    if (one==True):
        ManagerScenes().OnlyAddScene("map")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_gb"], cont.actuators["re_shop"],
         cont.actuators["re_shop_ui"]])
    elif (left==True):
        curr = int(own["current_key"])
        curr -= 1
        if curr < 0:
            curr = own["max_cars"]-1
        own["current_key"] = str(curr)
        SwapCars(own)
    elif (right==True):
        curr = int(own["current_key"])
        curr += 1
        if curr >= own["max_cars"]:
            curr = 0
        own["current_key"] = str(curr)
        SwapCars(own)
    elif (enter==True):
        SellCar(own, cont)
