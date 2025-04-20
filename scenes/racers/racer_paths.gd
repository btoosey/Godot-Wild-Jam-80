extends Node2D

func enable_racer_paths() -> void:
	for path in get_children():
		path.enabled = true
