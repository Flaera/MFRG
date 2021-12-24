from bge import logic, types
from scripts.manager_scenes import ManagerScenes


class SampleMenuHorizontal(ManagerScenes):
    def __init__(self, back_main_menu, restart, back=True):
        '''
        Constructor or initializator.
        In this class unknow selector only icons and options of acess...
        although keys. Don't is manager scenes? NO. It only invoke the buttons...
        and able (By return in functions boolens values, flags) the change of...
         scenes with use of class ManagerScenes.
        It's menu sample horizontal only.
        :param back: flag to invoker function of back
        :param back_main_menu: flag to invoker funtion that back all at the main menu.

        Somethings deleteds:
        :param yes: flag to invoker function that confim action/question...
         requered at player (Deprecated. It was replace for one function...
          of called ConfirmationScreen())
        :param no: flag to invoker function that no confim action/question...
         requered at player (Deprecated. It was replace for one function...
          of called ConfirmationScreen())
        :param restart: flag that invoker function that restart the race
        :param skip (deprecated. It was choiced that this put in the function of...
         dialogues): flag that invoker function that skip one scene of dialogue
        '''

        self.final_time  = ManagerScenes().final_time
        self.action      = ManagerScenes().action
        self.action_load = ManagerScenes().action_load
        self.loading_now = ManagerScenes().loading_now

        # Flags that activated the options for user selected by the keys presseds...
        # In game, It's options have showed in the same order.
        self.back = back
        self.back_all = back_main_menu
        #self.yes = yes
        #self.no = no
        self.restart_chalenge = restart
        #self.skip_dial = skip (Deprecated. See the motive of this in comentary of...
        # function.


    def VisiOffChildrens(self, obj, recusive=False):
        '''
        It's function make recursion once that paramenter recursive no manage like...
        API of BGE describe.
        :param obj: mother object.
        :param recusive: flag that if False make the recursion in each....
         children of object
        :return: none
        '''
        if recusive == False:
            for i in obj.childrenRecursive:
                i.setVisible(False)


    def InvokeBack(self, button_obj):
        '''
        It invoke or turn on visible the button that back at the before scene.
        :param button_obj: obj of the button. It have that to be index
        :return: False if requered in init function, True if requered in init
        '''
        if (self.back == True):
            button_obj.setVisible(True)
        else:
            button_obj.setVisible(False)
            self.VisiOffChildrens(button_obj, False)


    def InvokeBackAll(self, button_obj):
        '''
        It invoke or turn on visible the button that back all, at the map or main menu.
        :param button_obj: obj of the button. It have that to be index
        :return: False if requered in init function, True if requered in init
        '''
        if (self.back_all == True):
            button_obj.setVisible(True)
        else:
            button_obj.setVisible(False)
            self.VisiOffChildrens(button_obj, False)


    def InvokeRestart(self, button_res):
        '''
        It invoke or turn on visible the button of restart.
        :param button_res: obj of the button It have that to be index
        :return: False if requered in init function, True if requered in init
        '''
        if (self.restart_chalenge == True):
            button_res.setVisible(True)
        else:
            button_res.setVisible(False)
            self.VisiOffChildrens(button_res, False)


class ConfirmationMenuScreen(types.KX_GameObject, ManagerScenes):
    def __init__(self, own, text_question="", number_options=2, deltax=9):
        '''Constructor or nitializator.
        Onlyu menu screen to confirm the action/choice...
         of the player.
        '''

        self.final_time = ManagerScenes().final_time
        self.action = ManagerScenes().action
        self.action_load = ManagerScenes().action_load
        self.loading_now = ManagerScenes().loading_now

        self.old_selector = own
        self.text_question = text_question # It was create to help if I have to work...
        # with edition of text.
        self.number_opt = number_options
        self.deltax = deltax

        self.selector_pos = int(1)
        self.selector_index = int(0) # It equal at: selector_pos - 1


    def ConfirmationUser(self, confirm):
        '''
        It only set the confirmation for option selected...
        by the user.
        :param confirm: key that confirma action of user, with...
        tap activated.
        :return: true if confirmed, else false.
        '''
        if confirm == True: return True
        else: return False


    def ActionSelector(self, left, right):
        '''
        It define teh actions of selector in menu conf. screen and manage the ...
        variables to set responses of the actions of player.
        :param left: left key, with tap activated.
        :param right: only right key , with tap activated.
        :return: none
        '''
        if (left or right) and (self.selector_pos == 1):
            self.selector_pos += 1
            self.applyMovement([9, 0, 0], True)
        elif (left or right) and (self.selector_pos == 2):
            self.selector_pos -= 1
            self.applyMovement([-9, 0, 0], True)

        self.selector_index = (self.selector_pos - 1)


    def ActiveMenuConfScreen(self, confirm, left, right):
        '''
        It called the before functions to active the menu confimation screen context.
        :param confirm: key to confim actio of player with tap ativated.
        :param left: key to move for left the selector with tap activated.
        :param right: key to move for right the selector with tap activated.
        :return: list showing if player confirmed the option selected...
         (True or False) and index da position selected (0 - sim - or 1 - no).
        '''
        self.ActionSelector(left, right)
        return [self.ConfirmationUser(confirm), self.selector_index]


# PORQUE NÃO CONSEGUI FAZER ESTA CLASSE ABAIXO HERDAR O CLASSE CONFIRMATIONMENUSCREEN()
# erro: pesquisar: "TypeError: Cannot create a consistent method resolution
# order (MRO) for bases ManagerScenes, KX_GameObject, ConfirmationMenuScreen"
# Testes solucionaram minha duvida: se a ser herdade ja tem KX_GameObject and...
# ManagerScenes então eu no preciso mencionar para a classe filha estas mesmas...
# classes. Isso é algo que faz sentido, pois do modo com era feito antes estaria...
# chamando o mesmo código duas vezes.
class HardMenuHorizontal(ConfirmationMenuScreen):
    def __init__(self, own, number_options=1, deltax=1):
        '''Constructor or initializator.
        In this class exist one selector for user sleected options at according...
         with your preferences.
        '''

        self.final_time = ManagerScenes().final_time
        self.action = ManagerScenes().action
        self.action_load = ManagerScenes().action_load
        self.loading_now = ManagerScenes().loading_now

        self.old_selector = own
        self.number_opt = number_options
        self.deltax = deltax

        self.selector_pos = int(1)
        self.selector_index = int(0)


    def ActionSelectorHardMenuHori(self, left, right):
        '''
        It's function define the positions of the selector to the keys inserts...
         by user.
        :param left: key that define the user to like to move the selector for left...
        direction
        :param right: key that define thar user to like to move the selector for...
        right direction.
        :return: none
        '''
        if (left) and (self.selector_pos == 1): # If It's in position initial.
            self.selector_pos = self.number_opt
            self.applyMovement([-(self.deltax * (self.number_opt - 1)), 0, 0], True)
        elif (left) and (self.selector_pos > 1):
            self.selector_pos -= 1
            self.applyMovement([self.deltax, 0, 0], True)

        elif (right) and (self.selector_pos == self.number_opt):
            self.selector_pos = int(1)
            self.applyMovement([(self.deltax * (self.number_opt - 1)), 0, 0], True)
        elif (right) and (self.selector_pos < self.number_opt):
            self.selector_pos += 1
            self.applyMovement([-self.deltax, 0, 0], True)

        self.selector_index = self.selector_pos - 1


    def ActiveHardMenuHoriControl(self, confirm, left, right):
        '''
        It's function called functions before in this class to applying modifications...
        in selector horizontal menu and to check if the user confirmed the actions.
        :param confirm: key that define that player confirmed the option.
        :param left: key that make the selector to move for left direction.
        :param right: key that make the selector to move for right direction.
        :return: return one list with one flag setting if user confirmed the option ...
        selectd and index of this option.
        '''
        self.ActionSelectorHardMenuHori(left, right)
        return [self.ConfirmationUser(confirm), self.selector_index]


    def SetInitPos(self):
        self.applyMovement([self.deltax*(self.selector_pos-1), 0, 0], True)
        self.selector_pos = 1
        self.selector_index = self.selector_pos-1
        return self.selector_index