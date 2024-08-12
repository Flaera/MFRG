from bge import logic, types
from scripts.data_manager import SearchObjProp
from scripts.time_manager import TimeAction1
from scripts.manager_scenes import ManagerScenes


def SetCam(camera):
    curr_scene_objs = logic.getCurrentScene().objects
    pos = curr_scene_objs[camera["car_select"]].localPosition
    camera.applyMovement([pos[0]-camera["last_pos"][0], pos[1]-camera["last_pos"][1], 0], False)


def Start(cont):
    camera = cont.owner
    camera["last_pos"] = camera.localPosition
    try:
        camera["car_select"] = SearchObjProp("car") # It all car in scene have the...
    # property "car"
    except:
        car = open(logic.expandPath("//data_files/car_selected.txt"), "r")
        car_read = car.read()
        camera["car_select"] = car_read.split("\n")[0]

    camera["nitro_activated"] = False
    camera["nitro_inc"] = float(0)  # It's to transform height and max_height at active nitro
    camera["height_max"] = float(48) # It's the same thing that before

    cont.activate(cont.actuators["set_cam"])
    print("acts{}-".format(cont.actuators))
    SetCam(camera)
    #cont.activate(cont.actuators["car_cam"])

    # Calling user interface:
    ManagerScenes().OnlyAddScene("events_ui")

    # WARNING:It script can gengerat errors by be run after...
    # flag car_invoked be equal True.


def Update(cont):
    camera = cont.owner

    car = logic.getCurrentScene().objects[camera["car_select"]]

    SetCam(camera)


  # calling transformation in camera at press button nitro:
    action = TimeAction1(camera["cam_timer"], 10)[0]
    camera["cam_timer"] = TimeAction1(camera["cam_timer"], 10)[1]
    #print(car, " aí car", type(car), car["nitro"], sep=", ")
    #print(car.nitro, camera["car_invoked"], car, "e ai nitro, car_invoked, car")
    # It part of nitro transformation in camera cause the bug. She was removed.
    try:
        if (car.nitro == True):
            camera["nitro_inc"] = 8
            camera["nitro_activated"] = True
        elif (car.nitro == False) and (camera["nitro_activated"] == True) \
                and (action == True)\
                and ((camera["height_max"]+camera["nitro_inc"]) >= camera["height_max"]):
            camera["nitro_inc"] -= float(0.5)
            if ((camera["height_max"]+camera["nitro_inc"]) <= camera["height_max"]):
                camera["nitro_inc"] = 0
                camera["nitro_activated"] = False
    except:
        pass
