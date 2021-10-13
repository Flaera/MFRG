from bge import logic, events
from scripts.menu_scripts.menu_lista import MenuLista
from scripts.map_events_scripts.map_events import MapEventsFromChar
from scripts.time_manager import TimeAction1


def Start():
    cont = logic.getCurrentController()
    own = cont.owner

    # To manage the values of movement in x and y axis:
    own["deltax"] = float(0)
    own["deltay"] = float(0)
    own["deltax_cursor"] = float(0)
    own["deltay_cursor"] = float(0)

    cursor_cam = MenuLista(own, 5)
    
    # Add horizontal menu in scene and events:
    cursor_cam.OnlyAddScene("map_menu_hori_button")

    char1 = True
    char2 = False
    char3 = False
    with open(logic.expandPath("//data_files/progress_in_game.txt"), 'r') as chars_file:
        chars = chars_file.read().split('\n')
        char1 = bool(chars[0])
        char2 = bool(chars[1])
        char3 = bool(chars[2])
    map_events = MapEventsFromChar().CallEventsInChars(char1, char2, char3,
                                   logic.getCurrentScene().objects["events_char1"],
                                   logic.getCurrentScene().objects["events_char2"],
                                   logic.getCurrentScene().objects["events_char3"],
                                   logic.getCurrentScene())

    cursor_cam.OnlyAddScene("gold_board")


def SetVectorCamKeyboard(cursor_cam, up, down, left, right, x_max, y_max, constant):
    '''
    It function define the direction of movement of map cursor, this cursor is mother...
     object from camera.
    :param cursor_cam: cursor object of map.
    :param up: key to up cursor with camera
    :param down: key to down the camera.
    :param left: key to left direction
    :param right: key to move to right direction.
    :return: list/vector with directions of moves.
    '''
    x_inc = x_max / constant
    y_inc = y_max / constant
    x = 0
    y = 0

    if (up) and (cursor_cam["deltay"] < y_max):
        cursor_cam["deltay"] += y_inc
        y = 1
    elif (down) and (cursor_cam["deltay"] > -y_max):
        cursor_cam["deltay"] -= y_inc
        y = -1

    if (left) and (cursor_cam["deltax"] > -x_max):
        cursor_cam["deltax"] -= x_inc
        x = -1
    elif (right) and (cursor_cam["deltax"] < x_max):
        cursor_cam["deltax"] += x_inc
        x = 1

    return [x, y, 0] # It 0 in z x is for no to move


def MoveCursorKeyboard(cursor_cam, x_max, y_max,
                       up, down, left, right, constant):
    '''
    It manage the movements of the cursor in map.
    :param cursor_icon: object that move the cursor.
    :param x_max_cam: maximum limite of movement in y axis fro camera object
    :param y_max_cam: maximum limite of movement in y axis fro camera object

    :param cursor_cam: cursor object taht move camera in map.
    :param x_max: maximum limite for move cursor in map for x axis.
    :param y_max: maximum limite for move cursor in map for y axis.
    :param up: key to up cursor with camera
    :param down: key to down the camera.
    :param left: key to left direction
    :param right: key to move to right direction.
    :return: list/vector with directions of moves.
    '''
    x_inc = x_max / constant
    y_inc = y_max / constant
    x = 0
    y = 0
    if (up) and (cursor_cam["deltay_cursor"] < y_max):
        cursor_cam["deltay_cursor"] += y_inc
        y = 1
    elif (down) and (cursor_cam["deltay_cursor"] > -y_max):
        cursor_cam["deltay_cursor"] -= y_inc
        y = -1

    if (left) and (cursor_cam["deltax_cursor"] > -x_max):
        cursor_cam["deltax_cursor"] -= x_inc
        x = -1
    elif (right) and (cursor_cam["deltax_cursor"] < x_max):
        cursor_cam["deltax_cursor"] += x_inc
        x = 1

    return [x, y, 0] # Vector with directions of movement.


def Update(cont):
    own = cont.owner

    keys = logic.keyboard.events
    up = keys[events.UPARROWKEY]
    down = keys[events.DOWNARROWKEY]
    left = keys[events.LEFTARROWKEY]
    right = keys[events.RIGHTARROWKEY]

    x_max = 222#158.78
    y_max = 170#120.95
    constant = 150
    vector_cursor = SetVectorCamKeyboard(own, up, down, left, right, x_max, y_max, constant)
    #print("Como as coisas estão: ", vector_cursor,
     #     own["deltay"], own["deltax"], sep=", ")

    # To apply the movements of camera and cursor:
    deltax_speed = float(x_max/constant) #0.26# Speed research in each call of game...
    # engine for axis.
    deltay_speed = float(y_max/constant) #0.19
    timer_map = TimeAction1(own["timer_map"])
    own["timer_map"] = timer_map[1]
    if (timer_map[0]==True):
        own.applyMovement([vector_cursor[0]*deltax_speed, vector_cursor[1]*deltay_speed, 0], True)

    # To move cursor if x or y vector are in maximum limite:
    current_scene = logic.getCurrentScene()
    cursor = current_scene.objects["cursor"]
    # Int he end, I think that for optimization can make only one function and manage...
    # the varaibles "x_inc" and "y_inc" in each function that movement of cursor to...
    # eliminate the "delta_speeds" variables.
    '''if (timer_map[0]==True):
        vector_cursor_icon = MoveCursorKeyboard(own, x_max, y_max,
                                            up, down, left, right, constant)
        cursor.applyMovement([vector_cursor_icon[0]*deltax_speed,
                          vector_cursor_icon[1]*deltay_speed, 0], True)
    '''
    # To call the animation of cursor:
    # It's code show me that animations putted in locals with...
    # logic (Principle logic of moves) can happen fixing, like functions of movement...
    # malfuntion of activities. It happened with It animation that stoped the function...
    # of movement of cursor at end of the map.
    #current_scene = logic.getCurrentScene()
    current_scene.objects["cursor_icon"].playAction("cursor_map_anim", 1, 40, blendin=2)

