extends Node2D


func enable_racer_paths() -> void:
	for path in get_children():
		path.enabled = true


func disable_racer_paths() -> void:
	for path in get_children():
		path.enabled = false


func initialize_racers() -> void:
	for path in get_children():
		path.can_accelerate = true
		path.race_ended = false
		path.speed = 0
		path.path_follow_2d.progress_ratio = 0


func start_race() -> void:
	enable_racer_paths()
