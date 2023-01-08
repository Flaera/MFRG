from bge import logic
from data_files.events_talks import events_talks
from scripts.talk_system import TalkSystem


def Start(cont):
    own = cont.owner
    own["event_talk"] = TalkSystem(own, '2')


def Update(cont):
    own = cont.owner
    own["event_talk"].TalkCalledUpdate(cont)
    if own["event_talk"].end_diag == True:
        own["event_talk"].OnlyAddScene("event2_char1")
        own["event_talk"].OnlyRemoveScenes(cont, [cont.actuators["re_talk_iua"]])