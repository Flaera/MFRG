from bge import logic
from scripts.music_system import MusicSystem


def Start(cont):
    own = cont.owner
    own["music_player"] = MusicSystem(own)
    

def Update(cont):
    own = cont.owner
    own["music_player"].PlayList(cont)
