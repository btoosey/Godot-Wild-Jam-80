extends GameState

@onready var race_manager: RaceManager = $"../../RaceManager"
@onready var race_ui: CanvasLayer = $"../../../RaceUI"
@onready var racer_paths: Node2D = $"../../RaceManager/RacerPaths"
@onready var background_grid: TileMapLayer = $"../../../BackgroundGrid"

func enter() -> void:
	MusicPlayer.stop()
	race_ui.show()
	race_manager.initialize_race()
	racer_paths.improve_cpu_stats()
	racer_paths.show()
	racer_paths.initialize_racers()
	race_ui.start_countdown()
	background_grid.hide()


func exit() -> void:
	racer_paths.disable_racer_paths()
	race_ui.hide()
	racer_paths.hide()
