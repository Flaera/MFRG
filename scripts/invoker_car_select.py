from bge import logic, types


def Start(cont):
    invoker = cont.owner
    current_scene = logic.getCurrentScene()
    #print("invokername", type(invoker))
    # This code have the problem don't adapt at user path in OS from user.
    # I think that I to make the function to search the path correct in SO accord with...
    # type SO and name user from user

    # Calling car selected:
    path = "MFRG/data_files/"
    car_selected = open(path+"car_selected.txt", "r")

    #print(("lilas_proxie" in current_scene.objectsInactive), "essa lista ae")
    car_selected_obj = current_scene.objectsInactive[str(car_selected.read())]

    current_scene.addObject(car_selected_obj, invoker, 0)
    # Activating flags:
    current_scene.objects["camera01"]["car_invoked"] = True
    current_scene.objects["sun01"]["car_invoked"] = True
    current_scene.objects["invoker_dust0"]["car_invoked"] = True
    current_scene.objects["invoker_dust1"]["car_invoked"] = True
    current_scene.objects["invoker_dust2"]["car_invoked"] = True
    current_scene.objects["invoker_dust3"]["car_invoked"] = True


    car_selected.close()

# SEGUNDA TRABALHAR NA INTEGRAÇÃO DE UMA VARIAVEL PARA O JOGO QUE DEFINE O...
# CARRO QUE ESTA SELECIONADO PELO JOGADOR NO MENU...
# GARAGEM, A QUAL MERECE UMA SPEEDART ;)
