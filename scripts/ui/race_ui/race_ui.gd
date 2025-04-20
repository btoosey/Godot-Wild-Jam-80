extends CanvasLayer

@onready var race_manager: RaceManager = $"../Components/RaceManager"

@onready var lap_counter: Label = $LapCounter

func _process(_delta: float) -> void:
	lap_counter.text = str("Lap ", race_manager.current_lap, "/", race_manager.race_distance)
