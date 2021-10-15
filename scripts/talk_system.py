from bge import logic, events, types
from scripts.manager_scenes import ManagerScenes
from data_files.events_talks import events_talks


class TalkSystem(ManagerScenes):
    def __init__(self, own, id_event_talk):
        self.own = own
        self.id_event_talk = id_event_talk
        
        self.steps = int(0)
        for i in events_talks[id_event_talk]:
            self.steps += 1
        self.curr_steps = int(0)
        self.end_diag = False

        #Add bg and character if possible:
        self.curr_scene = logic.getCurrentScene()
        #self.curr_scene_ina_objs = self.curr_scene.objectsInactive
        self.curr_scene.addObject(events_talks[self.id_event_talk][0], "bg", 0)
        try: self.curr_char = self.curr_scene.addObject(events_talks[self.id_event_talk][1][0], "left", 0)
        except: pass
        self.own["Text"] = events_talks[self.id_event_talk][1][1]
        self.curr_scene.objects["name"]["Text"] = events_talks[self.id_event_talk][1][0].split('_')[0]
        self.curr_steps += 1

    
    def TalkCalledUpdate(self, cont):
       
        keyboard = logic.keyboard
        tap = logic.KX_INPUT_JUST_ACTIVATED
        
        if (keyboard.events[events.ENTERKEY]==tap) == True:
            if (self.curr_steps<self.steps):
                if (events_talks[self.id_event_talk][self.curr_steps][2]==1):
                    try: self.curr_char.endObject()
                    except: pass
                    self.own["Text"] = events_talks[self.id_event_talk][self.curr_steps][1]
                    print("curr-{}-".format(events_talks[self.id_event_talk][self.curr_steps][0]))
                    self.curr_char = self.curr_scene.addObject(events_talks[self.id_event_talk][self.curr_steps][0], "left", 0)
                    self.curr_scene.objects["name"]["Text"] = events_talks[self.id_event_talk][self.curr_steps][0].split('_')[0]
                elif (events_talks[self.id_event_talk][self.curr_steps][2]==2):
                    try: self.curr_char.endObject()
                    except: pass
                    self.own["Text"] = events_talks[self.id_event_talk][self.curr_steps][1]
                    self.curr_char = self.curr_scene.addObject(events_talks[self.id_event_talk][self.curr_steps][0], "right", 0)
                    self.curr_scene.objects["name"]["Text"] = events_talks[self.id_event_talk][self.curr_steps][0].split('_')[0]
                elif (events_talks[self.id_event_talk][self.curr_steps][2]==0):
                    try: self.curr_char.endObject()
                    except: pass
                    self.own["Text"] = events_talks[self.id_event_talk][self.curr_steps][1]
                    self.curr_scene.objects["name"]["Text"] = ""
                self.curr_steps += 1
            else:
                self.end_diag = True


