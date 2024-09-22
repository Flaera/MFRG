extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():
	#SelectLang.new().textInAllNodes(get_node("."))
	var text_color: Color = preload("res://resources/game_settings/game_settings.tres").color_legend
	get_node("Control/Control/Label2").add_color_override("font_color",text_color)
	get_node("Control/Control/Label3").add_color_override("font_color",text_color)
	get_node("Control/Control/Label").add_color_override("font_color",text_color)
	get_node("Control/Control/Label4").add_color_override("font_color",text_color)
	get_node("Control/Label").add_color_override("font_color",text_color)

	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))

