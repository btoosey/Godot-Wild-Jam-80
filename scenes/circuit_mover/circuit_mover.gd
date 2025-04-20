extends Path2D

signal track_card_ended

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@export var race_manager: RaceManager
@export var acceleration := 0.02
@export var deceleration := 0.02

var current_track_card
var current_lap := 1

var enabled = false
var speed = 0
var top_speed = 0.14
var can_accelerate = true


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


func accelerate() -> void:
	speed += acceleration
	speed = clampf(speed, 0, top_speed)


func decelerate() -> void:
	if speed == 0:
		return

	speed -= deceleration
	speed = clampf(speed, 0, top_speed)
	can_accelerate = false
	$DecelerationTimer.start()


func finish_race() -> void:
	decelerate()


func _input(event: InputEvent) -> void:
	if can_accelerate == false:
		return

	if event.is_action_pressed("player_accelerate"):
		accelerate()

	if event.is_action_pressed("player_decelerate"):
		decelerate()


func _on_deceleration_timer_timeout() -> void:
	decelerate()
