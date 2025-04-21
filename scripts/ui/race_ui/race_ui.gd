extends CanvasLayer

@export var countdown_sound_number: AudioStream
@export var countdown_sound_go: AudioStream
@export var caution: AudioStream
@export var main_theme_race: AudioStream


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
	SFXPlayer.play(caution)
	caution_label.show()


func start_countdown() -> void:
	progress_bar.max_value = player_path.top_speed
	countdown.show()
	countdown.text = "3"
	SFXPlayer.play(countdown_sound_number)
	await get_tree().create_timer(1).timeout
	countdown.text = "2"
	SFXPlayer.play(countdown_sound_number)
	await get_tree().create_timer(1).timeout
	countdown.text = "1"
	SFXPlayer.play(countdown_sound_number)
	await get_tree().create_timer(1).timeout
	countdown.text = "GO!"
	SFXPlayer.play(countdown_sound_go)
	racer_paths.start_race()
	MusicPlayer.stop()
	MusicPlayer.play(main_theme_race)

	await get_tree().create_timer(1).timeout
	countdown.hide()
