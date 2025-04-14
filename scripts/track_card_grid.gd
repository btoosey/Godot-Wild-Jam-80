class_name TrackCardGrid
extends Node

signal track_card_grid_changed

@export var size: Vector2i

var track_cards: Dictionary


func _ready() -> void:
	for i in size.x:
		for j in size.y:
			track_cards[Vector2i(i, j)] = null


func add_track_card(tile: Vector2i, track_card: Node) -> void:
	track_cards[tile] = track_card
	track_cards[tile + track_card.secondary_card_halves[track_card.card_orientation]] = track_card
	track_card_grid_changed.emit()


func remove_track_card(tile: Vector2i) -> void:
	var track_card := track_cards[tile] as Node

	if not track_card:
		return

	track_cards[tile] = null
	track_card_grid_changed.emit()


func is_tile_occupied(tile: Vector2i) -> bool:
	return track_cards[tile] != null


func is_grid_full() -> bool:
	return track_cards.keys().all(is_tile_occupied)


func get_first_empty_tile() -> Vector2i:
	for tile in track_cards:
		if not is_tile_occupied(tile):
			return tile

	return Vector2i(-1, -1)


func get_all_track_cards() -> Array[TrackCard]:
	var track_card_array: Array[TrackCard] = []

	for track_card: TrackCard in track_cards.values():
		if track_card:
			track_card_array.append(track_card)

	return track_card_array
