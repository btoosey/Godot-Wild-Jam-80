extends Label

@export var incomplete_colour: Color
@export var complete_colour: Color


func _on_circuit_manager_circuit_complete() -> void:
	text = "Circuit Complete"
	label_settings.font_color = complete_colour


func _on_circuit_manager_circuit_incomplete() -> void:
	text = "Circuit Incomplete"
	label_settings.font_color = incomplete_colour
