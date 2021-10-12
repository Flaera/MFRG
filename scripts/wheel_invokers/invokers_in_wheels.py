from bge import logic
from scripts.data_manager import SearchObjPropValue


def Start(cont):
    own = cont.owner
    #I think to edit this, because I have adapt the script at difenrents types of wheels
    #It can make with conditionals
    curr_scene = logic.getCurrentScene()
    own["wheel0"] = logic.getCurrentScene().objects[SearchObjPropValue("wheel", 0, curr_scene)]
    own["wheel1"] = logic.getCurrentScene().objects[SearchObjPropValue("wheel", 1, curr_scene)]
    own["wheel2"] = logic.getCurrentScene().objects[SearchObjPropValue("wheel", 2, curr_scene)]
    own["wheel3"] = logic.getCurrentScene().objects[SearchObjPropValue("wheel", 3, curr_scene)]

    own["delta_y"] = float(0)
    own["delta_z"] = float(-0.5)
    
    own["others_wheel_invokers"] = [curr_scene.objects["invoker_dust0"],
     curr_scene.objects["invoker_dust1"],
     curr_scene.objects["invoker_dust3"]]


def Update(cont):
    own = cont.owner

    #set position in each wheel:
    own["others_wheel_invokers"][0].worldPosition = [own["wheel0"].worldPosition.x,
     own["wheel0"].worldPosition.y + own["delta_y"],
     own["wheel0"].worldPosition.z + own["delta_z"]]
    
    own["others_wheel_invokers"][1].worldPosition = [own["wheel1"].worldPosition.x,
     own["wheel1"].worldPosition.y + own["delta_y"],
     own["wheel1"].worldPosition.z + own["delta_z"]]
    
    own.worldPosition = [own["wheel2"].worldPosition.x,
     own["wheel2"].worldPosition.y + own["delta_y"],
     own["wheel2"].worldPosition.z + own["delta_z"]]

    own["others_wheel_invokers"][2].worldPosition = [own["wheel3"].worldPosition.x,
     own["wheel3"].worldPosition.y + own["delta_y"],
     own["wheel3"].worldPosition.z + own["delta_z"]]
