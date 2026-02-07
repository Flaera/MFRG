extends Node2D

onready var index_music: int = 0
onready var music_nodes: Array = $Musics.get_children()
onready var max_index_music: int = len(music_nodes)
onready var is_time_play: bool = false



func _process(_delta):
	if (is_time_play==true):
		var play_anything=false
		for i in music_nodes:
			if (i.is_playing()==true):
				play_anything=true
				break
		if (play_anything==false):
			music_nodes[index_music].play()
			index_music+=1
			if (index_music==max_index_music):
				index_music=0


func music_play():
	is_time_play = true
	print("istimeplay=", is_time_play)


func music_pause():
	is_time_play=false
	print("istimeplay2=", is_time_play)
	
