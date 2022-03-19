from bge import logic, events
from scripts.menu_scripts.menu_horizontal import ConfirmationMenuScreen
from scripts.manager_scenes import ManagerScenes
from data_files.warnings import warnings


def Start(cont):
    own = cont.owner

    current_scene = logic.getCurrentScene()
    text_obj = current_scene.objects["text_conf_screen.001"]

    text = warnings['1']

    text_obj["Text"] = text

    selector = ConfirmationMenuScreen(own)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    confirm = keys[events.ENTERKEY] == tap
    left    = keys[events.LEFTARROWKEY] == tap
    right   = keys[events.RIGHTARROWKEY] == tap

    car = open(logic.expandPath("//data_files/car_selected.txt"), "w", encoding="utf-8")
    players_cars = open(logic.expandPath("//data_files/player_cars.txt"), "w", encoding="utf-8")
    gold = open(logic.expandPath("//data_files/gold.txt"), "w", encoding="utf-8")
    characters = open(logic.expandPath("//data_files/progress_in_game.txt"), "w", encoding="utf-8")
    
    list_opt = own.ActiveMenuConfScreen(confirm, left, right)
    if list_opt == [True, 0]:
        car.write("lilas_proxie")
        players_cars.write("lilas_proxie\n")
        gold.write("3000")
        characters.write("True\nFalse\nFalse")
    
        re_conf_screen = cont.actuators["re_csng"]
        re_menu_context = cont.actuators["re_mmc"]
        re_opt = cont.actuators["re_mmopt"]
        own.OnlyAddScene("screen_selected_char")
        with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'w', encoding="utf-8") as intros_file:
            intros_file.write("0")
        with open(logic.expandPath("//data_files/events_completes.txt"), 'w', encoding="utf-8") as evc_file:
            evc_file.write("")
        own.OnlyRemoveScenes(cont, [re_menu_context, re_opt, re_conf_screen])
    elif list_opt == [True, 1]:
        #print("AQUI!!!")
        own.OnlyResumeScene(cont, [cont.actuators["resu_mm_opt"]])
        curr_scene_act = cont.actuators["re_csng"]
        cont.activate(curr_scene_act)
    
    car.close()
    players_cars.close()
    gold.close()
    characters.close()
