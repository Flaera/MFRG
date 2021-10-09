from bge import logic, events
from scripts.manager_scenes import ManagerSecenes
from data_files.events_talks import events_talks


class TalkSystem(ManagerScenes):
    def __init__(self, own, id_event_talk, sequence=[]):
        self.own = own
        self.steps = int(0)
        for i in events_talks[id_event_talk]:
            self.steps += 1
        self.steps -= 1 
        self.curr_steps = int(0)
        self.end_diag = False
        
    
    def TalkCalledUpdate(cont):
        scene_event=logic.getCurrentScene()
        
        keyboard = logic.keyboard
        tap = logic.KX_INPUT_JUST_ACTIVATED
        
        if (keyboard.events[events.ENMTERKEY]==tap) == True:
            if (self.curr_steps<=self.steps):
                
                self.curr_steps += 1 
            else:
                self.end_diag = True    


