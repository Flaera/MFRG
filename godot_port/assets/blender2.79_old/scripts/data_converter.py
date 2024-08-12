

class TimeConverting():

    # Talvez eu deva mudar o nome desta funcao:
    def TimeToDecimal(self, minutes, seconds=0, hour=0):
        h = 0
        minu = 0
        sec = 0

        onedec_hour = float(1)
        onedec_min = float(onedec_hour/60)
        onedec_sec = float(onedec_min/60)

        #oneh = 1
        #oneh_min = 60
        #oneh_sec = 3600

        if not((seconds < 60) and (minu < 60) and (hour < 24)):
            print("It seconds or minutes paramenters have being into 0 at 59.")
        else:
            print("Como esta aqui?")
            minu = minutes * onedec_min
            sec =  seconds * onedec_sec
            print("Como esta aqui?", h+minu+sec)
            return h+minu+sec

    #def TimeToDecimal(self):