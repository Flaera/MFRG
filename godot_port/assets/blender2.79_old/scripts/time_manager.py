from bge import logic


class TimeManager():
    def __init__(self, old_owner, name_timer_prop):
        self.own = old_owner
        self.name_timer_prop = name_timer_prop


    def TimeAction(self, seconds_denominator=10):
        '''
        Use the property timer(time) to count the action of cars per decimate of seconds
        :return: True or False relative at property time
        '''
        if (self[self.name_timer_prop] >= float(1) / (seconds_denominator)):
            self[self.name_timer_prop] = float(0)
            return True
        else:
            return False


def TimeAction1(timer_prop, seconds_denominator=10):
        '''
        Use the property timer(time) to count the action of cars per decimate of seconds
        :return: True or False relative at property time
        '''
        if (timer_prop >= (float(1) / (seconds_denominator))):
            timer_prop = float(0)
            return [True, timer_prop]
        else:
            return [False, timer_prop]
