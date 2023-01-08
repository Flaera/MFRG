extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func saveStyleDefault():
	var file = File.new()
	file.open("res://data_files/style.dat", File.WRITE)
	file.store_string("Anne9")
	file.close()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	saveStyleDefault()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
