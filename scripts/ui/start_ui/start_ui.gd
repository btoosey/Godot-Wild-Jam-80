extends CanvasLayer

@onready var game_state_machine: GameStateMachine = $"../Components/GameStateMachine"


func _on_button_pressed() -> void:
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.SETUP)
