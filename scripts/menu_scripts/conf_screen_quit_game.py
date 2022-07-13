from bge import logic, events
from scripts.menu_scripts.menu_horizontal import ConfirmationMenuScreen
from scripts.manager_scenes import ManagerScenes
from data_files.warnings import warnings
from scripts.sqlite3.connection_sqlite import DataBase


def Start(cont):
    own = cont.owner

    current_scene = logic.getCurrentScene()
    text_obj = current_scene.objects["text_conf_screen"]

    text = warnings['0']

    text_obj["Text"] = text

    ConfirmationMenuScreen(own)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    confirm = keys[events.ENTERKEY] == tap
    left    = keys[events.LEFTARROWKEY] == tap
    right   = keys[events.RIGHTARROWKEY] == tap

    list_opt = own.ActiveMenuConfScreen(confirm, left, right)
    #print("conf_list_opt:", list_opt)
    if list_opt == [True, 0]:
        DataBase.SendDB()
        logic.endGame()
    elif list_opt == [True, 1]:
        ManagerScenes().OnlyResumeScene(cont, [cont.actuators["resu_mm_opt"]])
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_mcs"]])
        