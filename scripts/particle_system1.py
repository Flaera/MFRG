#from bge import types


class ParticleSystem():
    def __init__(self, scene, particles, index_particle, references_list, life_time,
                 number_particle_by_drawcall=1, active_dt=False, dt_invocation=1):

        self.scene = scene
        self.particles_list = particles
        self.index_particle = int(index_particle)
        self.invokers_list = references_list
        self.life_time_fps = life_time
        self.npdc = number_particle_by_drawcall # number of particles by draw call

        # Var utils in linear function to add particles at time change...
        # (development no complete):
        #self.active_dt = active_dt

    def AddParticleObj(self):
        '''
        It add the particle in scene.
        :return: the object that reference at the particle in game.
        '''
        for i in self.invokers_list:
            for p in [0, self.npdc]:
                self.scene.addObject(self.particles_list[self.index_particle],
                                     i, self.life_time_fps)


    def LinearPDCAddParticleObj(self, current_x, cont, acts_addObj, delta_invocation=30):
        '''
        No completed implementation.
        :param current_x:
        :param cont:
        :param acts_addObj:
        :param delta_invocation:
        :return:
        '''
        # In It's function pdc equal or more than 1 and less than...
        # max_pdc. By the wall, max_pdc been more than 1.

        lpdc = int((4 * current_x) + 1)
        for a in acts_addObj:
            for p in [0, lpdc]:
                cont.activate(a)



