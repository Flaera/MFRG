from bge import logic, events
from scripts.manager_scenes import ManagerScenes
from scripts.menu_scripts.menu_lista import MenuLista
from scripts.sqlite3.connection_sqlite import DataBase


def Start(cont):
    own = cont.owner
    MenuLista(own, 5)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED
    
    confirm = keys[events.ENTERKEY] == tap
    up      = keys[events.UPARROWKEY] == tap
    down    = keys[events.DOWNARROWKEY] == tap

    system_menu = own.ActivateMenuControl(confirm, up, down)

    if (system_menu[0]==True and system_menu[1]==0):
        DataBase.CreateDB(1)
        ManagerScenes().OnlyAddScene("intro_game_scene")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    elif (system_menu[0]==True and system_menu[1]==1):
        DataBase.CreateDB(2)
        ManagerScenes().OnlyAddScene("intro_game_scene")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    elif (system_menu[0]==True and system_menu[1]==2):
        DataBase.CreateDB(3)
        ManagerScenes().OnlyAddScene("intro_game_scene")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    elif (system_menu[0]==True and system_menu[1]==3):
        DataBase.CreateDB(4)
        ManagerScenes().OnlyAddScene("intro_game_scene")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    elif (system_menu[0]==True and system_menu[1]==4):
        DataBase.CreateDB(5)
        ManagerScenes().OnlyAddScene("intro_game_scene")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])

