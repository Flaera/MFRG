from bge import logic, types, events
from scripts.manager_scenes import ManagerScenes


def Start(cont):
    invoker = cont.owner
    current_scene = logic.getCurrentScene()

    # deactivating flags:
    current_scene.objects["camera01"]["car_invoked"] = False
    current_scene.objects["sun01"]["car_invoked"] = False
    current_scene.objects["invoker_dust0"]["car_invoked"] = False
    current_scene.objects["invoker_dust1"]["car_invoked"] = False
    current_scene.objects["invoker_dust2"]["car_invoked"] = False
    current_scene.objects["invoker_dust3"]["car_invoked"] = False

    # Calling car selected:
    car_selected = open(logic.expandPath("//data_files/car_selected.txt"), "r", encoding="utf-8")

    string_car = car_selected.read()
    print("car=", string_car, sep='-', end='-')
    car_list = string_car.split('\n')
    print("list of cars: ", car_list) 
    car_selected_obj = current_scene.objectsInactive[car_list[0]]
    
    current_scene.addObject(car_selected_obj, invoker, 0)
    # Activating flags:
    current_scene.objects["camera01"]["car_invoked"] = True
    current_scene.objects["sun01"]["car_invoked"] = True
    current_scene.objects["invoker_dust0"]["car_invoked"] = True
    current_scene.objects["invoker_dust1"]["car_invoked"] = True
    current_scene.objects["invoker_dust2"]["car_invoked"] = True
    current_scene.objects["invoker_dust3"]["car_invoked"] = True

    car_selected.close()
    invoker["manager_scenes"] = ManagerScenes()

    cont.activate(cont.actuators["dai_a_cesar_o_que_e_de_cesar"])


def Update(cont):
    own = cont.owner
    keyboard = logic.keyboard
    tap = logic.KX_INPUT_JUST_ACTIVATED
    if (keyboard.events[events.ENTERKEY]==tap) == True:
        own["manager_scenes"].OnlyAddScene("menu_pause_event2_char1")
        own["manager_scenes"].OnlyPauseScene(cont, [cont.actuators["pa_event2_char1"]])

    col_finish = cont.sensors["col_finish.001"].positive
    if (col_finish==True):
        own["manager_scenes"].OnlyAddScene("finish_event2_char1")
        own["manager_scenes"].OnlyPauseScene(cont, [cont.actuators["pa_event2_char1"]])