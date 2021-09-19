from bge import logic
from data_files.car_general_infos import cars


def Start(cont):
	pass


def Update(cont):
	curr_car = open(logic.expandPath("//data_files/car_selected.txt"), "r")
	car = curr_car.split('\n')[0]
	
	print(cars.keys)





	curr_car.close()
