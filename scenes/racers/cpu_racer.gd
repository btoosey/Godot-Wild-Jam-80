extends Path2D

signal track_card_ended

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@export var acceleration := 0.02

var current_track_card
var current_lap := 1

var enabled = false
var speed = 0
var top_speed = 0.14
var can_accelerate = true


func _process(_delta: float) -> void:
	if !enabled:
		return

	if speed + acceleration <= top_speed and can_accelerate:
		accelerate()

	path_follow_2d.progress += speed

	if path_follow_2d.progress_ratio == 1:
		track_card_ended.emit()

	if current_track_card.speed_threshold == 0:
		return

	if current_track_card.first_link == current_track_card.circuit_link_1:
		if (path_follow_2d.progress_ratio > current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio < current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio > current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio < current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				print("SPIN!")
	else:
		if (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				print("SPIN!")


func accelerate() -> void:
	speed += acceleration + speed_noise()
	speed = clampf(speed, 0, top_speed)
	can_accelerate = false
	$AccelerationTimer.start()


func _on_acceleration_timer_timeout() -> void:
	can_accelerate = true


func speed_noise() -> float:
	var min_noise = 0 - acceleration
	return randf_range(min_noise, acceleration)
