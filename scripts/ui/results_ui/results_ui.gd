extends CanvasLayer

@onready var game_state_machine: GameStateMachine = $"../Components/GameStateMachine"

@onready var race_manager: RaceManager = $"../Components/RaceManager"
@onready var race_results: VBoxContainer = $RaceResults
@onready var points_calculator: Node = $"../Components/PointsCalculator"


func display_race_results() -> void:
	var i = 0
	for position in race_results.get_children():
		if position == race_results.get_child(0) or position == race_results.get_child(1):
			continue

		position.position_label.text = str(i + 1)
		position.name_label.text = str(race_manager.race_order[i].three_letter)
		position.prize_money.text = str(points_calculator.prize_order[i],"$")
		i += 1


func _on_continue_pressed() -> void:
	game_state_machine._on_transition_requested(game_state_machine.current_state, GameState.State.SETUP)
