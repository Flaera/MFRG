from bge import logic, types
from scripts.manager_scenes import ManagerScenes

class MapEventsFromChar():
    #def __init__(self, char1, char2, char3, map_scene):
    '''
    Constructor or initializaator.
    It's class reference at the events that each character have. It manage ...
     the big groups of events.
    It have that be in map script.
    '''
     #   self.char1 = char1
      #  self.char2 = char2
       # self.char3 = char3
        #self.map_scene = map_scene # scene for addObject method of api bge
    # IT'S FUNCTION SHOW ME THAT SELF HAVE THAT TO BE USED SAME IF INIT ...
    # FUNCTION CONTRUCTING NO ATRIBUTTED.

    def CallEventsOneChar(self, main_char_obj, map_scene):
        '''
        It apply recursion in chilkdrens objects of each characters for to show the ...
        events to the player and activate the logic in events objects empties.
        It take support to function CallEventsInChars().
        :param main_char_obj: object own of empties objects with logic of each event.
        :param map_scene: scene of the map to add icon of event and to able the logic.
        :return: none
        '''
        for obj in main_char_obj.children:
            obj["active"] = True # It's flag activate the the logic in spot/empty...
            # object that have logic of each event.
            map_scene.addObject("event_icon", obj.name)


    def CallEventsInChars(self, char1, char2, char3,
                          obj_char1, obj_char2, obj_char3, map_scene):
        '''
        It make the same something that befiore function, but using the before function...
        for at reference of values in chars variables to manage the events in map.
        :param char1: value of character reference at the progress of the player in game.
        :param char2: value of character reference at the progress of the player in game.
        :param char3: value of character reference at the progress of the player in game.
        :param obj_char1: object of events relative at character unlocked.
        :param obj_char2: object of events relative at character unlocked.
        :param obj_char3: object of events relative at character unlocked.
        :param map_scene: scene to add the object icon and activate the logic...
         in each event.
        :return: none
        '''
        if char1 == True:
            self.CallEventsOneChar(obj_char1, map_scene)
        elif (char2 == True):
            self.CallEventsOneChar(obj_char1, map_scene)
            self.CallEventsOneChar(obj_char2, map_scene)
        elif (char3 == True):
            self.CallEventsOneChar(obj_char1, map_scene)
            self.CallEventsOneChar(obj_char2, map_scene)
            self.CallEventsOneChar(obj_char3, map_scene)


    # def CalledEvents() chama os eventos de acordo com os valores das variaveis "char"...
    # in "map.py" script.
    # AQUI ANTES DE RECONHECER OS EVENTS DEVO PASSAR UM FOR PARA QUE UM ARQUIVO...
    # NO QUAL CADA LINHA CORRESPONDE A UM EVENTO NO JOGO. É  O MESMO AQRUIVO DA SELECAO...
    # DE PERSONAGENS. SÓ QUE NÁ PRÁRTICA MUDA UM POUCO. PQ SE O SEGUNDO ESTIVER TRUE...
    # VAI LIBERAR O ANTERIOR TAMBÉM
    # if char1 == True:
    #   for obj in scene.objets["event_mother1"].children:
    #       if "event" in obj: nao precisa disso. porque já estou navegando nos filhos.
    #           add_event
    # E ASSIM VAI PARA OS OUTROS PERSONAGENS. DEVO ENCAPSSULAR OS TRÊS FOR_LOOPS...
    # EM UMA UNICA FUNCTION, QUE SERVIRA PARA AUXILIAR A FUNCÇÃO "CALLEDEVENTS()"
    # I no manage this last part.


class MapEventsChildrens(types.KX_GameObject, ManagerScenes):
    def __init__(self, old_owner, lv, time_min, time_sec):
        '''
        Constructor or initializaator.
        It's class reference at the units of events opens for the class...
        MapEventsFromChar().
        It each script her.
        '''

        self.final_time = ManagerScenes().final_time
        self.action = ManagerScenes().action
        self.action_load = ManagerScenes().action_load
        self.loading_now = ManagerScenes().loading_now

        self.event_own = old_owner
        #if (self["active"] == bool(True)):
        # ACHO QUE VOU TER TIRAR ESA CONDICIO0NAL E MOVER ELA PARA O START MODULE...
        # E INICIAR AS VARIAVEIS INDEPENDETE DA ACTIVE BOOL VALUE
        self.board_text = "Nível: {2}\nTempo: {0}min{1}".format(time_min, time_sec, lv)
        self.added_board = 0
        self.count_add_board = 0
        #else:
         #   print("It's active property no True. Verifying this. 'active' bool value: {0}".format(self["active"]))
        print("Evento 1, char 1, iniciado")

    def OpenCloseBoard(self, collision_sens, map_scene, empty_board_obj):
        '''
        It to add the board with characteristics of event and to delete It object...
         after tat cursor exit do spot of event in map.
        It have be called in update function.
        :param collision_sens: sensor that warniing if object in contact with ...
        material of cursor.
        :param map_scene: scene of the map. Normaly, the current scene.
        :param empty_board_obj: empty object to add in this same informations of...
         location.
        :return: none
        '''
        if (collision_sens.positive == True) and (self["active"] == True)\
                and (self.count_add_board == 0):
            self.count_add_board = 1
            print("Evento selecionado.")
            self.added_board = map_scene.addObject("board", empty_board_obj)
            self.added_board.playAction("board_map_anima", 1, 14)
            logic.getCurrentScene().objects["board_text"]["Text"] = self.board_text
        elif (collision_sens.positive == False) and (self["active"] == True)\
              and (self.count_add_board == 1):
            self.count_add_board = 0
            self.added_board.endObject()
