from bge import logic, types
from scripts.manager_scenes import ManagerScenes


class MenuLista(types.KX_GameObject, ManagerScenes):
    def __init__(self, old_selector, number_options=1, deltay=float(1)):
        '''
        Constructor or initializator.
        '''

        # Calling variables of lass manager scene:
        self.final_time = ManagerScenes().final_time
        self.action = ManagerScenes().action
        self.action_load = ManagerScenes().action_load
        self.loading_now = ManagerScenes().loading_now

        self.old_selector = old_selector
        self.init_opt = int(1)
        self.final_opt = int(number_options)
        self.delta_opt = self.final_opt - self.init_opt

        self.selected_pos = int(0) # It's index
        self.selected_opt = int(1) # It's index + 1. Always into 1 and "n_options"...
        # insert in class.

        self.deltay = deltay


    def ConfirmationSelector(self, confirmation):
        '''
        Check if player confirmed the selected option.
        :param confirmation: It's key that warning of confirmation of user/player.
        :return: True if cofirm or false if user no confirm option selected.
        '''

        if confirmation: return True
        else: return False


    def ActionSelector(self, up, down):
        '''
        It manage the variables of option selected by the player. By this way, It's...
        help in the setting of variable position selected (selected_pos), that...
        assign the index of position of selector.
        It too apply the movements in selector.
        :param up: get the response of the sensor for if player to like up selector.
        :param down: get the response of the sensor for if player to like down selector.
        :return: none. Only manage the variables and applies movements.
        '''
        if (up) and not(self.selected_opt == self.init_opt):
            self.selected_opt -= 1
            self.applyMovement([0, self.deltay, 0], True)
        elif (up) and (self.selected_opt == self.init_opt):
            self.selected_opt = self.final_opt
            self.applyMovement([0, -(self.deltay*self.delta_opt), 0], True)

        elif (down) and not(self.selected_opt == self.final_opt):
            self.selected_opt += 1
            self.applyMovement([0, -self.deltay, 0], True)
        elif (down) and (self.selected_opt == self.final_opt):
            self.selected_opt = self.init_opt
            self.applyMovement([0, (self.deltay*self.delta_opt), 0], True)

        self.selected_pos = int(self.selected_opt - 1)


    def ActivateMenuControl(self, confirm, up, down):

        self.ActionSelector(up, down)

        if (self.ConfirmationSelector(confirm)) == True:
            return [True, (self.selected_pos)]
        else:
            return [False, (self.selected_pos)]


    def DebugaAi(self):
        print("debug var/props: ", self.selected_pos, self.selected_opt, sep=", ")


