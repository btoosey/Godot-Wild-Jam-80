extends GameState

@onready var race_manager: RaceManager = $"../../RaceManager"
@onready var race_ui: CanvasLayer = $"../../../RaceUI"
@onready var racer_paths: Node2D = $"../../RaceManager/RacerPaths"


func enter() -> void:
	race_ui.show()
	race_manager.initialize_race()
	racer_paths.show()
	racer_paths.enable_racer_paths()
	racer_paths.initialize_racers()


func exit() -> void:
	race_ui.hide()
	racer_paths.hide()
