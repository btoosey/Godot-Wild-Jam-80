extends GameState

@onready var results_ui: CanvasLayer = $"../../../ResultsUI"

func enter() -> void:
	results_ui.show()
	results_ui.display_race_results()


func exit() -> void:
	results_ui.hide()
