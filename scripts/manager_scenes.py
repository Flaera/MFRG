from bge import logic, types
#from bge.types import PyObjectPlus


class ManagerLoadingScenes():
    def __init__(self):
        '''Constructor or initializator.'''

        # It are variables only used for scenes that needed of the "scene of loading":
        self.final_time = 0 # Time final with increment of delta time i code running.
        self.loading_now = False # Define the time to load the loading scene only...
        # one time.
        self.action_load = False # Define the time of to...
        # active the act of to add scene of loading at to set scene. While It var...
        # run the property delta time run too.
        self.action = False  # True why the property time is more then max_time_wait...
        # setting, then the time to change scene.


    def TimeChangeScene(self, confirmation, delta_time, max_time_wait=0.5):
        '''
        It manage the variables to set time of everything have that action.
        :param confirmation: response if user confime the option selected.
        :param delta_time: time of property in menu.
        :param max_time_wait: max time of waiting of player for change to next scene.
        :return: none.
        '''
        if not(confirmation == True) and (self.action_load == False):
            self.action = False
            self.action_load = False
            self.loading_now = False
        elif (confirmation == True):
            self.final_time = float(delta_time + max_time_wait)
            self.action = False
            self.action_load = True
            self.loading_now = True # Here add loading scene, finally, and ONLY TIME!
        elif not(confirmation == True) and (self.action_load == True)\
                and (delta_time < self.final_time):
            self.action = False
            self.loading_now = False
        elif (self.action_load == True) and (delta_time >= self.final_time):
            self.action = True
            self.action_load = True
            self.loading_now = False


    def AddLoadingScene(self, str_scene):
        '''
        It adding the loading scene.
        :param str_scene: loading scene to be adding. It have that be string type.
        :return: none
        '''
        if self.loading_now == True:
            logic.addScene(str(str_scene))


    def AddAnyScene(self, str_scene):
        '''
        It adding any scene put like parameter (string). It manage like at scene...
         actuator in the mode "Add_Overlay_Scene".
        :param str_scene: scene to be adding. It have one string.
        :return: none
        '''

        if self.action == True:
            logic.addScene(str(str_scene))


    def RemoveScenes(self, cont, sceneact_list):
        '''
        It remove scene that are put him like parameter in form of list.
        :param cont: controller this module.
        :param sceneact_list: list of scene actuators with remove mode activated for...
        delete scenes useless and by this way to free the memory ram.
        :return: none
        '''
        if self.action == True:
            for a in sceneact_list:
                cont.activate(a)
                cont.deactivate(a)


    def DebugManagerScenes(self):
        '''
        It manage only to debug variables and properties in the system.
        :return: none
        '''
        print(self.action, "action", self.action_load, "action_load", self.loading_now,
              "loding now")


class ManagerScenes(ManagerLoadingScenes):
    # I don't manage get the types.KX_Scene. Nem com isso types.KX_Scene(PyObjectPlus)
    def __init__(self):
        '''
        Constructor or initializator.
        '''
        # O certo e que aprendi que ao utlizar classes e quere usar variables de outra...
        # function construtora, __init__, de class herdada devo chama las de novo na...
        # children class. It's the case:
        self.final_time = ManagerLoadingScenes().final_time
        self.action = ManagerLoadingScenes().action
        self.action_load = ManagerLoadingScenes().action_load
        self.loading_now = ManagerLoadingScenes().loading_now

        #self.const_amb_mlscenes = ManagerLoadingScenes()


    def TransitionLoadingScenes(self, loading_scene, add_scene,
                                controller, scnlist_remove):
        '''
        It use functions of class that manage the trasition in scenes that need of...
        loading scene. This need of the called before of "TimeChangeScene()"...
         function that are into this class.
        :param loading_scene: scene of loading.
        :param add_scene: scene to add.
        :param controller: controller of module or script.
        :param scnlist_remove: list of scenes to remove.
        :return: none
        '''
        self.AddLoadingScene(loading_scene)
        self.AddAnyScene(add_scene)
        self.RemoveScenes(controller, scnlist_remove)


    def OnlyAddScene(self, add_scene):
        '''
        Only add one scene. It manage equal to actuator scene in mode...
         "Add Overlay Scene".
        :param add_scene: scene to add. It have that to be type string.
        :return: none
        '''
        logic.addScene(str(add_scene))


    def OnlyPauseScene(self, cont, acts_pause):
        '''
        It use the actuators of scene for suspend the most scene putting in list in...
        parameters.
        :param cont: reference at the controller in bge.
        :param acts_pause: reference at list of actuators of scene in mode suspend.
        :return: none
        '''
        for s in acts_pause:
            cont.activate(s)
            cont.deactivate(s)


    def OnlyResumeScene(self, cont, acts_scenes_resume):
        '''
        It make the resume of scene before paused although actuators scenes in mode...
        resume.
        :param cont: controller reference in bge.
        :param acts_scenes_resume: list of actuators of scene for activated
        :return: none
        '''
        for s in acts_scenes_resume:
            cont.activate(s)
            cont.deactivate(s)


    def OnlyRemoveScenes(self, cont, sceneact_list):
        '''
        Only remove the scenes in list put like parameter.
        :param cont: controller of script or module.
        :param sceneact_list: list of actuators of scene in mode remove.
        :return: none.
        '''
        for a in sceneact_list:
            #logic.end(a) I have test It after, but can't getting right because API...
            # no difine more.
            cont.activate(a)
            cont.deactivate(a)

