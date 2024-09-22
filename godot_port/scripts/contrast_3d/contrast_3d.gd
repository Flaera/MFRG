extends Node
class_name Contrast3D


func contrast_3d(mother_node: Node):
	var save_settings: Resource = ResourceLoader.load("res://resources/game_settings/game_settings.tres")
	for node in mother_node.get_children():
		if (node.get_child_count()>0):
			contrast_3d(node)
		if (node is WorldEnvironment):
			node.environment.adjustment_enabled=true
			node.environment.adjustment_contrast=save_settings.contrast_3d

