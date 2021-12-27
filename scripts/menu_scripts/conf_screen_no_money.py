from bge import logic, events
from scripts.menu_scripts.menu_horizontal import ConfirmationMenuScreen
from scripts.manager_scenes import ManagerScenes
from data_files.warnings import warnings

def Start(cont):
    own = cont.owner

    current_scene = logic.getCurrentScene()
    text_obj = current_scene.objects["text_conf_screen.006"]

    text = warnings['6']

    text_obj["Text"] = text

    #selector = ConfirmationMenuScreen(own)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    confirm = keys[events.ENTERKEY] == tap
    #left    = keys[events.LEFTARROWKEY] == tap
    #right   = keys[events.RIGHTARROWKEY] == tap

    #list_opt = own.ActiveMenuConfScreen(confirm, left, right)

    if (confirm==True):
        ManagerScenes().OnlyResumeScene(cont, [cont.actuators["resu_shop_cars"],
         cont.actuators["resu_shop_cars_ui"]])
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_no_money"]])
