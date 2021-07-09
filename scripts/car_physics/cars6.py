from bge import logic, types
from scripts.time_manager import TimeAction1


class Car(types.KX_GameObject):
    def __init__(self, car_old, acceleration, top_speed, rotation_z_max, nitro_max, mass=1700):
        '''
        Initializator or constructor.
        '''        
        self.car = car_old # old object from car reference
        self.acceleration = acceleration # modificable in game. 
        # max 5.1, min 1.9
        self.top_speed = top_speed # modificable in game. 
        # max 88, min 34
        self.rotation_z_max = rotation_z_max # modificable in game.
        # max 30, min 16
        self.nitro_max = nitro_max # modificable in game
        # max 50, min 20

        self.velocity_x = float(0)
        self.velocity_y = float(0)
        self.velocity_z = float(0)
        #self.velocity = [self.velocity_x, self.velocity_y, self.velocity_z]
        self.speed_x = float(0)
        self.speed_y = float(0)
        self.speed_z = float(0)
        #self.speed = [self.speed_x, self.speed_y, self.speed_z]
        self.velocity_result = float(0)
        self.speed_result = self.velocity_result
        
        self.rotation_x = float(0)
        self.rotation_y = float(0)
        self.rotation_z = float(0)
        self.rotation_z_inc = float(0.1)
        self.delta_rotx = float(0.0)

        self.nitro_power_inc = float(0.6 * self.acceleration)
        self.nitro_deactivation_increase = float(0.01)
        self.nitro_activation_decrease = float(0.1)
        self.nitro_fully = self.nitro_max

        self.brake_constant = float(0.75 * self.acceleration)

        self.gravity = float(10)

        self.time_divisor = 10 # From decimate of seconds.
        self.action = False

        # converting variables at accord with time_divisor:
        self.acceleration_conv = self.acceleration / self.time_divisor
        self.gravity_conv = self.gravity / self.time_divisor

        # variables of LO, jumps:
        self.jump_incoming = bool(False) # For why the car around of jump.
        self.velocity_init = float(0.0)
        self.time_on_air = float(0.0)
        #self.delta_time = float(0.0) #It simply working like rate of increament...
        #at each call the time_inc_vz
        self.time_inc_for_vz = float(0.0)
        self.on_lo_jump = bool(False)

        # For status of car in diferents situations:
        self.gear = int(0)
        self.braking = False
        self.nitro = False


    def GearSelection(self):
        '''
        It seleceted the gear correct at accord with velocity result.
        '''
        if (self.velocity_result > float(0)):
            self.gear = int(1)
        elif (self.velocity_result < float(0)):
            self.gear = int(-1)
        elif (self.velocity_result == float(0)):
            self.gear = int(0)


    def VeloConvertToGE(self, x):
        '''
        It's very simple function that convert real values mathematics and pyhsics for...
        that blender game engine manage less bug the car/proxie object.
        x = velocity result.
        return the velocity value converted by the Game Engime of Blender
        '''
        y = float((1.5*x)/88)
        return y


    def NitroActivation(self, nitro_trigger):
        '''
        It apply the nitro power in acceleration of car and too at same time It manage...
         the values of flag nitro.
        Used vars:
        self.nitro
        self.nitro_power_inc = float(1.5 * self.acceleration)
        self.nitro_deactivation_increase = float(0.01)
        self.nitro_activation_decrease = float(0.1)
        self.nitro_fully = self.nitro_max
        '''
        if (self.gear > 0) and (nitro_trigger > 0) and (self.nitro_fully > float(0)):
            self.nitro_fully -= self.nitro_activation_decrease
            self.nitro = True
            return (self.nitro_power_inc)
        elif (nitro_trigger == False) and (self.nitro_fully < self.nitro_max):
            self.nitro_fully += self.nitro_deactivation_increase
            self.nitro = False
            return float(0)
        else:
            self.nitro = False
            return float(0)


    def BrakesActivation(self, ground_trigger, brake_trigger):
        '''
        It apply the brake value at acceleration at same time too ...
        manage the values of flag braking var.
        '''
        if (ground_trigger > 0) and (brake_trigger > 0) and (self.gear > 0):
            self.braking = True
            return -(self.brake_constant)
        elif (ground_trigger > 0) and (brake_trigger > 0) and (self.gear < 0):
            self.braking = True
            return (self.brake_constant)
        else:
            self.braking = False
            return float(0)


    def VeloIncreaseAtTriggerPedal(self, ground_trigger, key_front, key_back,
     nitro_trigger, brake_trigger):
        '''
        It only manage the velocity in y axis if player/car press the pedal making...
         car accelerate in line right.
        '''
        # acceleration at moment:
        accel_logic_momentum = self.acceleration_conv + self.NitroActivation(nitro_trigger)
        #print("e aí accel_momentum", accel_logic_momentum, sep=", ")

        # if car accelerate in gears positives:
        if (ground_trigger == True) and (self.action == True) and (key_front > 0)\
         and (self.velocity_y < self.top_speed):
            if ((self.velocity_y + accel_logic_momentum) < self.top_speed):
                self.velocity_y += accel_logic_momentum
                self.velocity_y += self.BrakesActivation(ground_trigger, brake_trigger)
            else:
                self.velocity_y -= accel_logic_momentum
                self.velocity_y += self.BrakesActivation(ground_trigger, brake_trigger)
        
        # if car desacceleration in gear positives:
        elif (ground_trigger == True) and (self.action == True) and (key_front <= 0)\
         and (self.velocity_y > float(0)):
            if ((self.velocity_y - accel_logic_momentum) > float(0)):
                self.velocity_y -= accel_logic_momentum
                self.velocity_y += self.BrakesActivation(ground_trigger, brake_trigger)
            else:
                self.velocity_y = float(0)

        # if car accelerate in gears negatives (the next conditionals be only one copy of gear positive conditional):
        if (ground_trigger == True) and (self.action == True) and (key_back > 0)\
         and (self.velocity_y > -(self.top_speed*(1/4))):
            if ((self.velocity_y - accel_logic_momentum) > -(self.top_speed*(1/4))):
                self.velocity_y -= accel_logic_momentum
                self.velocity_y += self.BrakesActivation(ground_trigger, brake_trigger)
            else:
                self.velocity_y += accel_logic_momentum
                self.velocity_y += self.BrakesActivation(ground_trigger, brake_trigger)
        
        #if car desacceleration in gear negative:
        elif (ground_trigger == True) and (self.action == True) and (key_back <= 0) and (self.velocity_y < float(0)):
            if ((self.velocity_y + accel_logic_momentum) < float(0)):
                self.velocity_y += accel_logic_momentum
                self.velocity_y += self.BrakesActivation(ground_trigger, brake_trigger)
            else:
                self.velocity_y = float(0)

        # Update the values of velocity and speed 
        # TALVEZ PARTE DISSO, RESULTS VARS, TENHAM...
        # QUE SAIR DA DAQUI
        self.speed_y = abs(self.velocity_y)
        self.velocity_result = self.velocity_y
        self.speed_result = abs(self.velocity_result)


    def SetAccelCentript(self):
        '''
        DEPRECATED!!! THEY CAR ROTAION WAS MUCH LOW.
        It set the value correct in reference at acceleration centript in circular...
         uniform movement, but I no know like manage the ray then this was simplify.
        I thinked that ray decrease with low velocities and increase...
         in high velocities. Because It was get with one linear function.
        It's "gambiarra"! :D
        '''
        #ray = 440*self.velocity_y
        #self.rotation_z_inc = (self.velocity_y**2)/(440*self.velocity_y)
        # PRECISO FAZER ISSO REALTIVO A VELOCIDADE DE ALGUMA FORMA: SEJA COM...
        # SIMPLES FUNCAO LINEAR OU UTILIZANDO A FÓRMULA DE ACELERACAO CENTRÍPEDA! PARA AMANHÃ
        self.rotation_z_inc = (self.velocity_y)/(440)


    def ConvertRotationToGE(self, x):
        '''
        It convert values of rotation for values able for game engine.
        One time that values default case stranges effects.
        '''
        return (0.004*x)


    def SupportRotationZAxis(self):
        '''
        In normal rotation if car rotation in z axis while this was in gears rears happen...
        the car rotationed in inverted axis, rotationed for left same that user press...
        right button.
        It function correct the axis in car at rotationed in z axis while .
        return the constant of multiplication that change direction of rotation in z axis.
        #
        '''
        if (self.gear < 0): return -1
        else: return 1


    def RotationZ(self, ground_trigger, left, right):
        '''
        It manage the values in rotation of z axis.
        It too get the help of function of support to choice correct direction...
         in rotation z axis while in rear gear.
        Used vars:
        self.rotation_z_max = rotation_z_max # modificable in game.
        # max 30, min 16
        self.rotation_x = float(0)
        self.rotation_y = float(0)
        self.rotation_z = float(0)
        self.rotation_z_inc = float(0.001)
        '''
        if (ground_trigger == True) and (self.gear != 0) and (left > 0) and (self.rotation_z < self.rotation_z_max):
            if ((self.rotation_z + self.rotation_z_inc) < self.rotation_z_max):
                self.rotation_z += self.rotation_z_inc * self.SupportRotationZAxis()
            else:
                self.rotation_z -= self.rotation_z_inc * self.SupportRotationZAxis()
        
        elif (ground_trigger == True) and (self.gear != 0) and (right > 0) and (self.rotation_z > -self.rotation_z_max):
            if ((self.rotation_z - self.rotation_z_inc) > -self.rotation_z_max):
                self.rotation_z -= self.rotation_z_inc * self.SupportRotationZAxis()
            else:
                self.rotation_z += self.rotation_z_inc * self.SupportRotationZAxis()
        
        else: self.rotation_z = float(0)
        
        #print(self.gear, self.rotation_z, self.rotation_z_max, "gear, rotationZ", sep=", ")
        

    def WallLateralCollisions(self, wall, wall_l, wall_r):
        '''
        Note only in portuguese-br about devolopment of collisions in game:
        Para esta funcao foi feito um pequeno estudo sobre colisões e impulsos em física...
        na área de dinâmica, as implementações deveriam seguir com manejo de forças entre os...
        neus e o carro, mas isso não foi possível. Principalmente pelo fato de que a simples...
         aplicação de força na bge resultava em efeitos exagerados para uma dada velocidade...
         prescrita nas formulas da física. Ou seja, mesmo fazendo a relações entre f = (m*v^2)/2...
         e trabalho (trab = f*deltaS) pra obtenção força resultante bugs se expressavam.
        Foi percebido que força de efeitos colisoes (impulsos) aplicadas em um objeto são fruto...
        de uma relação entre a área da colisão e quantidade de movimento/velocidade/força...
         no instante da colisão... 
         NFSMH!!!! ARTIGOS LIDOS. DESCARTE PARA SIMPLIFICAÇÃO DO JOGO AFIM DE CUMPRIR COM O...
          OBJETIVO: ME PREPARAR PARA UMA FÍSICA MELHOR.
         POSSIBILIDADES DE IMPLEMENTAÇÃO ENCONTRADAS: VERTEX GROUPS, SENSORS OBJECTS AND...
          GET VERTEX THAT COLLIDE WITH ONE TYPE OF OBJECT
         INDENTIFICADORES OR SENSORS CHOICEDS!!!

        It's fucntion control velocity and impulse in collisions laterals of left and right.
        It function use similities with the coeficient of friction (var: coef_friction)
        By It's var is possible control the value of decrement of the velocity in y axis
        The velocity result is calculate with pitagora relation.
        The amount movement that car run at collide with wall is set in variable...
        constant_accel, It basically multiply the value of acceleration
        '''
        constant_accel = int(2)
        #It work how one coeficient of friction:
        coef_friction = 0.8 #coef of friction equal 0.05 to value 0.95

        if ((wall >= 1) and (wall_l >= 1)):
            self.applyMovement([self.acceleration_conv*constant_accel, 0, 0], 1)
            self.velocity_y = self.velocity_y * coef_friction
            #It only basic application of pitagoras:
            self.velocity_result = (((self.acceleration_conv*constant_accel)**2) + (self.velocity_y**2))**0.5
        elif ((wall >= 1) and (wall_r >= 1)):
            self.applyMovement([-self.acceleration_conv*constant_accel, 0, 0], 1)
            self.velocity_y = self.velocity_y * coef_friction
            self.velocity_result = (((-self.acceleration_conv*constant_accel)**2) + (self.velocity_y**2))**0.5


    def WallCollisionsFrontRear(self, wall, wall_f, wall_r):
        '''
        It's fucntion control velocity and impulse in collisions in the front and in the rear.
        It's well look with the function before that manage lateral collision effects, but...
        is different at other by run the sum of vector to set velocity in y axis.
        Variables of control: constant_accel and coef_friction, thus before function.
        '''
        constant_accel = int(4) # For details about this see function before
        #It too work how one coeficient of friction (Details in function before):
        coef_friction = 0.6 #coef of friction equal 0.05 to value 0.95

        if ((wall >= 1) and (wall_f >= 1)):
            self.applyMovement([0, -self.acceleration_conv*constant_accel, 0], 1)
            # simple sum of vectors:
            self.velocity_y = (self.velocity_y * coef_friction) + (-self.acceleration_conv*constant_accel)
        elif ((wall >= 1) and (wall_r >= 1)):
            self.applyMovement([0, self.acceleration_conv*constant_accel, 0], 1)
            self.velocity_y = (self.velocity_y * coef_friction) + (self.acceleration_conv*constant_accel)
        
        self.velocity_result = self.velocity_y


    def ObstacleCollisions(self, sens_obj1, sens_obj2):
        '''
        Id objects or identification os collissions with objects:
        - col_obj1 = cont.sensors["col_obj1"].positive:
        collisors that look like wall, but suffer with the impulse. It ...
        sensor search prop col_obj1;
        - col_obj2 = cont.sensors["col_obj2"].positive:
        Collisors that look like with objects that suffer much with the impulse forces. It...
         sensor search prop col_obj2
        How the modifications were minimun in velocity only two sensors in proxie was...
        create

        One part of this implementation is a system of impulse of collision (reaction)...
         that ignored at while, but I think that implemented this making the logic in...
         object that suffer the much effects of the collision, then objects that... 
         no be the car.
        
        Vars useds:
        constant_deaccel = # It look like with coeficient of...
         friction in manage with forces. 

        WARNING: UNHAPPY, THE OBJECTS BE INTO OF OTHERS OBJECTS BECAUSE NO HAVE ...
        SYSTEM OF REACTION!!!
        '''
        constant_deaccel1 = 0.6
        constant_deaccel2 = 0.99
        if (sens_obj1 >= 1) and (-10 <= self.velocity_y) and (self.velocity_y >= 10):
            self.velocity_y = self.velocity_y*constant_deaccel1
        if (sens_obj2 >= 1) and (-3 <= self.velocity_y) and (self.velocity_y >= 3):
            self.velocity_y = self.velocity_y*constant_deaccel2


    def RotXTransferWeight(self, ground):
        '''
        It align the axis y after to apply one rotation in x axis for this.
        I can too make one linear function to equilibrate the values any
         parameter velocity in y axis to make reference at set amount of rotation, It's rotation
         have to be in local trasnfomation
         It's function no is applied out function o f LO and jump
        It's function turn car in axis x at 45 degrees, 30 degrees of "rampa", jumper,
        and more 15
        But the first implementation use the rotation icreaseof z axis and gear to define
        the direction of rotation
        It's value 0.4 is coming of 40 degrees divide by 10 times, It's matter that
        at each 10 milesims of seconds 40 degrees the car turn
        DEVO DOCUMENTAR MELHOR AMANHÃ!!!!!!!!!!! TANTO ISSO QUANTO A FUNÇÃO DE LO/JUMP E 
        FAZER MAIS TESTES DE SALTOS PARA VERIFICAR REAÇÕES PINESPERADAS DO SISTEMA DE RESPOSTA
        DA PRÓPRIA GAME ENGINE, PORQUE ESTE PODE INTERFERIR NA MINHA LÓGICA DE MANEIRA DRÁSTICA
        Perhaps in second condition the system of predictive collision will be thing best 
        in this case
        '''
        if (self.action==True) and (ground==False) and (self.delta_rotx <= 45):
            self.delta_rotx += 3 * (self.gear*-1)
            self.rotation_x = 3 * (self.gear*-1)
        elif (ground == True) and (abs(self.delta_rotx) > 0.0):
            #print("rotx at chao true: {}".format(self.delta_rotx))
            self.rotation_x = (self.delta_rotx)*-1 # It multiply by -1 to 
            #invert the rotation
            #self.applyRotation([self.ConvertRotationToGE(self.rotation_x), 0, 0], True)
            self.delta_rotx = 0.0
        elif ((self.delta_rotx) == 0.0):
            self.rotation_x = 0.0


    def TableAngles(self, angle, axis):
        '''
        Simply function look like table learned in medium school.
        I's function do support the function that make the lancement oblique.
        DEPRECATED! IT WAS DEPRECATED BECAUSE THE GAME CAN WAS HARD DEVELOPMENT...
        AND ONCE THAT OBJECTIVE IS A SIMPLE GAME. IT WAS DISCARD!!
        ALL JUMPS IN GAME WAS SETUPS LIKE 30 GRAUS IN LANCAMENTS (PT-BR: CARA, EU TENHO...
         CERTEZA QUE NÃO É ASSIM QUE SE ESCREVE LANCAMENT EM INGLÊS)
        Parameters:
        - angle: It can be 30, 45 and 60!!
        - axis: sen(0), cossen(1) and tangent(2) - It's last no was implemented.
        '''
        if (((angle == 30) and (axis==0)) or ((angle == 60) and (axis==1))):
            return 1/2
        elif (((angle == 30) and (axis==1)) or ((angle == 60) and (axis==0))):
            return (3**0.5)/2
        elif (angle == 45):
            return (2**0.5)/2


    def JumpsAndLO(self, jumper, ground):
        '''
        se jujmp aprouch true pre calcule coisas como velo initial
        depois faca os calculos de lo com time_on_air.
        Remenber It: the default jumps angles to set in 30 degrees!!
        '''
        sen30 = float(0.5)
        cos30 = float((3**0.5) / 2)

        if (jumper == True):
            self.jump_incoming = True
        
        if ((ground==False) and (self.jump_incoming == True) and (self.on_lo_jump == False)):
            print("veloy de entrada: {}".format(self.velocity_y))
            self.velocity_init = self.velocity_y
            self.time_on_air = (2 * self.velocity_init * sen30) / self.gravity
            self.velocity_y = self.velocity_init * cos30 # It delta time here have value bool in logic
            #It's by this that have variable action. By the way, It no have needed of added the 
            # the more one constant that refenrece at delta time
            self.on_lo_jump = True
            print("First step COMPLETE!!!") #VERIFCAR ESTA VELOCITY ALTA NO PULO
        elif ((ground == False) and (self.action == True)
         and (self.time_inc_for_vz < self.time_on_air)):
            self.velocity_z = (self.velocity_init*sen30) - (self.gravity*self.time_inc_for_vz)
            self.time_inc_for_vz += self.time_on_air/10
            print("JUMP/LO: veloz={0}, veloy={1}, time_on_air={2}, time_inc_vz={3}".format(round(self.velocity_z, 4), round(self.velocity_y, 4),
             round(self.time_on_air, 4), round(self.time_inc_for_vz, 4)))
            print("RUNNING!!!")
        elif (ground == True) and (self.on_lo_jump == True):
            print("Last step COMPLETE!!!")
            self.velocity_init = 0.0
            self.velocity_z = 0.0
            self.rotation_x = 0.0
            self.time_on_air = 0
            self.time_inc_for_vz = 0.0
            #self.delta_time = 0.0
            self.on_lo_jump = False
            self.jump_incoming = False


    def MainCarPhysics(self, key_front, key_rear, key_right, key_left, 
     key_brake, key_nitro, 
      ground, wall, jump,
       col_wallLL, col_wallLR, col_wallF, col_wallR,
       col_obj1, col_obj2):
        '''
        ###### My main function #######

        ABOUT PHYSICS OF COLLISION WITH WALL:
        It's functions below was studies hardly. The gameplay of NFSMW inclusive was analysis...
        and material about car physics was read.
        Then was know that the system collision and impulse are linkeds of any way...
        with the area of impact of collision... 
        They functions was implementeds like if was work with forces in car. Thus in...
        real life and like the physics explain, but was used adaptations because implementation...
        with force in bge will resulting in several bugs, basically force was substitute by...
        velocity. It's too is one logic apply in all this script.
        
        '''
        
        self.action = TimeAction1(self["time"], self.time_divisor)[0]
        self["time"] = TimeAction1(self["time"], self.time_divisor)[1]

        self.GearSelection()
        
        self.VeloIncreaseAtTriggerPedal(ground, key_front, key_rear, key_nitro, key_brake)

        # physics collision
        self.WallLateralCollisions(wall, col_wallLL, col_wallLR)
        self.WallCollisionsFrontRear(wall, col_wallF, col_wallR)
        self.ObstacleCollisions(col_obj1, col_obj2)

        #jumps:
        #print("jump in main={0}\n".format(jump))
        self.JumpsAndLO(jump, ground)

        # Simply application of movement
        self.applyMovement([self.VeloConvertToGE(self.velocity_x), self.VeloConvertToGE(self.velocity_y), self.VeloConvertToGE(self.velocity_z)], True)
        #Set damping to decrease the effects of physics engine response at collisions:
        #self.setDamping(0, 1)

        #Transfer weight in x (rotations in x axis):
        self.RotXTransferWeight(ground) #the paramenter will be the weight in each wheels

        #self.SetAccelCentript()
        self.RotationZ(ground, key_left, key_right)
        #print("rotz in main: {}".format(self.rotation_z))        
        self.applyRotation([self.ConvertRotationToGE(self.rotation_x),
         self.ConvertRotationToGE(self.rotation_y),
         self.ConvertRotationToGE(self.rotation_z)], True)
