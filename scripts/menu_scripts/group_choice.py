from bge import logic, events
# from scripts.manager_scenes import ManagerScenes
from scripts.menu_scripts.menu_horizontal import HardMenuHorizontal
from scripts.sqlite3.connection_sqlite import DataBase


def Start(cont):
    own = cont.owner
    own["list_choice"] = HardMenuHorizontal(own, 11, 0.0)


def CallDB_and_Scene(own, cont, data_type_char):
    DataBase.CreateDB(data_type_char)
    own["list_choice"].OnlyAddScene("intro_game_scene")
    own["list_choice"].OnlyRemoveScenes(cont, [cont.actuators["re_igw"],
        cont.actuators["re_mgc"]])



def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED
    
    confirm = keys[events.ENTERKEY] == tap
    right = keys[events.RIGHTARROWKEY] == tap
    left = keys[events.LEFTARROWKEY] == tap

    system_menu = own.ActiveHardMenuHoriControl(confirm, right, left)

    if (system_menu[0]==True and system_menu[1]==0 and system_menu[1]==1):
        #indigenas:
        CallDB_and_Scene(own, cont, 1)
    elif (system_menu[0]==True and system_menu[1]==2 and system_menu[1]==3):
        #mulheres:
        CallDB_and_Scene(own, cont, 2)
    elif (system_menu[0]==True and system_menu[1]==4 and system_menu[1]==5):
        #lgbtqia+:
        CallDB_and_Scene(own, cont, 3)
    elif (system_menu[0]==True and system_menu[1]==6 and system_menu[1]==7
     and system_menu[1]==8 and system_menu[1]==9):
        #negras e negros:
        CallDB_and_Scene(own, cont, 4)
    elif (system_menu[0]==True and system_menu[1]==10):
        #outros:
        CallDB_and_Scene(own, cont, 5)
    else:
        print("Erro. Nada selecionado.")
    
    # if (system_menu[0]==True and system_menu[1]==0):
    #     DataBase.CreateDB(1)
    #     own["list_choice"].OnlyAddScene("intro_game_scene")
    #     ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    # elif (system_menu[0]==True and system_menu[1]==1):
    #     DataBase.CreateDB(2)
    #     ManagerScenes().OnlyAddScene("intro_game_scene")
    #     ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    # elif (system_menu[0]==True and system_menu[1]==2):
    #     DataBase.CreateDB(3)
    #     ManagerScenes().OnlyAddScene("intro_game_scene")
    #     ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    # elif (system_menu[0]==True and system_menu[1]==3):
    #     DataBase.CreateDB(4)
    #     ManagerScenes().OnlyAddScene("intro_game_scene")
    #     ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])
    # elif (system_menu[0]==True and system_menu[1]==4):
    #     DataBase.CreateDB(5)
    #     ManagerScenes().OnlyAddScene("intro_game_scene")
    #     ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"], cont.actuators["re_mgc"]])

