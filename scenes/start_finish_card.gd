extends Node2D

@onready var start_finish_link: Marker2D = $CircuitLinks/StartFinishLink
@onready var circuit_link_1: Marker2D = $CircuitLinks/CircuitLink1
@onready var circuit_link_2: Marker2D = $CircuitLinks/CircuitLink2

var first_link: Marker2D
var second_link: Marker2D

var point_out := Vector2(0, 0)
var point_in := Vector2(0, 0)

var stats = null
var card_orientation = 0

var speed_threshold = 0


func _ready() -> void:
	first_link = circuit_link_1
	second_link = circuit_link_2
