from bge import logic, types
from scripts.car_physics.cars6 import Car
from scripts.particle_system1 import ParticleSystem
from scripts.data_manager import SearchPropValue
from data_files.car_general_infos import cars
from scripts.controls import Keys


def Start():
    cont = logic.getCurrentController()
    own = cont.owner

    own["gravity"] = 10

    # max 5.1, min 1.9
    # max 88, min 34
    # max 30, min 16
    # max 50, min 20
    lilas = Car(own, cars['3'][2], cars['3'][3], cars['3'][4], cars['3'][5])


    #particle system:
    current_scene = logic.getCurrentScene()
    lilas["particle_nitro"] = ParticleSystem(current_scene, ["particle_nitro_fire"], 0,
                                           [current_scene.objects["caixa_invoker_nitro"],
                                            current_scene.objects["caixa_invoker_nitro.001"]],
                                           1, 1)
    # The correct value will be put 8. Because It make conditional with fps of animation.

    ground_type = SearchPropValue("chao")
    #invokers = ["invoker_dust0", "invoker_dust1",
     #"invoker_dust2", "invoker_dust3"]
    invokers = ["invoker_dust2", "invoker_dust3"]
    lilas["particle_dust"] = ParticleSystem(current_scene, ["particle_dust_seco",
     "particle_dust_molhado", "particle_dust_asfalt"], ground_type, invokers, 15, 1)
     # I think that increase this after!
    
    lilas["particle_markbrake"] = ParticleSystem(current_scene, ["particle_markbrake"], 
    0, invokers, 90, 1)

    #for i in invokers:
        #invoker = current_scene.objects[i]
        #invoker.setParent(lilas)
        #print("VEIO", current_scene.objects[i].parent)
    
    

def CallingParticles(own):
    '''
    It only to call the particles.
    :return: none
    '''
    if (own.nitro == True):
        own["particle_nitro"].AddParticleObj()


    # braking and dust particles:
    if (own.gear != int(0)) and (own["particle_dust"].index_particle == 0):
        # only reuse the calling class in start function:
        own["particle_dust"].AddParticleObj()
        if (own.braking == True):
            own["particle_dust"].AddParticleObj()
            own["particle_markbrake"].AddParticleObj()
    elif (own.gear != int(0)) and (own.braking == True):
        own["particle_dust"].AddParticleObj()
        own["particle_markbrake"].AddParticleObj()



def Update(cont):
    own = cont.owner

   
    # Id objecs for identification collisions:
    col_wall = bool(cont.sensors["col_wall"].positive)
    col_wallLL = bool(cont.sensors["col_wallLL"].positive)
    col_wallLR = bool(cont.sensors["col_wallLR"].positive)
    col_wallF = bool(cont.sensors["col_wallF"].positive)
    col_wallR = bool(cont.sensors["col_wallR"].positive)
    col_ground = bool(cont.sensors["col_chao"].positive)
    col_rampa = bool(cont.sensors["col_rampa"].positive)
    #Id objects or identification os collissions with objects:
    col_obj1 = cont.sensors["col_obj1"].positive
    col_obj2 = cont.sensors["col_obj2"].positive

    controls = Keys()

    #own.DebugCar()
    own.MainCarPhysics(controls[0], controls[1],
                    controls[2], controls[3],
                    controls[4], controls[5],  # brake and nitro
                    col_ground, col_wall, col_rampa,
                    col_wallLL, col_wallLR, col_wallF, col_wallR,
                    col_obj1, col_obj2)

    # calling particle system:
    CallingParticles(own)

    #print("filhos de lilas", own.childrenRecursive)


