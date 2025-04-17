class_name RaceManager
extends Node

signal lap_increased(lap)

@onready var circuit_manager: CircuitManager = $"../CircuitManager"
@onready var path2d_mover = $CircuitMover

var ordered_track_cards: Array
var current_track_card
var current_lap := 1


func set_race_start_points() -> void:
	current_track_card = circuit_manager.start_finish_card
	path2d_mover.curve.clear_points()
	path2d_mover.curve.add_point(circuit_manager.start_finish_card.start_finish_link.global_position)
	path2d_mover.curve.add_point(circuit_manager.start_finish_card.second_link.global_position)


func _on_circuit_mover_track_card_ended() -> void:
	if current_track_card == ordered_track_cards[-1]:
		enter_start_finish_straight()
	else:
		next_track_card()


func enter_start_finish_straight() -> void:
	current_track_card = ordered_track_cards[0]
	update_mover_points()


func next_track_card() -> void:
	current_track_card = ordered_track_cards[ordered_track_cards.find(current_track_card) + 1]
	update_mover_points()


func update_mover_points() -> void:
	$CircuitMover/PathFollow2D.progress_ratio = 0
	path2d_mover.curve.clear_points()

	path2d_mover.curve.add_point(current_track_card.first_link.global_position)
	path2d_mover.curve.add_point(current_track_card.second_link.global_position)


func order_track_cards() -> void:
	var temp = circuit_manager.circuit_cards

	while temp[0] != circuit_manager.start_finish_card:
		temp.append(temp.pop_front())

	ordered_track_cards = temp


func _on_area_2d_body_exited(_body: Node2D) -> void:
	current_lap += 1
	lap_increased.emit(current_lap)
