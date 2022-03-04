from bge import logic, events
from scripts.menu_scripts.menu_horizontal import SampleMenuHorizontal
from scripts.manager_scenes import ManagerScenes


def Update(cont):

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    current_scene = logic.getCurrentScene()
    obj_mhs = current_scene.objects
    # print("Lista de obj: \n", obj_mhs)

    mhs = SampleMenuHorizontal(False, False, True)
    mhs.InvokeBack(obj_mhs["back_button"])
    mhs.InvokeBackAll(obj_mhs["back_all_button"])
    mhs.InvokeRestart(obj_mhs["restart_button"])

    remmabout = cont.actuators["remmabout"]
    re_mhs = cont.actuators["re_mhs"]

    if (keys[events.ONEKEY] == tap) or (keys[events.BACKSPACEKEY]==tap) or (keys[events.ESCKEY]==tap):
        ManagerScenes().OnlyAddScene("main_menu_optmain")
        #cont.activate(cont.actuators["test"])
        ManagerScenes().OnlyRemoveScenes(cont, [remmabout, re_mhs])
