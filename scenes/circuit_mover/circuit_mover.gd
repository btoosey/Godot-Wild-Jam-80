extends Path2D

signal track_card_ended

@export var acceleration := 0.02

var speed = 0

func _process(_delta: float) -> void:
	$PathFollow2D.progress += speed
	if $PathFollow2D.progress_ratio == 1:
		track_card_ended.emit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_player_move"):
		speed += acceleration
