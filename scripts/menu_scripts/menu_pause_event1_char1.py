from bge import logic, events
from scripts.menu_scripts.menu_lista import MenuLista


def Start(cont):
    own = cont.owner
    menu_pause = MenuLista(own, 2, 1.495)


def Update(cont):
    own = cont.owner
    keyboard = logic.keyboard
    tap = logic.KX_INPUT_JUST_ACTIVATED

    confirm = (keyboard.events[events.ENTERKEY]==tap) == True
    up = (keyboard.events[events.UPARROWKEY]==tap) == True
    down = (keyboard.events[events.DOWNARROWKEY]==tap) == True
    opts = []
    opts = own.ActivateMenuControl(confirm, up, down)

    if (opts[0]==True and opts[1]==0):
        own.OnlyResumeScene(cont, [cont.actuators["resu_event1_char1"]])
        own.OnlyRemoveScenes(cont, [cont.actuators["re_pause"]])
    elif (opts[0]==True and opts[1]==1):
        own.OnlyAddScene("main_menu_context")
        own.OnlyRemoveScenes(cont, [cont.actuators["re_event"], cont.actuators["re_pause"],
         cont.actuators["re_event_ui"]])
            
