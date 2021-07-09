from bge import logic, types, events
from scripts.map_events_scripts.map_events import MapEventsChildrens


def Start(cont):
    own = cont.owner
    event_children = MapEventsChildrens(own, 1, 3, 13)


def Update(cont):
    own = cont.owner

    # For collision sensor manage, It have that to be sensor preset in physics painel...
    # and anything corpus collision selected:
    col_cursor = own.sensors["col"]
    current_scene = logic.getCurrentScene()

    own.OpenCloseBoard(col_cursor, current_scene,
                       logic.getCurrentScene().objects["event_board"])

    keys = logic.keyboard.events
    confirm = keys[events.ENTERKEY] == logic.KX_INPUT_JUST_ACTIVATED

    if ((confirm) and (col_cursor.positive == True) and (own["active"] == True)) \
            or (own.action_load == True):
        own.TimeChangeScene(confirm, current_scene.objects["empty_map"]["dtime_map"], 0.5)
        own.TransitionLoadingScenes("loading", "event1_char1", cont,
                                    [cont.actuators["re_map"],
                                     cont.actuators["re_map_smh"],
                                     cont.actuators["re_loading"]])

    elif (confirm): print("Oxi! Ta maluco! Não tem evento aqui.")
