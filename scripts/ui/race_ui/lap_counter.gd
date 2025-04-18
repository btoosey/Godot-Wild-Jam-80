extends Label


func _on_race_manager_lap_increased(lap: Variant) -> void:
	text = "Lap " + str(lap)
