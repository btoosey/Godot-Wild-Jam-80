class_name TrackCardSpawner
extends Node

signal track_card_spawned(track_card: TrackCard)

const TRACK_CARD = preload("res://scenes/track_cards/track_card.tscn")

@export var play_area: PlayArea


func _ready() -> void:
	var t_card_1 := preload("res://data/track_cards/c_corner_01.tres")
	var t_card_2 := preload("res://data/track_cards/straight_long_01.tres")
	var _t_card_3 := preload("res://data/track_cards/s_corner_01.tres")
	var _t_card_4 := preload("res://data/track_cards/l_corner_long_01.tres")
	var _t_card_5 := preload("res://data/track_cards/j_corner_long_01.tres")
	var tween := create_tween()
	
	tween.tween_callback(spawn_track_card.bind(t_card_1))
	tween.tween_callback(spawn_track_card.bind(t_card_1))
	tween.tween_callback(spawn_track_card.bind(t_card_2))


func _get_first_available_area() -> PlayArea:
	if not play_area.play_area_track_card_grid.is_grid_full():
		return play_area

	return null


func spawn_track_card(track_card: TrackCardStats) -> void:
	var area := _get_first_available_area()

	var new_track_card := TRACK_CARD.instantiate()
	var tile = area.play_area_track_card_grid.get_first_empty_tile()

	area.play_area_track_card_grid.add_child(new_track_card)
	area.play_area_track_card_grid.add_track_card(tile, new_track_card)
	new_track_card.global_position = area.get_global_from_tile(tile)
	new_track_card.stats = track_card

	track_card_spawned.emit(new_track_card)
