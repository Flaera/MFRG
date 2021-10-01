from bge import logic
from data_files.car_general_infos import cars

def Start(cont):
    pass
    
    
def Percent(x, maxx):
    return int((100*x)/maxx)


def Update(cont):
    own = cont.owner
    curr_scene_objs = logic.getCurrentScene().objects
    
    car = open(logic.expandPath("//data_files/car_selected.txt"), 'r')
    car_sel = car.split('\n')[0]
    for i in cars.keys():
        if i[0] == car_sel:
            #Actions:
            act_top_speed = cont.actuators["act_top_speed"]
            act_acceleration = cont.actuators["act_accel"]
            act_turning = cont.actuators["act_turning"]
            act_nitro_fully = cont.actuators["act_nitro_fully"]

            #Change specifications.
            curr_scene_objs["top_speed"]["top_speed"] = Percent(i[2], float(5.1))
            curr_scene_objs["accel"]["acceleration"] = Percent(i[3], float(88))
            curr_scene_objs["turning"]["turning"] = Percent(i[4], float(30))
            curr_scene_objs["nitro_fully"]["nitro_fully"] = Percent(i[5], float(50))
            #Activated the actions:
            cont.activate(act_top_speed)
            cont.activate(act_acceleration)
            cont.activate(act_turning)
            cont.activate(act_nitro_fully)
            

    car.close()
    
    
