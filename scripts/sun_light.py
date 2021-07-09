from bge import logic
from scripts.data_manager import SearchObjProp


def Start(cont):
    sun = cont.owner

    sun["car_select"] = SearchObjProp("car")


def Update(cont):
    sun = cont.owner

    car = logic.getCurrentScene().objects[sun["car_select"]]

    delta_x = 0
    delta_y = 0
    delta_z = float(0)

    sun.localPosition = [car.localPosition.x+delta_x,
                         car.localPosition.y+delta_y,
                         sun.localPosition.z+delta_z]
    #camera.
