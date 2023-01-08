from bge import logic, events

keys = logic.keyboard.events
tap = logic.KX_INPUT_JUST_ACTIVATED

def Keys():
    nitro_key = keys[events.SPACEKEY]
    brake_key = keys[events.LEFTSHIFTKEY]

    front_key = keys[events.WKEY]
    rear_key = keys[events.SKEY]
    right_key = keys[events.AKEY]
    left_key = keys[events.DKEY]
    return [front_key, rear_key, left_key, right_key, brake_key, nitro_key]