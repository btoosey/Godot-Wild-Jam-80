extends CanvasLayer

@onready var race_manager: RaceManager = $"../Components/RaceManager"
@onready var racer_paths: Node2D = $"../Components/RaceManager/RacerPaths"
@onready var player_path: Path2D = $"../Components/RaceManager/RacerPaths/PlayerPath"

@onready var countdown: Label = $Countdown

@onready var lap_counter: Label = $Panel/VBoxContainer/HBoxContainer2/LapCounter
@onready var caution_label: Label = $Panel/VBoxContainer/HBoxContainer2/CautionLabel
@onready var progress_bar: ProgressBar = $Panel/VBoxContainer/HBoxContainer/ProgressBar


func _process(_delta: float) -> void:
	lap_counter.text = str("Lap ", race_manager.current_lap, "/", race_manager.race_distance)
	progress_bar.value = player_path.speed


func _on_player_path_hide_caution() -> void:
	caution_label.hide()


func _on_player_path_show_caution() -> void:
	caution_label.show()


func start_countdown() -> void:
	progress_bar.max_value = player_path.top_speed
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
