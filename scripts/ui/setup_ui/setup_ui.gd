extends CanvasLayer

@onready var game_state_machine: GameStateMachine = $"../Components/GameStateMachine" as GameStateMachine
@onready var player_path: Path2D = $"../Components/RaceManager/RacerPaths/PlayerPath"
@onready var panel: Panel = $Panel

var displayed := false


func _on_start_race_button_pressed() -> void:
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.RACE)


func _on_top_speed_pressed() -> void:
	player_path.top_speed += 0.02


func _on_accelerator_power_pressed() -> void:
	player_path.acceleration += 0.01


func _on_brake_power_pressed() -> void:
	player_path.deceleration += 0.01


func _on_shop_pressed() -> void:
	if displayed:
		hide_shop_ui()
	else:
		show_shop_ui()


func hide_shop_ui() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "position", Vector2(-1010, 608), 0.4)
	displayed = false


func show_shop_ui() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "position", Vector2(0, 608), 0.4)
	displayed = true
