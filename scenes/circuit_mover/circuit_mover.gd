extends Path2D

@export var acceleration := 0.04

var speed = 0

func _process(_delta: float) -> void:
	$PathFollow2D.progress += speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_player_move"):
		speed += acceleration
