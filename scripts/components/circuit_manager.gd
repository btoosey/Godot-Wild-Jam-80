class_name CircuitManager
extends Node

signal circuit_complete
signal circuit_incomplete

@export var track_card_mover: TrackCardMover

@onready var start_finish_card: Node2D = $StartFinishCard

var circuit_cards:= []
var complete: bool


func _ready() -> void:
	track_card_mover.track_card_final_position_dropped.connect(_on_track_card_final_position_dropped)
	circuit_cards.append(start_finish_card)


func setup_track_card(track_card: TrackCard) -> void:
	track_card.drag_and_drop.drag_started.connect(remove_from_circuit.bind(track_card))


func remove_from_circuit(card: TrackCard) -> void:
	if !circuit_cards.has(card):
		return

	if is_circuit_complete():
		if circuit_cards.find(card) < circuit_cards.find(start_finish_card):
			var cards = get_front_cards(card)
			for c in cards:
				circuit_cards.erase(c)
			circuit_cards.append_array(cards)

		elif circuit_cards.find(card) > circuit_cards.find(start_finish_card):
			var cards = get_back_cards(card)
			for c in range(cards.size(),0,-1):
				circuit_cards.erase(cards[c - 1])
				circuit_cards.push_front(cards[c - 1])

		circuit_cards.erase(card)

	else:
		if circuit_cards.find(card) < circuit_cards.find(start_finish_card):
			var cards = get_front_cards(card)
			for c in cards:
				circuit_cards.erase(c)
		elif circuit_cards.find(card) > circuit_cards.find(start_finish_card):
			var cards = get_back_cards(card)
			for c in range(cards.size(),0,-1):
				circuit_cards.erase(cards[c - 1])
		circuit_cards.erase(card)


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


	if is_circuit_complete():
		circuit_complete.emit()
	else:
		circuit_incomplete.emit()


func add_to_circuit_array_start(card: TrackCard) -> void:
	circuit_cards.push_front(card)
	check_for_floating_card(card)


func add_to_circuit_array_end(card: TrackCard) -> void:
	circuit_cards.append(card)
	check_for_floating_card(card)


func get_front_cards(card: TrackCard) -> Array:
	var cards = []

	for c in circuit_cards:
		if circuit_cards.find(c) < circuit_cards.find(card):
			cards.append(c)

	return cards


func get_back_cards(card: TrackCard) -> Array:
	var cards = []

	for c in circuit_cards:
		if circuit_cards.find(c) > circuit_cards.find(card):
			cards.append(c)

	return cards


func is_circuit_complete() -> bool:
	if circuit_cards.size() < 4:
		return false
	return check_for_matching_links(circuit_cards[0], circuit_cards[-1])


func check_for_matching_links(card_1, card_2) -> bool:
	if card_1.circuit_link_1.global_position == card_2.circuit_link_1.global_position or card_1.circuit_link_1.global_position == card_2.circuit_link_2.global_position or card_1.circuit_link_2.global_position == card_2.circuit_link_1.global_position or card_1.circuit_link_2.global_position == card_2.circuit_link_2.global_position:
		return true
	return false


func check_for_floating_card(card: TrackCard) -> void:
	for track_card in get_tree().get_nodes_in_group("track_cards"):
		if circuit_cards.has(track_card):
			continue

		if check_for_matching_links(track_card, card):
			if check_for_matching_links(track_card, circuit_cards[-1]):
				check_and_add_to_circuit(track_card)
			elif check_for_matching_links(track_card, circuit_cards[0]):
				check_and_add_to_circuit(track_card)
