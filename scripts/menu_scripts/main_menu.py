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
    re_loading = cont.actuators["re_loading"]
    re_opt = cont.actuators["re_menu_opt"]

    # To enter in map. First or second option. This is only scene that need loading...
    # scenes:
    own.TimeChangeScene(confirm, own["delta_time"], 0.5)

    if ((sys_res[0] == True) and (sys_res[1] == 0))\
            or ((sys_res[1] == 0) and (own.action_load == True)):
        own.TransitionLoadingScenes("loading", "screen_selected_char",
                                   cont, [re_menu_context, re_loading, re_opt])
        # To enter in map. First or second option: I really, i probbly would to...
        # adapter this code for get functions of saving and loading of game.
        #scene = types.KX_SceneActuator("game_testes") I think that code to like class...
        # base in class SceneActuator by eheirant(herança)
    elif ((sys_res[0] == True) and (sys_res[1] == 1))\
            or ((sys_res[1] == 1) and (own.action_load == True)):
        own.TransitionLoadingScenes("loading", "screen_selected_char",
                                   cont, [re_menu_context, re_loading, re_opt])
        # At this point, It have that change because the load files have that to be...
        # deleted in system. Probably, I will have delete this in globalDict.
        # In both fates, It scene have change for map scene.
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
