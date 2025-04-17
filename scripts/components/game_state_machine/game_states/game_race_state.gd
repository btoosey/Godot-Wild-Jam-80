extends GameState

@onready var race_manager: RaceManager = $"../../RaceManager"


func enter() -> void:
	race_manager.order_track_cards()
	race_manager.set_race_start_points()
