from bge import logic, types
from scripts.data_manager import SearchObjProp
from scripts.time_manager import TimeAction1


def Start(cont):
    own = cont.owner

    scene_list = logic.getSceneList()
    event_scene = scene_list[0]
    own["car_name"] = SearchObjProp("car", scene=event_scene.objects)
    
    own["cursor"] = logic.getCurrentScene().objects["EmptyPonteiro"]
    own["speed0"] = float(0)
    own["speed1"] = float(0)
    own["current_position"] = float(0)
    own["delta"] = float(0)
    own["max_position"] = float(88)

    own["bar"] = logic.getCurrentScene().objects["nitro_bar_current"]


def Update():
    cont = logic.getCurrentController()
    own = cont.owner

    scene_list = logic.getSceneList()
    event_scene = scene_list[0]
    car = event_scene.objects[own["car_name"]]
    car_speed = car.speed_result
    logic.getCurrentScene().objects["speed"]["Text"] = int((3.6)*car_speed)

    # To move cursor and bar of nitro:
    own["speed1"] = car_speed
    time_result = [TimeAction1(own["timer_ui"])[0], TimeAction1(own["timer_ui"])[1]]
    own["timer_ui"] = time_result[1]
    
    #print("e api tempo: ", time_result)
    if (time_result[0] == 1) and (own["current_position"] < own["max_position"]):
        own["delta"] = own["speed1"] - own["speed0"]        
        if not((own["current_position"] + own["delta"]) < 0.0):
            own["current_position"] += own["delta"]
        else: own["current_position"] = float(0)
        own["speed0"] = own["speed1"]
        #print(own["delta"], "1 e aí delta\n")
    elif (time_result[0] == 1) and (own["current_position"] >= own["max_position"]):
        own["delta"] = own["speed1"] - own["speed0"]
        own["current_position"] = own["max_position"]
        own["speed0"] = own["speed1"]
        #print(own["delta"], "2 e aí delta\n")
    else: own["delta"] = float(0.0)

    #print(own["delta"], "3 e aí delta\n")
    # It's multiply by -1 for invert direction rotation:
    # min: 0.0; max: -3.95
    own["cursor"].applyRotation([0, 0, ((-3.95*own["delta"]) / 88)], 0)

    # Bar nitro immplementaion:
    own["bar"]["nitro_fully"] = 50-car.nitro_fully
    #It upodate the value of property for the next logic bricks activate...
    # animation of bar nitro
    
    