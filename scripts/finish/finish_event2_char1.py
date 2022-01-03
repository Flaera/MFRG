from bge import logic, events
from scripts.manager_scenes import ManagerScenes
from data_files.prices_events import prices
from scripts.data_manager import IsEqualString


def PriceAttribute(gain, time):
    constant = 100 #Setting in each self script and event
    return int((gain/time)*constant)


def Start(cont):
    own = cont.owner

    scene_list = logic.getSceneList()
    id_scene_event = int(0)
    for i in range(len(scene_list)):
        if scene_list[i]=="event2_char1": # settings string in each self event
            id_scene_event = i
    scene_event_objs = scene_list[id_scene_event].objects 
    time = scene_event_objs["car_invoker"]["timer_chalenger"]
    own["Text"] = str(int(time/60))+"min"+str(int(time%60))+'s'
    
    curr_scene_objs = logic.getCurrentScene().objects
    gold = PriceAttribute(int(prices[0]), time) # Settings index in each self event
    curr_scene_objs["gold"]["Text"] = gold
    gfr_int = int(0)
    with open(logic.expandPath("//data_files/gold.txt"), 'r') as gold_file:
        gfr = gold_file.read().split('\n')[0]
        gfr_int = int(gfr)+gold
    with open(logic.expandPath("//data_files/gold.txt"), 'w') as gold_file:
        gold_file.write(str(gfr_int))

    own["manager_scenes"] = ManagerScenes()


def Update(cont):
    own = cont.owner
    keyboard = logic.keyboard
    tap = logic.KX_INPUT_JUST_ACTIVATED
    enter = keyboard.events[events.ENTERKEY]==tap
    name_event = "event2_char1" #Setting in each script
    if enter == True:
        is_have = False
        with open(logic.expandPath("//data_files/events_completes.txt"), 'r') as events_completes_file:
            list_events = events_completes_file.read().split('\n')
            print("list_events:{}-".format(list_events))
            for i in list_events:
                print("i:{}-".format(i))
                if (IsEqualString(i, name_event)==True) and (i!=''):
                    is_have = True
                    break
        print("is_have:{}-".format(is_have))
        if (is_have==False):
            with open(logic.expandPath("//data_files/events_completes.txt"), 'a') as eca_file:
                eca_file.write("\n"+name_event)
        own["manager_scenes"].OnlyAddScene("screen_selected_char")
        re_scene_list = [cont.actuators["re_ui"], cont.actuators["re_event"], cont.actuators["re_finish"]]
        own["manager_scenes"].OnlyRemoveScenes(cont, re_scene_list)