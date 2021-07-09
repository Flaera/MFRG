from bge import logic, events
from scripts.menu_scripts.menu_horizontal import SampleMenuHorizontal


#def Start(cont):
 #   own = cont.owner
  #  own["in_opt_two"] = False


def Update(cont):
    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    current_scene = logic.getCurrentScene()
    back = current_scene.objects["back_button.001"]
    back_main_menu = current_scene.objects["back_all_button.001"]

    smh = SampleMenuHorizontal(True, False, True)
    smh.InvokeBack(back)
    smh.InvokeBackAll(back_main_menu) # In this case, It's for map menu.
    smh.InvokeRestart(current_scene.objects["restart_button.001"])

    #own = cont.owner
    if (keys[events.ONEKEY] == tap):
        smh.OnlyAddScene("main_menu_context")
        smh.OnlyRemoveScenes(cont, [cont.actuators["re_map"],
                                    cont.actuators["re_map_smh"]])
    elif (keys[events.TWOKEY] == tap): #and (own["in_opt_two"] == False):
        #own["in_opt_two"] = True
        smh.OnlyAddScene("map_menu_list")
        smh.OnlyPauseScene(cont, [cont.actuators["pause_map"],
                                  cont.actuators["pause_map_smh"]])
    #elif (keys[events.TWOKEY] == tap) and (own["in_opt_two"] == False):
    # It's for map menu
