extends Node2D

@export var camera: Camera2D
@export var camera_left_limit: int
@export var camera_right_limit: int
@export var camera_top_limit: int
@export var camera_bottom_limit: int

var previous_position: Vector2 = Vector2(0, 0)
var is_dragging := false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_dragging == true:
		camera.position -= event.relative / camera.zoom
		camera.position.x = clamp(camera.position.x, camera_left_limit, camera_right_limit)
		camera.position.y = clamp(camera.position.y, camera_top_limit, camera_bottom_limit)


	if event.is_action_released("camera_drag"):
		get_viewport().set_input_as_handled()
		is_dragging = false


	if event.is_action_pressed("camera_drag"):
		get_viewport().set_input_as_handled()
		is_dragging = true
