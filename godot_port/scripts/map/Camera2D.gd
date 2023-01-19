# Script by Bramwell on youtube:https://www.youtube.com/watch?v=gpvLqLggJuk; acesso em 18/01/2023 às 22:57

extends Camera2D

var MIN_ZOOM: float = 0.1
var MAX_ZOOM: float = 1.0
var ZOOM_INCREAMENT: float = 0.1
var _target_zoom: float = 1.0
const ZOOM_RATE: float = 8.0


func zoom_in() -> void:
	_target_zoom = max(_target_zoom-ZOOM_INCREAMENT, MIN_ZOOM)
	set_physics_process(true)


func zoom_out() -> void:
	_target_zoom = min(_target_zoom+ZOOM_INCREAMENT, MAX_ZOOM)
	set_physics_process(true)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if (event.button_mask==BUTTON_MASK_MIDDLE):
			position-=event.relative*zoom

	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_in()
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_out()


func _physics_process(delta):
	zoom = lerp(
		zoom,
		_target_zoom*Vector2.ONE,
		ZOOM_RATE*delta
		)
	set_physics_process(
		not is_equal_approx(zoom.x, _target_zoom)
		)
