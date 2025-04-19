class_name RaceManager
extends Node


@onready var circuit_manager: CircuitManager = $"../CircuitManager"
@onready var racer_paths: Node2D = $RacerPaths


var ordered_track_cards: Array


func _ready() -> void:
	for path in racer_paths.get_children():
		path.track_card_ended.connect(_on_racer_path_track_card_ended.bind(path))


func set_race_start_points() -> void:
	for path in racer_paths.get_children():
		path.current_track_card = circuit_manager.start_finish_card
		path.curve.clear_points()
		path.curve.add_point(circuit_manager.start_finish_card.start_finish_link.global_position)
		path.curve.add_point(circuit_manager.start_finish_card.second_link.global_position)


func _on_racer_path_track_card_ended(path) -> void:
	if path.current_track_card == ordered_track_cards[-1]:
		enter_start_finish_straight(path)
	else:
		next_track_card(path)


func enter_start_finish_straight(path) -> void:
	path.current_track_card = ordered_track_cards[0]
	update_mover_points(path)


func next_track_card(path) -> void:
	path.current_track_card = ordered_track_cards[ordered_track_cards.find(path.current_track_card) + 1]
	update_mover_points(path)


func update_mover_points(path) -> void:
	path.path_follow_2d.progress_ratio = 0
	path.curve.clear_points()

	path.curve.add_point(path.current_track_card.first_link.global_position)
	path.curve.set_point_out(0, (path.current_track_card.point_out).rotated(deg_to_rad(90 * path.current_track_card.card_orientation)))
	path.curve.add_point(path.current_track_card.second_link.global_position)
	path.curve.set_point_in(1, (path.current_track_card.point_in).rotated(deg_to_rad(90 * path.current_track_card.card_orientation)))


func order_track_cards() -> void:
	var temp = circuit_manager.circuit_cards

	while temp[0] != circuit_manager.start_finish_card:
		temp.append(temp.pop_front())

	ordered_track_cards = temp


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.get_parent().get_parent().current_lap += 1
