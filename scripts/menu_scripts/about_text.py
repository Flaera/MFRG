#from bge import logic
from scripts.manager_scenes import ManagerScenes


def Start(cont):
    #cont = logic.getCurrentController()
    own = cont.owner

    ab_text = "(Esta versão desta sessão " \
              "ainda esta em desenvolvimento)" \
              "\n\n\nDesenvolvedores:" \
              "\nRafael Luiz dos Santos (Flaera)\nGuilherme dos Santos Bras " \
              "\n\n\nColaboradores:" \
              "\nElias" \
              "\nElthon Oliveira" \
              "\nRoberta Lopes" \
              "\n\n\n"

    own["Text"] = ab_text

    # Called menu in the about scene:
    ManagerScenes().OnlyAddScene("menu_hori_button")

