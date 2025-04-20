extends CanvasLayer

@onready var race_manager: RaceManager = $"../Components/RaceManager"
@onready var racer_paths: Node2D = $"../Components/RaceManager/RacerPaths"

@onready var lap_counter: Label = $LapCounter
@onready var caution_label: Label = $CautionLabel
@onready var countdown: Label = $Countdown


func _process(_delta: float) -> void:
	lap_counter.text = str("Lap ", race_manager.current_lap, "/", race_manager.race_distance)


func _on_player_path_hide_caution() -> void:
	caution_label.hide()


func _on_player_path_show_caution() -> void:
	caution_label.show()


func start_countdown() -> void:
	countdown.show()
	countdown.text = "3"
	await get_tree().create_timer(1).timeout
	countdown.text = "2"
	await get_tree().create_timer(1).timeout
	countdown.text = "1"
	await get_tree().create_timer(1).timeout
	countdown.text = "GO!"
	racer_paths.start_race()

	await get_tree().create_timer(1).timeout
	countdown.hide()
