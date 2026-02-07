from bge import logic, events, types
from scripts.menu_scripts.menu_lista import MenuLista


def Start(cont):
    own = cont.owner

    MenuLista(own, 6)
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
    re_mp = cont.actuators["re_mp"]

    #A lógica do Guilherme deu errado, a mesma que esta abaixo:
    # obj_view_name = ""
    # options = ["1continue", "2new_game", "3settings", "4about", "5musicplayer", "6quit"]
    # cam = logic.getCurrentScene().active_camera
    # m_pos = Vector(logic.mouse.position)
    # #Corrigindo aspect ratio do mouse.position:
    # factor = 640 / ((360 / bge.render.getWindowHeight())*bge.render.getWindowWidth())
    # m_pos.y *= factor
    # m_pos.y -= (factor - 1.0)/2.0
    # obj_view_name = cam.getScreenRay(m_pos[0],m_pos[1],1000)
    # print(obj_view_name)

    if ((sys_res[0] == True) and (sys_res[1] == 0)
     or (cont.sensors["1m_continue"].positive and logic.mouse.events[events.LEFTMOUSE])):
        #  and logic.getCurrentScene().name!="")): TEM UM BUG AQUI
        own.OnlyAddScene("screen_selected_char")
        own.OnlyRemoveScenes(cont, [re_menu_context, re_opt])
    elif ((sys_res[0] == True) and (sys_res[1] == 1)
     or (cont.sensors["1m_ngame"].positive and logic.mouse.events[events.LEFTMOUSE])):
        #caled confirmation screen:
        own.OnlyAddScene("conf_screen_new_game")
        own.OnlyPauseScene(cont, [cont.actuators["susp_mm_opt"]])
    elif ((sys_res[0] == True) and (sys_res[1] == 2)
     or (cont.sensors["1m_config"].positive and logic.mouse.events[events.LEFTMOUSE])):
        #Settings
        #own.OnlyAddScene("main_menu_settings")
        #own.OnlyRemoveScenes(cont, [re_opt])
        pass
    elif ((sys_res[0] == True) and (sys_res[1] == 3)
     or (cont.sensors["1m_about"].positive and logic.mouse.events[events.LEFTMOUSE])):
        own.OnlyAddScene("main_menu_about")
        own.OnlyRemoveScenes(cont, [re_opt])
    elif ((sys_res[0] == True) and (sys_res[1] == 4)
     or (cont.sensors["1m_musicp"].positive and logic.mouse.events[events.LEFTMOUSE])):
        own.OnlyAddScene("music_player2")
        own.OnlyRemoveScenes(cont, [re_opt, re_mp])
    elif ((sys_res[0] == True and sys_res[1] == 5)
     or (keys[events.BACKSPACEKEY]==tap or keys[events.ESCKEY]==tap)
      or (cont.sensors["1m_quit"].positive and logic.mouse.events[events.LEFTMOUSE])):
        own.OnlyAddScene("main_menu_conf_screen_quit")
        own.OnlyPauseScene(cont, [cont.actuators["susp_mm_opt"]])
        #own.OnlyRemoveScenes(cont, [re_opt])
