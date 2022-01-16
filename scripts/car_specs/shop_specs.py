from bge import logic
from scripts.car_specs.board_specs import Percent
from data_files.car_general_infos import cars


def Update(cont):
    own = cont.owner
    curr_scene_objs = logic.getCurrentScene().objects
    
    key = str('')
    file_key = open(logic.expandPath("//data_files/curr_key_car.txt"), 'r')
    key = file_key.read()
    #car_sel2 = .split('\n')[0]+'\0'
    #for i in cars.keys():
        #print("carsel2:-", car_sel2, cars[i][0])
        #if IsEqualString(cars[i][0], car_sel2)==True:
            #print("i:-", i)
            #Actions:
    act_top_speed = cont.actuators["act_top"]
    act_acceleration = cont.actuators["act_accel"]
    act_turning = cont.actuators["act_turning"]
    act_nitro_fully = cont.actuators["act_nitro"]
    #Change specifications.
    curr_scene_objs["top_speed"]["top_speed"] = Percent(cars[key][3], float(88))
    curr_scene_objs["accel"]["accel"] = Percent(cars[key][2], float(5.1))
    curr_scene_objs["turning"]["turning"] = Percent(cars[key][4], float(30))
    curr_scene_objs["nitro_fully"]["nitro_fully"] = Percent(cars[key][5], float(50))
    #Activated the actions:
    cont.activate(act_top_speed)
    cont.activate(act_acceleration)
    cont.activate(act_turning)
    cont.activate(act_nitro_fully)
            

    file_key.close()
    