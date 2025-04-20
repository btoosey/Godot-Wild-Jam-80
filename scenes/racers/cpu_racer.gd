extends Path2D

signal track_card_ended

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@export var acceleration := 0.02
@export var deceleration := 0.02

var current_track_card
var current_lap := 1

var enabled = false
var speed = 0
var top_speed = 0.16
var can_accelerate = true

var race_ended = false


func _process(_delta: float) -> void:
	if !enabled:
		return

	if (speed + acceleration <= top_speed and can_accelerate) and !race_ended:
		accelerate()

	path_follow_2d.progress += speed

	if path_follow_2d.progress_ratio == 1:
		track_card_ended.emit()

	if current_track_card.speed_threshold == 0:
		return

	if current_track_card.first_link == current_track_card.circuit_link_1:
		if (path_follow_2d.progress_ratio > current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio < current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio > current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio < current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				spin_out()
	else:
		if (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				spin_out()


func accelerate() -> void:
	speed += acceleration + speed_noise()
	speed = clampf(speed, 0, top_speed)
	can_accelerate = false
	$AccelerationTimer.start()


func decelerate(value) -> void:
	speed -= value
	speed = clampf(speed, 0, top_speed)


func decelerate_continously() -> void:
	can_accelerate = false
	if speed == 0:
		can_accelerate = true
		return

	decelerate(0.02)
	$DecelerationTimer.start()


func _on_acceleration_timer_timeout() -> void:
	can_accelerate = true


func _on_deceleration_timer_timeout() -> void:
	decelerate_continously()


func speed_noise() -> float:
	var min_noise = 0 - acceleration
	return randf_range(min_noise, acceleration)


func finish_race() -> void:
	decelerate_continously()
	race_ended = true


func spin_out() -> void:
	decelerate_continously()
	var tween = get_tree().create_tween()
	tween.tween_property(path_follow_2d.get_child(0).sprite_2d, "rotation", deg_to_rad(360), 1)
	path_follow_2d.get_child(0).sprite_2d.rotation = 0
