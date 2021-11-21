from bge import logic
from data_files.music_list import musics


class MusicSystem():
    def __init__(self, old_owner, music_player=False):
        self.music_player = music_player
        self.own = old_owner
        self.acc_main = 0
        self.max_musics = len(musics)
        print("max musics: ", self.max_musics)

    
    def PlayList(self, cont):
        own = cont.owner
        if (self.music_player==False):
            if (self.acc_main<self.max_musics) and (own["timer_sound"]>=musics[self.acc_main][1]):
                self.acc_main = self.acc_main + 1
                if (self.acc_main==self.max_musics):
                    self.acc_main = 0
                own["timer_sound"] = float(0.0)
                print("acc_music:{}-".format(self.acc_main))
            else:
                cont.activate(musics[self.acc_main][0])


