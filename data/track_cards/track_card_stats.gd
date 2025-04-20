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
@export var price: int

@export_category("Visuals")
@export var skin_coordinates: Vector2i

@export_category("Circuit Link Locations")
@export var circuit_link_1: Vector2
@export var circuit_link_2: Vector2

@export_category("Circuit Link OutIn")
@export var c_1_out: Vector2
@export var c_2_in: Vector2
@export var c_2_out: Vector2
@export var c_1_in: Vector2

@export_category("Speed Limits")
@export var caution_min_limit_1: float
@export var caution_max_limit_1: float
@export var speed_min_limit_1: float
@export var speed_max_limit_1: float

@export var caution_min_limit_2: float
@export var caution_max_limit_2: float
@export var speed_min_limit_2: float
@export var speed_max_limit_2: float 

@export_category("Speed Threshold")
@export var speed_threshold: float
