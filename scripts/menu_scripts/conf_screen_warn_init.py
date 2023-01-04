from bge import logic, events
from scripts.menu_scripts.menu_horizontal import ConfirmationMenuScreen
from scripts.manager_scenes import ManagerScenes
from data_files.warnings import warnings


def Start(cont):
    own = cont.owner

    current_scene = logic.getCurrentScene()
    text_obj = current_scene.objects["text_conf_screen.002"]

    text = warnings['3']

    text_obj["Text"] = text

    ConfirmationMenuScreen(own)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    confirm = keys[events.ENTERKEY] == tap
    left    = keys[events.LEFTARROWKEY] == tap
    right   = keys[events.RIGHTARROWKEY] == tap

    list_opt = own.ActiveMenuConfScreen(confirm, left, right)

    if (list_opt == [True, 1]
     or (cont.sensors["mo_winit_yes"].positive and logic.mouse.events[events.LEFTMOUSE])):
        with open(logic.expandPath("//data_files/data_permission.txt"), 'w') as data_file:
            data_file.write('0')
        ManagerScenes().OnlyAddScene("intro_game_scene")
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_igw"]])
    elif (list_opt == [True, 0]
     or (cont.sensors["mo_winit_no"].positive and logic.mouse.events[events.LEFTMOUSE])):
        with open(logic.expandPath("//data_files/data_permission.txt"), 'w') as data_file:
            data_file.write('1')
        ManagerScenes().OnlyAddScene("menu_group_choice")
        ManagerScenes().OnlyPauseScene(cont, [cont.actuators["pau_igw"]])
