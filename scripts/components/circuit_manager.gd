class_name CircuitManager
extends Node

@export var track_card_mover: TrackCardMover
@onready var start_finish_card: Node2D = $StartFinishCard


var circuit_cards:= []
var complete: bool


func _ready() -> void:
	track_card_mover.track_card_final_position_dropped.connect(_on_track_card_final_position_dropped)
	circuit_cards.append(start_finish_card)


func _on_track_card_final_position_dropped(track_card: TrackCard) -> void:
	check_and_add_to_circuit(track_card)


func check_and_add_to_circuit(card: TrackCard) -> void:
	if circuit_cards.size() == 1:
		if card.circuit_link_1.global_position == start_finish_card.circuit_link_1.global_position or card.circuit_link_2.global_position == start_finish_card.circuit_link_1.global_position:
			add_to_circuit_array_start(card)
		elif card.circuit_link_1.global_position == start_finish_card.circuit_link_2.global_position or card.circuit_link_2.global_position == start_finish_card.circuit_link_2.global_position:
			add_to_circuit_array_end(card)
	else:
		if check_for_matching_links(card, circuit_cards[-1]):
			add_to_circuit_array_end(card)
		elif check_for_matching_links(card, circuit_cards[0]):
			add_to_circuit_array_start(card)
	print(circuit_cards)


func check_for_matching_links(card_1, card_2) -> bool:
	if card_1.circuit_link_1.global_position == card_2.circuit_link_1.global_position or card_1.circuit_link_1.global_position == card_2.circuit_link_2.global_position or card_1.circuit_link_2.global_position == card_2.circuit_link_1.global_position or card_1.circuit_link_2.global_position == card_2.circuit_link_2.global_position:
		return true
	return false

func add_to_circuit_array_start(card: TrackCard) -> void:
	circuit_cards.push_front(card)


func add_to_circuit_array_end(card: TrackCard) -> void:
	circuit_cards.append(card)
