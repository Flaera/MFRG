from bge import logic, events
from scripts.menu_scripts.menu_lista import MenuLista
# IT'S IN DEVELOPMENT!!

def Start(cont):
    own = cont.owner

    selector = MenuLista(own, 3)

    # to active the animation of dar screen!!
    bg_dark_screen = logic.getCurrentScene().objects["mmap_dark_screen"]
    bg_dark_screen.playAction("map_menu_dark_screen", 1, 30)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap  = logic.KX_INPUT_JUST_ACTIVATED
    confirm = keys[events.ENTERKEY] == tap
    up      = keys[events.UPARROWKEY] == tap
    down    = keys[events.DOWNARROWKEY] == tap

    # Response of system/class:
    sys_res = own.ActivateMenuControl(confirm, up, down)
    # To enable the optionss for transtion with loading scene:
    own.TimeChangeScene(confirm, own["dtime_menu_map"], 0.5)

    if (sys_res == [True, 0]):
        own.OnlyAddScene("like_garage")
        own.OnlyRemoveScenes(cont, [cont.actuators["re_gold"], cont.actuators["re_map_smh"],
                                    cont.actuators["re_map_menu"], cont.actuators["re_map"]])
    elif (sys_res == [True, 1]):
        own.OnlyAddScene("shop_cars")
        own.OnlyRemoveScenes(cont, [cont.actuators["re_gold"], cont.actuators["re_map_smh"],
                                    cont.actuators["re_map_menu"], cont.actuators["re_map"]])
    elif (sys_res == [True, 2]) and (own.action_load == True):
        own.OnlyResumeScene(cont, [cont.actuators["res_map"],
                                   cont.actuators["res_map_smh"]])
        own.OnlyRemoveScenes(cont, [cont.actuators["re_map_menu"]])


