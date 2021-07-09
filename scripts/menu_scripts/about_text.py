#from bge import logic
from scripts.manager_scenes import ManagerScenes


def Start(cont):
    #cont = logic.getCurrentController()
    own = cont.owner

    ab_text = "(Esta versao da sessao Sobre " \
              "ainda esta desenvolvimento)" \
              "\n\n\nDesenvolvedores:" \
              "\nFlaera\nGuilherme Bras (PP)" \
              "\n\n\nColaboradores:" \
              "\nElias (falta o segundo nome, PP)" \
              "\nElthon Oliveira (PP)" \
              "\n\n\nTestadores (Beta testers):" \
              "\nDevo adicionar algum quando tiver uma beta estável para testes." \
              "\n\n\nTÓPICOS PARA REVISÃO DO DESENVOLVEDOR (ESTA..." \
              "\nPARTE DEVE SER EXCLUÍDA DO TEXTO FINAL):" \
              "\n- PP =  perguntar se posso colocar o nome."

    own["Text"] = ab_text

    # Called menu in the about scene:
    ManagerScenes().OnlyAddScene("menu_hori_button")

