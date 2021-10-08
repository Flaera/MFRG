from bge import logic, events
from scripts.manager_scenes import ManagerSecenes
from data_files.events_talks import events_talks


class TalkSystem(ManagerScenes):
    def __init__(self, own, pass_key, pass_all, id_event_talk, sequence=[]):
        self.own = own
        self.steps = int(0)
        for i in events_talks[id_event_talk]:
            self.steps += 1
        self.steps -= 1 
        self.curr_steps = int(0)
        
    
    def TalkCalledUpdate(cont):
        scene_event=logic.getCurrentScene()
        
        keyboard = logic.keyboard
        just_activated = logic.KX_INPUT_JUST_ACTIVATED
        
        if (keyboard.events[events.ZKEY]==True) and (keyboard.events[events.XKEY]==False):
            if (self.curr_steps<=self.steps):
                self.curr_steps += 1 
                #fazer mais coisas
        elif (keyboard.events[events.XKEY]==True):
            self.TimeChangeScene(True, own["dtime_talk"])
            
            re_scene_list = [cont.actuators["re_curr_scene"], cont.actuators["re_loading"]]
            self.TransitionLoadingScenes("loading", scene_event, cont, re_scene_list)