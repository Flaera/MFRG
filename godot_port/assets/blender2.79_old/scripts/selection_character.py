from bge import logic
from scripts.menu_scripts.menu_horizontal import HardMenuHorizontal
from scripts.data_manager import IsEqualString


def ConditionsProgress():
    event_list = []
    with open(logic.expandPath("//data_files/events_completes.txt"), 'r') as events_file:
        event_list = events_file.read().split('\n')
    event1 = bool(False)
    event2 = bool(False)
    event3 = bool(False)
    event4 = bool(False)
    event5 = bool(False)
    event6 = bool(False)
    for i in event_list:
        try:
            if (i=="event1_char1"): event1 = True
            elif (i=="event2_char1"): event2 = True
            elif (i=="event3_char1"): event3 = True
            
            elif (i=="event4_char2"): event4 = True
            elif (i=="event5_char2"): event5 = True
            elif (i=="event6_char2"): event6 = True
        except: pass
    print("events:", event1, event2, event3, event4, event5, event6)
    intro_main = int(0)
    with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'r') as intros_file:
        intro_main = int(intros_file.read())
    
    if (event1==True and event2==True and event3==True and \
        (event4==False and event5==False and event6==False) and intro_main==1):
        with open(logic.expandPath("//data_files/progress_in_game.txt"), 'w') as progress_file:
            progress_file.write("True\nTrue\nFalse")
        with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'w') as intro_file:
            intro_file.write("1")

    if (event4==True and event5==True and event6==True) and intro_main==2:
        with open(logic.expandPath("//data_files/progress_in_game.txt"), 'w') as progress_file:
            progress_file.write("True\nTrue\nTrue")
        with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'w') as intro_file:
            intro_file.write("2")


def Start(cont):
    own = cont.owner

    ConditionsProgress()

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
    if IsEqualString(own["char2"], 'True') == True:
        own["n_options"] = 1
        locked_opt2.playAction("screen_char_selected_opt_anima", 0, 60)
    if IsEqualString(own["char3"], 'True') == True:
        own["n_options"] = 2
        locked_opt3.playAction("screen_char_selected_opt_anima", 0, 60)

    own["position"] = float(0)  # For to move blue selector.
    #selector = HardMenuHorizontal(own, 3, float(6.90754))
    # Abondoned, because It's don'st one menu horizontal, but surely one showd...
    # that presentation the character of the moment at least that player progress in game.

    selector = HardMenuHorizontal(own) # To call the functions of transition for loading scene.

    try:
        selector.OnlyAddScene("music_player")
    except:
        pass


def LinearFuncMoveSelector(cont): # I think that is best to make funtion of second degree.
    '''
    It's apply the movements in cursor that define the character selected on this moment.
    :param cont: rference at the controller.
    :return: none
    '''
    own = cont.owner
    #print("n_options: ", own["n_options"])
    delta_s = (float(6.90754) * own["n_options"])
    inc = float(delta_s / 20)
    own["position"] += inc

    if (own["position"] < delta_s):
        own.applyMovement([(-inc), 0, 0], True)


def Update(cont):
    own = cont.owner

    LinearFuncMoveSelector(cont)
    intros_readed = int(0)
    with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'r') as intros_file:
        intros_readed = int(intros_file.read())
    print("intros_read:{}-".format(intros_readed))
    if own["char1"] == "True" and own["char2"] == "False" and own["char3"] == "False":
        if (own["n_options"]==0) == True and intros_readed==0: 
            own.OnlyAddScene("intro_talk_carlos")
            own.OnlyRemoveScenes(cont, [cont.actuators["re_select_char"]])
            with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'w') as intros_filew:
                intros_filew.write("1")
    if own["char1"] == "True" and own["char2"] == "True" and own["char3"] == "False":
        if (own["n_options"]==1) == True and (intros_readed==1):
            own.OnlyAddScene("intro_talk_maria")
            own.OnlyRemoveScenes(cont, [cont.actuators["re_select_char"]])
            with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'w') as intros_filew:
                print("DOIS!!!")
                intros_filew.write("2")
    if own["char1"] == "True" and own["char2"] == "True" and own["char3"] == "True":
        if (own["n_options"]==2) == True and (intros_readed==2):
            own.OnlyAddScene("intro_talk_vitoria")
            own.OnlyRemoveScenes(cont, [cont.actuators["re_select_char"]])
            with open(logic.expandPath("//data_files/states_main_scenes.txt"), 'w') as intros_filew:
                intros_filew.write("3")
        
    elif own["dtime"]>3.50:
        own.OnlyAddScene("map")
        own.OnlyRemoveScenes(cont, [cont.actuators["re_select_char"]])
