extends Path2D

signal track_card_ended

@export var race_manager: RaceManager
@export var acceleration := 0.02
@onready var path_follow_2d: PathFollow2D = $PathFollow2D

var current_track_card
var current_lap := 1

var enabled = false
var speed = 0

func _process(_delta: float) -> void:
	if !enabled:
		return

	path_follow_2d.progress += speed
	if path_follow_2d.progress_ratio == 1:
		track_card_ended.emit()

	if current_track_card.speed_threshold == 0:
		return

	if current_track_card.first_link == current_track_card.circuit_link_1:
		if (path_follow_2d.progress_ratio > current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio < current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio > current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio < current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				print("SPIN!")
		elif (path_follow_2d.progress_ratio > current_track_card.caution_min_limit_1 and path_follow_2d.progress_ratio < current_track_card.caution_max_limit_1) or (path_follow_2d.progress_ratio > current_track_card.caution_min_limit_2 and path_follow_2d.progress_ratio < current_track_card.caution_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				print("Caution")
	else:
		if (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				print("SPIN!")
		elif (path_follow_2d.progress_ratio < 1 - current_track_card.caution_min_limit_1 and path_follow_2d.progress_ratio > 1 - current_track_card.caution_max_limit_1) or (path_follow_2d.progress_ratio < 1 - current_track_card.caution_min_limit_2 and path_follow_2d.progress_ratio > 1 - current_track_card.caution_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				print("Caution")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_player_accelerate"):
		speed += acceleration

	if event.is_action_pressed("test_player_decelerate"):
		if speed > 0:
			speed -= acceleration
