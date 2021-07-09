from bge import logic, events
from scripts.menu_scripts.menu_horizontal import ConfirmationMenuScreen
from scripts.manager_scenes import ManagerScenes

def Start(cont):
    own = cont.owner

    current_scene = logic.getCurrentScene()
    text_obj = current_scene.objects["text_conf_screen"]

    text = "AÉ!? VOCÊ QUER MESMO SAIR DO JOGO? " \
           "\n\nTenha certeza que salvou o jogo dentro do mapa." \
           "\nDados recentes poderão ser perdidos se você não tiver salvo." \
           "\n\nSe liga!"

    text_obj["Text"] = text

    selector = ConfirmationMenuScreen(own)


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    confirm = keys[events.ENTERKEY] == tap
    left    = keys[events.LEFTARROWKEY] == tap
    right   = keys[events.RIGHTARROWKEY] == tap

    list_opt = own.ActiveMenuConfScreen(confirm, left, right)

    if list_opt == [True, 0]:
        logic.endGame()
    elif list_opt == [True, 1]:
        ManagerScenes().OnlyResumeScene(cont, [cont.actuators["resu_mm_opt"]])
        ManagerScenes().OnlyRemoveScenes(cont, [cont.actuators["re_mcs"]])
