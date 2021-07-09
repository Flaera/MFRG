from bge import logic, events, types
from cars5 import Cars
from scripts.particle_system1 import ParticleSystem


def Start():
    cont = logic.getCurrentController()
    own = cont.owner

    own["gravity"] = 10

    #particle system:
    own["particle_nitro"] = ParticleSystem(1)
    own["particle_dust"]  = ParticleSystem(1) # I think that increase this after!

    lilas = Cars(own, "Lilás",
                 2.2, # max 5.1, min 1.9
                 52, # max 90, min 34
                 20, # max 30, min 16
                 30) # max 50, min 20


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    tap = logic.KX_INPUT_JUST_ACTIVATED

    # Id objecs for identification collisions:
    col_wall = bool(cont.sensors["col_wall"].positive)
    col_wallLL = bool(cont.sensors["col_wallLL"].positive)
    col_wallLR = bool(cont.sensors["col_wallLR"].positive)
    col_wallF = bool(cont.sensors["col_wallF"].positive)
    col_wallR = bool(cont.sensors["col_wallR"].positive)
    col_ground = bool(cont.sensors["col_chao"].positive)
    col_rampa = bool(cont.sensors["col_rampa"].positive)

    own.DebugCar()
    own.CarPhysics(keys[events.UPARROWKEY], keys[events.DOWNARROWKEY],
                   keys[events.RIGHTARROWKEY], keys[events.LEFTARROWKEY],
                   keys[events.ZKEY], keys[events.XKEY],  # brake and nitro
                   col_ground, col_wall, col_rampa,
                   col_wallLL, col_wallLR, col_wallF, col_wallR)

    # DEVO APERFEIÇOAR ESTA CLASSE. INCLUINDO A FUNÇAO ADDOBJ DA API DA BGE E FAZENDO...
    # A CLASSE EMITIR A PARTÍCULA CORRETA PARA O DETERMINADO CHAO (PROPRIEDADE COM O ...
    # O VALOR 0 PARA DUST/POEIRA, 1 PARA ASFALTO E 2 PARA BARRO MOLHADO)
    # calling particle system:
    if (own["nitro"] == True):
        own["particle_nitro"].AddParticleObj(cont, [cont.actuators["act_nitro1"],
                                                    cont.actuators["act_nitro2"]])

    # braking particles, smooths and dust:
    if (own["gear"] != int(0)):
        # only reuse the calling class in start function:
        own["particle_dust"].AddParticleObj(cont, [cont.actuators["act_dust1"],
                                                   cont.actuators["act_dust2"],
                                                   cont.actuators["act_dust3"],
                                                   cont.actuators["act_dust4"]])
        if (own["braking"] == True):
            own["particle_dust"].AddParticleObj(cont, [cont.actuators["act_dust1"],
                                                       cont.actuators["act_dust2"],
                                                       cont.actuators["act_dust3"],
                                                       cont.actuators["act_dust4"]])

# AINDA HÁ OBJETOS INDIVIDUAIS COM A PROPRIEDAED PAREDE QUE NAO...
# CORRESPODEM BEM AO SISTEMA DE COLISÃO. O CARRO AFUNDA E...
# ATRAVESSA O CHAO E CAI NO ESPAÇO, POR EXEMPLO.