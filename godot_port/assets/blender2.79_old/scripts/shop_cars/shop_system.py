from bge import logic, types
from data_files.car_general_infos import cars
from scripts.manager_scenes import ManagerScenes


class CarShop(types.KX_GameObject, ManagerScenes):
    def __init__(self, old_owner, index_scene, curr_key, curr_car, m_cars):
        '''Constructor'''
        self.own = old_owner
        self.index_shop = index_scene
        self.current_key = curr_key
        self.current_car = curr_car
        self.max_cars = m_cars


    def GetCurrentCar(self): return self.current_car
    def GetCurrentKey(self): return self.current_key


    def SwapCars(self):
        scene_list = logic.getSceneList()
        self.current_car.endObject()
        #del self.current_car
        car = cars[self.current_key][0].split('_')[0]+"_only_asset"
        self.current_car = scene_list[self.index_shop].addObject(car, "logic_point")



    def ToLeft(self):
        curr = int(self.current_key)-1
        if curr<0:
            curr = self.max_cars-1
        self.current_key = str(curr)
        print("LEFT")


    def ToRight(self):
        curr = int(self.current_key)+1
        if curr>=self.max_cars:
            curr = 0
        self.current_key = str(curr)
        print("RIGHT")

    
    def SellCar(self, cont):
        gold_int = 0
        with open(logic.expandPath("//data_files/gold.txt"), 'r') as gold_file:
            gold_str = gold_file.read()
            gold_int = int(gold_str)
        
        amount_cars = 0
        car_str = []
        with open(logic.expandPath("//data_files/player_cars.txt"), 'r') as car_file:
            car_str = car_file.readlines()
            amount_cars = int(len(car_str))
        print("cars vec=", car_str)
        if (amount_cars==3):
            self.OnlyAddScene("conf_screen_fully_garage")
            self.OnlyPauseScene(cont, [cont.actuators["pau_shop"],
            cont.actuators["pau_shop_ui"]])
            return 1
        elif (gold_int<cars[self.current_key][1]):
            self.OnlyAddScene("conf_screen_no_money")
            self.OnlyPauseScene(cont, [cont.actuators["pau_shop"],
            cont.actuators["pau_shop_ui"]])
            return 2
        else:
            for i in car_str:
                if (i.split('_')[0]==self.current_car.name.split('_')[0]):
                    self.OnlyAddScene("conf_screen_already_car")
                    self.OnlyPauseScene(cont, [cont.actuators["pau_shop"],
                    cont.actuators["pau_shop_ui"]])
                    return 3

        gold_int = gold_int-cars[own["current_key"]][1]
        with open(logic.expandPath("//data_files/gold.txt"), 'w') as gold_file:
            gold_file.write(str(gold_int))
        with open(logic.expandPath("//data_files/player_cars.txt"), 'a') as cars_file:
            cars_file.write(self.current_car.name.split('_')[0]+"_proxie\n")
        return 4