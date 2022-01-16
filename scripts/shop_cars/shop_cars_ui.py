from bge import logic, events
from data_files.car_general_infos import cars
from scripts.shop_cars.shop_system import CarShop


def Start(cont):
    own = cont.owner
    scene_list = logic.getSceneList()
    index_shop = 1
    for i in range(len(scene_list)):
        if scene_list[i] == "shop_cars":
            index_shop = i
            break

    max_cars = len(cars)
    current_key = '0'

    first_car = cars[current_key][0].split('_')[0]+"_only_asset"
    current_car = scene_list[index_shop].addObject(first_car, "logic_point")
    #print("Duas vezes!!??")

    car_shop = CarShop(own, index_shop, current_key, current_car, max_cars)
    car_shop.OnlyAddScene("gold_board")


def Update(cont):
    own = cont.owner
    #print("current_car: ", own["current_car"])
    #try:
    
    #except:
     #   own["Text"] = cars[own["current_key"]][0].split('_')[0].upper()
    scene = logic.getCurrentScene()
    scn_objs = scene.objects
    scn_objs["car_price"]["Text"] = str(cars[own.GetCurrentKey()][1])
    scn_objs["car_sel"]["Text"] = own.GetCurrentCar().name.split('_')[0].upper()
    
    keyboard = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED
    enter = keyboard[events.ENTERKEY]==tap
    left = keyboard[events.LEFTARROWKEY]==tap
    right = keyboard[events.RIGHTARROWKEY]==tap
    one = keyboard[events.ONEKEY]==tap

    if (one==True):
        own.OnlyAddScene("map")
        own.OnlyRemoveScenes(cont, [cont.actuators["re_gb"], cont.actuators["re_shop"],
         cont.actuators["re_shop_ui"]])
    elif (left==True):
        own.ToLeft()
        own.SwapCars()
    elif (right==True):
        own.ToRight()
        own.SwapCars()
    elif (enter==True):
        own.SellCar(cont)
