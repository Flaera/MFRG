from bge import logic
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
    

