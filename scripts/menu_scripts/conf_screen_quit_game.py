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

    own["data_perm"] = int(0)
    with open(logic.expandPath("//data_files/data_permission.txt"), 'r') as data_file:
        own["data_perm"] = int(data_file.read())

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
    if (list_opt == [True, 0]
     or (cont.sensors["mo_quit_yes"].positive and logic.mouse.events[events.LEFTMOUSE])):
        try:
            if (own["data_perm"]==1):
                DataBase.SendDB()
        finally:
            logic.endGame()
    elif (list_opt == [True, 1]
     or (cont.sensors["mo_quit_no"].positive and logic.mouse.events[events.LEFTMOUSE])):
        ManagerScenes().OnlyResumeScene(cont, [cont.actuators["resu_mm_opt"]])
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_mcs"]])
        