from bge import logic, events
from data_files.music_list import musics


class MusicSystem():
    def __init__(self, old_owner, music_player=False):
        self.music_player = music_player
        self.own = old_owner
        self.acc_main = 0
        self.max_musics = len(musics)
        print("max musics: ", self.max_musics)
        self.only_time = True


    def OnlyPlay(self, cont):
        own = cont.owner
        if (own["timer_sound"]>=musics[self.acc_main][1]):
            self.acc_main = self.acc_main + 1
            if (self.acc_main==self.max_musics):
                self.acc_main = 0
            cont.deactivate(musics[self.acc_main-1][0])
            own["timer_sound"] = float(0.0)
            print("acc_music:{}-".format(self.acc_main))
            self.only_time = True
        elif self.only_time==True:
            cont.activate(musics[self.acc_main][0])
            self.only_time = False

    
    def PlayList(self, cont):
        own = cont.owner
        if (self.music_player==False):
            self.OnlyPlay(cont)
        elif (self.music_player==True):
            keyboard = logic.keyboard
            JUST_ACTIVATED = logic.KX_INPUT_JUST_ACTIVATED
            if (keyboard.events[events.RIGHTARROWKEY]==JUST_ACTIVATED)==True:
                cont.deactivate(musics[self.acc_main][0])
                self.acc_main += 1
                #print("AQUI1")
                if (self.acc_main==self.max_musics):
                    self.acc_main = 0
            elif (keyboard.events[events.LEFTARROWKEY]==JUST_ACTIVATED)==True:
                cont.deactivate(musics[self.acc_main][0])
                self.acc_main -= 1
                #print("AQUI2")
                if (self.acc_main==-1):
                    self.acc_main = self.max_musics-1
            self.OnlyPlay(cont)


