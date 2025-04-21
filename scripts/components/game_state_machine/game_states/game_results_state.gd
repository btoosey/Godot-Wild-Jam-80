extends GameState

@onready var results_ui: CanvasLayer = $"../../../ResultsUI"
@onready var points_calculator: Node = $"../../PointsCalculator"

@export var main_theme_muffle: AudioStream


func enter() -> void:
	points_calculator.calculate_prize_money()
	results_ui.display_race_results()
	results_ui.show()
	MusicPlayer.stop()
	MusicPlayer.play(main_theme_muffle)


func exit() -> void:
	results_ui.hide()
