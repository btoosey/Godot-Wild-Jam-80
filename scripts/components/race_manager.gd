class_name RaceManager
extends Node

@onready var circuit_manager: CircuitManager = $"../CircuitManager"
@onready var path2d_mover = $CircuitMover

var ordered_track_cards: Array
var current_track_card


func set_race_start_points() -> void:
	current_track_card = circuit_manager.start_finish_card
	path2d_mover.curve.clear_points()
	path2d_mover.curve.add_point(circuit_manager.start_finish_card.start_finish_link.global_position)
	path2d_mover.curve.add_point(circuit_manager.start_finish_card.circuit_link_2.global_position)


func _on_circuit_mover_track_card_ended() -> void:
	#check_if_end_of_lap()
	next_track_card()


#func check_if_end_of_lap() -> void:
	#check_if_race_ended()


func next_track_card() -> void:
	current_track_card = ordered_track_cards[ordered_track_cards.find(current_track_card) + 1]
	update_mover_points()


func update_mover_points() -> void:
	$CircuitMover/PathFollow2D.progress_ratio = 0
	path2d_mover.curve.clear_points()

	path2d_mover.curve.add_point(current_track_card.circuit_link_1.global_position)
	path2d_mover.curve.add_point(current_track_card.circuit_link_2.global_position)


func order_track_cards() -> void:
	var temp = circuit_manager.circuit_cards

	while temp[0] != circuit_manager.start_finish_card:
		temp.append(temp.pop_front())

	ordered_track_cards = temp
