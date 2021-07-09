from bge import logic
from scripts.menu_scripts.menu_horizontal import HardMenuHorizontal

def Start(cont):
    own = cont.owner

    # ISSO É APENAS UM TESTE. O QUE DEVE SER FEITO É LER O ARQUIVO. NÃO ESCREVER...
    # UM ARCHIVE.
    # PRECISO FAZER EXERCÍCIOS DE "ARQUIVOS" E "Capítulo 9: Estudo de caso: jogos de...
    # palavras" DO PENSEEMPYTHON2 ASSIM QU TERMINAR A PRIMEIRA BETA DO GAME
    #char_status = open("char_status.txt", "w")
    #char_status.write("True\nFalse\nFalse")

    # A IDEIA E FAZER ESTAS PROPRIEDADES TEREM SEUS VALORES CARREGADOS DE UM ARQUIVO.
    # ALGORITMO: NESTE CASO, DEVE SER LIDO UM AQRQUIVO NO INICIO PARA PROPRIESDADE.
    own["char1"] = False
    own["char2"] = True
    own["char3"] = False

    # To support the function of movement of the selector and application of animation...
    # in the dark screen:
    own["n_options"] = 0

    current_scene = logic.getCurrentScene()
    locked_opt1 = current_scene.objects["locked_opt1"]
    locked_opt2 = current_scene.objects["locked_opt2"]
    locked_opt3 = current_scene.objects["locked_opt3"]

    if (own["char1"] == True):
        own["n_options"] = 0
        locked_opt1.playAction("screen_char_selected_opt_anima", 0, 60) # I like here...
        # to work with alpha channel, but bge...
        # only run animations of actions/movements.
    elif (own["char2"] == True):
        own["n_options"] = 1
        locked_opt2.playAction("screen_char_selected_opt_anima", 0, 60)
    elif (own["char3"] == True):
        own["n_options"] = 2
        locked_opt3.playAction("screen_char_selected_opt_anima", 0, 60)

    own["position"] = float(0)  # For to move blue selector.
    #selector = HardMenuHorizontal(own, 3, float(6.90754))
    # Abondoned, because It's don'st one menu horizontal, but surely one showd...
    # that presentation the character of the moment at least that player progress in game.

    own["counter"] = int(0) # To help in the transition scenes.

    selector = HardMenuHorizontal(own) # To call the functions of transition for loading scene.


def LinearFuncMoveSelector(cont): # I think that is best to make funtion of second degree.
    '''
    It's apply the movements in cursor that define the character selected on this moment.
    :param cont: rference at the controller.
    :return: none
    '''
    own = cont.owner
    delta_s = (float(6.90754) * own["n_options"])
    inc = float(delta_s / 20)
    own["position"] += inc

    if (own["position"] < delta_s):
        own.applyMovement([(-inc), 0, 0], True)


def Update(cont):
    own = cont.owner

    LinearFuncMoveSelector(cont)

    # For change fot map scene:
    confirmation = False
    if (float(2.9) <= own["dtime"] <= float(3.0)) and (own["counter"] == 0):
        confirmation = True
        own["counter"] += 1
    elif (own["dtime"] > float(3)) or (own["counter"] == 1):
        confirmation = False

    own.TimeChangeScene(confirmation, own["dtime"], float(3.5))
    # I liked one transition with fade-out and fade-in. Probably, It think that will...
    # make in the future. I can manage make this with API of BGE in part of material.
    if (own.action_load == True):
        own.TransitionLoadingScenes("loading", "map", cont,
                                   [cont.actuators["re_loading"],
                                    cont.actuators["re_select_char"]])
