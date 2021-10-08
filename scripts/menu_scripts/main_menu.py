from bge import logic, events, types
from scripts.menu_scripts.menu_lista import MenuLista
# IT'S IN DEVELOPMENT!!

def Start(cont):
    own = cont.owner

    selector = MenuLista(own, 6)
    #manager_scene = selector.manager_scene()  # First research the init function


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap  = logic.KX_INPUT_JUST_ACTIVATED

    confirm = keys[events.ENTERKEY] == tap
    up      = keys[events.UPARROWKEY] == tap
    down    = keys[events.DOWNARROWKEY] == tap

    sys_res = own.ActivateMenuControl(confirm, up, down)
    print('sys_res', sys_res)
    # ScenesActuators:
    #game_testes = cont.actuators["game_test"]
    #loading_scene = cont.actuators["loading"]
    # Actuators of scene for delete:
    re_menu_context = cont.actuators["re_menu_context"]
    # Em KX_SCENE tem the comands for substitute It's actuators.
    re_opt = cont.actuators["re_menu_opt"]

    if ((sys_res[0] == True) and (sys_res[1] == 0)):
        own.OnlyAddScene("screen_selected_char")
        own.OnlyRemoveScenes(cont, [re_menu_context, re_opt])
    elif ((sys_res[0] == True) and (sys_res[1] == 1)):
        #caled confirmation screen:
        own.OnlyAddScene("conf_screen_new_game")
        own.OnlyPauseScene(cont, [cont.actuators["susp_mm_opt"]])
    elif ((sys_res[0] == True) and (sys_res[1] == 2)):
        own.OnlyAddScene("main_menu_settings")
        own.OnlyRemoveScenes(cont, [re_opt])
    elif ((sys_res[0] == True) and (sys_res[1] == 3)):
        # It's about. I WILL GO LOVE MAKE THIS.
        own.OnlyAddScene("main_menu_about")
        own.OnlyRemoveScenes(cont, [re_opt])
    elif ((sys_res[0] == True) and (sys_res[1] == 4)):
        # It's music player. Tooo I sense same about this. :D
        own.OnlyAddScene("main_menu_musicplayer")
        own.OnlyRemoveScenes(cont, [re_opt])
    elif ((sys_res[0] == True) and (sys_res[1] == 5)):
        own.OnlyAddScene("main_menu_conf_screen_quit")
        own.OnlyPauseScene(cont, [cont.actuators["susp_mm_opt"]])
        #own.OnlyRemoveScenes(cont, [re_opt])


    #own.ActLoadScene(cont, game_testes) # To load scene at of actuator.
    #own.DebugaAi() # Function of class MenuLista only debug of same.
