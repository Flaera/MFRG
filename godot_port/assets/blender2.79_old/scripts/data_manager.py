from bge import logic


def SearchPropValue(prop_name):
    '''
    It help the system know the value that set the property. For example, It...
     search the value reference at type of ground in scene:...
      clay seco, clay molhado e asfalt
    :return: the value that reference at ground type; 0, 1 and 2, in this sequence; or
    anyother value that was searching.
    '''
    for obj in logic.getCurrentScene().objects:
        if (prop_name in obj):
            return obj[prop_name]


def SearchObjProp(prop_name, scene=logic.getCurrentScene().objects):
    '''
    It search the name of object that have one property.
    :param prop_name: property name at be searching.
    :return: str name of objects with that property.
    '''
    for obj in scene:
        if (prop_name in obj):
            return obj.name


def SearchObjPropValue(prop_name, property_value, scene=logic.getCurrentScene().objects):
    '''
    It search the name of object that have one property.
    :param prop_name: property name at be searching.
    :return: str name of objects with that property.
    '''
    #print("scene{}-".format(scene))
    for obj in scene.objects:
        if (prop_name in obj) and (obj[prop_name] == property_value):
            return obj.name


def SearchAssetWithProxie(car_proxie):
	if car_proxie=="lilas_proxie\0": return "lilas_only_asset\0"
	elif car_proxie=="nocturne_proxie\0": return "nocturne_only_asset\0"
	elif car_proxie=="roots_proxie\0": return "roots_only_asset\0"
	print("Error: not finded only_asset in coresponsed. car_proxie={}.".format(car_proxie))
	return car_proxie


def IsEqualString(str1, str2):
    if len(str1)>len(str2):
        aux = str1
        str1 = str2
        str2 = aux
        
    for i in range(0, len(str1), 1):
        #print('i:', i)
        if str2[i]!=str1[i]: return False
    return True