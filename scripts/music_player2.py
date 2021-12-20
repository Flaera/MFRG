from bge import logic, events
from scripts.music_system import MusicSystem
from data_files.music_list2 import musics2
from data_files.info_musics import info_musics

def Start(cont):
    own = cont.owner
    own["music_player"] = MusicSystem(own, True, musics2)
    

def Update(cont):
    own = cont.owner
    own["music_player"].PlayList2(cont)

    childrens = own.children
    #print("childrens:", childrens)
    music = info_musics[musics2[own["music_player"].GetAccMain()][0]]

    #print("music:", music)
    childrens["name_music.001"]["Text"] = music[0]
    childrens["names_artists.001"]["Text"] = music[1]

    keyboard = logic.keyboard
    tap = logic.KX_INPUT_JUST_ACTIVATED
    if (keyboard.events[events.ONEKEY] == tap):
        cont.activate(cont.actuators["add_menu_opt"])
        cont.activate(cont.actuators["add_mp1"])
        cont.activate(cont.actuators["re_mp2"])
    

