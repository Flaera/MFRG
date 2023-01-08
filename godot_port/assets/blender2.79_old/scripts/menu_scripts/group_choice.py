from bge import logic, events
# from scripts.manager_scenes import ManagerScenes
from scripts.menu_scripts.menu_horizontal import HardMenuHorizontal
from scripts.sqlite3.connection_sqlite import DataBase
LEN_OPTIONS = 11


def saveStyle(style_string):
    with open(logic.expandPath("//data_files/style.txt"),"w") as file_save_style:
        file_save_style.write(style_string)


def Start(cont):
    own = cont.owner
    # print("STARTOU")
    own["id_style"] = int(9)
    HardMenuHorizontal(own, LEN_OPTIONS, 0.0)
    saveStyle("Anne9")


def callDB_and_Scene(own, cont, data_type_char):
    DataBase.CreateDB(data_type_char)
    own.OnlyAddScene("intro_game_scene")
    own.OnlyRemoveScenes(cont, [cont.actuators["re_mgc"]])


def addImageAnne(own, center, styles, res_left, res_right):
    # print("id=", own["id_style"])
    index=own["id_style"]
    ds = logic.getCurrentScene().addObject(styles[index], center)
    ds.setParent(center)
    saveStyle(styles[index])


    if (res_right): own["id_style"] += 1
    elif (res_left): own["id_style"] -= 1
    if own["id_style"] == LEN_OPTIONS and res_right==True:
        own["id_style"] = 0
    elif own["id_style"] == 0 and res_left==True:
        own["id_style"] = LEN_OPTIONS-1


def translateStyleAnne(own, res_left, res_right):
    styles = ["Anne0","Anne1","Anne2","Anne3","Anne4","Anne5","Anne6",
     "Anne7","Anne8","Anne9","Anne10"]
    scene_obj = logic.getCurrentScene().objects
    # print("scn+objs: ",scene_obj)
    center = scene_obj["anne_empty"]
    lenght = len(center.children)
    if (lenght<=1):
        try:
            # print("childrens=", center.children)
            center.children[0].endObject()
            
            addImageAnne(own, center, styles, res_left, res_right)
        except: addImageAnne(own, center, styles, res_left, res_right)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED
    
    confirm = keys[events.ENTERKEY] == tap
    right = keys[events.RIGHTARROWKEY] == tap
    left = keys[events.LEFTARROWKEY] == tap

    #Controles de mouse:
    left_mouse_over = cont.sensors["lmo"].positive
    right_mouse_over = cont.sensors["rmo"].positive
    center_mouse_over = cont.sensors["mosel"].positive
    if (left_mouse_over and logic.mouse.events[events.LEFTMOUSE]==tap): left = True
    if(right_mouse_over and logic.mouse.events[events.LEFTMOUSE]==tap): right=True
    if (center_mouse_over and logic.mouse.events[events.LEFTMOUSE]==tap): confirm = True
    translateStyleAnne(own,left,right)
    
    print("cmo=",center_mouse_over, confirm)
    system_menu = own.ActiveHardMenuHoriControl(confirm, right, left)
    
    if (system_menu[0]==True and (system_menu[1]==0 or system_menu[1]==1)):
        #indigenas:
        callDB_and_Scene(own, cont, system_menu[1])
    elif (system_menu[0]==True and (system_menu[1]==2 or system_menu[1]==3)):
        #mulheres:
        callDB_and_Scene(own, cont, system_menu[1])
    elif (system_menu[0]==True and system_menu[1]==4 or system_menu[1]==5):
        #lgbtqia+:
        callDB_and_Scene(own, cont, system_menu[1])
    elif (system_menu[0]==True and (system_menu[1]==6 or system_menu[1]==7
     or system_menu[1]==8 or system_menu[1]==9)):
        #negras e negros:
        callDB_and_Scene(own, cont, system_menu[1])
    elif (system_menu[0]==True and system_menu[1]==10):
        #outros:
        callDB_and_Scene(own, cont, system_menu[1])
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

