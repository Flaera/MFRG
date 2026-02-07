# To get logic comands from BGE:
from bge import logic as game

# To assign the own of this script:
cont = game.getCurrentController()
own = cont.owner
# To get others objects in this scene:
scene0 = game.getCurrentScene()
obj0 = scene0.objects
quit = obj0['quit']
new_game = obj0['new_game']
about = obj0['about']
# Actuators:
menu_selector = cont.actuators['menu_selector']
# Sensors:
enter = cont.sensors['confirm']
up = cont.sensors['up']
down = cont.sensors['down']
colquit = cont.sensors['colquit']
# Properties:
selector = own['selector']
quit = obj0['quit']
about = obj0['about']
ng = new_game['new_game']
# Constants:
null_value = float(0)
add = float(1.5)

n = 0
if (down.positive) and (0 <= selector <= 1):
    own['selector'] += 1
    own.applyMovement([0, -add, 0], True)
elif (selector == 2) and (down.positive):
    n = 0
    own.applyMovement([0, (2*add), 0], True)
    