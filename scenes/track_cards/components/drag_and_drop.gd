class_name DragAndDrop
extends Node

signal drag_started
signal dropped(starting_position: Vector2)

@export var enabled: bool = true
@export var target: Area2D

var starting_position: Vector2
var offset := Vector2.ZERO
var dragging := false


func _ready() -> void:
	assert(target, "No target set for DragAndDrop component")
	target.input_event.connect(_on_target_input_event.unbind(1))


func _process(_delta: float) -> void:
	if dragging and target:
		target.global_position = target.get_global_mouse_position()


func _input(event: InputEvent) -> void:
	if dragging and event.is_action_released("select_track_card"):
		_drop()


func _end_dragging() -> void:
	dragging = false
	target.remove_from_group("dragging")
	target.z_index = 1


func _start_dragging() -> void:
	dragging = true
	starting_position = target.global_position
	target.add_to_group("dragging")
	target.z_index = 98
	drag_started.emit()
	get_viewport().set_input_as_handled()


func _drop() -> void:
	_end_dragging()
	dropped.emit(starting_position)


func _on_target_input_event(_vieport: Node, event: InputEvent) -> void:
	if not enabled:
		return

	var dragging_object := get_tree().get_first_node_in_group("dragging")
	if not dragging and dragging_object:
		return

	if not dragging and event.is_action_pressed("select_track_card"):
		get_viewport().set_input_as_handled()
		_start_dragging()
