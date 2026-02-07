#from bge import types


class ParticleSystem():
    def __init__(self, number_particle_by_drawcall=1,
                 active_dt=False, dt_invocation=1):

        #self.scene = scene
        #self.particle = particle
        #self.list_invokers = list_references
        #self.life_time_fps = life_time
        self.npdc = number_particle_by_drawcall # number of particles by draw call

        # Var utils in linear function to add particles at time change...
        # (development no complete):
        self.active_dt = active_dt
        self.dt_invocation = dt_invocation
    # DEVO APERFEIÇOAR ESTA CLASSE. INCLUINDO A FUNÇAO ADDOBJ DA API DA BGE E FAZENDO...
    # A CLASSE EMITIR A PARTÍCULA CORRETA PARA O DETERMINADO CHAO (PROPRIEDADE COM O ...
    # O VALOR 0 PARA DUST/POEIRA, 1 PARA ASFALTO E 2 PARA BARRO MOLHADO)

    def AddParticleObj(self, cont, acts_addObj, delta_invocation=30):
        '''
        Simply the added the particle at scene.
        :param scene:
        :param particle_obj:
        :param list_invokers:
        :param life_time_fps:
        :param npdc: number of particles by draw call
        :return:
        '''
        for a in acts_addObj:
            for p in [0, self.npdc]:
                cont.activate(a)


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



