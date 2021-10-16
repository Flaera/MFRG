from bge import logic, types, events
from scripts.map_events_scripts.map_events import MapEventsChildrens
from data_files.prices_events import prices


def Start(cont):
    own = cont.owner
    event_children = MapEventsChildrens(own, 1, prices[1]) #There have modifications in each self script


def Update(cont):
    own = cont.owner

    # For collision sensor manage, It have that to be sensor preset in physics painel...
    # and anything corpus collision selected:
    col_cursor = own.sensors["col"]
    current_scene = logic.getCurrentScene()

    own.OpenCloseBoard(col_cursor, current_scene,
                       logic.getCurrentScene().objects["event_board.001"]) # setting object board

    keys = logic.keyboard.events
    confirm = keys[events.ENTERKEY] == logic.KX_INPUT_JUST_ACTIVATED

    if ((confirm) and (col_cursor.positive == True) and (own["active"] == True)):
        own.OnlyAddScene("talk_zu") #Name of talk scene 
        own.OnlyRemoveScenes(cont, [cont.actuators["re_map"], cont.actuators["re_map_smh"], cont.actuators["re_gold"]])

    elif (confirm): print("Oxi! Ta maluco! Não tem evento aqui.")
