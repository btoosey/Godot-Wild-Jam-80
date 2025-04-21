extends Path2D

signal track_card_ended
signal show_caution
signal hide_caution

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

var race_ended = false


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
				spin_out()
		elif (path_follow_2d.progress_ratio > current_track_card.caution_min_limit_1 and path_follow_2d.progress_ratio < current_track_card.caution_max_limit_1) or (path_follow_2d.progress_ratio > current_track_card.caution_min_limit_2 and path_follow_2d.progress_ratio < current_track_card.caution_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				show_caution.emit()
			else:
				hide_caution.emit()
		else:
			hide_caution.emit()
	else:
		if (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_1 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_1) or (path_follow_2d.progress_ratio < 1 - current_track_card.speed_min_limit_2 and path_follow_2d.progress_ratio > 1 - current_track_card.speed_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				spin_out()
		elif (path_follow_2d.progress_ratio < 1 - current_track_card.caution_min_limit_1 and path_follow_2d.progress_ratio > 1 - current_track_card.caution_max_limit_1) or (path_follow_2d.progress_ratio < 1 - current_track_card.caution_min_limit_2 and path_follow_2d.progress_ratio > 1 - current_track_card.caution_max_limit_2):
			if speed >= current_track_card.speed_threshold:
				show_caution.emit()
			else:
				hide_caution.emit()
		else:
			hide_caution.emit()


func accelerate() -> void:
	speed += acceleration
	speed = clampf(speed, 0, top_speed)


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


func finish_race() -> void:
	race_ended = true
	decelerate_continously()


func _input(event: InputEvent) -> void:
	if !enabled:
		return

	if can_accelerate == false or race_ended == true:
		return

	if event.is_action_pressed("player_accelerate"):
		accelerate()

	if event.is_action_pressed("player_decelerate"):
		decelerate(deceleration)


func _on_deceleration_timer_timeout() -> void:
	decelerate_continously()


func spin_out() -> void:
	decelerate_continously()
	var tween = get_tree().create_tween()
	tween.tween_property(path_follow_2d.get_child(0).sprite_2d, "rotation", deg_to_rad(360), 1)
	path_follow_2d.get_child(0).sprite_2d.rotation = 0


func improve_random_stat() -> void:
	pass
