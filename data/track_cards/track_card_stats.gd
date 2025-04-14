class_name TrackCardStats
extends Resource

enum CardType {
	STRAIGHT_LONG,
	STRAIGHT_SHORT,
	C_CORNER,
	J_CORNER_SHORT,
	L_CORNER_SHORT,
	J_CORNER_LONG,
	L_CORNER_LONG,
	S_CORNER,
	Z_CORNER
	}

@export_category("Data")
@export var card_type : CardType

@export_category("Visuals")
@export var skin_coordinates: Vector2i

@export_category("Circuit Link Locations")
@export var circuit_link_1: Vector2
@export var circuit_link_2: Vector2
