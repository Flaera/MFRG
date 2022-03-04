from bge import *

def ffix_orthographic():
    controller = logic.getCurrentController().owner
    #controller = logic.getCurrentController()
    #scene = logic.getCurrentScene()
    cam_size = (render.getWindowWidth() / controller.scene.active_camera.ortho_scale) * controller.dimension[1]
    controller.resolution = cam_size / controller.dimensions[1] / 100

def ffix_perspective():
    controller = logic.getCurrentController().owner
    cam_size = (render.getWindowWidth() / controller.scene.active_camera.fov) * controller.dimensions[1]
    controller.resolution = render.getWindowWidth() / controller.scene.active_camera.fov / 15