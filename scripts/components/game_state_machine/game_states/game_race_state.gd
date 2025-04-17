extends GameState

@onready var race_manager: RaceManager = $"../../RaceManager"
@onready var race_ui: CanvasLayer = $"../../../RaceUI"


func enter() -> void:
	race_manager.order_track_cards()
	race_manager.set_race_start_points()
	race_ui.show()


func exit() -> void:
	race_ui.hide()
