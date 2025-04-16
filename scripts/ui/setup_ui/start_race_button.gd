extends Button


func _ready() -> void:
	disabled = true


func _on_circuit_manager_circuit_complete() -> void:
	disabled = false


func _on_circuit_manager_circuit_incomplete() -> void:
	disabled = true
