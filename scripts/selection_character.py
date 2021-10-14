from bge import logic
from scripts.menu_scripts.menu_horizontal import HardMenuHorizontal
from scripts.data_manager import IsEqualString


def Start(cont):
    own = cont.owner

    character = open(logic.expandPath("//data_files/progress_in_game.txt"), 'r')
    char_list = character.read().split('\n')
    print("char list-", char_list)
    own["char1"] = char_list[0]
    own["char2"] = char_list[1]
    own["char3"] = char_list[2]

    # To support the function of movement of the selector and application of animation...
    # in the dark screen:
    own["n_options"] = 0

    current_scene = logic.getCurrentScene()
    locked_opt1 = current_scene.objects["locked_opt1"]
    locked_opt2 = current_scene.objects["locked_opt2"]
    locked_opt3 = current_scene.objects["locked_opt3"]

    if IsEqualString(own["char1"], 'True') == True:
        #print("AQUI!!!")
        own["n_options"] = 0
        locked_opt1.playAction("screen_char_selected_opt_anima", 0, 60)
    elif IsEqualString(own["char2"], 'True') == True:
        own["n_options"] = 1
        locked_opt2.playAction("screen_char_selected_opt_anima", 0, 60)
    elif IsEqualString(own["char3"], 'True') == True:
        own["n_options"] = 2
        locked_opt3.playAction("screen_char_selected_opt_anima", 0, 60)

    own["position"] = float(0)  # For to move blue selector.
    #selector = HardMenuHorizontal(own, 3, float(6.90754))
    # Abondoned, because It's don'st one menu horizontal, but surely one showd...
    # that presentation the character of the moment at least that player progress in game.

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
    intros_readed = []
    with open(logic.expandPath("//data_files/intros.txt"), 'r') as intros_file:
        intros_readed = intros_file.read().split('\n')
    print("intros_read:{}-".format(intros_readed))
    if IsEqualString(intros_readed[0], "True") == True:
        with open(logic.expandPath("//data_files/intros.txt"), 'w') as intros_filew:
            intros_filew.write("False")
        mains_chars = []
        with open(logic.expandPath("//data_files/progress_in_game.txt"), 'r') as progress_file:
            mains_chars = progress_file.read().split('\n')
        if IsEqualString(mains_chars[0], "True") == True: #Index change in order with main character
            own.OnlyAddScene("intro_talk_carlos")#Go to scene of introduction of carlos
            own.OnlyRemoveScenes(cont, [cont.actuators["re_select_char"]])
        #At time create the scenes talks of introductions I can copy code above and setting in order
    elif own["dtime"]>3.50:
        own.OnlyAddScene("map")
        own.OnlyRemoveScenes(cont, [cont.actuators["re_select_char"]])
