extends RayCast

var cool_down_collision = 2

signal colliding
signal non_colliding


func _physics_process(delta):
	if self.get_collider() != null:
		emit_signal("colliding", self)
	else:
		emit_signal("non_colliding", self)
	
	yield(get_tree().create_timer(cool_down_collision), "timeout")

func toggle(onoff: bool):
	set_physics_process(onoff)
	set_physics_process_internal(onoff)
	set_process(onoff)
	set_process_internal(onoff)
	set_process_input(onoff)
	set_process_unhandled_input(onoff)
	set_process_unhandled_key_input(onoff)
