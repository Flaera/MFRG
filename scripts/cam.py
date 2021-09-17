from bge import logic, types
from scripts.data_manager import SearchObjProp
from scripts.time_manager import TimeAction1
from scripts.manager_scenes import ManagerScenes


#def CamActActivate(controller, damping, axis, min, max, height, obj):
    # It implement this function before end this script.
    # MODULARIZAR ISSO!! IMPORTANTE!!


def Start(cont):
    camera = cont.owner

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
    act_cam = cont.actuators["car_cam"]
    act_cam.damping = 0.03
    act_cam.axis = 1
    act_cam.min = 38
    act_cam.max = camera["height_max"] + camera["nitro_inc"]
    act_cam.height = camera["height_max"] + camera["nitro_inc"]
    act_cam.object = logic.getCurrentScene().objects[camera["car_select"]]
    cont.activate(act_cam)
    #cont.activate(cont.actuators["car_cam"])

    # Calling user interface:
    ManagerScenes().OnlyAddScene("events_ui")

    # WARNING:It script can gengerat errors by be run after...
    # flag car_invoked be equal True.


def Update(cont):
    camera = cont.owner

    car = logic.getCurrentScene().objects[camera["car_select"]]

    #delta_posx = 0
    #delta_posy = 0
    #delta_posz = 0

    #camera.localPosition = [car.localPosition.x+delta_posx,
     #                       car.localPosition.y+delta_posy,
      #                      camera.localPosition.z+delta_posz]
    # Eu queria fazer uma camera que seguisse o carro sem rotacoes e com inclinações,...
    # mas como nao conseguir imaginar em algo simples pra isso. Tipo uma camera ficxa,...
    # isometrica. Recorri ao controle do actuator...
    # camera

    act_cam = cont.actuators["car_cam"]
    act_cam.damping = 0.03
    act_cam.axis = 1
    act_cam.min = 38
    act_cam.max = camera["height_max"] + camera["nitro_inc"]
    act_cam.height = camera["height_max"] + camera["nitro_inc"]
    act_cam.object = car
    cont.activate(act_cam)


  # calling transformation in camera at press button nitro:
    action = TimeAction1(camera["cam_timer"], 10)[0]
    camera["cam_timer"] = TimeAction1(camera["cam_timer"], 10)[1]
    #print(car, " aí car", type(car), car["nitro"], sep=", ")
    #print(car.nitro, camera["car_invoked"], car, "e ai nitro, car_invoked, car")
    # It part of nitro transformation in camera cause the bug. She was removed.
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
    
