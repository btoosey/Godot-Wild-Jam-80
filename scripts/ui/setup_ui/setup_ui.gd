extends CanvasLayer

@onready var game_state_machine: GameStateMachine = $"../Components/GameStateMachine" as GameStateMachine

func _on_start_race_button_pressed() -> void:
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.RACE)
