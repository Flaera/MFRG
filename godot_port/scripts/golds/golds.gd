extends HBoxContainer


onready var save_file: Resource = preload("res://resources/saved_game/saved_game.tres")


func _ready():
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))



func _process(_delta):
	#var file = File.new()
	#file.open("res://data_files/gold.txt",File.READ)
	#var golds = file.get_csv_line()
	var golds = save_file.gold
	get_node("LGolds").text = " Golds: "+String(golds)+" "
	#file.close()
