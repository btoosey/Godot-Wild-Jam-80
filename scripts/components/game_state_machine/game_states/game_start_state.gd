extends GameState

@onready var start_ui: CanvasLayer = $"../../../StartUI"


func exit() -> void:
	start_ui.hide()
