@tool
class_name TrackCard
extends Area2D

@export var stats: TrackCardStats : set = set_stats

@onready var track_card_sprite: Sprite2D = $TrackCardSprite
@onready var drag_and_drop: DragAndDrop = $Components/DragAndDrop

@onready var circuit_link_1: Marker2D = $CircuitLinks/CircuitLink1
@onready var circuit_link_2: Marker2D = $CircuitLinks/CircuitLink2

var first_link: Marker2D
var second_link: Marker2D

var dragging := false
var card_orientation := 0

var secondary_card_halves = {
	0: Vector2i(0, 1),
	1: Vector2i(-1, 0),
	2: Vector2i(0, -1),
	3: Vector2i(1, 0)
}


func set_stats(value: TrackCardStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	track_card_sprite.region_rect.position = Vector2(stats.skin_coordinates) * Main.TRACK_CARD_SIZE
	
	circuit_link_1.position = stats.circuit_link_1
	circuit_link_2.position = stats.circuit_link_2


func rotate_card(deg) -> void:
	rotate(deg_to_rad(deg))
	card_orientation += 1
	if card_orientation == 4:
		card_orientation = 0


func reset_after_dragging(starting_position: Vector2, orientation: int) -> void:
	while orientation != card_orientation:
		rotate_card(90)
	global_position = starting_position
