from bge import logic, events
from scripts.manager_scenes import ManagerScenes
from data_files.prices_events import prices


def Start(cont):
    own = cont.owner

    scene_list = logic.getSceneList()
    id_scene_event = int(0)
    for i in range(len(scene_list)):
        if scene_list[i]=="event1_char1": # settings string in each self event
            id_scene_event = i
    scene_event_objs = scene_list[id_scene_event].objects 
    time = scene_event_objs["car_invoker"]["timer_chalenger"]
    own["Text"] = str(int(time/60))+"min"+str(int(time%60))+'s'
    
    curr_scene_objs = logic.getCurrentScene().objects
    gold = int(prices[0]/time) # Settings index in each self event
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
    if enter == True:
        own["manager_scenes"].OnlyAddScene("map")
        re_scene_list = [cont.actuators["re_ui"], cont.actuators["re_event"], cont.actuators["re_finish"]]
        own["manager_scenes"].OnlyRemoveScenes(cont, re_scene_list)