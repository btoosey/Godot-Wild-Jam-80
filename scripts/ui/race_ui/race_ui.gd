extends CanvasLayer

@onready var race_manager: RaceManager = $"../Components/RaceManager"

@onready var lap_counter: Label = $LapCounter
@onready var caution_label: Label = $CautionLabel


func _process(_delta: float) -> void:
	lap_counter.text = str("Lap ", race_manager.current_lap, "/", race_manager.race_distance)


func _on_player_path_hide_caution() -> void:
	caution_label.hide()


func _on_player_path_show_caution() -> void:
	caution_label.show()
